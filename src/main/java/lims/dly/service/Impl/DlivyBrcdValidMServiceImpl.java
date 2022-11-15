package lims.dly.service.Impl;

import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import lims.dly.dao.DlivyBrcdValidMDao;
import lims.dly.service.DlivyBrcdValidMService;
import lims.dly.vo.DlivyMVo;

@Service("DlivyBrcdValidMService")
public class DlivyBrcdValidMServiceImpl implements DlivyBrcdValidMService {

	@Autowired
	private DlivyBrcdValidMDao dlivyBrcdValidM;
	
	/**
	 * 바코드 검증 조회
	 */
	@Override	
	public HashMap<String, Object> getBrcdVal(DlivyMVo vo) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> tempMap = new HashMap<String, Object>();
		
		int resultCnt = 0;
		
		try{
			//바코드 개별조회
			for(int i=1; i<=Integer.valueOf(vo.getTot()); i++){
				HashMap<String, Object> voVlidation = new HashMap<String, Object>();
				tempMap = new HashMap<String, Object>();
				
				if(i==1){
					voVlidation.put("brcd1", vo.getBrcd1());		
				}
				else if(i==2){
					voVlidation.put("brcd2", vo.getBrcd2());
				}			
				else if(i==3){
					voVlidation.put("brcd3", vo.getBrcd3());
				}
				else if(i==4){
					voVlidation.put("brcd4", vo.getBrcd4());
				}
				else if(i==5){
					voVlidation.put("brcd5", vo.getBrcd5());
				}
				
				int Vlidation = dlivyBrcdValidM.getBrcdValidation(voVlidation);

				if(Vlidation > 0){
					tempMap.put("msg", "합격");
					tempMap.put("result", true);
					resultMap.put("indiviBrcd"+i, tempMap);
				}
				else{
					tempMap.put("msg", "불합격");
					tempMap.put("result", false);
					resultMap.put("indiviBrcd"+i, tempMap);
					resultCnt++;
				}
			}
			
			//바코드 조회
			DlivyMVo firstVo = dlivyBrcdValidM.getBrcdVal(vo);
			
						
			//조회된 값이 없을때
			if(firstVo == null){
				resultMap.put("msg", "불합격");
				resultMap.put("result", false);
				resultCnt++;
			}
			else{
				//갯수 안맞음
				if(Integer.valueOf(firstVo.getTopRepr()) != Integer.valueOf(vo.getTot())){
					tempMap = new HashMap<String, Object>();				
					tempMap.put("msg", "불합격");
					tempMap.put("result", false);	
					resultMap.put("topRepr", tempMap);
					resultCnt++;
				}
				
				
				//생성일 불합격
				if(!firstVo.getBrcdCreatDte().equals(vo.getBrcdCreatDte())){
					tempMap = new HashMap<String, Object>();				
					tempMap.put("msg", "불합격");
					tempMap.put("result", false);				
					resultMap.put("brcdCreatDte", tempMap);
					resultCnt++;
				}
				else{
					tempMap = new HashMap<String, Object>();				
					
					tempMap.put("msg", "합격");
					tempMap.put("result", true);
					resultMap.put("brcdCreatDte", tempMap);
					
				}

				//제조팀 비교
				if(!firstVo.getDeptCode().equals(vo.getDeptCode())){
					tempMap = new HashMap<String, Object>();				
					tempMap.put("msg", "불합격");
					tempMap.put("result", false);
					resultMap.put("deptCode", tempMap);
					resultCnt++;
				}
				else{
					tempMap = new HashMap<String, Object>();	
					
					tempMap.put("msg", "합격");
					tempMap.put("result", true);
					resultMap.put("deptCode", tempMap);
					
				}
			
				if(vo.getBrValid().equals("1")) {

					//출하처 비교 (출고지시서때 출하처가 등록되있는지 확인)
					//출하처 없을때
					if(firstVo.getShipmntLcCode() == null || firstVo.getShipmntLcCode() =="") {
						//출하처 없고 입력값도 없을때는 검증 성공
						if(firstVo.getShipmntLcCode()== null && vo.getShipmntLcCode()==""){
							tempMap = new HashMap<String, Object>();	
							tempMap.put("msg", "합격");
							tempMap.put("result", true);
							resultMap.put("shipmntLcCode", tempMap);
							
						//출하처 없고 입력값은 있을때 실패	
						} else {
							tempMap = new HashMap<String, Object>();				
							tempMap.put("msg", "불합격");
							tempMap.put("result", false);
							resultMap.put("shipmntLcCode", tempMap);
							resultCnt++;
						}
					//출하처 있을때	
					} else {
						//출하처 있을때 입력값과 비교 값이 같으면 검증 성공
						if(firstVo.getShipmntLcCode().equals(vo.getShipmntLcCode())){
							tempMap = new HashMap<String, Object>();	
							tempMap.put("msg", "합격");
							tempMap.put("result", true);
							resultMap.put("shipmntLcCode", tempMap);
						//값이 다르면 실패
						} else {
							tempMap = new HashMap<String, Object>();				
							tempMap.put("msg", "불합격");
							tempMap.put("result", false);
							resultMap.put("shipmntLcCode", tempMap);
							resultCnt++;
						}
					}
				}
				else {
					tempMap = new HashMap<String, Object>();	
					tempMap.put("msg", "합격");
					tempMap.put("result", true);
					resultMap.put("shipmntLcCode", tempMap);
				}

				
				
				HashMap<String, Object> updDlibyDetailMap = new HashMap<String, Object>();
				
				//검증여부가 Y일때 이미 합격한 바코드면 튕겨냄
				if(resultCnt == 0 && firstVo.getVrifyQy() > 0 &&firstVo.getVrifyAt().equals("Y")){
					if(firstVo.getVrifyQy() == firstVo.getVrifyCnt()){
						tempMap = new HashMap<String, Object>();
						resultMap.put("msg", "불합격");
						resultMap.put("result", false);
						
						tempMap.put("msg", "이미 검증된 바코드 입니다.");
						tempMap.put("result", false);
						resultMap.put("vrifyAt", tempMap);
						return resultMap;
					}
					
//					if(firstVo.getDlivyBrcdSttusCode().equals("IM16000002")){
//						tempMap = new HashMap<String, Object>();
//						resultMap.put("msg", "불합격");
//						resultMap.put("result", false);
//						
//						tempMap.put("msg", "이미 검증된 바코드 입니다.");
//						tempMap.put("result", false);
//						resultMap.put("vrifyAt", tempMap);
//						return resultMap;
//					}
				}

				//resultCnt 0이면 합격 아니면 불합격
				
				if(resultCnt == 0){
					if(resultCnt == 0 && firstVo.getVrifyQy() > 0 &&firstVo.getVrifyAt().equals("Y")){
						updDlibyDetailMap.put("vrifyCnt", firstVo.getVrifyCnt() + 1);
					}
					updDlibyDetailMap.put("dlivyBrcdSttusCode", "IM16000002");
					updDlibyDetailMap.put("dlivyBrcdSeqno", firstVo.getDlivyBrcdSeqno());
					updDlibyDetailMap.put("ordr", firstVo.getOrdr());		
					updDlibyDetailMap.put("shipmntLcCode", vo.getShipmntLcCode());
					updDlibyDetailMap.put("dlivyDte", vo.getDlivyDte());
					dlivyBrcdValidM.updDlivyBrcdDetailSttusCode(updDlibyDetailMap);
					
					resultMap.put("msg", "합격");
					resultMap.put("result", true);
				}
				else if(resultCnt > 0){
					if(firstVo.getVrifyAt().equals("N")){
						updDlibyDetailMap.put("dlivyBrcdSttusCode", "IM16000003");
						updDlibyDetailMap.put("dlivyBrcdSeqno", firstVo.getDlivyBrcdSeqno());
						updDlibyDetailMap.put("ordr", firstVo.getOrdr());
						dlivyBrcdValidM.updDlivyBrcdDetailSttusCode(updDlibyDetailMap);
					}
					resultMap.put("msg", "불합격");
					resultMap.put("result", false);
				}
			}

			DlivyMVo sttuCodeVo = new DlivyMVo();
			sttuCodeVo.setDlivyBrcdSeqno(firstVo.getDlivyBrcdSeqno());
			DlivyMVo valResult = dlivyBrcdValidM.getBrcdProgrsSittnCode(sttuCodeVo);
			
			if(firstVo != null){
				//바코드 상세가 모두 합격이면 바코드 테이블의 상태를 합격으로 저장
				if(valResult.getSuccessResult().equals("Y")){
					sttuCodeVo.setShipmntLcCode(vo.getShipmntLcCode());
					sttuCodeVo.setDlivyBrcdSttusCode("IM16000002");
					dlivyBrcdValidM.updDlivyBrcdInfoSttusCode(sttuCodeVo);
				}
				else if(valResult.getSuccessResult().equals("N")){
					sttuCodeVo.setDlivyBrcdSttusCode("IM16000003");
					dlivyBrcdValidM.updDlivyBrcdInfoSttusCode(sttuCodeVo);
				}
				else if(valResult.getSuccessResult().equals("N/A")){
					sttuCodeVo.setShipmntLcCode(vo.getShipmntLcCode());
					sttuCodeVo.setDlivyBrcdSttusCode("IM16000001");
					dlivyBrcdValidM.updDlivyBrcdInfoSttusCode(sttuCodeVo);
				}
			}
			resultMap.put("data", firstVo);			
		}catch(Exception e){
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}

		return resultMap;
	}

}
