package lims.util;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

public class ExcelView extends AbstractExcelView{
	
	Workbook wb = null;
	
	//기본 생성자
	public ExcelView(){
		
	}
	
	public ExcelView(Workbook wb){
		this.wb = wb;
	}
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
		String time = sdf.format(cal.getTime());

		String excelName = time;
		
		workbook = (HSSFWorkbook) wb;
		
		
		//리스폰스 헤더 세팅
		response.setContentType("application/Msexcel");
		response.setHeader("Content-Disposition", "attachment; Filename=" + excelName + ".xls");
		response.setHeader("Content-Transfer-Encoding", "binary;"); 
	    response.setHeader("Pragma", "no-cache;"); 
	    response.setHeader("Expires", "-1;");
		
		OutputStream os = null;
		try{
			os = response.getOutputStream();
			
			workbook.write(os);
		} catch(IOException e){
			e.printStackTrace();
		} finally {
			if(workbook != null){
				try{
					workbook.close();
				} catch(IOException e){
					e.printStackTrace();
				}
			}
			
			if(os != null){
				try {
					os.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
}