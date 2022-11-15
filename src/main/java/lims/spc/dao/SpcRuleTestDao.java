package lims.spc.dao;

import lims.spc.vo.*;
import lims.wrk.vo.CLManageMVo;
import lims.wrk.vo.TrendSpcRuleVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SpcRuleTestDao {
	CLManageMVo getMtrilClManage(SpcMtrilExpriem spcMtrilExpriem);
	List<SpcResultExpriem> getSpcSample(SpcParam spcParam);
	SpcSampleStats getSpcSampleStats(SpcParam spcParam);
	List<TrendSpcRuleVO> getSpcRules(SpcParam spcParam);
	List<SpcMtrilExpriem> getMtrilSdpcList(SpcRuleTestDto spcRuleTestDto);
}
