package lims.wrk.dao;

import java.util.List;

import lims.wrk.vo.CalcLawMVo;
import lims.wrk.vo.PrductMVo;

public interface CalcLawMDao {

	//계산식 조회
	public List<CalcLawMVo> getCalcLawMList(CalcLawMVo vo);

	//계산 수식 조회
	public List<CalcLawMVo> getCalcNomfrm(CalcLawMVo vo);

	//계산법 저장
	public int insExprMthCalc(CalcLawMVo vo);

	//계산법 수정
	public int updExprMthCalc(CalcLawMVo vo);

	//계산 수식 변수 저장
	public int insCalcNomfrmVriabl(CalcLawMVo vo);

	
	//계산 수식 변수 삭제
	public int delCalcNomfrmVriabl(String sCalcLawSeqno);

	//계산 수식 변수 삭제여부 'Y' 선진행, 계산 수식 삭제여부 'Y' 후진행
	public int delCalcLawAndVriabl(CalcLawMVo vo);

	//동일한 계산식 체크
	public int chkCalcInfo(CalcLawMVo vo);

	//자재 리스트
	public List<PrductMVo> getMtrilPopList(PrductMVo vo);

	//자재 하위 시험항목 리스트
	public List<CalcLawMVo> getCLMtrilExpriemList(CalcLawMVo vo);
	
	//계산식 콤보만들기
	public List<CalcLawMVo> getCalcLawCombo(CalcLawMVo vo);

	public CalcLawMVo getCalcMasterInfo(CalcLawMVo vo);
}
