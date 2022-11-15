package lims.wrk.service;

import java.util.List;

import lims.wrk.vo.TrendSpcExprVO;
import lims.wrk.vo.TrendSpcRuleVO;
import lims.wrk.vo.TrendStdrMVO;

public interface TrendStdrMService {
	List<TrendStdrMVO> getSpcManageList(TrendStdrMVO vo);
	List<TrendSpcRuleVO> getSpcRules(TrendStdrMVO vo);
	List<TrendSpcExprVO> getExprIemsOfSpcGroup(TrendStdrMVO vo);
	void saveSpcManage(List<TrendStdrMVO> list);
	void delSpcManage(List<TrendStdrMVO> list);
	void delSpcGroup(List<TrendStdrMVO> list);

}
