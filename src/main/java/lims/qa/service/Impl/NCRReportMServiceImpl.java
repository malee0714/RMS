package lims.qa.service.Impl;

import java.util.List;

import javax.annotation.Resource;

import lims.req.vo.RequestMVo;
import lims.test.vo.ResultInputMVo;
import lims.test.vo.RoaMVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.qa.dao.NCRReportMDao;
import lims.qa.service.NCRReportMService;
import lims.qa.vo.NCRReportMVo;
import lims.util.CommonFunc;
import lims.util.CustomException;

@Service(value="NCRReportMServiceImpl")
public class NCRReportMServiceImpl implements NCRReportMService {

	@Autowired
	NCRReportMDao ncrReportMDao;
	
	@Resource
	CommonFunc commonFunc;
	
	@Override
	public int saveNCRReport(NCRReportMVo vo) {
		try {
			List<NCRReportMVo> expriemList = vo.getExpriemList();
			if(commonFunc.isEmpty(vo.getNcrSeqno())) {
				ncrReportMDao.insNCRReport(vo);
				if(expriemList.size() > 0){
					for(NCRReportMVo item : expriemList){
						item.setNcrSeqno(vo.getNcrSeqno());
						ncrReportMDao.insertNcrExpriem(item);
					}
				}
			}else {
				return ncrReportMDao.updNCRReport(vo);
			}
		} catch (Exception e) {
			throw new CustomException(e, vo, "저장중 에러가 발생하였습니다.");
		}

		return 1;
	}

	@Override
	public List<NCRReportMVo> getNCRReportList(NCRReportMVo vo) {
		return ncrReportMDao.getNCRReportList(vo);
	}

	@Override
	public List<NCRReportMVo> getExpriemListSch(NCRReportMVo vo) {
		return ncrReportMDao.getExpriemListSch(vo);
	}

	@Override
	public int deleteNCRReport(NCRReportMVo ncrSeqno) {
		return ncrReportMDao.deleteNCRReport(ncrSeqno);
	}

    @Override
    public List<RoaMVo> getRequestExpriemListSch(RoaMVo vo) {
		return ncrReportMDao.getRequestExpriemListSch(vo);
    }

}
