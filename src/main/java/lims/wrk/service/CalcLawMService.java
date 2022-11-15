package lims.wrk.service;

import java.util.List;

import lims.wrk.vo.CalcLawMVo;
import lims.wrk.vo.PrductMVo;

public interface CalcLawMService {

	//계산식 조회
	public List<CalcLawMVo> getCalcLawMList(CalcLawMVo vo);

	//계산 수식 조회
	public List<CalcLawMVo> getCalcNomfrm(CalcLawMVo vo);

	//계산법 저장
	public String saveExprMthCalc(CalcLawMVo vo);

	//계산식 삭제여부 'Y'
	public int delCalcLawInfo(CalcLawMVo vo);

	//동일한 계산식 체크
	public int chkCalcInfo(CalcLawMVo vo);

	//자재 리스트
	public List<PrductMVo> getMtrilPopList(PrductMVo vo);

	//자재 하위 시험항목 리스트
	public List<CalcLawMVo> getCLMtrilExpriemList(CalcLawMVo vo);
	
	//계산식 콤보만들기
	public List<CalcLawMVo> getCalcLawCombo(CalcLawMVo vo);

	//계산식 마스터 데이터 조회하기
	public CalcLawMVo getCalcMasterInfo(CalcLawMVo vo);
}
