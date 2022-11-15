package lims.wrk.service.Impl;

import java.util.List;

import javax.annotation.Resource;

import lims.wrk.vo.PrductMVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.util.CommonFunc;
import lims.wrk.dao.CalcLawMDao;
import lims.wrk.service.CalcLawMService;
import lims.wrk.vo.CalcLawMVo;

@Service
public class CalcLawMServiceImpl implements CalcLawMService {

	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Autowired
    private CalcLawMDao calcLawMDao;

	@Override
	public List<CalcLawMVo> getCalcLawMList(CalcLawMVo vo) {
		return calcLawMDao.getCalcLawMList(vo);
	}

	@Override
	public List<CalcLawMVo> getCalcNomfrm(CalcLawMVo vo) {
		return calcLawMDao.getCalcNomfrm(vo);
	}

	@Override
	public String saveExprMthCalc(CalcLawMVo vo) {

		if(commonFunc.isEmpty(vo.getCalcLawSeqno())) {
			calcLawMDao.insExprMthCalc(vo);
		} else {
			calcLawMDao.updExprMthCalc(vo);
		}
		
		//계산 수식 삭제 후 다시 등록
		calcLawMDao.delCalcNomfrmVriabl(vo.getCalcLawSeqno());
		vo.getList().forEach(v -> {
			v.setCalcLawSeqno(vo.getCalcLawSeqno());
			calcLawMDao.insCalcNomfrmVriabl(v);
		});
		
		return vo.getCalcLawSeqno();
	}

	@Override
	public int delCalcLawInfo(CalcLawMVo vo) {
		return calcLawMDao.delCalcLawAndVriabl(vo);
	}

	@Override
	public int chkCalcInfo(CalcLawMVo vo) {
		return calcLawMDao.chkCalcInfo(vo);
	}

	@Override
	public List<PrductMVo> getMtrilPopList(PrductMVo vo) {
		return calcLawMDao.getMtrilPopList(vo);
	}

	@Override
	public List<CalcLawMVo> getCLMtrilExpriemList(CalcLawMVo vo) {
		return calcLawMDao.getCLMtrilExpriemList(vo);
	}

	//계산식 콤보만들기
	@Override
	public List<CalcLawMVo> getCalcLawCombo(CalcLawMVo vo) {
		return calcLawMDao.getCalcLawCombo(vo);
	}

	//계산식 마스터 데이터 조회하기
	@Override
	public CalcLawMVo getCalcMasterInfo(CalcLawMVo vo) {
		CalcLawMVo calcLawVo = new CalcLawMVo(); 
		calcLawVo = calcLawMDao.getCalcMasterInfo(vo);
		calcLawVo.setList(calcLawMDao.getCalcNomfrm(vo));
		return calcLawVo;
	}
}
