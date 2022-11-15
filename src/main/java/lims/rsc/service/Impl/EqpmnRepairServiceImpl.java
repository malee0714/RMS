package lims.rsc.service.Impl;

import lims.rsc.dao.EqpmnRepairDao;
import lims.rsc.service.EqpmnRepairService;
import lims.rsc.vo.EqpmnRepairDto;
import lims.util.CommonFunc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EqpmnRepairServiceImpl implements EqpmnRepairService {

    private final EqpmnRepairDao eqpmnRepairDao;

	private final CommonFunc commonFunc;

	@Autowired
	public EqpmnRepairServiceImpl(EqpmnRepairDao eqpmnRepairDao, CommonFunc commonFunc) {
		this.eqpmnRepairDao = eqpmnRepairDao;
		this.commonFunc = commonFunc;
	}

	@Override
	public List<EqpmnRepairDto> getEqpRepairHist(EqpmnRepairDto eqpmnRepairDto) {
		return eqpmnRepairDao.getEqpRepairHist(eqpmnRepairDto);
	}

	/**
	 * - 수리이력 수정
	 * 가장 최근의 수리이력인 동시에 수리종료일시가 입력되었을 경우에만 가동여부 "Y" 처리
	 *
	 * - 수리이력 삭제
	 * 가장 최근의 수리이력인 경우, 해당 장비 가동여부 "Y" 처리
	 *
	 * @param eqpmnRepairDto 장비수리정보
	 * @return script에서 setSelection할 eqpmnRepairHistSeqno
	 */
	@Override
	public int saveEqpRepairHist(EqpmnRepairDto eqpmnRepairDto) {
		int result = 0;

		// 수리이력 삭제
		if (("Y").equals(eqpmnRepairDto.getDeleteAt())) {
			Integer repairSeqno = eqpmnRepairDao.getMostRecentRepairHist(eqpmnRepairDto);
			if (repairSeqno.equals(eqpmnRepairDto.getEqpmnRepairHistSeqno())) {
				eqpmnRepairDto.setOprAt("Y");
				eqpmnRepairDao.updEqpmnOprAt(eqpmnRepairDto);
			}

			return eqpmnRepairDao.updEqpRepairHist(eqpmnRepairDto);
		}

		if (commonFunc.isEmpty(eqpmnRepairDto.getEqpmnRepairHistSeqno())) {
			// 수리종료일자 입력여부에 따라 가동여부 값 세팅
			if (commonFunc.isEmpty(eqpmnRepairDto.getRepairEndDt())) {
				eqpmnRepairDto.setOprAt("N");
			} else {
				eqpmnRepairDto.setOprAt("Y");
			}

			result += eqpmnRepairDao.updEqpmnOprAt(eqpmnRepairDto);
			result += eqpmnRepairDao.insEqpRepairHist(eqpmnRepairDto);

		} else {
			Integer repairSeqno = eqpmnRepairDao.getMostRecentRepairHist(eqpmnRepairDto);
			if (repairSeqno.equals(eqpmnRepairDto.getEqpmnRepairHistSeqno()) && !commonFunc.isEmpty(eqpmnRepairDto.getRepairEndDt())) {
				eqpmnRepairDto.setOprAt("Y");
				result += eqpmnRepairDao.updEqpmnOprAt(eqpmnRepairDto);
			}

			result += eqpmnRepairDao.updEqpRepairHist(eqpmnRepairDto);
		}
		
		return (result > 0) ? eqpmnRepairDto.getEqpmnRepairHistSeqno() : result;
	}

}
