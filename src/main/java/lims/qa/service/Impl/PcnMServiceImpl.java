package lims.qa.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import lims.com.dao.CmExmntDao;
import lims.com.service.CmExmntTemplate;
import lims.com.service.CmSanctnService;
import lims.com.vo.CmExmntDto;
import lims.com.vo.ComboVo;
import lims.qa.dao.PcnMDao;
import lims.qa.service.PcnMService;
import lims.qa.vo.PcnChangePointVo;
import lims.qa.vo.PcnMVo;
import lims.qa.vo.QlityDocHistVo;

@Service("PcnMService")
public class PcnMServiceImpl implements PcnMService {
	
	private final PcnMDao pcnMDao;
	private final CmSanctnService cmSanctnServiceImpl;
	private final CmExmntTemplate cmExmntTemplate;
	
	@Value("${style.table}")
	String tableStyle;

	@Value("${style.th}")
	String thStyle;
	
	@Value("${style.td}")
	String tdStyle;
	
	@Autowired
	public PcnMServiceImpl(CmExmntDao cmExmntDao, PcnMDao pcnMDao, CmSanctnService cmSanctnServiceImpl, CmExmntTemplate cmExmntTemplate) {
		this.pcnMDao = pcnMDao;
		this.cmSanctnServiceImpl = cmSanctnServiceImpl;
		this.cmExmntTemplate = cmExmntTemplate;
	}
	
	
	/**
	 * PCN 목록 조회
	 */
	public List<PcnMVo> getPcnList(PcnMVo vo) {
		return pcnMDao.getPcnList(vo);
	}
	
	/**
	 * PCN 정보 저장
	 */
	public void insPcnInfo(PcnMVo vo) {
		
		// PCN NO 자동입력.
		int pcnSeqno = pcnMDao.getPcnSeq();
		vo.setPcnSeqno(pcnSeqno);
		
		// 발행일자 구하기
		String pblicteDte = vo.getPblicteDte();
		String pcnNoDate = pblicteDte.substring(2, 7);

		// 날짜별 마지막 3자리 자동 +1 하기.
		String lotPcnNo = pcnMDao.getMaxPcnNo(pcnNoDate);
		if(lotPcnNo != null) {
			vo.setPcnNo("FCC-PCN-"+pcnNoDate+"-"+lotPcnNo);
		} else {
			vo.setPcnNo("FCC-PCN-"+pcnNoDate+"-000");
		}
		
		// PCN 저장.
		pcnMDao.insPcnInfo(vo);
		
		// 변경점 저장.
		saveChangePoint(vo);

		// cn 설정.
		this.setPcnCn(vo);

		// 결재 정보 저장.
		this.saveSanctn(vo);
	}
	
	/**
	 * PCN 정보 수정/삭제
	 */
	public void updPcnInfo(PcnMVo vo) {
		int cnt = 0;
		
		// 발행일자 구하기
		String pblicteDate = vo.getPblicteDte().substring(2, 7);
		String pcnNoDate = vo.getPcnNo().substring(8,13);	

		if(pblicteDate.equals(pcnNoDate)) {
			if(vo.getDeleteAt().equals("N")) {
				pcnMDao.updPcnInfo(vo);
			}else if(vo.getDeleteAt().equals("Y")) {
				pcnMDao.deletePcnInfo(vo);
				cnt = 1;
			}
		} else {
			// 날짜별 마지막 3자리 자동 +1 하기.
			String lotPcnNo = pcnMDao.getMaxPcnNo(pblicteDate);
			if(lotPcnNo != null) {
				vo.setPcnNo("FCC-PCN-"+pblicteDate+"-"+lotPcnNo);
			} else {
				vo.setPcnNo("FCC-PCN-"+pblicteDate+"-000");
			}
			
			if(vo.getDeleteAt().equals("N")) {
				pcnMDao.updPcnInfo(vo);
			}else if(vo.getDeleteAt().equals("Y")) {
				pcnMDao.deletePcnInfo(vo);
				cnt = 1;
			}
		}

		// PCN 변경점 삭제.
		pcnMDao.delChangePoint(vo);
		
		// 변경점 저장.
		saveChangePoint(vo);

		// cn 설정.
		this.setPcnCn(vo);

		// 결재 정보 저장.
		this.saveSanctn(vo);
	}
	
	
	/**
	 * 입력 결재 상신
	 */
	public void insApprovalPcnM(PcnMVo vo){
		this.insPcnInfo(vo);
		this.cmSanctnServiceImpl.approvalRequest(vo);
	};
	
	/**
	 * 업데이트 결재 상신
	 */
	public void updApprovalPcnM(PcnMVo vo){
		this.updPcnInfo(vo);
		this.cmSanctnServiceImpl.approvalRequest(vo);
	};
	
	/**
	 * 고객사 이름 리스트 조회
	 */
	public List<ComboVo> getEntrpsNameList() {
		return pcnMDao.getEntrpsNameList();
	}
	
	/**
	 * 해당 제품 이름 리스트 조회
	 */
	public List<ComboVo> getMtrilNameList() {
		return pcnMDao.getMtrilNameList();
	}
	
	
	/**
	 * 담당자 이름 리스트 조회
	 */
	public List<ComboVo> getUserNameList() {
		return pcnMDao.getUserNameList();
	}

	@Override
	public void saveExmnt(CmExmntDto cmExmntDto) {
		cmExmntTemplate.saveExmnt(cmExmntDto, pcnMDao::updateExmntSeqno);
	}

	/**
	 * Cn 설정 로직.
	 */
	private void setPcnCn(PcnMVo vo) {
		vo.setSj("PCN("+ vo.getPcnNo() + ")");
		vo.setCn(this.getPcnFormHtml(vo));
	}
	
	/**
	 * Pcn HTML form 설정.
	 */
	private String getPcnFormHtml(PcnMVo vo) {
		String form = 
				"<h2>PCN정보<h2>" +
				"<table "+ tableStyle +">" +
				"    <colgroup>" +
				"        <col style=\"width:10%\"/>" +
				"        <col style=\"width:15%\"/>" +
				"        <col style=\"width:10%\"/>" +
				"        <col style=\"width:15%\"/>" +
				"        <col style=\"width:10%\"/>" +
				"        <col style=\"width:15%\"/>" +
				"        <col style=\"width:10%\"/>" +
				"        <col style=\"width:15%\"/>" +
				"    </colgroup>" +
				"    <tr>" +
				"        <th "+ thStyle +">PCN명</th> " +
				"        <td "+ tdStyle +"> "+ vo.getPcnNm() +" </td>" +
				"        <th "+ thStyle +">PCN NO.</th> " +
				"        <td "+ tdStyle +">"+ vo.getPcnNo() +"</td>" +
				"        <th "+ thStyle +">변경점 적용</th>" +
				"        <td "+ tdStyle +" colspan=\"3\">"+ vo.getChangePointApplcCn() +"</td>" +
				"    </tr>" +
				"    <tr>" +
				"        <th "+ thStyle +">고객사</th>" +
				"        <td "+ tdStyle +">"+ vo.getCtmmnySeqnoNm() +"</td>" +
				"        <th "+ thStyle +">해당 제품</th>" +
				"        <td "+ tdStyle +">"+ vo.getMtrilSeqnoNm() +"</td>" +
				"        <th "+ thStyle +">M5E1</th>" +
				"        <td "+ tdStyle +">"+ vo.getM5e1Nm() +"</td>" +
				"        <th "+ thStyle +">PCN grade</th>" +
				"        <td "+ tdStyle +">"+ vo.getPcnGradNm() +"</td>" +
				"    </tr>" +
				"    <tr>" +
				"        <th "+ thStyle +">예정일자</th>" +
				"        <td "+ tdStyle +">"+ vo.getPrearngeDte() +"</td>" +
				"        <th "+ thStyle +">담당부서</th>" +
				"        <td "+ tdStyle +">"+ vo.getChrgDeptNm() +"</td>" +
				"        <th "+ thStyle +">담당자</th>" +
				"        <td "+ tdStyle +">"+ vo.getChargerNm() +"</td>" +
				"    </tr>" +
				"    <tr>" +
				"        <th "+ thStyle +">PCN내용</th>" +
				"        <td "+ tdStyle +" colspan=\"7\">"+ vo.getPcnCn() +"</td>" +
				"    </tr>" +
				"    <tr>" +
				"        <th "+ thStyle +">PCN 전</th>" +
				"        <td "+ tdStyle +" colspan=\"3\">" + vo.getPcnBfeCn() + "</td>" +
				"        <th "+ thStyle +">PCN 후</th>" +
				"        <td "+ tdStyle +" colspan=\"3\">" + vo.getPcnAfterCn() + "</td>" +
				"    </tr>" +
				"    <tr>" +
				"        <th "+ thStyle +">PCN 결과</th>" +
				"        <td "+ tdStyle +">" + vo.getPcnBfeCn() + "</td>" +
				"        <th "+ thStyle +">발행일자</th>" +
				"        <td "+ tdStyle +">" + vo.getPblicteDte() + "</td>" +
				"        <th "+ thStyle +">완료일자</th>" +
				"        <td "+ tdStyle +">" + vo.getComptDte() + "</td>" +
				"    </tr>" +
				"    <tr>" +
				"        <th "+ thStyle +">첨부파일</th>" +
				"        <td "+ tdStyle +" colspan=\"7\">" +
				"            <div id=\"auditDropZoneArea\" class='dropzoneSelector'></div>" +
				"            <input type=\"text\" name=\"atchmnflSeqno\" style=\"display: none;\" value=\""+vo.getAtchmnflSeqno()+"\">" +
				"        </td>" +
				"    </tr>" +
				"</table>";
		return form;
	}
	
	
	/**
	 * 결재 정보 저장
	 */
	private void saveSanctn(PcnMVo vo) {
		this.cmSanctnServiceImpl.saveSanctn(vo);
		this.pcnMDao.updatePcnSanctn(vo);
	}
	
	/**
	 * Pcn 회수
	 */
	public void revertPcn(PcnMVo vo) {
		this.cmSanctnServiceImpl.revert(vo);
	}
	
	// 변경점 저장 로직
	private void saveChangePoint(PcnMVo vo){
		
		if(vo.getChangePointApplcCn() != null) {
			// PCN 변경점 저장.
			String tempChangePointApplcCn = vo.getChangePointApplcCn();
			String[] changePointApplcCns = tempChangePointApplcCn.split(",");
			
			for(String changePointApplcCn : changePointApplcCns) {
				String chagePointApplcCode = pcnMDao.getChangePointApplcCode(changePointApplcCn);

				PcnChangePointVo changePointVo = new PcnChangePointVo();
				changePointVo.setChangePointApplcCode(chagePointApplcCode);
				changePointVo.setPcnSeqno(vo.getPcnSeqno());
				
				// PCN 변경점 저장.
				pcnMDao.insChangePoint(changePointVo);
			}
		} 
		
	}
	
}
