package lims.util;
import  java.io.BufferedWriter ;
import java.io.File;
import  java.io.FileInputStream ;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import  java.io.IOException ;
import  java.io.InputStream ;
import java.io.OutputStreamWriter;
import java.text.NumberFormat;
import java.util.Iterator;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import  org.apache.poi.openxml4j.exceptions.InvalidFormatException ;
import  org.apache.poi.ss.usermodel.Cell ;
import org.apache.poi.ss.usermodel.CellValue;
import  org.apache.poi.ss.usermodel.DateUtil ;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import  org.apache.poi.ss.usermodel.Row ;
import  org.apache.poi.ss.usermodel.Sheet ;
import  org.apache.poi.ss.usermodel.Workbook;
import  org.apache.poi.ss.usermodel.WorkbookFactory ;





public class ExcelReading {
	public static void convertExcelToCSV(String fileName) throws InvalidFormatException, IOException {
		BufferedWriter output = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fileName.substring(0, fileName.lastIndexOf(".")) + ".csv"), "euc-kr"));
		//파일만들고
		InputStream is = new FileInputStream(fileName);
		//워크북만들고
		Workbook wb = WorkbookFactory.create(is);
		//시트만들고
		Sheet sheet = wb.getSheetAt(0);
		
		FormulaEvaluator evaluator = wb.getCreationHelper().createFormulaEvaluator();
		
		// 마지막 셀 번호	
		if(wb.getSheetAt(0).getFirstRowNum() >= 1) {
			// 행을 0부터 돌려야하는데 엑셀 서식에 1부터 시작된게 있어서 추가시킴(양식에 따라 0시작,1시작)
			Row row22 = sheet.createRow(0);
		}
		int maxColumns = sheet.getRow(0).getLastCellNum();
		//행 갯수를 가져온다
		int rows = sheet.getLastRowNum() + 1;
		for(int a=0; a<rows; a++) {
			Row row = sheet.getRow(a);
			if(row == null) {
				continue;
			}

			// 행을 돌려서 컬럼값이 더 크면 넣어줌
			if(maxColumns < sheet.getRow(a).getLastCellNum()) {
				maxColumns = sheet.getRow(a).getLastCellNum();
			} 

		}

		for (int q=0; q < rows; q++) {
			int minCol = 0; // row.getFirstCellNum()
			int maxCol = maxColumns; // row.getLastCellNum()
			Row row = sheet.getRow(q);	
			if(row == null) {
				output.write("\r\n");
				continue;
			}
			for (int i = minCol; i < maxCol; i++) {

				Cell cell = row.getCell(i);
				String buf = "";

				if (i > 0) {
					buf = ",";
				}
				
				if (cell == null) {
					output.write(buf);
				} else {

					String v = null;
					switch (cell.getCellType()) {
					case STRING:
						// 공백이 nbsp가 들어가있는경우도 있다
						if(cell.getRichStringCellValue().getString().contains("   ")) {
							v = cell.getRichStringCellValue().getString().replace("   ","   ");
						} else {
							v = cell.getRichStringCellValue().getString();
						}
						
						break;
					case NUMERIC:
						if (DateUtil.isCellDateFormatted(cell)) {
							v = cell.getDateCellValue().toString();
						} else {
//							v = String.valueOf(cell.getNumericCellValue());
							NumberFormat f = NumberFormat.getInstance();
							f.setGroupingUsed(false);
							v = String.valueOf(f.format(cell.getNumericCellValue())).trim();
						}
						break;
					case BOOLEAN:
						v = String.valueOf(cell.getBooleanCellValue());
						break;
					case FORMULA:
						// 수식계산해서 넣어줌
						evaluator.evaluateFormulaCell(cell); 
						Cell cellValue = evaluator.evaluateInCell(cell);
						v =  String.valueOf(cellValue);
						break;
					default:
					}
					if (v != null) {
						//모든 시트의 셀을 다 가져와서 수식이 포함된 셀의 결과를 저장
						buf = buf + toCSV(v);
					} 
					output.write(buf);
				}
				
			}

			output.write("\n");
		}
		
		is.close();
		output.close();
	}


	public static String toCSV(String value) {
		String v = null;
		boolean doWrap = false;
		if (value != null) {
			v = value;

			// 벨류값에 포함
			if (v.contains("\"")) {
				v = v.replace("\"", "\"\""); // 치환
				doWrap = true;
			}

			if (v.contains(",") || v.contains("\n")) {
				doWrap = true;
			}

			if (doWrap) {
				v = "\"" + v + "\""; // 큰 따옴표로 쉼표 숨김
			}
		}

		return v;
	}
	
}
