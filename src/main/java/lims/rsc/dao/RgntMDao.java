package lims.rsc.dao;

import java.util.List;


import lims.rsc.vo.RgntMVo;
import lims.rsc.vo.WrhousngMVo;
import lims.sys.vo.DvyfgEntrpsMVo;

public interface RgntMDao{
	
	public List<RgntMVo> getRgntMList(RgntMVo vo);

	public int saveRgntM(RgntMVo vo);
	public int updateRgntM(RgntMVo vo);
	public RgntMVo getPrductdate(RgntMVo vo);
	public List<RgntMVo> getprductSeqno(RgntMVo vo);
	public int nowInvntryupdate(RgntMVo vo);
	public int deletRgntM(RgntMVo vo);
	public int nowInvntrydelet(RgntMVo vo);
	public int savePrevnt(RgntMVo vo);
	public int delPrevnt(RgntMVo vo);
	public List<RgntMVo> listPrevnt(RgntMVo vo);

	public int deletPrevntlist(RgntMVo vo);

}
