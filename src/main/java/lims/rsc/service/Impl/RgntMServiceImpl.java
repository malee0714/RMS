package lims.rsc.service.Impl;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.com.vo.ComboVo;
import lims.req.vo.RequestMVo;
import lims.rsc.dao.RgntMDao;
import lims.rsc.service.RgntMService;
import lims.rsc.vo.CmpdsUseMVo;
import lims.rsc.vo.RgntMVo;
import lims.rsc.vo.WrhousngMVo;
import lims.sys.vo.DvyfgEntrpsMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;
import lims.util.FasooExtract;
import lims.wrk.vo.PrductMVo;
import lombok.var;


@Service
public class RgntMServiceImpl implements RgntMService {
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	@Autowired
	private RgntMDao RgntMDao;
	@Value("${file.upload.path}")
	private String fileUploadPath;

	@Override
	public List<RgntMVo> getRgntMList(RgntMVo vo) {
		return RgntMDao.getRgntMList(vo);
	}
	@Override
	public List<RgntMVo> listPrevnt(RgntMVo vo) {
		return RgntMDao.listPrevnt(vo);
	}
	
	@Override
	public String saveRgntM(RgntMVo vo) {
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest); 
		if(vo.getPrductSeqno() == null ){
			RgntMDao.saveRgntM(vo);
		}else{
			RgntMDao.updateRgntM(vo);
		}
		return vo.getPrductSeqno().toString();
	}	
	@Override
	public int savePrevnt(RgntMVo vo) {
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest); 
		int count=1;

		var addedPrevntMaster = vo.getAddedPrevntMaster();
		if(addedPrevntMaster != null){
			for(RgntMVo avo : addedPrevntMaster){
				avo.setPrductSeqno(vo.getPrductSeqno());
				avo.setBplcCode(vo.getBplcCode());
				count+=RgntMDao.savePrevnt(avo);
			}
		}
		var getEditedPrevntMaster = vo.getEditedPrevntMaster();
		if(getEditedPrevntMaster != null){
			for(RgntMVo evo : getEditedPrevntMaster){
				evo.setPrductSeqno(vo.getPrductSeqno());
				evo.setBplcCode(vo.getBplcCode());
				count+=RgntMDao.savePrevnt(evo);
			}
		}

		
		return count;
	}
	@Override
	public int delPrevnt(RgntMVo vo){
		int count = 0;
		var getRemovedPrevntMaster = vo.getRemovePrevntMaster();
		if(getRemovedPrevntMaster != null){
			for(RgntMVo rvo : getRemovedPrevntMaster){
				count+=RgntMDao.delPrevnt(rvo);
			}
		}

		return count;
	}
	@Override
	public HashMap<String,String> deletRgntM(RgntMVo vo) {
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest); 
		HashMap<String,String> check = new HashMap<String,String>();
		RgntMDao.deletRgntM(vo);
		check.put("delet",vo.getPrductSeqno().toString());
			
		return check;
	}
	@Override
	public int deletPrevntlist(List<RgntMVo> vo) {
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest); 
		int check = 0;
		for(int i=0;i<vo.size();i++){
			check += RgntMDao.deletPrevntlist(vo.get(i));
		}
		return check;
	}
	
	@Override
	public RgntMVo getPrductdate(RgntMVo vo) {
		return RgntMDao.getPrductdate(vo);
	}
	@Override
	public List<RgntMVo> getprductSeqno(RgntMVo vo) {
		return RgntMDao.getprductSeqno(vo);
	}
	@Override
	public int nowInvntryupdate(RgntMVo vo){
		int check = 0;
		check =RgntMDao.nowInvntryupdate(vo);
		int NowInvntryQy =vo.getNowInvntryQy();
		int ProprtInvntryQy = vo.getProprtInvntryQy();
		if(NowInvntryQy > ProprtInvntryQy){
			//사용자한테 알림메일
		}
		
		
		return check;
	}
	@Override
	public int nowInvntrydelet(List<RgntMVo> vo) {
		// Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
				.getRequest();
		
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		int check = 0;
		for(int i=1;i<vo.size();i++){
			vo.get(i).setWrhsdlvrQy(1);
			check +=RgntMDao.nowInvntrydelet(vo.get(i));
		}
		return check;
	}

//	@Override
//	public HashMap<String, Object> saveimagefile(MultipartHttpServletRequest request) {
//		
//		MultipartFile file = null;
//		File convFile = null;
//		
//		try{
//			file = request.getFile("formFile");
//			convFile = new File(file.getOriginalFilename());
//			file.transferTo(convFile);
//			new File(fileUploadPath+uploadPath);
//			RgntMVo RgntMVo = new RgntMVo();		
//			RgntMDao.saveimagefile(RgntMVo);
//		}catch(Exception e){
//			e.getStackTrace();
//		}
//		return null;
//	}
}
