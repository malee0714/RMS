package lims.util;

import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.xssf.usermodel.*;

public class RowCopy {

    public static void copyRow(HSSFWorkbook workbook, HSSFSheet worksheet, int sourceRowNum, int destinationRowNum) {

        //복사할 대상 행과 새 행 가져오기
        HSSFRow newRow = worksheet.getRow(destinationRowNum);
        HSSFRow sourceRow = worksheet.getRow(sourceRowNum);

        if (newRow != null) {
            worksheet.removeRow(newRow);
            newRow = worksheet.createRow(destinationRowNum);
        } else {
            newRow = worksheet.createRow(destinationRowNum);
        }

        //복사할 대상 행의 열 수만큼 반복하여 새 행에 추가
        for (int i = 0; i < sourceRow.getLastCellNum(); i++) {
            HSSFCell oldCell = sourceRow.getCell(i);
            HSSFCell newCell = newRow.createCell(i);

            //이전 셀이 null이면 다음 셀로 점프
            if (oldCell == null) {
                newCell = null;
                continue;
            }

            if (oldCell.getCellType() == oldCell.getCellType().FORMULA) {
                newCell.setCellFormula(oldCell.getCellFormula().toString());
            }

            //이전 셀에서 스타일을 복사하고 새 셀에 적용
            HSSFCellStyle newCellStyle = workbook.createCellStyle();
            newCellStyle.cloneStyleFrom(oldCell.getCellStyle());

            newCell.setCellStyle(newCellStyle);

            //셀 주석이 있으면 복사
            if (oldCell.getCellComment() != null) {
                newCell.setCellComment(oldCell.getCellComment());
            }

            //셀 하이퍼링크가 있는 경우 복사
            if (oldCell.getHyperlink() != null) {
                newCell.setHyperlink(oldCell.getHyperlink());
            }

            //셀 데이터 유형 설정
            newCell.setCellType(oldCell.getCellType());

            /**
             * 셀 데이터 값 설정
             * 복사한 셀에 박혀있던 인덱스 값이 그대로 복사되어 새 행에 붙여넣어 졌기 때문에
             * 새 셀의 인덱스 값을 행 번호와 매핑되도록 변경
             */
            switch (oldCell.getCellType()) {
                case BLANK:
                    newCell.setCellValue(oldCell.getStringCellValue());
                    break;
                case BOOLEAN:
                    newCell.setCellValue(oldCell.getBooleanCellValue());
                    break;
                case ERROR:
                    newCell.setCellErrorValue(oldCell.getErrorCellValue());
                    break;
                case FORMULA:
                    String intStr = oldCell.getCellFormula().replaceAll("[^\\d]", "");
                    newCell.setCellFormula(oldCell.getCellFormula().replace(intStr.substring(0,1), String.valueOf(newRow.getRowNum()+1)));
                    break;
                case NUMERIC:
                    newCell.setCellValue(oldCell.getNumericCellValue());
                    break;
                case STRING:
                    newCell.setCellValue(oldCell.getRichStringCellValue());
                    break;
            }
        }
    }

    public static void copyRow2(XSSFWorkbook workbook, XSSFSheet worksheet, int sourceRowNum, int destinationRowNum) {

        //복사할 대상 행과 새 행 가져오기
        XSSFRow newRow = worksheet.getRow(destinationRowNum);
        XSSFRow sourceRow = worksheet.getRow(sourceRowNum);

        FormulaEvaluator formulaEval = workbook.getCreationHelper().createFormulaEvaluator();
        workbook.getCreationHelper().createFormulaEvaluator().evaluateAll();
        workbook.setForceFormulaRecalculation(true);
        
        /**
         * 모든 COA양식은 첫번째 row에만 양식을 작성하고 그 행을 제품lot 수만큼 copy하여 데이터를 출력하는 방식이기 때문에
         * 첫번째 행을 제외하고 다른 행은 null일 수가 없음.
         * but, null인 경우 -> 사용자가 기존에 다른 엑셀파일의 내용을 지우고 그 파일에 양식을 만드는 케이스
         */
        //새 행이 null이 아니면 새 행을 제거하고 다른 새로운 행을 생성해줌
        if (newRow != null) {
            worksheet.removeRow(newRow);
            newRow = worksheet.createRow(destinationRowNum);
        } else {
            newRow = worksheet.createRow(destinationRowNum);
        }

        //복사할 대상 행의 열 수만큼 반복하여 새 행에 추가
        for (int i = 0; i < sourceRow.getLastCellNum(); i++) {
            XSSFCell oldCell = sourceRow.getCell(i);
            XSSFCell newCell = newRow.createCell(i);

            //이전 셀이 null이면 다음 셀로 점프
            if (oldCell == null) {
                newCell = null;
                continue;
            }

            //복사한 셀의 셀타입이 수식인 경우 새 행에 동일한 수식을 적용
            if (oldCell.getCellType() == oldCell.getCellType().FORMULA) {
                newCell.setCellFormula(oldCell.getCellFormula().toString());
            }

            //이전 셀에서 스타일을 복사하고 새 셀에 적용
            XSSFCellStyle newCellStyle = workbook.createCellStyle();
            newCellStyle.cloneStyleFrom(oldCell.getCellStyle());

            newCell.setCellStyle(newCellStyle);

            //셀 주석이 있으면 복사
            if (oldCell.getCellComment() != null) {
                newCell.setCellComment(oldCell.getCellComment());
            }

            //셀 하이퍼링크가 있는 경우 복사
            if (oldCell.getHyperlink() != null) {
                newCell.setHyperlink(oldCell.getHyperlink());
            }

            //셀 데이터 유형 설정
            newCell.setCellType(oldCell.getCellType());

            //셀 데이터 값 설정
            switch (oldCell.getCellType()) {
                case BLANK:
                    newCell.setCellValue(oldCell.getStringCellValue());
                    break;
                case BOOLEAN:
                    newCell.setCellValue(oldCell.getBooleanCellValue());
                    break;
                case ERROR:
                    newCell.setCellErrorValue(oldCell.getErrorCellValue());
                    break;
                case FORMULA:
                    //수식셀을 copy하는 경우 기존 수식의 숫자값을 행 번호에 맞는 숫자값으로 바꿔서 set
                    String intStr = oldCell.getCellFormula().replaceAll("[^\\d]", "");
                    newCell.setCellFormula(oldCell.getCellFormula().replace(intStr.substring(0,1), String.valueOf(newRow.getRowNum())));
                    break;
                case NUMERIC:
                    newCell.setCellValue(oldCell.getNumericCellValue());
                    break;
                case STRING:
                    newCell.setCellValue(oldCell.getRichStringCellValue());
                    break;
            }
        }
    }
}
