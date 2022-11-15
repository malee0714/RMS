package lims.wrk.service.Impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.util.CommonFunc;
import lims.wrk.dao.EntrpsMDao;
import lims.wrk.service.EntrpsMService;
import lims.wrk.vo.EntrpsMDto;
import lims.wrk.vo.EntrpsMVo;

@Service
public class EntrpsMServiceImpl implements EntrpsMService{
	
	
	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	
	@Autowired
	EntrpsMDao entrpsMDao;
	
	@Override
	public List<EntrpsMDto> getEntrpsMList(EntrpsMVo EntrpsMVo) {
		return entrpsMDao.getEntrpsMList(EntrpsMVo);
	}
	
	/*
	 * 업체 입력/수정/삭제
	 * 
	 */
	@Override
	public void saveEntrpsM(EntrpsMDto vo){
		
		List<EntrpsMDto> insEntrpsMDtos = vo.getInsgridData();
		List<EntrpsMDto> updEntrpsMDtos = vo.getUpdGridData();
		List<EntrpsMDto> delEntrpsMDtos = vo.getDelGridData();
		
		if(insEntrpsMDtos != null && insEntrpsMDtos.size() != 0) {
			insEntrpsM(insEntrpsMDtos);
		} 
		if(updEntrpsMDtos != null &&  updEntrpsMDtos.size() != 0) {
			updEntrpsM(updEntrpsMDtos);
		} 
		if(delEntrpsMDtos != null && delEntrpsMDtos.size() != 0) {
			delEntrpsM(delEntrpsMDtos);
		}
	}
	
	// 업체 입력
	private void insEntrpsM(List<EntrpsMDto> entrpsMDtos){
		
		for(EntrpsMDto data : entrpsMDtos){
			String entrpsSeCode = CheckEntrpsSeCode(data);
			if(entrpsSeCode.equals("all")){
				entrpsMDao.insEntrpsM(data);
				data.setEntrpsSeCode("SY08000001");
				entrpsMDao.saveEntrpsSe(data);
				data.setEntrpsSeCode("SY08000002");
				entrpsMDao.saveEntrpsSe(data);
			} else {
				data.setEntrpsSeCode(entrpsSeCode);
				entrpsMDao.insEntrpsM(data);
				entrpsMDao.saveEntrpsSe(data);
			}
		}
	}
	
	// 업체 수정
	private void updEntrpsM(List<EntrpsMDto> entrpsMDtos) {
		
		for(EntrpsMDto data : entrpsMDtos){
			String entrpsSeCode = CheckEntrpsSeCode(data);
			if(entrpsSeCode.equals("all")){
				entrpsMDao.updEntrpsM(data);
				entrpsMDao.resetEntrpsSeCode(data);
				data.setEntrpsSeCode("SY08000001");
				entrpsMDao.saveEntrpsSe(data);
				data.setEntrpsSeCode("SY08000002");
				entrpsMDao.saveEntrpsSe(data);
			} else {
				entrpsMDao.updEntrpsM(data);
				entrpsMDao.resetEntrpsSeCode(data);
				data.setEntrpsSeCode(entrpsSeCode);
				entrpsMDao.saveEntrpsSe(data);
			}
		}
	}
	
	// 업체 제거
	private void delEntrpsM(List<EntrpsMDto> entrpsMDtos) {
		
		for(EntrpsMDto data : entrpsMDtos){
			entrpsMDao.deleteEntrpsM(data);
		}
	}
	
	// EntrpsSeCode 체크 확인
	private String CheckEntrpsSeCode(EntrpsMDto vo){
		if(vo.getEntrpsSeCodeCoop().equals("Y") && vo.getEntrpsSeCodeCus().equals("Y")){
			return "all";
		} else if(vo.getEntrpsSeCodeCoop().equals("Y")) {
			return "SY08000002";
		} else if(vo.getEntrpsSeCodeCus().equals("Y")) {
			return "SY08000001";
		} else {
			return "-";
		}
	}
	
	@Override
	public int entrpsNmValidation(EntrpsMDto vo){
		
		int count = 0;
	
		for(EntrpsMDto entrpsMDto : vo.getInsgridData()) {
			if(entrpsMDao.insEntrpsNmValidation(entrpsMDto) >= 1) {
				count ++;
			}
		}
		
		for(EntrpsMDto entrpsMDto : vo.getUpdGridData()) {
			if(entrpsMDao.updEntrpsNmValidation(entrpsMDto) >= 1) {
				count ++;
			}
		}
		
		return count;
	}
}