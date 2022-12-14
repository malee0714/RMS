package lims.rsc.service.Impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.channels.FileChannel;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CellValue;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.com.service.FileUpDownloadMService;
import lims.com.vo.FileDetailMVo;
import lims.rsc.dao.MhrlsUnInspctMDao;
import lims.rsc.service.MhrlsUnInspctMService;
import lims.rsc.vo.MhrlsUnInspctMVo;
import lims.util.ConverterUtils;
import lims.util.FasooExtract;

@Service("MhrlsUnInspctMService")
public class MhrlsUnInspctMServiceImpl implements MhrlsUnInspctMService{

	@Autowired
	private MhrlsUnInspctMDao mhrlsUnInspctMDao;
	
	@Value("${form.file.download}")
	private String formFilePath;
	
	@Value("${file.upload.path}")
	private String fileUploadPath;
	
	
	@Resource(name="fileUpDownloadMServiceImpl")
	private FileUpDownloadMService fileUpDownloadServiceImpl;
	
	/**
	 * ????????? ?????? ????????? ?????? ??????
	 */
	@Override
	public List<MhrlsUnInspctMVo> getMhrlsUnInspctM(MhrlsUnInspctMVo vo) {
		return mhrlsUnInspctMDao.getMhrlsUnInspctM(vo);
	}
	/**
	 * ????????? ?????? ????????? ?????? ?????? (??????)
	 */
	@Override
	public List<MhrlsUnInspctMVo> getMonthMhrlsUnInspctM(MhrlsUnInspctMVo vo) {
		return mhrlsUnInspctMDao.getMonthMhrlsUnInspctM(vo);
	}
	
	/**
	 * ????????? ?????? ????????? ?????? ?????? (?????????)
	 */
	@Override
	public List<MhrlsUnInspctMVo> getdeptMhrlsUnInspctM(MhrlsUnInspctMVo vo) {
		return mhrlsUnInspctMDao.getdeptMhrlsUnInspctM(vo);
	}
	
	/**
	 * ????????? ?????? ????????? ?????? ??????
	 */
	@Override
	public int saveMhrlsUnInspctM(MhrlsUnInspctMVo vo) {
		int result = 0;
		
		try{
			//??????
			MhrlsUnInspctMVo addListVo = new MhrlsUnInspctMVo();
			//??????
			MhrlsUnInspctMVo editListVo = new MhrlsUnInspctMVo();
			//??????
			MhrlsUnInspctMVo removeListVo = new MhrlsUnInspctMVo();
			
			/* ????????? ?????? ????????? ?????? */
			for(int i=0; i<vo.getAddGridData().size(); i++ ){
				addListVo = vo.getAddGridData().get(i);
				result += mhrlsUnInspctMDao.insertMhrlsUnInspctM(addListVo);
			}
			
			/* ????????? ?????? ????????? ?????? */
			for(int i=0; i<vo.getEditGridData().size(); i++ ){
				editListVo = vo.getEditGridData().get(i);
				addListVo.setDeleteAt("N");
				result += mhrlsUnInspctMDao.updateMhrlsUnInspctM(editListVo);
			}
			
			/* ????????? ?????? ????????? ?????? */
			for(int i=0; i<vo.getRemoveGridData().size(); i++ ){
				removeListVo = vo.getRemoveGridData().get(i);
				result += mhrlsUnInspctMDao.deleteMhrlsUnInspctM(removeListVo);
			}
			
		}catch(Exception e){
			result = 0;
			throw e;
		}
		
		return result;
	}

	/**
	 * ?????? ?????? ?????????
	 * @throws Exception 
	 */
	@Override
	public int applyFormFile(MultipartHttpServletRequest request) throws Exception {
        int result = 0;
        File convFile = null;
        Workbook workbook = null;
        
		try {
			MultipartFile file = request.getFile("formFile");
			
			
			convFile = new File(file.getOriginalFilename());
			file.transferTo(convFile);
			
			FasooExtract fasooExtract = new FasooExtract();
			fasooExtract.DoExtract(convFile.getAbsoluteFile().toString());
			
			workbook = WorkbookFactory.create(convFile);
			
			int rowindex = 0;
			//?????? ??? (??????????????? ??????????????? 0??? ??????)
			Sheet sheet = workbook.getSheetAt(0); //????????? ????????????
			
			int rows = sheet.getPhysicalNumberOfRows(); // ?????? ??? ?????? ?????? ??????.
			
			String[] sampleList = {
					"deptCode"			  /*??? ??????*/
				   ,"ProcessCode"		  /*????????????*/
				   ,"mhrlsNm"			  /*?????????*/
				   ,"mhrlsManageNo"       /*PM????????????*/
				   ,"inspctCrrctPlanDte"  /*????????? ?????????*/
				   ,"sanctnDrftDte"       /*???????????????*/
				   ,"inspctCrrctOpertnAt" /*????????? ????????????*/
				   ,"inspctCrrctCycle"    /*????????? ??????*/
				   ,"inspctCrrctMthCode"  /*????????? ??????*/
				   ,"inspctCrrctChargerNm"/*??????????????????*/
				   ,"nextInspctCrrctDte", /*??????????????????*/
					"inspctCrrctDte"      /*????????????*/
				   };
			
			//?????? ??????
			for(rowindex = 5; rowindex <= rows; rowindex++){
				Row row = sheet.getRow(rowindex);
				if(row != null){
					Cell cell = sheet.getRow(rowindex).getCell(0);
					String value = "";
					
					if(cell != null){
						if(String.valueOf(cell.getCellType()).equals("STRING")){
							value = cell.getStringCellValue().trim();
						}
						else if(String.valueOf(cell.getCellType()).equals("BOOLEAN")){
							value = String.valueOf(cell.getBooleanCellValue()).trim();
						}
						else if(String.valueOf(cell.getCellType()).equals("NUMERIC")){
							NumberFormat f = NumberFormat.getInstance();
							f.setGroupingUsed(false);
							value = String.valueOf(f.format(cell.getNumericCellValue())).trim();
						}
						
						HashMap<String, Object> sampleMap = new HashMap<String, Object>();
						
						
						sampleMap.put("deptCode", value);						
						MhrlsUnInspctMVo mhrlsUnInspctMVo = mhrlsUnInspctMDao.getDeptCodeCnt(sampleMap);
						
						if(mhrlsUnInspctMVo.getDeptCode() == null || mhrlsUnInspctMVo.getDeptCode().equals("")){
							result = -2;
							break;
						}
					}
				}
			}
			//?????????????????? -2????????? ??????
			if(result == -2){
				return result;
			}
			
			//?????? ???????????? ???????????? 5?????? row ??????
			for(rowindex = 5; rowindex <= rows; rowindex++){
				
				Row row = sheet.getRow(rowindex);
				HashMap<String, Object> sampleMap = new HashMap<String, Object>();
				MhrlsUnInspctMVo sampleListVo = new MhrlsUnInspctMVo();
				Object obj = sampleListVo;
				
				if(row != null){
					
					//????????? ?????? ??????
					for(int cols = 0; cols < sampleList.length; cols++){
						
						Cell cell = sheet.getRow(rowindex).getCell(cols); //?????? ???????????? ?????? ?????????.
						String value = "";
						
						if(cell != null){
							if(String.valueOf(cell.getCellType()).equals("STRING")){
								value = cell.getStringCellValue().trim();
							}
							else if(String.valueOf(cell.getCellType()).equals("BOOLEAN")){
								value = String.valueOf(cell.getBooleanCellValue()).trim();
							}
							else if(String.valueOf(cell.getCellType()).equals("NUMERIC")){
								NumberFormat f = NumberFormat.getInstance();
								f.setGroupingUsed(false);
								value = String.valueOf(f.format(cell.getNumericCellValue())).trim();
							}
						}
						
						
						
						//????????? ?????????
						if(sampleList[cols].toString().equals("deptCode")){
							HashMap<String, Object> deptMap = new HashMap<String, Object>();
							deptMap.put("deptCode", value);
							MhrlsUnInspctMVo mhrlsUnInspctMVo = mhrlsUnInspctMDao.getDeptCodeCnt(deptMap);
							
							value = mhrlsUnInspctMVo.getDeptCode();
						}
						else if(sampleList[cols].toString().equals("inspctCrrctPlanDte")){
							value = value.replaceAll("\\.", "-");
						}		
						//?????? ?????????
						else if(sampleList[cols].toString().equals("sanctnDrftDte")){
							value = value.replaceAll("\\.", "-");
						}
						//?????? ????????????
						else if(sampleList[cols].toString().equals("nextInspctCrrctDte")){
							value = value.replaceAll("\\.", "-");
						}
						//????????????
						else if(sampleList[cols].toString().equals("inspctCrrctDte")){
							value = value.replaceAll("\\.", "-");
						}
						//????????? ?????? : ?????? (????????? I - RS12000001), ?????? (????????? O - RS12000002)
						else if(sampleList[cols].toString().equals("inspctCrrctMthCode")){
							if(String.valueOf(cell).equals("I")){
								value = "RS12000001";
							}
							else if(String.valueOf(cell).equals("O")){
								value = "RS12000002";
							}
						}else if(sampleList[cols].toString().equals("inspctCrrctOpertnAt")){
							if(value.equals("") || value.equals("null")){
								value = "N";
							}
						}
						
						//??????????????? ??????
						if(!sampleList[cols].toString().equals("ProcessCode")){
							sampleMap.put(sampleList[cols], value);
						}						
					}
					
					//??????
					result = mhrlsUnInspctMDao.insertMhrlsUnInspctM((MhrlsUnInspctMVo) ConverterUtils.convertHashMapToVo(sampleMap, obj));
				}
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = -2;
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		} finally {
			if(workbook != null){
				workbook.close();
			}
			if(convFile != null){
				convFile.delete();
			}
		}
		return result;
	}

}
