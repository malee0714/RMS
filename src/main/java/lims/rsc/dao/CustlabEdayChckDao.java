package lims.rsc.dao;

import lims.com.vo.ComboVo;
import lims.rsc.vo.CustlabEdayChckRegistDto;
import lims.rsc.vo.CustlabEdayChckResultDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CustlabEdayChckDao {

	List<ComboVo> getCustlabCombo();

	List<CustlabEdayChckRegistDto> getCustlabEday(CustlabEdayChckRegistDto custlabEdayChckRegistDto);

	List<CustlabEdayChckResultDto> getCustlabEdayCheckResultList(CustlabEdayChckRegistDto custlabEdayChckRegistDto);

	void insertEveryDayCheckRegist(CustlabEdayChckRegistDto custlabEdayChckRegistDto);

	void updateEveryDayCheckRegist(CustlabEdayChckRegistDto custlabEdayChckRegistDto);

	void saveEveryDayCheckExprResult(CustlabEdayChckResultDto custlabEdayChckResultDto);

	void deleteEveryDayExprResult(CustlabEdayChckRegistDto custlabEdayChckRegistDto);

	List<CustlabEdayChckResultDto> getCustlabEdayCheckResultSearchList(CustlabEdayChckRegistDto custlabEdayChckRegistDto);
}
