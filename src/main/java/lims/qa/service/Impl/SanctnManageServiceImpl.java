package lims.qa.service.Impl;

import lims.com.dao.CmSanctnDao;
import lims.com.vo.CmRtn;
import lims.com.vo.CmSanctn;
import lims.qa.dao.SanctnManageDao;
import lims.qa.service.SanctnManageService;
import lims.qa.vo.SanctnManageDto;
import lims.util.CustomException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class SanctnManageServiceImpl implements SanctnManageService {

	private final SanctnManageDao sanctnManageDao;
	private final CmSanctnDao cmSanctnDao;

	@Autowired
	public SanctnManageServiceImpl(SanctnManageDao sanctnManageDao, CmSanctnDao cmSanctnDao) {
		this.sanctnManageDao = sanctnManageDao;
		this.cmSanctnDao = cmSanctnDao;
	}

	@Override
	public List<SanctnManageDto> getSanctn(SanctnManageDto cmSanctn) {
		return sanctnManageDao.getSanctn(cmSanctn);
	}
	
	@Override
	public List<CmRtn> getRtn(CmRtn cmRtn) {
		return sanctnManageDao.getRtn(cmRtn);
	}

	@Override
	public void confirm(List<SanctnManageDto> confirmList) {
		confirmList.forEach(this::confirm);
	}

	@Override
	public void confirm(SanctnManageDto sanctnManageDto) {
		if (sanctnManageDto.validation()) {
			CmSanctn presentSanctn = Optional.ofNullable(cmSanctnDao.getSanctn(sanctnManageDto))
					.orElseThrow(() -> new CustomException("결재 정보가 존재하지 않아 결재를 진행할 수 없습니다."));
	
			presentSanctn.sanctnConfirmValidation(); // 결재 진행상황 validation.
			
			sanctnManageDao.confirmSanctnInfo(sanctnManageDto);
		}
	}

	@Override
	public void returnProcess(List<SanctnManageDto> returnList) {
		returnList.forEach(this::returnProcess);
	}

	@Override
	public void returnProcess(SanctnManageDto sanctnManageDto) {
		if (sanctnManageDto.validation()) {
			
			CmSanctn presentSanctn = Optional.ofNullable(cmSanctnDao.getSanctn(sanctnManageDto))
					.orElseThrow(() -> new CustomException("결재 정보가 존재하지 않아 반려를 진행할 수 없습니다."));
	
			presentSanctn.sanctnConfirmValidation(); // 반려 진행상황 validation.
			
			sanctnManageDao.insertReturn(sanctnManageDto);
			sanctnManageDao.returnProcess(sanctnManageDto);
		}
	}
}
