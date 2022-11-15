package lims.req.service.Impl;

import java.io.File;
import java.io.IOException;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map.Entry;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellValue;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.dly.vo.DlivyMVo;
import lims.req.dao.PartnersCoaMDao;
import lims.req.service.PartnersCoaMService;
import lims.req.vo.PartnersCoaMVo;
import lims.util.ConverterUtils;
import lims.util.FasooExtract;
import lims.util.GetUserSession;
import lims.wrk.dao.PrductMDao;
import lims.wrk.vo.PrductMVo;

@Service("PartnersCoaMService")
public class PartnersCoaMServiceImpl implements PartnersCoaMService{

	@Autowired
	private PartnersCoaMDao partnersCoaMDao;
	
	@Autowired
    private PrductMDao prductMDao;
	
	/**
	 * 저장
	 */
	@SuppressWarnings("unused")
	@Override
	public int insPartnersCoaM(PartnersCoaMVo vo) {
		
		int result = 0;
		
		try{
			//의뢰정보 저장
			result = partnersCoaMDao.insImRequest(vo);
			//CAN 정보 저장
			//result = partnersCoaMDao.insImReqestCanNo(vo);
			
			PartnersCoaMVo expriemGrid = new PartnersCoaMVo();
			
			//시험항목 정보 저장
			for(int i=0; i<vo.getReqestExpriemGrid().size(); i++){
				expriemGrid = vo.getReqestExpriemGrid().get(i);
				expriemGrid.setReqestSeqno(vo.getReqestSeqno());
				expriemGrid.setBplcCode(vo.getBplcCode());
				//시험항목 정보 저장
				result = partnersCoaMDao.insImReqestExpriem(expriemGrid);
				//시험항목 정보 결과 저장
				double sumData = 0;
				PartnersCoaMVo expriemGrid2 = new PartnersCoaMVo();
				expriemGrid2 = vo.getReqestExpriemGrid().get(i);
				expriemGrid2.setReqestSeqno(vo.getReqestSeqno());
				expriemGrid2.setExprOdr("1");
				double count =0;
				String FrstAnals=null;
				String middleAnals=null;
				String lastAnals =null;
				if(expriemGrid.getFrstAnals() !=null){
					FrstAnals =expriemGrid.getFrstAnals();
				}
					expriemGrid2.setExprNumot(1);
					expriemGrid2.setResultValue(FrstAnals);
					expriemGrid2.setMarkValue(FrstAnals);
					if(FrstAnals != null && FrstAnals !=""){
						if(expriemGrid.getJdgmntFomCode().equals("IM06000001")){
					count ++;
						}
					}
					result = partnersCoaMDao.insImReqestExpriemResult(expriemGrid2);
			}
			
		}catch(Exception e){
			e.getStackTrace();
			throw e;
		}
		return result;
	}

	/**
	 * 협력업체 의뢰목록 조회
	 */
	@Override
	public List<PartnersCoaMVo> getPartnersCoaList(PartnersCoaMVo vo) {		
		GetUserSession sessionD = new GetUserSession();
		vo.setAuthorSeCode(sessionD.getAuthorSeCode());
		return partnersCoaMDao.getPartnersCoaList(vo);
	}
	
	
	@Override
	public List<PartnersCoaMVo> getExpriemCoaList(PartnersCoaMVo vo) {		
		GetUserSession sessionD = new GetUserSession();
		vo.setAuthorSeCode(sessionD.getAuthorSeCode());
		List<PartnersCoaMVo> list =null;
		if(!partnersCoaMDao.getReqestExpriemSeqno(vo).isEmpty()){
		 list= partnersCoaMDao.getReqestExpriemSeqno(vo);
		List<PartnersCoaMVo> list2 = partnersCoaMDao.getExpriemCoaList(list.get(0));
		for(int i = 1 ; i <list.size(); i ++){
			list2.addAll(partnersCoaMDao.getExpriemCoaList(list.get(i)));
		}
		return list2;
		}
		return list;
	}


	/**
	 * 시험항목 정보 조회
	 */
	@Override
	public List<PartnersCoaMVo> getImReqestExpriem(PartnersCoaMVo vo) {		
		return partnersCoaMDao.getImReqestExpriem(vo);
	}
	
	@Override
	public List<PartnersCoaMVo> getExpriem(PartnersCoaMVo vo) {		
		return  partnersCoaMDao.getExpriem(vo);
	
	}
	
	/**
	 * 수정
	 */
	@Override
	public int updPartnersCoaM(PartnersCoaMVo vo) {
		int result = 0;
		
		try{
			//의뢰정보 수정
			result = partnersCoaMDao.updImRequest(vo);
			
			PartnersCoaMVo editedExpriemGrid = new PartnersCoaMVo();

			//시험항목 정보 저장
			for(int i=0; i<vo.getReqestExpriemGrid().size(); i++){
				editedExpriemGrid = vo.getReqestExpriemGrid().get(i);
				result = partnersCoaMDao.updImReqestExpriemResult(editedExpriemGrid);

			}
		}catch(Exception e){
			e.getStackTrace();
			throw e;
		}
		
		
		return result;
	}

	/**
	 * 의뢰정보 삭제
	 */
	@Override
	public int delPartnersCoaM(PartnersCoaMVo vo) {
		int result = 0;
		
		try{
			//시험정보 삭제
			result += partnersCoaMDao.delImReqestExpriem(vo);
			//의뢰정보 삭제
			result += partnersCoaMDao.delImRequest(vo);
			result += partnersCoaMDao.delImReqestExpriemResult(vo);
			
			partnersCoaMDao.delLotno(vo);
		}catch(Exception e){
			throw e;
		}
		
		return result;
	}

	@Override
	public String getMtrilCode(PartnersCoaMVo vo) {

		return partnersCoaMDao.getMtrilCode(vo);
	}

	@Override
	public int getVenderLotNo(PartnersCoaMVo vo){
		return partnersCoaMDao.getVenderLotNo(vo);
	}

}
