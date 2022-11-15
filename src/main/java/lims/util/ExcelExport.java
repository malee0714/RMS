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

            FileInputStream fis = new FileInputStream("D:\\foosung_excel\\201906\\15\\"+fileName+".xlsx");//경로의 파일을 읽어 온다.

            XSSFWorkbook workbook = new XSSFWorkbook(fis);
            XSSFSheet sheet = workbook.getSheetAt(0); // 해당 엑셀파일의 시트(Sheet) 수
            int rows = sheet.getPhysicalNumberOfRows(); // 해당 시트의 행의 개수
            for (int rowIndex = 0; rowIndex < rows; rowIndex++) {//행 개수 만큼 포문 실행
                Row row = sheet.getRow(rowIndex); // 각 행을 읽어온다
                if (row != null) {//로우의 값이 널이 아닌지 체크
                    int cells = row.getPhysicalNumberOfCells();//row에 몇개의 컬럼이 있는지 체크(size(), length와 비슷함)
                    //읽은 값들은 넣어줄 map변수 선언
                    map = new HashMap<String,Object>();
                    for (int columnIndex = 0; columnIndex <= cells; columnIndex++) {//컬럼 개수만큼 포문 실행



                    	//셀의 값이 널이 아닌지 체크

                    	if(!"".equals(row.getCell(columnIndex))&& row.getCell(columnIndex) != null){
                    		//columnIndex번째에 셀의 값 담기
                    		Cell cell = row.getCell(columnIndex);

                            //데이터 타입에 따라 값 읽기
                            switch (cell.getCellType()) {
                                case STRING://문자열일떄
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
                    list.add(rowIndex, map);//각 컬럼의 값을 읽어온후 리스트에 담는다.(리스트의 인덱스 = 엑셀의 행)
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

		return list;
	}

	public MainVo excelWrite(String fileName){
		// Workbook 생성
		//HSSFWorkbook  xlsWb = new HSSFWorkbook(); // Excel 2007 이전 버전
        XSSFWorkbook xlsxWb = new XSSFWorkbook(); // Excel 2007 이상

        MainVo result = null;

        try {
	        // *** Sheet-------------------------------------------------
	        // Sheet 생성
	        Sheet sheet1 = xlsxWb.createSheet("firstSheet");


	        // Cell 스타일 생성
	        CellStyle cellStyle = xlsxWb.createCellStyle();//제목용

	        // 줄 바꿈
	        cellStyle.setWrapText(true);

	        Row row = null;
	        Cell cell = null;
	        //----------------------------------------------------------

        	// 줄 생성
	        row = sheet1.createRow(0);


    		row.setHeight((short)1000);

    		sheet1.addMergedRegion(new CellRangeAddress(//셀 병합
	                0, //first row (0-based)
	                0, //last row  (0-based)
	                0, //first column (0-based)
	                3  //last column  (0-based)
	        ));

    		//스타일 지정
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
    		cell.setCellValue("공지사항");
    		cell.setCellStyle(cellStyle);

    		row = sheet1.createRow(1);

    		cell = row.createCell(0);
	        cell.setCellValue("공지사항");
	        cell.setCellStyle(cellStyle);

        	//각 열의 헤더 값
			cellStyle.setFillForegroundColor(IndexedColors.AQUA.getIndex());
			cellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			cellStyle.setAlignment(HorizontalAlignment.CENTER);
			cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);


    		// 첫 번째 줄에 Cell 설정하기-------------
        	cell = row.createCell(1);
	        cell.setCellValue("두번째 값");
	        cell.setCellStyle(cellStyle);

        	//내용

    		//row = sheet1.createRow(2);

    		// 첫 번째 줄에 Cell 설정하기-------------
        	cell = row.createCell(2);
	        cell.setCellValue(1555);
	        cell.setCellStyle(cellStyle);

	        // 첫 번째 줄에 Cell 설정하기-------------
        	cell = row.createCell(3);
	        cell.setCellValue(new Date());
	        cell.setCellStyle(cellStyle);

	        //현재 날짜 계산
	        SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd");
	        Date time = new Date();
	        String time1 = format1.format(time);
	        fileName = fileName+"_"+time1.replaceAll("-", "")+".xlsx";
	        String path = "D:\\foosung_excel\\"+time1.substring(0,7).replaceAll("-", "")+"\\"+time1.substring(8, time1.length());
	        String fullPath = path+"\\"+fileName;


	        //경로 있는지 확인
	        File Folder = new File("D:\\foosung_excel\\"+time1.substring(0,7).replaceAll("-", ""));
	        if(!Folder.exists()){
        		Folder.mkdir(); //폴더 생성합니다.
	        }

	        File Folder2 = new File(path);
    		if(!Folder2.exists()){
        		Folder2.mkdir(); //폴더 생성합니다.
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