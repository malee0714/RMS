package lims.wrk.service.Impl;

import java.util.List;

import lims.com.service.CmExmntTemplate;
import lims.com.service.CmSanctnService;
import lims.qa.vo.DocDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import lims.rsc.vo.ProductMVo;
import lims.wrk.dao.EntrpsSpecMDao;
import lims.wrk.service.EntrpsSpecMService;
import lims.wrk.vo.EntrpsSpecMVo;
import lims.wrk.vo.PrductMVo;

@Service("EntrpsSpecMService")
public class EntrpsSpecMServiceImpl implements EntrpsSpecMService{

	@Autowired
	public EntrpsSpecMServiceImpl(EntrpsSpecMDao entrpsSpecMDao, CmSanctnService cmSanctnServiceImpl, CmExmntTemplate cmExmntTemplate) {
		this.entrpsSpecMDao = entrpsSpecMDao;
		this.cmSanctnServiceImpl = cmSanctnServiceImpl;
		this.cmExmntTemplate = cmExmntTemplate;
	}
	private final EntrpsSpecMDao entrpsSpecMDao;
	private final CmSanctnService cmSanctnServiceImpl;
	private final CmExmntTemplate cmExmntTemplate;
	@Value("${style.table}")
	String tableStyle;

	@Value("${style.th}")
	String thStyle;

	@Value("${style.td}")
	String tdStyle;


	/**
	 * 제품 목록 규격 관리 조회
	 */
	@Override
	public List<EntrpsSpecMVo> getPrductListManage(EntrpsSpecMVo vo) {
		// TODO Auto-generated method stub
		return entrpsSpecMDao.getPrductListManage(vo);
	}
	
	
	/**
	 * 제품 목록 규격 결재 조회
	 */
	@Override
	public List<EntrpsSpecMVo> getPrductList(EntrpsSpecMVo vo) {
		// TODO Auto-generated method stub
		return entrpsSpecMDao.getPrductList(vo);
	}
	
	/**
	 * 자재 팝업 조회
	 * @param vo
	 * @return
	 */
	@Override
	public List<ProductMVo> getProductPopList(PrductMVo vo) {
		// TODO Auto-generated method stub
		return entrpsSpecMDao.getProductPopList(vo);
	}
	
	/**
	 * 제품 이력 조회
	 */
	@Override
	public List<EntrpsSpecMVo> getPrductHist(EntrpsSpecMVo vo) {
		// TODO Auto-generated method stub
		return entrpsSpecMDao.getPrductHist(vo);
	}	
	
	/**
	 * 시험 항목 조회
	 */
	@Override
	public List<EntrpsSpecMVo> getPrductCtmmnySdspcList(EntrpsSpecMVo vo) {
		// TODO Auto-generated method stub
		return entrpsSpecMDao.getPrductCtmmnySdspcList(vo);
	}
	
	/**
	 * 자재정보 조회
	 */
	@Override
	public List<EntrpsSpecMVo> getPrductCtmmnyMtrilList(EntrpsSpecMVo vo) {
		// TODO Auto-generated method stub
		return entrpsSpecMDao.getPrductCtmmnyMtrilList(vo);	
	}
	
	/**
	 * 결재순서 정보 조회
	 */
	@Override
	public List<EntrpsSpecMVo> getCmSanctnList(EntrpsSpecMVo vo) {
		// TODO Auto-generated method stub
		return entrpsSpecMDao.getCmSanctnList(vo);	
	}	

	/**
	 * 시험항목 항목추가 조회
	 */
	@Override
	public List<PrductMVo> getPrductExpriemList(PrductMVo vo) {		
		return entrpsSpecMDao.getPrductExpriemList(vo);
	}
	
	/**
	 * 고객사 규격관리 저장
	 */
	@Override
	public int saveEntrpsSpecM(EntrpsSpecMVo vo) {
		
		int result = 0; 
		
		try{
			//1. 처음 임시저장시 insApp == null
			//2. 임시저장 없이 결재상신 시  = insApp == insApp
			//3. 개정 후 임시저장 insApp == null 첫 임시저장 동일
			if(vo.getInsApp().equals("insApp")) { //첫저장때 바로 상신


				result = entrpsSpecMDao.insertSyPrductCtmmny(vo);
				
				EntrpsSpecMVo requestVo = new EntrpsSpecMVo();
				EntrpsSpecMVo materialVo = new EntrpsSpecMVo();
				EntrpsSpecMVo sanctnlVo = new EntrpsSpecMVo();
				EntrpsSpecMVo sanctnlVoSanctner = new EntrpsSpecMVo();
				this.approval(vo);
				//제품 고객사 시험항목 저장
				for(int i=0; i<vo.getRequestGridData().size(); i++){
					requestVo = vo.getRequestGridData().get(i);
					requestVo.setVer(vo.getVer());
					requestVo.setPrductCtmmnySeqno(vo.getPrductCtmmnySeqno());
					requestVo.setMarkCphr(requestVo.getCtmspcMarkCphr());
					requestVo.setUnitSeqno(requestVo.getCtmspcUnitSeqno());
					result += entrpsSpecMDao.insertSyPrductCtmmnySdspc(requestVo);
				}
				
				//자재 정보 저장
				for(int i=0; i<vo.getMaterialGridData().size(); i++){
					materialVo = vo.getMaterialGridData().get(i);
					materialVo.setVer(vo.getVer());
					materialVo.setPrductCtmmnySeqno(vo.getPrductCtmmnySeqno());
					result += entrpsSpecMDao.insertSyPrductCtmmnyMtril(materialVo);
				}

			} else { 
				//1. 임시저장
				//2. 개정 후 임시저장
			result = entrpsSpecMDao.updLastVer(vo);
			//제품 고객사 테이블 저장			
			result = entrpsSpecMDao.insertSyPrductCtmmny(vo);
			
			EntrpsSpecMVo requestVo = new EntrpsSpecMVo();
			EntrpsSpecMVo materialVo = new EntrpsSpecMVo();
			EntrpsSpecMVo sanctnlVo = new EntrpsSpecMVo();
			EntrpsSpecMVo sanctnlVoSanctner = new EntrpsSpecMVo();
			this.saveSanctn(vo);
			//제품 고객사 시험항목 저장
			for(int i=0; i<vo.getRequestGridData().size(); i++){
				requestVo = vo.getRequestGridData().get(i);
				requestVo.setVer(vo.getVer());
				requestVo.setPrductCtmmnySeqno(vo.getPrductCtmmnySeqno());
				requestVo.setMarkCphr(requestVo.getCtmspcMarkCphr());
				requestVo.setUnitSeqno(requestVo.getCtmspcUnitSeqno());
				result += entrpsSpecMDao.insertSyPrductCtmmnySdspc(requestVo);
			}
			//자재 정보 삭제
			entrpsSpecMDao.deleteSyPrductCtmmnyMtril(vo);
			//자재 정보 저장
			for(int i=0; i<vo.getMaterialGridData().size(); i++){
				materialVo = vo.getMaterialGridData().get(i);
				materialVo.setVer(vo.getVer());
				materialVo.setPrductCtmmnySeqno(vo.getPrductCtmmnySeqno());
				result += entrpsSpecMDao.insertSyPrductCtmmnyMtril(materialVo);
			}
		  }	
		}catch(Exception e){  
			result = 0;
			throw e;
		}
		return result;
	}
	
	 
	/**
	 * 고객사 규격관리 수정
	 */
	@Override
	public int updateEntrpsSpecM(EntrpsSpecMVo vo){
		int result = 0;
		
		try{
			
			EntrpsSpecMVo requestVo = new EntrpsSpecMVo();
			EntrpsSpecMVo materialVo = new EntrpsSpecMVo();
			EntrpsSpecMVo sanctnlVoSanctner = new EntrpsSpecMVo();


			this.saveSanctn(vo);
			if(vo.getCrud().equals("U")){
				result = entrpsSpecMDao.updatePrductCtmmny(vo);
			}
			
			//시험항목 수정 사항이 있을때만
			if(vo.getRequestCnt().equals("Y")){
				//제품 고객사 시험항목 저장
				//추가
				if(vo.getRequestAdd() != null){
					for(int i=0; i<vo.getRequestAdd().size(); i++){
						requestVo = vo.getRequestAdd().get(i);
						requestVo.setVer(vo.getVer());
						requestVo.setPrductCtmmnySeqno(vo.getPrductCtmmnySeqno());
						requestVo.setMarkCphr(requestVo.getCtmspcMarkCphr());
						requestVo.setUnitSeqno(requestVo.getCtmspcUnitSeqno());
						result += entrpsSpecMDao.insertPrductCtmmnySdspc(requestVo);
					}
				}
				
				if(vo.getRequestEdite() != null){
					//수정
					for(int i=0; i<vo.getRequestEdite().size(); i++){
						requestVo = vo.getRequestEdite().get(i);
						requestVo.setVer(vo.getVer());
						requestVo.setPrductCtmmnySeqno(vo.getPrductCtmmnySeqno());
						requestVo.setMarkCphr(requestVo.getCtmspcMarkCphr());
						requestVo.setUnitSeqno(requestVo.getCtmspcUnitSeqno());
						result += entrpsSpecMDao.updateSyPrductCtmmnySdspc(requestVo);
					}
				}
				
				if(vo.getRequestRemove() != null){
					//삭제
					for(int i=0; i<vo.getRequestRemove().size(); i++){
						requestVo = vo.getRequestRemove().get(i);
						requestVo.setVer(vo.getVer());
						requestVo.setPrductCtmmnySeqno(vo.getPrductCtmmnySeqno());
						requestVo.setMarkCphr(requestVo.getCtmspcMarkCphr());
						requestVo.setUnitSeqno(requestVo.getCtmspcUnitSeqno());
						result += entrpsSpecMDao.deleteSyPrductCtmmnySdspc(requestVo);
					}
				}
				
			}
			
			//자재 정보 삭제
			entrpsSpecMDao.deleteSyPrductCtmmnyMtril(vo);
			
			//자재 정보 저장
			for(int i=0; i<vo.getMaterialGridData().size(); i++){
				materialVo = vo.getMaterialGridData().get(i);
				materialVo.setVer(vo.getVer());
				materialVo.setPrductCtmmnySeqno(vo.getPrductCtmmnySeqno());
				result += entrpsSpecMDao.insertSyPrductCtmmnyMtril(materialVo);
			}

		}catch(Exception e){
			throw e;
		}		
		return result;		
	}

	/**
	 * 고객사 규격관리 개정
	 */
	@Override
	public int revisionEntrpsSpecM(EntrpsSpecMVo vo){
		int result = 0;
		
		try{
			this.approval(vo);
			//제품 고객사 테이블 저장
			result += entrpsSpecMDao.insertSyPrductCtmmny(vo);
			
			EntrpsSpecMVo requestVo = new EntrpsSpecMVo();
			EntrpsSpecMVo materialVo = new EntrpsSpecMVo();
			EntrpsSpecMVo sanctnlVoSanctner = new EntrpsSpecMVo();
			
			//제품 고객사 시험항목 저장
			//추가
			if(vo.getRequestGridData() != null){
				
				for(int i=0; i<vo.getRequestGridData().size(); i++){
					requestVo = vo.getRequestGridData().get(i);
					requestVo.setVer(vo.getVer());
					requestVo.setPrductCtmmnySeqno(vo.getPrductCtmmnySeqno());
					requestVo.setMarkCphr(requestVo.getCtmspcMarkCphr());
					requestVo.setUnitSeqno(requestVo.getCtmspcUnitSeqno());
					result += entrpsSpecMDao.insertPrductCtmmnySdspc(requestVo);
				}
			}
			
			if(vo.getRequestEdite() != null){
				//수정
				for(int i=0; i<vo.getRequestEdite().size(); i++){
					requestVo = vo.getRequestEdite().get(i);
					requestVo.setVer(vo.getVer());
					requestVo.setPrductCtmmnySeqno(vo.getPrductCtmmnySeqno());
					requestVo.setMarkCphr(requestVo.getCtmspcMarkCphr());
					requestVo.setUnitSeqno(requestVo.getCtmspcUnitSeqno());
					result += entrpsSpecMDao.updateSyPrductCtmmnySdspc(requestVo);
				}
			}
			
			if(vo.getRequestRemove() != null){
				//삭제
				for(int i=0; i<vo.getRequestRemove().size(); i++){
					requestVo = vo.getRequestRemove().get(i);
					requestVo.setVer(vo.getVer());
					requestVo.setPrductCtmmnySeqno(vo.getPrductCtmmnySeqno());
					requestVo.setMarkCphr(requestVo.getCtmspcMarkCphr());
					requestVo.setUnitSeqno(requestVo.getCtmspcUnitSeqno());
					result += entrpsSpecMDao.deleteSyPrductCtmmnySdspc(requestVo);
				}
			}
			
			//시험항목 버전 업데이트
			entrpsSpecMDao.updateSyPrductCtmmnySdspcVer(vo);
			
			//자재 정보 삭제
			entrpsSpecMDao.deleteSyPrductCtmmnyMtril(vo);
			
			//자재 정보 저장
			for(int i=0; i<vo.getMaterialGridData().size(); i++){
				materialVo = vo.getMaterialGridData().get(i);
				materialVo.setVer(vo.getVer());
				materialVo.setPrductCtmmnySeqno(vo.getPrductCtmmnySeqno());
				result += entrpsSpecMDao.insertSyPrductCtmmnyMtril(materialVo);
			}


		}catch(Exception e){
			throw e;
		}
		
		return result;
	}

	/**
	 * 현재 정보가 개정승인요청을 했는지 구분
	 */
	@Override
	public String getAmendmentAt(EntrpsSpecMVo vo) {
		return entrpsSpecMDao.getAmendmentAt(vo);
	}
	
	@Override
	public int delSyPrductCtmmny(EntrpsSpecMVo vo) {
		int result = 0;
		int ver = Integer.valueOf(vo.getVer());
		
		result =  entrpsSpecMDao.delSyPrductCtmmnyMtril(vo); // 자재 삭제
		result =  entrpsSpecMDao.delSyPrductCtmmnySdspc(vo); // 기준규격 삭제
		result =  entrpsSpecMDao.delSyPrductCtmmny(vo); //제품 삭제
		
		vo.setVer(String.valueOf(ver-1));
		result = entrpsSpecMDao.delUpdLastVer(vo);
		
		return result;
	}
	
	@Override
	// 임시저장 후 결재 상신
	// 개정 후 결재 상신
	// 회수 후 결재 상신
	public int insConfirmM(EntrpsSpecMVo vo) {

		int result = 0;

		//////////////////////////////////////
		EntrpsSpecMVo requestVo = new EntrpsSpecMVo();
		EntrpsSpecMVo materialVo = new EntrpsSpecMVo();
		EntrpsSpecMVo sanctnlVoSanctner = new EntrpsSpecMVo();
		this.approval(vo);
		if(vo.getCrud().equals("U")){
			result = entrpsSpecMDao.updatePrductCtmmny(vo);
			vo.setSanctnProgrsSittnCode("CM01000002");
			if(vo.getSanctnSeqno() != null){//임시저장 후 상신
				result = entrpsSpecMDao.updSanctnCon(vo);

			}  
		}
		if(vo.getCrud().equals("R")){
			result = entrpsSpecMDao.updLastVer(vo);
			result = entrpsSpecMDao.insertSyPrductCtmmny(vo);
			//제품 고객사 시험항목 저장
			for(int i=0; i<vo.getRequestGridData().size(); i++){
				requestVo = vo.getRequestGridData().get(i);
				requestVo.setVer(vo.getVer());
				requestVo.setPrductCtmmnySeqno(vo.getPrductCtmmnySeqno());
				requestVo.setMarkCphr(requestVo.getCtmspcMarkCphr());
				requestVo.setUnitSeqno(requestVo.getCtmspcUnitSeqno());
				result += entrpsSpecMDao.insertSyPrductCtmmnySdspc(requestVo);
			}
			vo.setSanctnProgrsSittnCode("CM01000002");
			result = entrpsSpecMDao.insertCMSanctn(vo);

		}
		//시험항목 수정 사항이 있을때만
		if(vo.getRequestCnt().equals("Y")){
			//제품 고객사 시험항목 저장
			//추가
			if(vo.getRequestAdd() != null){
				for(int i=0; i<vo.getRequestAdd().size(); i++){
					requestVo = vo.getRequestAdd().get(i);
					requestVo.setVer(vo.getVer());
					requestVo.setPrductCtmmnySeqno(vo.getPrductCtmmnySeqno());
					requestVo.setMarkCphr(requestVo.getCtmspcMarkCphr());
					requestVo.setUnitSeqno(requestVo.getCtmspcUnitSeqno());
					result += entrpsSpecMDao.insertPrductCtmmnySdspc(requestVo);
				}
			}
			
			if(vo.getRequestEdite() != null){
				//수정
				for(int i=0; i<vo.getRequestEdite().size(); i++){
					requestVo = vo.getRequestEdite().get(i);
					requestVo.setVer(vo.getVer());
					requestVo.setPrductCtmmnySeqno(vo.getPrductCtmmnySeqno());
					requestVo.setMarkCphr(requestVo.getCtmspcMarkCphr());
					requestVo.setUnitSeqno(requestVo.getCtmspcUnitSeqno());
					result += entrpsSpecMDao.updateSyPrductCtmmnySdspc(requestVo);
				}
			}
			
			if(vo.getRequestRemove() != null){
				//삭제
				for(int i=0; i<vo.getRequestRemove().size(); i++){
					requestVo = vo.getRequestRemove().get(i);
					requestVo.setVer(vo.getVer());
					requestVo.setPrductCtmmnySeqno(vo.getPrductCtmmnySeqno());
					requestVo.setMarkCphr(requestVo.getCtmspcMarkCphr());
					requestVo.setUnitSeqno(requestVo.getCtmspcUnitSeqno());
					result += entrpsSpecMDao.deleteSyPrductCtmmnySdspc(requestVo);
				}
			}
			
		}
		//자재 정보 삭제
		entrpsSpecMDao.deleteSyPrductCtmmnyMtril(vo);
		//자재 정보 저장
		for(int i=0; i<vo.getMaterialGridData().size(); i++){
			materialVo = vo.getMaterialGridData().get(i);
			materialVo.setVer(vo.getVer());
			materialVo.setPrductCtmmnySeqno(vo.getPrductCtmmnySeqno());
			result += entrpsSpecMDao.insertSyPrductCtmmnyMtril(materialVo);
		}


		return result;
	}

	private void setCn(EntrpsSpecMVo vo) {
		vo.setSj("고객사 규격 (" + vo.getEntrpsNm() + ")");
		vo.setCn(this.getSaveFormHtml(vo));
	}

	/**
	 * 결재 정보, 결재자 정보, cn정보 저장 및 결재 seqno 업데이트
	 */
	private void saveSanctn(EntrpsSpecMVo vo) {
		this.setCn(vo);
		this.cmSanctnServiceImpl.saveSanctn(vo);
		this.entrpsSpecMDao.updSanctnSeqno(vo);
	}
	/**
	 * 결재 상신
	 */
	private void approval(EntrpsSpecMVo vo) {
		this.saveSanctn(vo);
		cmSanctnServiceImpl.approvalRequest(vo);
	}

	private String getSaveFormHtml(EntrpsSpecMVo vo) {

		String form =
				"<h2>문서 정보<h2>" +
						"<table " + tableStyle + ">" +
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
						"        <th " + thStyle + ">업체 정보</th> " +
						"        <td " + tdStyle + "> " + vo.getEntrpsNm() + " </td>" +
						"        <th " + thStyle + ">기준 명</th> " +
						"        <td " + tdStyle + ">" + vo.getStdrNm() + "</td>" +
						"        <th " + thStyle + ">시작 일자</th>" +
						"        <td " + tdStyle + ">" + vo.getBeginDte() + "</td>" +
						"        <th " + thStyle + ">사용 여부</th>" +
						"        <td " + tdStyle + ">" + vo.getUseAt() + "</td>" +
						"    </tr>" +
						"    <tr>" +
						"        <th " + thStyle + ">변경 사유</th>" +
						"        <td " + tdStyle + " colspan=\"7\">" + vo.getUpdtResn() + "</td>" +
						"    </tr>" +
						"    <tr>" +
						"        <th " + thStyle + ">첨부파일</th>" +
						"        <td " + tdStyle + " colspan=\"7\">" +
						"            <div id=\"dropZoneArea\" class='dropzoneSelector'></div>" +
						"            <input type=\"text\" name=\"atchmnflSeqno\" style=\"display: none;\" value=\"" + vo.getAtchmnflSeqno() + "\">" +
						"        </td>" +
						"    </tr>" +
						"</table>"+
						"<table " + tableStyle + ">" +
						" <colgroup>" +
						"        <col style=\"width:10%\"/>" +
						"        <col style=\"width:15%\"/>" +
						"        <col style=\"width:10%\"/>" +
						"        <col style=\"width:15%\"/>" +
						"        <col style=\"width:10%\"/>" +
						"        <col style=\"width:15%\"/>" +
						"        <col style=\"width:10%\"/>" +
						"        <col style=\"width:15%\"/>" +
						"    </colgroup>";
						for(int i = 0;i<vo.getRequestListData().size();i++) {
							EntrpsSpecMVo requestVo = vo.getRequestListData().get(i);
							String from2 =
									"    <tr>" +
									"        <th " + thStyle + ">제품명</th> " +
									"        <td " + tdStyle + "> " + requestVo.getMtrilNm() + " </td>" +
									"        <th " + thStyle + ">시험항목 명</th> " +
									"        <td " + tdStyle + ">" + requestVo.getExpriemNm() + "</td>" +
									"        <th " + thStyle + ">LSL</th>" +
									"        <td " + tdStyle + ">" + requestVo.getExtrlMummValue() + "</td>" +
									"        <th " + thStyle + ">USL</th>" +
									"        <td " + tdStyle + ">" + requestVo.getExtrlMxmmValue() + "</td>" +
									"    </tr>";
						form+=from2;
						}
		return form+"</table>";
	}
}
