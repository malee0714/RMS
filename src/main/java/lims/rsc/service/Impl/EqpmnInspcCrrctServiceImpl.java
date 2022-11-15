package lims.rsc.service.Impl;

import lims.rsc.dao.EqpmnInspcCrrctDao;
import lims.rsc.service.EqpmnInspcCrrctService;
import lims.rsc.vo.EqpmnInspcCrrctDto;
import lims.util.CommonFunc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EqpmnInspcCrrctServiceImpl implements EqpmnInspcCrrctService {

	private final EqpmnInspcCrrctDao eqpmnInspcCrrctDao;
	private final CommonFunc commonFunc;

	@Autowired
	public EqpmnInspcCrrctServiceImpl(EqpmnInspcCrrctDao eqpmnInspcCrrctDao, CommonFunc commonFunc) {
		this.eqpmnInspcCrrctDao = eqpmnInspcCrrctDao;
		this.commonFunc = commonFunc;
	}

	@Override
	public List<EqpmnInspcCrrctDto> getEqpmnInspctList(EqpmnInspcCrrctDto eqpmnInspcCrrctDto) {
		return eqpmnInspcCrrctDao.getEqpmnInspctList(eqpmnInspcCrrctDto);
	}

	@Override
	public int saveEqpmnInspctCrrct(EqpmnInspcCrrctDto eqpmnInspcCrrctDto) {
		int result = 0;

		if (("Y").equals(eqpmnInspcCrrctDto.getDeleteAt())) {
			//검교정예정일자와 최근검교정일자 초기화
			eqpmnInspcCrrctDto.setNextInspctCrrctDte("");
			eqpmnInspcCrrctDto.setInspctCrrctDte("");
			eqpmnInspcCrrctDto.setInspctCrrctSeCode("RS24000001");
			eqpmnInspcCrrctDao.updInspctCrrctDte(eqpmnInspcCrrctDto);

			//검교정정보 삭제 전, 해당 검교정에 딸린 검교정의뢰 삭제
			if (eqpmnInspcCrrctDto.isExistReq()) {
				List<EqpmnInspcCrrctDto> inspctReqList = eqpmnInspcCrrctDto.getExistReqList();
				for (EqpmnInspcCrrctDto dto : inspctReqList) {
					eqpmnInspcCrrctDao.delEqpInspctCrrctReq(dto);
				}
			}

			//검교정정보 삭제
			return eqpmnInspcCrrctDao.updEqpmnInspctCrrct(eqpmnInspcCrrctDto);
		}

		//검교정정보 등록
		if (commonFunc.isEmpty(eqpmnInspcCrrctDto.getEqpmnInspctCrrctSeqno())) {
			result += eqpmnInspcCrrctDao.insEqpmnInspctCrrct(eqpmnInspcCrrctDto);
		} else {
			result += eqpmnInspcCrrctDao.updEqpmnInspctCrrct(eqpmnInspcCrrctDto);
		}


		//검교정의뢰 등록
		if (eqpmnInspcCrrctDto.isExistReq()) {
			if (eqpmnInspcCrrctDto.isAddedReq()) {
				List<EqpmnInspcCrrctDto> addedList = eqpmnInspcCrrctDto.getAddedReqList();
				for (EqpmnInspcCrrctDto addedRow : addedList) {
					addedRow.setEqpmnInspctCrrctSeqno(eqpmnInspcCrrctDto.getEqpmnInspctCrrctSeqno());
					result += eqpmnInspcCrrctDao.insEqpInspctCrrctReq(addedRow);
				}
			}
		}

		//등록하려는 검교정일자가 오늘날짜보다 이전날짜가 아닌 경우에만 주기정보 업데이트
		if (("Y").equals(eqpmnInspcCrrctDto.getCycleUpdAt())) {
			eqpmnInspcCrrctDto.setInspctCrrctSeCode("RS24000001");

			result += eqpmnInspcCrrctDao.updInspctCrrctDte(eqpmnInspcCrrctDto);
		}
			
		return (result > 0) ? eqpmnInspcCrrctDto.getEqpmnInspctCrrctSeqno() : result;
	}

	@Override
	public EqpmnInspcCrrctDto chkExistAtInspctCycle(EqpmnInspcCrrctDto eqpmnInspcCrrctDto) {
		return eqpmnInspcCrrctDao.chkExistAtInspctCycle(eqpmnInspcCrrctDto);
	}

	@Override
	public int chkDuplicateInspctDte(EqpmnInspcCrrctDto eqpmnInspcCrrctDto) {
		return eqpmnInspcCrrctDao.chkDuplicateInspctDte(eqpmnInspcCrrctDto);
	}

	@Override
	public List<EqpmnInspcCrrctDto> getEqpInspctCrrctReq(EqpmnInspcCrrctDto eqpmnInspcCrrctDto) {
		return eqpmnInspcCrrctDao.getEqpInspctCrrctReq(eqpmnInspcCrrctDto);
	}

	@Override
	public List<EqpmnInspcCrrctDto> getEqpInspctCrrctReqExpr(List<Integer> list) {
		return eqpmnInspcCrrctDao.getEqpInspctCrrctReqExpr(list);
	}

	@Override
	public int delEqpInspctCrrctReq(List<EqpmnInspcCrrctDto> list) {
		int result = 0;

		for (EqpmnInspcCrrctDto dto : list) {
			if (!commonFunc.isEmpty(dto.getEqpmnInspctCrrctReqestSeqn())) {
				result += eqpmnInspcCrrctDao.delEqpInspctCrrctReq(dto);
			}
		}

		return (result > 0) ? 1 : 99;
	}

}
