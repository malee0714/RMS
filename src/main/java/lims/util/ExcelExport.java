package lims.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Color;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.web.servlet.View;

import lims.com.vo.MainVo;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;

import org.apache.poi.xssf.usermodel.XSSFRow;

import org.apache.poi.xssf.usermodel.XSSFSheet;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.xssf.usermodel.extensions.XSSFCellAlignment;
import org.apache.poi.xssf.usermodel.extensions.XSSFCellBorder;
import org.apache.poi.xssf.usermodel.extensions.XSSFCellFill;

public class ExcelExport {

	public List<HashMap<String, Object>> excelRead(String fileName){
		List<HashMap<String,Object>> list = new ArrayList<>();
		HashMap<String, Object> map = null;

		File file = new File("D:\\foosung_excel\\201906\\15\\"+fileName+".xlsx");
		if(!file.exists()){
			return list;
		}

		try {

            FileInputStream fis = new FileInputStream("D:\\foosung_excel\\201906\\15\\"+fileName+".xlsx");//????????? ????????? ?????? ??????.

            XSSFWorkbook workbook = new XSSFWorkbook(fis);
            XSSFSheet sheet = workbook.getSheetAt(0); // ?????? ??????????????? ??????(Sheet) ???
            int rows = sheet.getPhysicalNumberOfRows(); // ?????? ????????? ?????? ??????
            for (int rowIndex = 0; rowIndex < rows; rowIndex++) {//??? ?????? ?????? ?????? ??????
                Row row = sheet.getRow(rowIndex); // ??? ?????? ????????????
                if (row != null) {//????????? ?????? ?????? ????????? ??????
                    int cells = row.getPhysicalNumberOfCells();//row??? ????????? ????????? ????????? ??????(size(), length??? ?????????)
                    //?????? ????????? ????????? map?????? ??????
                    map = new HashMap<String,Object>();
                    for (int columnIndex = 0; columnIndex <= cells; columnIndex++) {//?????? ???????????? ?????? ??????



                    	//?????? ?????? ?????? ????????? ??????

                    	if(!"".equals(row.getCell(columnIndex))&& row.getCell(columnIndex) != null){
                    		//columnIndex????????? ?????? ??? ??????
                    		Cell cell = row.getCell(columnIndex);

                            //????????? ????????? ?????? ??? ??????
                            switch (cell.getCellType()) {
                                case STRING://???????????????
                                    map.put(String.valueOf(columnIndex), cell.getStringCellValue());
                                    break;
                                case NUMERIC:
                                    if (DateUtil.isCellDateFormatted(cell)) {
                                        map.put(String.valueOf(columnIndex), cell.getDateCellValue());
                                    } else {
                                        map.put(String.valueOf(columnIndex), cell.getNumericCellValue());
                                    }
                                    break;
                                case BOOLEAN:
                                    map.put(String.valueOf(columnIndex), cell.getBooleanCellValue());
                                    break;
                                case FORMULA:
                                    map.put(String.valueOf(columnIndex), cell.getCellFormula());
                                    break;
                                case BLANK:
                                    map.put(String.valueOf(columnIndex), "");
                                    break;
                                default:
                                	break;
                            }
                    	}
                    }
                    list.add(rowIndex, map);//??? ????????? ?????? ???????????? ???????????? ?????????.(???????????? ????????? = ????????? ???)
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

		return list;
	}

	public MainVo excelWrite(String fileName){
		// Workbook ??????
		//HSSFWorkbook  xlsWb = new HSSFWorkbook(); // Excel 2007 ?????? ??????
        XSSFWorkbook xlsxWb = new XSSFWorkbook(); // Excel 2007 ??????

        MainVo result = null;

        try {
	        // *** Sheet-------------------------------------------------
	        // Sheet ??????
	        Sheet sheet1 = xlsxWb.createSheet("firstSheet");


	        // Cell ????????? ??????
	        CellStyle cellStyle = xlsxWb.createCellStyle();//?????????

	        // ??? ??????
	        cellStyle.setWrapText(true);

	        Row row = null;
	        Cell cell = null;
	        //----------------------------------------------------------

        	// ??? ??????
	        row = sheet1.createRow(0);


    		row.setHeight((short)1000);

    		sheet1.addMergedRegion(new CellRangeAddress(//??? ??????
	                0, //first row (0-based)
	                0, //last row  (0-based)
	                0, //first column (0-based)
	                3  //last column  (0-based)
	        ));

    		//????????? ??????
    		Font font = xlsxWb.createFont();
    		font.setFontHeightInPoints((short)24);
    		//font.setBoldweight((short)font.BOLDWEIGHT_BOLD);
    		font.setBold(true);


    		cellStyle.setAlignment(HorizontalAlignment.CENTER);
    		cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);

    		cellStyle.setFont(font);

    		cellStyle.setBorderLeft(BorderStyle.MEDIUM);
    		cellStyle.setBorderBottom(BorderStyle.MEDIUM);
    		cellStyle.setBorderRight(BorderStyle.MEDIUM);

    		cell = row.createCell(0);
    		cell.setCellValue("????????????");
    		cell.setCellStyle(cellStyle);

    		row = sheet1.createRow(1);

    		cell = row.createCell(0);
	        cell.setCellValue("????????????");
	        cell.setCellStyle(cellStyle);

        	//??? ?????? ?????? ???
			cellStyle.setFillForegroundColor(IndexedColors.AQUA.getIndex());
			cellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			cellStyle.setAlignment(HorizontalAlignment.CENTER);
			cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);


    		// ??? ?????? ?????? Cell ????????????-------------
        	cell = row.createCell(1);
	        cell.setCellValue("????????? ???");
	        cell.setCellStyle(cellStyle);

        	//??????

    		//row = sheet1.createRow(2);

    		// ??? ?????? ?????? Cell ????????????-------------
        	cell = row.createCell(2);
	        cell.setCellValue(1555);
	        cell.setCellStyle(cellStyle);

	        // ??? ?????? ?????? Cell ????????????-------------
        	cell = row.createCell(3);
	        cell.setCellValue(new Date());
	        cell.setCellStyle(cellStyle);

	        //?????? ?????? ??????
	        SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd");
	        Date time = new Date();
	        String time1 = format1.format(time);
	        fileName = fileName+"_"+time1.replaceAll("-", "")+".xlsx";
	        String path = "D:\\foosung_excel\\"+time1.substring(0,7).replaceAll("-", "")+"\\"+time1.substring(8, time1.length());
	        String fullPath = path+"\\"+fileName;


	        //?????? ????????? ??????
	        File Folder = new File("D:\\foosung_excel\\"+time1.substring(0,7).replaceAll("-", ""));
	        if(!Folder.exists()){
        		Folder.mkdir(); //?????? ???????????????.
	        }

	        File Folder2 = new File(path);
    		if(!Folder2.exists()){
        		Folder2.mkdir(); //?????? ???????????????.
	        }


	        File xlsFile = new File(fullPath);
            FileOutputStream fileOut = new FileOutputStream(xlsFile);

            result = new MainVo();
			result.setFullPath(fullPath);
			result.setFileName(fileName);
            xlsxWb.write(fileOut);
            xlsxWb.close();
            fileOut.close();

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

	        return result;
	}
}