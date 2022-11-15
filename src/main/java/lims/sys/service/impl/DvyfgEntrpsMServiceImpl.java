package lims.sys.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.sys.dao.DvyfgEntrpsMDao;
import lims.sys.service.DvyfgEntrpsMService;
import lims.sys.vo.DvyfgEntrpsMVo;
import lims.util.FasooExtract;

@Service("DvyfgEntrpsMService")
public class DvyfgEntrpsMServiceImpl implements DvyfgEntrpsMService{

	@Autowired
	private DvyfgEntrpsMDao dvyfgEntrpsMDao;
	
	/**
	 * 납품 업체 정보 저장
	 */
	@Override
	public int saveDvyfgEntrpsM(DvyfgEntrpsMVo vo) {
		int result = 0;
		
		if(vo.getCrud().equals("C")){
			result = dvyfgEntrpsMDao.saveDvyfgEntrpsM(vo);
		}
		else if(vo.getCrud().equals("U")){
			result = dvyfgEntrpsMDao.updDvyfgEntrpsM(vo);
		}
		else if(vo.getCrud().equals("D")){
			result = dvyfgEntrpsMDao.delDvyfgEntrpsM(vo);
		}
		
		return result;
	}

	@Override
	public List<DvyfgEntrpsMVo> getDvyfgEntrpsM(DvyfgEntrpsMVo vo) {
		// TODO Auto-generated method stub
		return dvyfgEntrpsMDao.getDvyfgEntrpsM(vo);
	}

	/**
	 * 납품업체 엑셀 업로드
	 */
	@Override
	public HashMap<String, Object> uploadDvyfgEntrpsExcel(MultipartHttpServletRequest request) {
		
		MultipartFile file = null;
		File convFile = null;
		Workbook workbook = null;
		
		try{
			file = request.getFile("formFile");
			convFile = new File(file.getOriginalFilename());
			
			file.transferTo(convFile);
			
			FasooExtract fasooExtract = new FasooExtract();
			fasooExtract.DoExtract(convFile.getAbsoluteFile().toString());
			
			//Workbook 로 해야 xls, xlsx 두개다 됨
			workbook = WorkbookFactory.create(convFile);
			
			int rowindex = 0;
			//시트 수			
			int sheetIndex = workbook.getNumberOfSheets();			
			//시트 수만큼 반복
			for(int shIndex=0; shIndex<sheetIndex; shIndex++){
				Sheet sheet = workbook.getSheetAt(shIndex); //각행을 읽어온다
				
				int rows = sheet.getPhysicalNumberOfRows(); // 정의 된 행의 수를 반환.
				
				//실제 데이터가 작성되는 2번째 row 부터
				for(rowindex = 2; rowindex <= rows; rowindex++){
					Row row = sheet.getRow(rowindex);
					
					if(row != null){
						
						
						DvyfgEntrpsMVo dvyfgEntrpsMVo = new DvyfgEntrpsMVo();
						
						//컬럼수 만큼 반복
						for(int cols = 1; cols < 4; cols++){
							Cell cell = row.getCell(cols);
							String value = "";
							
							if(cell != null){
								if(String.valueOf(cell.getCellType()).equals("STRING")){
									value = cell.getStringCellValue().trim();
								}
								else if(String.valueOf(cell.getCellType()).equals("BOOLEAN")){
									value = String.valueOf(cell.getBooleanCellValue()).trim();
								}
								else if(String.valueOf(cell.getCellType()).equals("NUMERIC")){
									value = String.valueOf((int)cell.getNumericCellValue()).trim();
								}
								
								if(cols == 1){
									dvyfgEntrpsMVo.setDvyfgEntrpsCode(value);
								}
								else if(cols == 2){
									dvyfgEntrpsMVo.setDvyfgEntrpsNm(value);
								}
								else if(cols == 3){
									dvyfgEntrpsMVo.setDvyfgEntrpsSeCode(value);
								}
							}
						}						
						
						dvyfgEntrpsMDao.saveDvyfgEntrpsM(dvyfgEntrpsMVo);
					}
				}
			}
		}catch(Exception e){
			e.getStackTrace();
		}finally {
			if(workbook != null){
				try {
					workbook.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(convFile != null){
				convFile.delete();
			}
		}
		return null;
	}

}
