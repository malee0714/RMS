package lims.wrk.dao;

import lims.wrk.vo.TrendSpcExprVO;
import lims.wrk.vo.TrendSpcRuleVO;
import lims.wrk.vo.TrendStdrMVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TrendStdrMDao {
	List<TrendStdrMVO> getSpcManageList(TrendStdrMVO trendStdrMVO);
	List<TrendSpcRuleVO> getSpcRules(TrendStdrMVO trendStdrMVO);
	List<TrendSpcExprVO> getExprIemsOfSpcGroup(TrendStdrMVO trendStdrMVO);
	int delSpcManage(TrendStdrMVO trendStdrMVO);
	int delSpcGroup(TrendStdrMVO trendStdrMVO);
	int insertSpcMnage(TrendStdrMVO trendStdrMVO);
	int updateSpcMnage(TrendStdrMVO trendStdrMVO);
	int insertSpcRule(TrendSpcRuleVO trendSpcRuleVO);
	int deleteSpcRule(TrendStdrMVO trendStdrMVO);
	int insertSpcExpr(TrendSpcExprVO trendSpcExprVO);
	int deleteSpcExpr(TrendSpcExprVO trendSpcExprVO);
}
