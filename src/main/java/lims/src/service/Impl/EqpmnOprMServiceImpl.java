package lims.src.service.Impl;

import lims.src.dao.EqpmnOprMDao;
import lims.src.service.EqpmnOprMService;
import lims.src.vo.EqpmnOprManageDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EqpmnOprMServiceImpl implements EqpmnOprMService {

	private final EqpmnOprMDao eqpmnOprMDao;

	@Autowired
	public EqpmnOprMServiceImpl(EqpmnOprMDao eqpmnOprMDao) {
		this.eqpmnOprMDao = eqpmnOprMDao;
	}

	@Override
	public List<EqpmnOprManageDto> getParMonTU(EqpmnOprManageDto eqpmnOprManageDto) {
		return eqpmnOprMDao.getParMonTU(eqpmnOprManageDto);
	}

}
