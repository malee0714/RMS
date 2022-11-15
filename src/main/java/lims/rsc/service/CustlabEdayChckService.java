package lims.rsc.service;

import lims.com.vo.ComboVo;
import lims.rsc.vo.CustlabEdayChckRegistDto;
import lims.rsc.vo.CustlabEdayChckResultDto;

import java.util.List;

public interface CustlabEdayChckService {
	List<ComboVo> getCustlabCombo();

	List<CustlabEdayChckRegistDto> getCustlabEday(CustlabEdayChckRegistDto custlabEdayChckRegistDto);

	List<CustlabEdayChckResultDto> getCustlabEdayCheckResultList(CustlabEdayChckRegistDto custlabEdayChckRegistDto);

	void saveEveryDayCheckRegist(CustlabEdayChckRegistDto custlabEdayChckRegistDto);

	void deleteEveryDayCheckRegist(CustlabEdayChckRegistDto custlabEdayChckRegistDto);

	List<CustlabEdayChckResultDto> getCustlabEdayCheckResultSearchList(CustlabEdayChckRegistDto custlabEdayChckRegistDto);
}
