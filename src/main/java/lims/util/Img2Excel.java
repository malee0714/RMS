package lims.util;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.apache.poi.hssf.usermodel.HSSFClientAnchor;
import org.apache.poi.hssf.usermodel.HSSFPatriarch;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.ClientAnchor;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.web.servlet.view.document.AbstractExcelView;

public class Img2Excel extends AbstractExcelView{
	
	String chartImg = null;
	String[] chartImgArr = null;
	
	//기본 생성자
	public Img2Excel(){
		
	}
	
	//이미지 여러개일때
	public Img2Excel(String[] chartImgArr){
		this.chartImgArr = chartImgArr;
	}
	
	//이미지 단건일때
	public Img2Excel(String chartImg){
		this.chartImg = chartImg;
	}
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
		String time = sdf.format(cal.getTime());

		String excelName = time;
		
		
		String img = chartImg;
		img = img.replaceAll("data:image/png;base64,", "");
		byte[] data = Base64.decodeBase64(img);
		
		HSSFSheet worksheet = workbook.createSheet("차트1");
		//이미지 크기만큼 셀병합
		worksheet.addMergedRegion (new CellRangeAddress(1, 36, 0, 20));
//		HSSFCell cell = getCell(worksheet, 0, 0);

//		cell.setCellValue(new HSSFRichTextString("테스트중"));

		int picture = workbook.addPicture(data, HSSFWorkbook.PICTURE_TYPE_PNG);
		
		HSSFPatriarch patriarch = worksheet.createDrawingPatriarch();
		//이미지박아넣음
		HSSFClientAnchor anchor = new HSSFClientAnchor(2,2,1021,253,(short)0,1,(short)20,36);
		anchor.setAnchorType(ClientAnchor.AnchorType.byId(1));
		patriarch.createPicture(anchor, picture);
		
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