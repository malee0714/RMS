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
	 * 미등록 설비 검교정 목록 조회
	 */
	@Override
	public List<MhrlsUnInspctMVo> getMhrlsUnInspctM(MhrlsUnInspctMVo vo) {
		return mhrlsUnInspctMDao.getMhrlsUnInspctM(vo);
	}
	/**
	 * 미등록 설비 검교정 목록 조회 (월별)
	 */
	@Override
	public List<MhrlsUnInspctMVo> getMonthMhrlsUnInspctM(MhrlsUnInspctMVo vo) {
		return mhrlsUnInspctMDao.getMonthMhrlsUnInspctM(vo);
	}
	
	/**
	 * 미등록 설비 검교정 목록 조회 (부서별)
	 */
	@Override
	public List<MhrlsUnInspctMVo> getdeptMhrlsUnInspctM(MhrlsUnInspctMVo vo) {
		return mhrlsUnInspctMDao.getdeptMhrlsUnInspctM(vo);
	}
	
	/**
	 * 미등록 설비 검교정 목록 저장
	 */
	@Override
	public int saveMhrlsUnInspctM(MhrlsUnInspctMVo vo) {
		int result = 0;
		
		try{
			//추가
			MhrlsUnInspctMVo addListVo = new MhrlsUnInspctMVo();
			//수정
			MhrlsUnInspctMVo editListVo = new MhrlsUnInspctMVo();
			//삭제
			MhrlsUnInspctMVo removeListVo = new MhrlsUnInspctMVo();
			
			/* 그리드 추가 데이터 저장 */
			for(int i=0; i<vo.getAddGridData().size(); i++ ){
				addListVo = vo.getAddGridData().get(i);
				result += mhrlsUnInspctMDao.insertMhrlsUnInspctM(addListVo);
			}
			
			/* 그리드 수정 데이터 저장 */
			for(int i=0; i<vo.getEditGridData().size(); i++ ){
				editListVo = vo.getEditGridData().get(i);
				addListVo.setDeleteAt("N");
				result += mhrlsUnInspctMDao.updateMhrlsUnInspctM(editListVo);
			}
			
			/* 그리드 삭제 데이터 저장 */
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
	 * 양식 파일 업로드
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
			//시트 수 (첫번째에만 존재하므로 0을 준다)
			Sheet sheet = workbook.getSheetAt(0); //각행을 읽어온다
			
			int rows = sheet.getPhysicalNumberOfRows(); // 정의 된 행의 수를 반환.
			
			String[] sampleList = {
					"deptCode"			  /*팀 코드*/
				   ,"ProcessCode"		  /*공정코드*/
				   ,"mhrlsNm"			  /*설비명*/
				   ,"mhrlsManageNo"       /*PM설비번호*/
				   ,"inspctCrrctPlanDte"  /*검교정 계획일*/
				   ,"sanctnDrftDte"       /*결재기안일*/
				   ,"inspctCrrctOpertnAt" /*검교정 시행여부*/
				   ,"inspctCrrctCycle"    /*검교정 주기*/
				   ,"inspctCrrctMthCode"  /*검교정 방법*/
				   ,"inspctCrrctChargerNm"/*검교정검사자*/
				   ,"nextInspctCrrctDte", /*차기검교정일*/
					"inspctCrrctDte"      /*검교정일*/
				   };
			
			//부서 확인
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
			//부서가없으면 -2값으로 리턴
			if(result == -2){
				return result;
			}
			
			//실제 데이터가 작성되는 5번째 row 부터
			for(rowindex = 5; rowindex <= rows; rowindex++){
				
				Row row = sheet.getRow(rowindex);
				HashMap<String, Object> sampleMap = new HashMap<String, Object>();
				MhrlsUnInspctMVo sampleListVo = new MhrlsUnInspctMVo();
				Object obj = sampleListVo;
				
				if(row != null){
					
					//컬럼수 만큼 반복
					for(int cols = 0; cols < sampleList.length; cols++){
						
						Cell cell = sheet.getRow(rowindex).getCell(cols); //셀에 담겨있는 값을 읽는다.
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
						
						
						
						//검교정 계획일
						if(sampleList[cols].toString().equals("deptCode")){
							HashMap<String, Object> deptMap = new HashMap<String, Object>();
							deptMap.put("deptCode", value);
							MhrlsUnInspctMVo mhrlsUnInspctMVo = mhrlsUnInspctMDao.getDeptCodeCnt(deptMap);
							
							value = mhrlsUnInspctMVo.getDeptCode();
						}
						else if(sampleList[cols].toString().equals("inspctCrrctPlanDte")){
							value = value.replaceAll("\\.", "-");
						}		
						//결재 기안일
						else if(sampleList[cols].toString().equals("sanctnDrftDte")){
							value = value.replaceAll("\\.", "-");
						}
						//차기 검교정일
						else if(sampleList[cols].toString().equals("nextInspctCrrctDte")){
							value = value.replaceAll("\\.", "-");
						}
						//검교정일
						else if(sampleList[cols].toString().equals("inspctCrrctDte")){
							value = value.replaceAll("\\.", "-");
						}
						//검교정 방법 : 자체 (대문자 I - RS12000001), 사외 (대문자 O - RS12000002)
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
						
						//공정코드는 제외
						if(!sampleList[cols].toString().equals("ProcessCode")){
							sampleMap.put(sampleList[cols], value);
						}						
					}
					
					//저장
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
