package lims.rsc.service.Impl;

import lims.rsc.dao.EqpmnGageDao;
import lims.rsc.dao.EqpmnInspcCrrctDao;
import lims.rsc.service.EqpmnGageService;
import lims.rsc.vo.EqpmnGageDto;
import lims.util.CommonFunc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EqpmnGageServiceImpl implements EqpmnGageService {

	private final EqpmnGageDao eqpmnGageDao;
	private final EqpmnInspcCrrctDao inspcCrrctDao;
	private final CommonFunc commonFunc;

	@Autowired
	public EqpmnGageServiceImpl(EqpmnGageDao eqpmnGageDao, EqpmnInspcCrrctDao inspcCrrctDao, CommonFunc commonFunc) {
		this.eqpmnGageDao = eqpmnGageDao;
		this.inspcCrrctDao = inspcCrrctDao;
		this.commonFunc = commonFunc;
	}

	@Override
	public List<EqpmnGageDto> getEqpmnGageList(EqpmnGageDto eqpmnGageDto) {
		return eqpmnGageDao.getEqpmnGageList(eqpmnGageDto);
	}
	
	@Override
	public int saveEqpmnGage(EqpmnGageDto eqpmnGageDto) {
		int result = 0;
		
		if (("Y").equals(eqpmnGageDto.getDeleteAt())) {
			// 검교정예정일자와 최근검교정일자 초기화
			eqpmnGageDto.setNextInspctCrrctDte("");
			eqpmnGageDto.setInspctCrrctDte("");
			eqpmnGageDto.setInspctCrrctSeCode("RS24000002");
			inspcCrrctDao.updInspctCrrctDte(eqpmnGageDto);

			// Gage의뢰 삭제
			if (eqpmnGageDto.isNotEmptyReq()) {
				List<EqpmnGageDto> gageReqList = eqpmnGageDto.getReqList();
				for (EqpmnGageDto dto : gageReqList) {
					eqpmnGageDao.delEqpGageReq(dto);
				}
			}

			// Gage결과 삭제
			if (eqpmnGageDto.isNotEmptyResult()) {
				List<EqpmnGageDto> resultList = eqpmnGageDto.getResultList();
				for (EqpmnGageDto dto : resultList) {
					dto.setDeleteAt("Y");
					eqpmnGageDao.updEqpGageResult(dto);
				}
			}

			// Gage정보 삭제
			return eqpmnGageDao.updEqpmnGage(eqpmnGageDto);
		}

		// Gage정보 등록 및 수정
		if (eqpmnGageDto.isNull()) {
			result += eqpmnGageDao.insEqpmnGage(eqpmnGageDto);
		} else {
			result += eqpmnGageDao.updEqpmnGage(eqpmnGageDto);
		}

		// Gage의뢰 등록
		if (eqpmnGageDto.isNotEmptyReq()) {
			if (eqpmnGageDto.isNewReq()) {
				List<EqpmnGageDto> addedList = eqpmnGageDto.getNewReqList();
				for (EqpmnGageDto addedRow : addedList) {
					addedRow.setEqpmnGageRegistSeqno(eqpmnGageDto.getEqpmnGageRegistSeqno());
					result += eqpmnGageDao.insEqpGageReq(addedRow);
				}
			}
		}

		// Gage결과 등록
		if (eqpmnGageDto.isNewResult()) {
			List<EqpmnGageDto> addedResult = eqpmnGageDto.getNewResultList();
			for (EqpmnGageDto addedRow : addedResult) {
				addedRow.setEqpmnGageRegistSeqno(eqpmnGageDto.getEqpmnGageRegistSeqno());
				result += eqpmnGageDao.insEqpGageResult(addedRow);
			}
		}

		// Gage결과 수정
		if (eqpmnGageDto.isEditedResult()) {
			List<EqpmnGageDto> editedResult = eqpmnGageDto.getEditedResultList();
			for (EqpmnGageDto editedRow : editedResult) {
				editedRow.setDeleteAt("N");
				result += eqpmnGageDao.updEqpGageResult(editedRow);
			}
		}

		// 등록하려는 검교정일자가 오늘날짜보다 이전날짜가 아닌 경우에만 주기정보 업데이트
		if (("Y").equals(eqpmnGageDto.getCycleUpdAt())) {
			eqpmnGageDto.setInspctCrrctDte(eqpmnGageDto.getRegistDte());
			eqpmnGageDto.setInspctCrrctSeCode("RS24000002");

			result += inspcCrrctDao.updInspctCrrctDte(eqpmnGageDto);
		}

		return (result > 0) ? eqpmnGageDto.getEqpmnGageRegistSeqno() : result;
	}

	@Override
	public int chkDuplicateRegistDte(EqpmnGageDto eqpmnGageDto) {
		return eqpmnGageDao.chkDuplicateRegistDte(eqpmnGageDto);
	}

	@Override
	public List<EqpmnGageDto> getEqpGageResult(EqpmnGageDto eqpmnGageDto) {
		return eqpmnGageDao.getEqpGageResult(eqpmnGageDto);
	}

	@Override
	public List<EqpmnGageDto> getEqpGageReq(EqpmnGageDto eqpmnGageDto) {
		return eqpmnGageDao.getEqpGageReq(eqpmnGageDto);
	}

	@Override
	public int delEqpGageReq(List<EqpmnGageDto> list) {
		int result = 0;

		for (EqpmnGageDto dto : list) {
			result += eqpmnGageDao.delEqpGageReq(dto);
		}

		return (result > 0) ? 1 : 99;
	}

	@Override
	public int delEqpGageResult(List<EqpmnGageDto> list) {
		int result = 0;

		for (EqpmnGageDto dto : list) {
			if (!commonFunc.isEmpty(dto.getEqpmnGageResultSeqno())) {
				dto.setDeleteAt("Y");
				result += eqpmnGageDao.updEqpGageResult(dto);
			}
		}

		return (result > 0) ? 1 : 99;
	}

}
