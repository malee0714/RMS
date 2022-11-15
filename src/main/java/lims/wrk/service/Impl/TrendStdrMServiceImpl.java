package lims.wrk.service.Impl;

import lims.util.CommonFunc;
import lims.util.CustomException;
import lims.wrk.dao.TrendStdrMDao;
import lims.wrk.service.TrendStdrMService;
import lims.wrk.vo.TrendSpcExprVO;
import lims.wrk.vo.TrendSpcRuleVO;
import lims.wrk.vo.TrendStdrMVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TrendStdrMServiceImpl implements TrendStdrMService {

    private final TrendStdrMDao trendStdrMDao;
    private final CommonFunc cm;

    @Autowired
    public TrendStdrMServiceImpl(TrendStdrMDao trendStdrMDao, CommonFunc commonFunc) {
        this.trendStdrMDao = trendStdrMDao;
        this.cm = commonFunc;
    }

    @Override
    public List<TrendStdrMVO> getSpcManageList(TrendStdrMVO vo) {
        return trendStdrMDao.getSpcManageList(vo);
    }

    @Override
    public List<TrendSpcRuleVO> getSpcRules(TrendStdrMVO vo) {
        return trendStdrMDao.getSpcRules(vo);
    }

    @Override
    public List<TrendSpcExprVO> getExprIemsOfSpcGroup(TrendStdrMVO vo) {
        return trendStdrMDao.getExprIemsOfSpcGroup(vo);
    }

    @Override
    public void saveSpcManage(List<TrendStdrMVO> list) {
        
        list.forEach(trendStdrVO -> {
            
            // seq 없으면 ? insert : update
            int result = cm.isEmpty(trendStdrVO.getSpcManageSeqno()) ? trendStdrMDao.insertSpcMnage(trendStdrVO) : trendStdrMDao.updateSpcMnage(trendStdrVO);
            
            // spc rule 저장
            try {
                List<TrendSpcRuleVO> spcRules = trendStdrVO.getSpcRules();
                if(spcRules != null){
                    
                    // spc manage seqno 잇으면 spc rule delete insert
                    if (!cm.isEmpty(trendStdrVO.getSpcManageSeqno())) {
                        trendStdrMDao.deleteSpcRule(trendStdrVO);
                    }
                    
                    spcRules.forEach(rule -> {
                        rule.setSpcManageSeqno(trendStdrVO.getSpcManageSeqno()); // spc 관리 seqno set
                        trendStdrMDao.insertSpcRule(rule); //spc rule insert
                    });
                }
            } catch (Exception e) {
                throw new CustomException(e, "Spc Rule 저장이 정상적으로 완료되지 않았습니다.");
            }
    
            // spc 시험항목 삭제
            try {
                List<TrendSpcExprVO> deleteSpcExprIems = trendStdrVO.getDeleteSpcExprIems();
                if(deleteSpcExprIems != null){
                    deleteSpcExprIems.forEach(trendStdrMDao::deleteSpcExpr);
                }
            } catch (Exception e) {
                throw new CustomException(e, "기준그룹 선택된 시험항목 삭제가 정상적으로 완료되지 않았습니다.");
            }
    
            // spc 시험항목 저장
            try {
                List<TrendSpcExprVO> addSpcExprIems = trendStdrVO.getAddSpcExprIems();
                if(addSpcExprIems != null){
                    addSpcExprIems.forEach(expr -> {
                        expr.setSpcManageSeqno(trendStdrVO.getSpcManageSeqno()); // spc 관리 seqno set
                        trendStdrMDao.insertSpcExpr(expr);
                    });
                }
            } catch (Exception e) {
                throw new CustomException(e, "기준그룹 선택된 시험항목 저장이 정상적으로 완료되지 않았습니다.");
            }
        });
    }

    @Override
    public void delSpcManage(List<TrendStdrMVO> list) {
        list.forEach(spcManage -> {
            // spc manage seano 있을때만 삭제처리.
            if (!cm.isEmpty(spcManage.getSpcManageSeqno())) {
                trendStdrMDao.delSpcManage(spcManage);
            }
        });
    }
    @Override
    public void delSpcGroup(List<TrendStdrMVO> list) {
        list.forEach(spcGroup -> {
            if (!cm.isEmpty(spcGroup.getSpcManageSeqno())&&!cm.isEmpty(spcGroup.getMtrilSdspcSeqno())) {
                trendStdrMDao.delSpcGroup(spcGroup);
            }
        });
    }

}
