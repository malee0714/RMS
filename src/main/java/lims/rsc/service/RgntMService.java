package lims.rsc.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.com.vo.ComboVo;
import lims.rsc.vo.RgntMVo;
import lims.rsc.vo.WrhousngMVo;

public interface RgntMService{

	public List<RgntMVo> getRgntMList(RgntMVo vo);
	
	public String saveRgntM(RgntMVo list);
	
	public int savePrevnt(RgntMVo vo);

	public int delPrevnt(RgntMVo vo);
	
	public RgntMVo getPrductdate(RgntMVo list);

	public List<RgntMVo> getprductSeqno(RgntMVo vo);
	
	public int nowInvntryupdate(RgntMVo list);

	public HashMap<String, String> deletRgntM(RgntMVo vo);

	public int nowInvntrydelet(List<RgntMVo> vo);



	public List<RgntMVo> listPrevnt(RgntMVo vo);

	public int deletPrevntlist(List<RgntMVo> vo);

	

}
