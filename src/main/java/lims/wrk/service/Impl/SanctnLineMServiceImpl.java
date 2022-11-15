package lims.wrk.service.Impl;


import lims.util.CommonFunc;
import lims.wrk.dao.SanctnLineMDao;
import lims.wrk.service.SanctnLineMService;
import lims.wrk.vo.SanctnLineMVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class SanctnLineMServiceImpl implements SanctnLineMService{

	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Autowired
    private SanctnLineMDao sanctnLineMDao;

	@Override
	public List<SanctnLineMVo> getSanctnKndList() {
		return sanctnLineMDao.getSanctnKndList();
	}

	@Override
	public List<SanctnLineMVo> getSanctnLineList(SanctnLineMVo vo) {
		return sanctnLineMDao.getSanctnLineList(vo);
	}

	@Override
	public List<SanctnLineMVo> getUserAList(SanctnLineMVo vo) {
		return sanctnLineMDao.getUserAList(vo);
	}

	@Override
	public List<SanctnLineMVo> getSanctnerList(SanctnLineMVo vo) {
		return sanctnLineMDao.getSanctnerList(vo);
	}

	@Override
	public int saveSanctnLine(SanctnLineMVo vo) {

		int check = 0;

		SanctnLineMVo sanctnLineFrmVo = vo.getSanctnLineVo();
		sanctnLineFrmVo.setCount(0);
		List<SanctnLineMVo> list = vo.getSanctnLineList();


		if(commonFunc.isEmpty(sanctnLineFrmVo.getSanctnLineSeqno())) {
			//결재라인 등록
			check += sanctnLineMDao.insertSanctnLine(sanctnLineFrmVo);
		} else {
			//결재라인 수정
			check += sanctnLineMDao.updateSanctnLine(sanctnLineFrmVo);
		}

		//결재라인 결재자 삭제
		check += sanctnLineMDao.deleteSanctner(sanctnLineFrmVo);

		list.stream().forEach(v -> {
			sanctnLineFrmVo.setCount(sanctnLineFrmVo.getCount() + 1);
			v.setSanctnOrdr(String.valueOf(sanctnLineFrmVo.getCount()));
			v.setSanctnLineSeqno(sanctnLineFrmVo.getSanctnLineSeqno());
			sanctnLineMDao.insertSanctner(v);
		});
		
		// 반환할 결재라인 시퀀스, null 여부 체크 후 반환
		return (check > 0) ?
				(sanctnLineFrmVo.getSanctnLineSeqno() != null) ? Integer.parseInt(sanctnLineFrmVo.getSanctnLineSeqno()) : 0
				: check;
	}

	@Override
	public List<SanctnLineMVo> getUserNtncList(SanctnLineMVo vo) {
		return sanctnLineMDao.getUserNtncList(vo);
	}
}
