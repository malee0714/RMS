package lims.rsc.service.Impl;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.rsc.dao.EqpmnRlabltyEvlDao;
import lims.rsc.service.EqpmnRlabltyEvlService;
import lims.rsc.vo.EqpmnManageDto;
import lims.rsc.vo.EqpmnRlabltyEvlVo;
import lims.util.CustomException;

@Service
public class EqpmnRlabltyEvlServiceImpl implements EqpmnRlabltyEvlService{

	@Autowired
    private EqpmnRlabltyEvlDao eqpmnRlabltyEvlDao;
	
	/**
	 * 장비 신뢰성평가 목록 조회
	 */
	@Override
	public List<EqpmnRlabltyEvlVo> searchEqpmnRlabltyEvlRegst(EqpmnRlabltyEvlVo vo) {
		return eqpmnRlabltyEvlDao.searchEqpmnRlabltyEvlRegst(vo);
	}
	
	/**
	 * 장비 신뢰성평가 저장된 시험항목 목록 조회
	 */
	@Override
	public List<EqpmnRlabltyEvlVo> searchEqpmnRlabltyEvlRegstSub(EqpmnRlabltyEvlVo vo) {
		return eqpmnRlabltyEvlDao.searchEqpmnRlabltyEvlRegstSub(vo);
	}
	
	/**
	 * 장비 신뢰성평가 저장
	 */
	@Override
	public int saveEqpmnRlabltyEvlRegstDate(EqpmnRlabltyEvlVo vo) {
		try{
			int result = 0;
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			String datestr = dateFormat.format(cal.getTime());
			List<EqpmnRlabltyEvlVo> list = vo.getList(); //신뢰성 시험항목 결과 리스트
			EqpmnManageDto eqpmnManageDto = eqpmnRlabltyEvlDao.getInspctCrrctCycle(vo);
			
			// 장비 마스터에 주기 정보 등록이 안되어 있다면 저장 못하도록 함
			if(eqpmnManageDto == null) {
				return result;
			}
			
			String detectLimitApplcAt = eqpmnRlabltyEvlDao.getRsEqpmnDetectLimitApplcAt(vo);
			//---------------------------------장비 신뢰성 평가 등록 일련번호 시퀀스 호출 ---------------------------------
			if(vo.getEqpmnRlabltyEvlRegistSeqno() == 0  || "".equals(vo.getEqpmnRlabltyEvlRegistSeqno())){
				result =  eqpmnRlabltyEvlDao.insEqpmnRlabltyEvlRegstDate(vo);
			}
			else{
				result =  eqpmnRlabltyEvlDao.updEqpmnRlabltyEvlRegstDate(vo);
				
			}
			//---------------------------------장비 신뢰성 평가 저장 ---------------------------------
			
			
			//장비 교정테이블에 데이터 평가일자 업데이트
			 Date evlDte = dateFormat.parse(vo.getEvlDte());
	         Date tobay = dateFormat.parse(datestr);
	         Calendar evlDteCalendar = Calendar.getInstance();
	         evlDteCalendar.setTime(evlDte);

			if(tobay.compareTo(evlDte)<0 || tobay.compareTo(evlDte)==0){		
				if("SY14000001".equals(eqpmnManageDto.getCycleCode())){
					Integer integerAddDay = eqpmnManageDto.getInspctCrrctCycle();
					int addDay = integerAddDay.intValue();
					evlDteCalendar.add(Calendar.YEAR, addDay);
				}else if("SY14000002".equals(eqpmnManageDto.getCycleCode())){
					Integer integerAddDay = eqpmnManageDto.getInspctCrrctCycle();
					int addDay = integerAddDay.intValue();
					evlDteCalendar.add(Calendar.MONTH, addDay*6);
				}else if("SY14000003".equals(eqpmnManageDto.getCycleCode())){
					Integer integerAddDay = eqpmnManageDto.getInspctCrrctCycle();
					int addDay = integerAddDay.intValue();
					evlDteCalendar.add(Calendar.MONTH, addDay*3);
				}else if("SY14000004".equals(eqpmnManageDto.getCycleCode())){
					Integer integerAddDay = eqpmnManageDto.getInspctCrrctCycle();
					int addDay = integerAddDay.intValue();
					evlDteCalendar.add(Calendar.MONTH, addDay);
				}else if("SY14000005".equals(eqpmnManageDto.getCycleCode())){
					Integer integerAddDay = eqpmnManageDto.getInspctCrrctCycle();
					int addDay = integerAddDay.intValue();
					evlDteCalendar.add(Calendar.DATE, addDay);
				}
				String inspctCrrctPrearngeDte = dateFormat.format(evlDteCalendar.getTime());
				eqpmnManageDto.setInspctCrrctPrearngeDte(inspctCrrctPrearngeDte);
				eqpmnManageDto.setRecentInspctCrrctDte(vo.getEvlDte());
				// 장비 검사 교정 주기 업데이트
				eqpmnRlabltyEvlDao.updateInspctCrrctCycle(eqpmnManageDto);
			}
			//---------------------------------장비 신뢰성 평가 결과값 저장 ---------------------------------
			if(list.size()>0){
				for(int i=0;i< list.size();i++){
					EqpmnRlabltyEvlVo map = list.get(i);
					if(map.getEqpmnRlabltyEvlRegistSeqno() == 0  || "".equals(map.getEqpmnRlabltyEvlRegistSeqno())){
						map.setEqpmnRlabltyEvlRegistSeqno(vo.getEqpmnRlabltyEvlRegistSeqno());
					}
					if(vo.getBplcCode() == null || "".equals(vo.getBplcCode())){
						map.setBplcCode(vo.getBestInspctInsttCode());
					}else{
						map.setBplcCode(vo.getBplcCode());
					}
					eqpmnRlabltyEvlDao.saveEqpmnRlabltyEvlRegstSubDate(map);
					/*
					 * 검사교정구분이 DL이면서 선택된 장비의 DL적용여부가 ‘Y’인 경우 RS_장비분류검출한계 테이블에 INSERT
					 * */
					
					
					if("RS24000003".equals(vo.getInspctCrrctSeCode())){
						if("Y".equals(detectLimitApplcAt)){
							
							map.setEqpmnRlabltyEvlRegistSeqno(vo.getEqpmnRlabltyEvlRegistSeqno());
							map.setEqpmnClCode(vo.getEqpmnClCode());
							map.setRm(vo.getRm());
							map.setEvlDte(vo.getEvlDte());
							if(map.getDetectLimitSeqno()==0 || "".equals(map.getDetectLimitSeqno())){
								eqpmnRlabltyEvlDao.updateRsEqpmnClDetectLimitOldDate(map); //DL쪽 종료일짜가 오늘날짜보다큰 데이터  오늘날짜의 하루전으로 UPDATE
								eqpmnRlabltyEvlDao.saveRsEqpmnClDetectLimitDate(map);	
							}
							else{
								eqpmnRlabltyEvlDao.updRsEqpmnClDetectLimitDate(map);
							}
							
						}
					}
				}
			}
			
			return result ;
		}catch(Exception e){
			throw new CustomException(e, vo, "저장 및 수정이 정상적으로 처리되지 않았습니다.");
		}
	}
	
	/**
	 * 장비 신뢰성평가 삭제
	 */
	@Override
	public int updateEqpmnRlabltyEvlRegstDel(EqpmnRlabltyEvlVo vo) {
		try{
			int result=0;
			result =  eqpmnRlabltyEvlDao.updateEqpmnRlabltyEvlRegstDel(vo);
			return result ;
		}catch(Exception e){
			throw new CustomException(e, vo, "삭제가 정상적으로 처리되지 않았습니다.");
		}
	}
	
	/**
	 * 장비 신뢰성평가 시험항목 목록 조회
	 */
	@Override
	public List<EqpmnRlabltyEvlVo> getRsEqpmnRlabltyEvlExpriem(EqpmnRlabltyEvlVo vo) {
		return eqpmnRlabltyEvlDao.getRsEqpmnRlabltyEvlExpriem(vo);
	}
	
	/**
	 * 장비 신뢰성평가 시험항목 목록 조회
	 */
	@Override
	public EqpmnRlabltyEvlVo getSelectEqpmnManageNo(EqpmnRlabltyEvlVo vo) {
		return eqpmnRlabltyEvlDao.getSelectEqpmnManageNo(vo);
	}
	
	/**
	 * 장비 검사 교정  데이터 호출
	 */
	@Override
	public List<EqpmnRlabltyEvlVo> getCmmnInspctCode(EqpmnRlabltyEvlVo vo) {
		return eqpmnRlabltyEvlDao.getCmmnInspctCode(vo);
	}
	
	/**
	 * 장비 관리번호 조회
	 */
	@Override
	public int getChkRegistDate(EqpmnRlabltyEvlVo vo) {
		int result = 0;
		result =  eqpmnRlabltyEvlDao.getChkRegistDate(vo);
		return result;
	}

}
