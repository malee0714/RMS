package lims.qa.service.Impl;

import lims.com.service.CmExmntTemplate;
import lims.com.service.CmSanctnService;
import lims.com.vo.CmExmntDto;
import lims.qa.dao.DocMDao;
import lims.qa.service.DocMService;
import lims.qa.vo.DocDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DocMServiceImpl implements DocMService {

	private final DocMDao docMDao;
	private final CmSanctnService cmSanctnServiceImpl;
	private final CmExmntTemplate cmExmntTemplate;

	@Value("${style.table}")
	String tableStyle;

	@Value("${style.th}")
	String thStyle;

	@Value("${style.td}")
	String tdStyle;

	@Autowired
	public DocMServiceImpl(DocMDao docMDao, CmSanctnService cmSanctnServiceImpl, CmExmntTemplate cmExmntTemplate) {
		this.docMDao = docMDao;
		this.cmSanctnServiceImpl = cmSanctnServiceImpl;
		this.cmExmntTemplate = cmExmntTemplate;
	}

	/**
	 * 저장
	 */
	@Override
	public int insDocM(DocDto docDto) {
		int result = 0;
		int sanctn = 0;
		//개정
		if (String.valueOf(docDto.getCrud()).equals("R")) {
			//해당 일련번호  deleteAt = 'Y'
			//새로 개정하는 데이터 INSERT -> 일련번호 삭제 
			docDto.setLastVerAt("N");
			result += docMDao.updLastAt(docDto); //해당 데이터 긁어와서 최종여부 수정
			docDto.setDocSeqno(null);
			result += docMDao.insDocM(docDto); //해당 데이터 새로 INSERT 즉 개정

			this.saveSanctn(docDto);
			
		} else if (String.valueOf(docDto.getCrud()).equals("D")) { //문서 삭제 //이전 문서 롤백
			result += docMDao.updDeleteAt(docDto); //해당 데이터 긁어와서 데이터 삭제
			docDto.setLastVerAt("Y");
			result += docMDao.updLastAt(docDto);
			
		} else if (String.valueOf(docDto.getCrud()).equals("N")) { //폐기시 일련번호 지우고 새로 insert태우기 폐기
			docDto.setLastVerAt("N");
			result += docMDao.updLastAt(docDto); //해당 데이터 긁어와서 데이터 삭제
			docDto.setDocSeqno(null);
			result += docMDao.insDocM(docDto); //해당 데이터 새로 INSERT 즉 개정
			
			this.saveSanctn(docDto);
		} else {
			if ("0".equals(docDto.getReformNo())) {   // 문서 제정 제정시 개정일자 -> 제정일자에 세팅 
				docDto.setEstbshDte(docDto.getReformDte());
				docDto.setReformDte(null);
			}
			if (docDto.isNew()) {
				result = docMDao.insDocM(docDto); // 첫 제정 시
			} else {
				result = docMDao.updDocM(docDto); // 문서 수정
			}
			
			this.saveSanctn(docDto);
		}
		return result;
	}


	@Override
	public int insConfirmM(DocDto docDto) {
		int result = 0;

		//개정
		if (String.valueOf(docDto.getCrud()).equals("R")) {
			//해당 일련번호  deleteAt = 'Y'
			//새로 개정하는 데이터 INSERT -> 일련번호 삭제 
			docDto.setLastVerAt("N");
			result += docMDao.updLastAt(docDto); //해당 데이터 긁어와서 최종여부 수정
			docDto.setDocSeqno(null);
			result += docMDao.insDocM(docDto); //해당 데이터 새로 INSERT 즉 개정

			this.approval(docDto);
			
		} else if (String.valueOf(docDto.getCrud()).equals("N")) {//폐기시 일련번호 지우고 새로 insert태우기
			docDto.setLastVerAt("N");
			result += docMDao.updLastAt(docDto); //해당 데이터 긁어와서 데이터 삭제
			docDto.setDocSeqno(null);
			result += docMDao.insDocM(docDto); //해당 데이터 새로 INSERT 즉 개정

			this.approval(docDto);
			
		} else {
			if ("0".equals(docDto.getReformNo())) {   // 문서 저장 및 상신 제정시 개정일자 -> 제정일자에 세팅
				docDto.setEstbshDte(docDto.getReformDte());
				docDto.setReformDte(null);
			}
			if (docDto.isNew()) {
				result = docMDao.insDocM(docDto); // 첫 제정 시
			} else {
				result = docMDao.updDocM(docDto); // 문서 수정
			}

			this.approval(docDto);
		}
		return result;
	}

	/**
	 * 문서 목록 조회
	 */
	@Override
	public List<DocDto> getDocList(DocDto vo) {
		return docMDao.getDocList(vo);
	}

	/**
	 * 문서 이력 조회
	 */
	@Override
	public List<DocDto> getDocHistList(DocDto vo) {
		return docMDao.getDocHistList(vo);

	}

	@Override
	public List<DocDto> getDocSanctnLineCombo(DocDto vo) {
		return docMDao.getDocSanctnLineCombo(vo);
	}

	@Override
	public List<DocDto> getMtrilNmCombo(DocDto vo) {
		return docMDao.getMtrilNmCombo(vo);
	}

	@Override
	public List<DocDto> getEntrpsNmCombo(DocDto vo) {
		return docMDao.getEntrpsNmCombo(vo);
	}

	@Override
	public int docNoChk(DocDto vo) {
		return docMDao.docNoChk(vo);
	}

	@Override
	public void saveExmnt(CmExmntDto cmExmntDto) {
		cmExmntTemplate.saveExmnt(cmExmntDto, this.docMDao::updateDocExmnt);
	}

	@Override
	public void revertDoc(DocDto docDto) {
		this.cmSanctnServiceImpl.revert(docDto);
	}

	private void setCn(DocDto docDto) {
		docDto.setSuperSj("표준문서 (" + docDto.getDocNo() + ")");
		docDto.setCn(this.getSaveFormHtml(docDto));
	}

	/**
	 * 결재 정보, 결재자 정보, cn정보 저장 및 결재 seqno 업데이트
	 */
	private void saveSanctn(DocDto docDto) {
		this.setCn(docDto);
		this.cmSanctnServiceImpl.saveSanctn(docDto);
		this.docMDao.updSanctnSeqno(docDto);
	}

	/**
	 * 결재 상신
	 */
	private void approval(DocDto docDto) {
		this.saveSanctn(docDto);
		cmSanctnServiceImpl.approvalRequest(docDto);
	}

	private String getSaveFormHtml(DocDto dto) {
		StringBuilder dissUseHtml = new StringBuilder();
		if (String.valueOf(dto.getCrud()).equals("N")) {
			dissUseHtml
					.append("<tr>")
					.append("<th " + thStyle + ">폐기자</th> ")
					.append("<td " + tdStyle + "> " + dto.getDuspsnNm() + " </td>")
					.append("<th " + thStyle + ">폐기일자</th> ")
					.append("<td " + tdStyle + "> " + dto.getDsuseDte() + " </td>")
					.append("<td></td>")
					.append("<td></td>")
					.append("<td></td>")
					.append("<td></td>")
					.append("</tr>")
					.append("<tr>")
					.append("<th " + thStyle + ">제.개정사유</th>")
					.append("<td " + tdStyle + " colspan=\"7\">" + dto.getDsuseResn() + "</td>")
					.append("</tr>");
		}

		StringBuilder form = new StringBuilder();
			form
				.append("<h2>문서 정보<h2>")
				.append("<table " + tableStyle + ">")
				.append("    <colgroup>")
				.append("        <col style=\"width:10%\"/>")
				.append("        <col style=\"width:15%\"/>")
				.append("        <col style=\"width:10%\"/>")
				.append("        <col style=\"width:15%\"/>")
				.append("        <col style=\"width:10%\"/>")
				.append("        <col style=\"width:15%\"/>")
				.append("        <col style=\"width:10%\"/>")
				.append("        <col style=\"width:15%\"/>")
				.append("    </colgroup>")
				.append("    <tr>")
				.append("        <th " + thStyle + ">문서 구분</th> ")
				.append("        <td " + tdStyle + "> " + dto.getDocSeCodeNm() + " </td>")
				.append("        <th " + thStyle + ">문서 제목</th> ")
				.append("        <td " + tdStyle + " colspan='3'>" + dto.getSj() + "</td>")
				.append("        <th " + thStyle + ">문서 번호</th>")
				.append("        <td " + tdStyle + ">" + dto.getDocNo() + "</td>")
				.append("    </tr>")
				.append("    <tr>")
				.append("        <th " + thStyle + ">작성 일자</th> ")
				.append("        <td " + tdStyle + "> " + dto.getWritngDte() + " </td>")
				.append("        <th " + thStyle + ">제.개정일자</th> ")
				.append("        <td " + tdStyle + ">" + dto.getReformAndEstbshDte() + "</td>")
				.append("        <th " + thStyle + ">제.개정번호</th>")
				.append("        <td " + tdStyle + ">" + dto.getReformNo() + "</td>")
				.append("        <td></td>")
				.append("        <td></td>")
				.append("    </tr>")
				.append("    <tr>")
				.append("        <th " + thStyle + ">담당부서</th> ")
				.append("        <td " + tdStyle + "> " + dto.getChrgDeptCodeNm() + " </td>")
				.append("        <th " + thStyle + ">담당자</th> ")
				.append("        <td " + tdStyle + "> " + dto.getChargerNm() + " </td>")
				.append("        <td></td>")
				.append("        <td></td>")
				.append("        <td></td>")
				.append("        <td></td>")
				.append("    </tr>")
				.append("    <tr>")
				.append("        <th " + thStyle + ">제.개정사유</th>")
				.append("        <td " + tdStyle + " colspan=\"7\">" + dto.getRevnResn() + "</td>")
				.append("    </tr>")
				.append(dissUseHtml)
				.append("    <tr>")
				.append("        <th " + thStyle + ">첨부파일</th>")
				.append("        <td " + tdStyle + " colspan=\"7\">")
				.append("            <div id=\"dropZoneArea\" class='dropzoneSelector'></div>")
				.append("            <input type=\"text\" name=\"atchmnflSeqno\" style=\"display: none;\" value=\"" + dto.getAtchmnflSeqno() + "\">")
				.append("        </td>")
				.append("    </tr>")
				.append("</table>");
		return form.toString();
	}
}
