package lims.rsc.dao;

import java.util.List;

import lims.rsc.vo.DsuseMVo;
import lims.rsc.vo.RgntMVo;



public interface DsuseMDao {
	public List<DsuseMVo> getDsuseBacode(DsuseMVo vo);
	public int insDsuseBacode(DsuseMVo vo);
	public int insDsuseDetailBacode(DsuseMVo vo);
	public void nowInvntryupdate(RgntMVo rgntMVo);
}
