package lims.rsc.service.Impl;


import lims.rsc.dao.EqpmnEdayChckDao;
import lims.rsc.service.EqpmnEdayChckService;
import lims.rsc.vo.EqpmnEdayChckDto;
import lims.util.CommonFunc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EqpmnEdayChckServiceImpl implements EqpmnEdayChckService {

	private final CommonFunc commonFunc;
	private final EqpmnEdayChckDao eqpmnEdayChckDao;

	@Autowired
	public EqpmnEdayChckServiceImpl(CommonFunc commonFunc, EqpmnEdayChckDao eqpmnEdayChckDao) {
		this.commonFunc = commonFunc;
		this.eqpmnEdayChckDao = eqpmnEdayChckDao;
	}

	@Override
	public List<EqpmnEdayChckDto> getEqpmnEdayChkList(EqpmnEdayChckDto eqpmnEdayChckDto) {
		return eqpmnEdayChckDao.getEqpmnEdayChkList(eqpmnEdayChckDto);
	}

	@Override
	public int chkDuplicateChckDte(EqpmnEdayChckDto eqpmnEdayChckDto) {
		return eqpmnEdayChckDao.chkDuplicateChckDte(eqpmnEdayChckDto);
	}

	@Override
	public int saveEqpEdayChkResult(EqpmnEdayChckDto eqpmnEdayChckDto) {
		int result = 0;

		List<EqpmnEdayChckDto> exprList = eqpmnEdayChckDto.getEdayChckExprList();

		// 등록된 일상점검정보 삭제
		if (("Y").equals(eqpmnEdayChckDto.getDeleteAt())) {
			return eqpmnEdayChckDao.updEqpEdayChkRegist(eqpmnEdayChckDto);
		}

		if (commonFunc.isEmpty(eqpmnEdayChckDto.getEqpmnEdayChckRegistSeqno())) {
			result += eqpmnEdayChckDao.insEqpEdayChkRegist(eqpmnEdayChckDto);
			
			for (EqpmnEdayChckDto data : exprList) {
				data.setEqpmnEdayChckRegistSeqno(eqpmnEdayChckDto.getEqpmnEdayChckRegistSeqno());
				result += eqpmnEdayChckDao.insEqpEdayChkResult(data);
			}
			
		} else {
			result += eqpmnEdayChckDao.updEqpEdayChkRegist(eqpmnEdayChckDto);

			for (EqpmnEdayChckDto data : exprList) {
				result += eqpmnEdayChckDao.updEqpEdayChckResult(data);
			}
		}

		return (result > 0) ? Integer.parseInt(eqpmnEdayChckDto.getEqpmnEdayChckRegistSeqno()) : result;
	}
	
	@Override
	public List<EqpmnEdayChckDto> getEqpEdayChckExprM(EqpmnEdayChckDto eqpmnEdayChckDto) {
		return eqpmnEdayChckDao.getEqpEdayChckExprM(eqpmnEdayChckDto);
	}
	
	@Override
	public List<EqpmnEdayChckDto> getEqpEdayChckResult(EqpmnEdayChckDto eqpmnEdayChckDto) {
		return eqpmnEdayChckDao.getEqpEdayChckResult(eqpmnEdayChckDto);
	}

	@Override
	public List<EqpmnEdayChckDto> getEqpmnListOnPop(EqpmnEdayChckDto eqpmnEdayChckDto) {
		return eqpmnEdayChckDao.getEqpmnListOnPop(eqpmnEdayChckDto);
	}

}
