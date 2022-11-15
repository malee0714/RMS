package lims.rsc.service.Impl;

import lims.rsc.dao.EqpmnManageDao;
import lims.rsc.service.EqpmnManageService;
import lims.rsc.vo.EqpmnManageDto;
import lims.util.CommonFunc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EqpmnManageServiceImpl implements EqpmnManageService {

	private final CommonFunc commonFunc;

    private final EqpmnManageDao eqpmnManageDao;

	@Autowired
	public EqpmnManageServiceImpl(CommonFunc commonFunc, EqpmnManageDao eqpmnManageDao) {
		this.commonFunc = commonFunc;
		this.eqpmnManageDao = eqpmnManageDao;
	}

	@Override
	public List<EqpmnManageDto> getEqpmnMList(EqpmnManageDto eqpmnManageDto) {
		return eqpmnManageDao.getEqpmnMList(eqpmnManageDto);
	}

	@Override
	public int insEqpmn(EqpmnManageDto eqpmnManageDto) {
		int result = 0;

		List<EqpmnManageDto> relateMtrilList = eqpmnManageDto.getRelateMtrilGrid();
		List<EqpmnManageDto> relateExprList = eqpmnManageDto.getRelateExprGrid();
		List<EqpmnManageDto> inspctCrrctList = eqpmnManageDto.getInspctCrrctGrid();
		List<EqpmnManageDto> edayExprList = eqpmnManageDto.getEdayExpriemGrid();
		
		// 장비상세정보 등록
		result += eqpmnManageDao.insEqpmn(eqpmnManageDto);

		// 관련제품 등록
		if (!commonFunc.isEmpty(relateMtrilList)) {
			for (int i = 0; i < relateMtrilList.size(); i++) {
				relateMtrilList.get(i).setEqpmnSeqno(eqpmnManageDto.getEqpmnSeqno());
				relateMtrilList.get(i).setSortOrdr(i);

				result += eqpmnManageDao.insAnalsMtril(relateMtrilList.get(i));
			}
		}

		// 관련시험항목 등록
		if (!commonFunc.isEmpty(relateExprList)) {
			for (int i = 0; i < relateExprList.size(); i++) {
				relateExprList.get(i).setEqpmnSeqno(eqpmnManageDto.getEqpmnSeqno());
				relateExprList.get(i).setSortOrdr(i);

				result += eqpmnManageDao.insAnalsItem(relateExprList.get(i));
			}
		}

		// 검교정주기정보 등록
		if (!commonFunc.isEmpty(inspctCrrctList)) {
			for (EqpmnManageDto data : inspctCrrctList) {
				data.setEqpmnSeqno(eqpmnManageDto.getEqpmnSeqno());
				result += eqpmnManageDao.insCrrctCycle(data);
			}
		}

		// 일상점검시험항목 등록
		if (!commonFunc.isEmpty(edayExprList)) {
			for (int i = 0; i < edayExprList.size(); i++) {
				edayExprList.get(i).setEqpmnSeqno(eqpmnManageDto.getEqpmnSeqno());
				edayExprList.get(i).setSortOrdr(i);

				result += eqpmnManageDao.insChckExpr(edayExprList.get(i));
			}
		}

		return (result > 0) ? eqpmnManageDto.getEqpmnSeqno() : result;
	}

	@Override
	public int updEqpmn(EqpmnManageDto eqpmnManageDto) {
		int result = 0;

		// 장비 삭제
		if (("Y").equals(eqpmnManageDto.getDeleteAt())) {
			return eqpmnManageDao.updEqpmn(eqpmnManageDto);

		} else {
			List<EqpmnManageDto> relateMtrilList = eqpmnManageDto.getRelateMtrilGrid();
			List<EqpmnManageDto> relateExprList = eqpmnManageDto.getRelateExprGrid();
			List<EqpmnManageDto> inspctCrrctList = eqpmnManageDto.getInspctCrrctGrid();
			List<EqpmnManageDto> edayExprList = eqpmnManageDto.getEdayExpriemGrid();

			// 장비상세정보 수정
			result += eqpmnManageDao.updEqpmn(eqpmnManageDto);

			// 관련제품 추가등록 및 순서변경
			if (!commonFunc.isEmpty(relateMtrilList)) {
				for (int i = 0; i < relateMtrilList.size(); i++) {
					if (!commonFunc.isEmpty(relateMtrilList.get(i).getEqpmnAnalsPrductSeqno())) {
						relateMtrilList.get(i).setSortOrdr(i);

						result += eqpmnManageDao.updMtrilSortOrdr(relateMtrilList.get(i));

					} else {
						relateMtrilList.get(i).setEqpmnSeqno(eqpmnManageDto.getEqpmnSeqno());
						relateMtrilList.get(i).setSortOrdr(i);

						result += eqpmnManageDao.insAnalsMtril(relateMtrilList.get(i));
					}
				}
			}

			// 관련시험항목 추가등록 및 순서변경
			if (!commonFunc.isEmpty(relateExprList)) {
				for (int i = 0; i < relateExprList.size(); i++) {
					if (!commonFunc.isEmpty(relateExprList.get(i).getEqpmnAnalsIemSeqno())) {
						relateExprList.get(i).setSortOrdr(i);

						result += eqpmnManageDao.updItemSortOrdr(relateExprList.get(i));

					} else {
						relateExprList.get(i).setEqpmnSeqno(eqpmnManageDto.getEqpmnSeqno());
						relateExprList.get(i).setSortOrdr(i);

						result += eqpmnManageDao.insAnalsItem(relateExprList.get(i));
					}
				}
			}

			// 검교정주기정보 추가등록 및 수정
			if (!commonFunc.isEmpty(inspctCrrctList)) {
				for (EqpmnManageDto data : inspctCrrctList) {
					if (!commonFunc.isEmpty(data.getEqpmnSeqno())) {
						result += eqpmnManageDao.updCrrctCycle(data);
					} else {
						data.setEqpmnSeqno(eqpmnManageDto.getEqpmnSeqno());
						result += eqpmnManageDao.insCrrctCycle(data);
					}
				}
			}

			// 일상점검시험항목 추가등록 및 수정
			if (!commonFunc.isEmpty(edayExprList)) {
				for (int i = 0; i < edayExprList.size(); i++) {
					if (!commonFunc.isEmpty(edayExprList.get(i).getEqpmnChckExpriemSeqno())) {
						edayExprList.get(i).setSortOrdr(i);

						result += eqpmnManageDao.updChckExpr(edayExprList.get(i));

					} else {
						edayExprList.get(i).setEqpmnSeqno(eqpmnManageDto.getEqpmnSeqno());
						edayExprList.get(i).setSortOrdr(i);

						result += eqpmnManageDao.insChckExpr(edayExprList.get(i));
					}
				}
			}
		}

		return (result > 0) ? eqpmnManageDto.getEqpmnSeqno() : result;
	}

	@Override
	public List<EqpmnManageDto> getAnalsMtrilList(EqpmnManageDto eqpmnManageDto) {
		return eqpmnManageDao.getAnalsMtrilList(eqpmnManageDto);
	}

	@Override
	public int delAnalsMtril(List<EqpmnManageDto> list) {
		int result = 0;
		for (EqpmnManageDto dto : list) {
			if (!commonFunc.isEmpty(dto.getEqpmnAnalsPrductSeqno())) {
				result += eqpmnManageDao.delAnalsMtril(dto);
			}
		}

		return (result == 0) ? 1 : result;
	}

	@Override
	public List<EqpmnManageDto> getAnalsItemList(EqpmnManageDto eqpmnManageDto) {
		return eqpmnManageDao.getAnalsItemList(eqpmnManageDto);
	}

	@Override
	public int delAnalsItem(List<EqpmnManageDto> list) {
		int result = 0;
		for (EqpmnManageDto dto : list) {
			if (!commonFunc.isEmpty(dto.getEqpmnAnalsIemSeqno())) {
				result += eqpmnManageDao.delAnalsItem(dto);
			}
		}

		return (result == 0) ? 1 : result;
	}

	@Override
	public List<EqpmnManageDto> getCrrctCycleList(EqpmnManageDto eqpmnManageDto) {
		return eqpmnManageDao.getCrrctCycleList(eqpmnManageDto);
	}

	@Override
	public int delCrrctCycle(List<EqpmnManageDto> list) {
		int result = 0;
		for (EqpmnManageDto dto : list) {
			if (!commonFunc.isEmpty(dto.getEqpmnSeqno())) {
				result = eqpmnManageDao.delCrrctCycle(dto);
			}
		}

		return (result == 0) ? 1 : result;
	}
	
	@Override
	public List<EqpmnManageDto> getEqpmnChckExpr(EqpmnManageDto eqpmnManageDto) {
		return eqpmnManageDao.getEqpmnChckExpr(eqpmnManageDto);
	}
	
	@Override
	public int delChckExpr(List<EqpmnManageDto> list) {
		int result = 0;
		for (EqpmnManageDto dto : list) {
			if (!commonFunc.isEmpty(dto.getEqpmnChckExpriemSeqno())) {
				result += eqpmnManageDao.delChckExpr(dto);
			}
		}
		
		return (result == 0) ? 1 : result;
	}
}
