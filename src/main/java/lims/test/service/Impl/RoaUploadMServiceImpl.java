package lims.test.service.Impl;

import lims.test.dao.RoaUploadMDao;
import lims.test.service.RoaUploadMService;
import lims.test.vo.RoaUploadMVo;
import lims.util.CommonFunc;
import lims.util.ExcelDRMRequest;
import org.apache.poi.ss.formula.eval.ErrorEval;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.NumberToTextConverter;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.util.*;

@Service
public class RoaUploadMServiceImpl implements RoaUploadMService {

    @Autowired
    private RoaUploadMDao roaUploadMDao;

    @Autowired
    private CommonFunc commonFunc;

    @Autowired
    private ExcelDRMRequest excelDRMRequest;

    @Override
    public RoaUploadMVo getUploadAvailability(MultipartHttpServletRequest request) {
        //벨리데이션 상태값을 사용자에게 전달하기 위한 변수
        RoaUploadMVo msg = new RoaUploadMVo();
        //DRM 해제 및 return Base64 String 추출 (원래 소스)
        //DRM 해제한 String to workBook

        try (XSSFWorkbook workbook = getDRMStringToWorkBook(excelDRMRequest.callSoapService(request))) {
            if (workbook != null) {
                Sheet sheet = workbook.getSheetAt(0); //첫번째 시트에 Lot Trace 정보가 있으므로 0번 시트 고정

                //그리드에서 선택한 자재시퀀스와 엑셀에있는 자재코드 비교
                Row mtrilCodeRow = sheet.getRow(3);
                Cell mtrilCodeCell = mtrilCodeRow.getCell(1);
                String excelMtrilCode = getValue(mtrilCodeCell);
                String mtrilSeqno = request.getParameter("mtrilSeqno");
                String mtrilCode = roaUploadMDao.getMtrilCode(mtrilSeqno);
                if (!excelMtrilCode.equals(mtrilCode)) {
                    msg.setGbnMsg("Not Match");
                    return msg;
                }

                //자재 마스터 시험항목 리스트와 엑셀에 시험항목 리스트 비교
                //서로 다를 수 있으며 사용자에게 내용만 전달하고 저장에 분기사항이 되지 않음
                List<String> mtrilExpriemList = roaUploadMDao.getMtrilExpriem(mtrilSeqno);
                int expriemCnt = 0;
                if (mtrilExpriemList.size() > 0) {
                    Row exprimeRow = sheet.getRow(2); //시험항목명이 있는 로우
                    int cells = exprimeRow.getPhysicalNumberOfCells(); //총 열의 수
                    for (int i = 0; i < cells; i++) {
                        if (commonFunc.isEmpty(getValue(exprimeRow.getCell(i))))
                            break; //시험항목명이 비어있는 이후는 사용하지 않는 Cell로 정함
                        for (String s : mtrilExpriemList) {
                            //시험 횟수와 관련된 추가 시험항목명은 카운트 올리지 않음
                            if (!getValue(exprimeRow.getCell(i)).contains("#"))
                                expriemCnt = s.equals(getValue(exprimeRow.getCell(i))) ? expriemCnt + 1 : expriemCnt;
                        }
                    }
                }

                if (mtrilExpriemList.size() < expriemCnt) {
                    msg.setGbnMsg("cntDifference");
                    return msg;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        //엑셀 종료

        msg.setGbnMsg("success");
        return msg;
    }

    @Override
    public int insRoaUpload(MultipartHttpServletRequest request) {
        int returnCount = 0;
        try (XSSFWorkbook workbook = getDRMStringToWorkBook(excelDRMRequest.callSoapService(request))) {
            String mtrilSeqno = request.getParameter("mtrilSeqno");
            if (workbook != null) {
                //ROA 업로드는 삭제 후 등록
                roaUploadMDao.delSyMtrilRoaUploadResult(mtrilSeqno);
                roaUploadMDao.delSyMtrilRoaUpload(mtrilSeqno);

                Sheet sheet = workbook.getSheetAt(0); //첫번째 시트에 Lot Trace 정보가 있으므로 0번 시트 고정
                int rows = sheet.getPhysicalNumberOfRows();  //총 행의 수
                //값이 있는 행부터 진행
                for (int i = 3; i < rows; i++) {
                    //해당 로우에 자재코드값이 비어있으면 해당 행부터 반복루프 제거
                    Row row = sheet.getRow(i);
                    if (commonFunc.isEmpty(getValue(row.getCell(1)))) break;

                    RoaUploadMVo roaUploadMVo = new RoaUploadMVo();
                    roaUploadMVo.setMtrilSeqno(mtrilSeqno);
                    roaUploadMVo.setSn(String.valueOf(i - 2));
                    //SY 자재 ROA 업로드 테이블 등록
                    roaUploadMDao.insSyMtrilRoaUpload(roaUploadMVo);
                    int cells = row.getPhysicalNumberOfCells(); //총 열의 수
                    int resultTableIdx = 1; //ROA 업로드한 데이터 엑셀과 동일하게 뿌려주기 위해서 추가
                    for (int j = 4; j < cells; j++) {
                        //해당 셀에 시험항목명이 비어있으면 해당 행부터 반복루프 제거
                        if (commonFunc.isEmpty(getValue(sheet.getRow(2).getCell(j)))) break;
                        //VO 초기화 필요
                        roaUploadMVo.setExprNumot("");
                        roaUploadMVo.setResultValue("");
                        roaUploadMVo.setExpriemSeqno("");

                        //해당 행의 시험항목명을 가지고 항목시퀀스를 넣어주고 값넣어주고 인서트
                        Row expriemRow = sheet.getRow(2);
                        Cell expriemCell = expriemRow.getCell(j);
                        String expriemNm = getValue(expriemCell);
                        String expriemSeqno;
                        if (expriemNm.contains("#")) {
                            String subStringExpriemNm = expriemNm.substring(0, expriemNm.indexOf("#"));
                            expriemSeqno = roaUploadMDao.getExpriemSeqno(subStringExpriemNm);
                            roaUploadMVo.setExprNumot(expriemNm.substring(expriemNm.lastIndexOf("#") + 1)); //시험 횟수 추가
                        } else {
                            expriemSeqno = roaUploadMDao.getExpriemSeqno(expriemNm);
                            roaUploadMVo.setExprNumot("1"); //시험 횟수 디폴트
                        }
                        roaUploadMVo.setExpriemSeqno(expriemSeqno); //시험항목 일련번호
                        roaUploadMVo.setResultValue(getValue(sheet.getRow(i).getCell(j))); //결과 값
                        roaUploadMVo.setSortOrdr(String.valueOf(resultTableIdx));
                        resultTableIdx++;
                        //SY 자재 ROA 업로드 결과 테이블 등록
                        roaUploadMDao.insSyMtrilRoaUploadResult(roaUploadMVo);
                    }
                }
                returnCount = 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnCount;
    }

    //엑셀 컬럼 타입별 벨류 가져오기
    public String getValue(Cell cell) {
        //엑셀 03이하 버전에서 null에 대한 에러처리
        if(cell == null) return null;
        String value;
        // 셀 내용의 유형 판별
        switch (cell.getCellType()) {
            case STRING: // getRichStringCellValue() 메소드를 사용하여 컨텐츠를 읽음
                value = cell.getRichStringCellValue().getString(); break;
            case NUMERIC: // 날짜 또는 숫자를 포함 할 수 있으며 아래와 같이 읽음
                // NUMERIC을 사용하여 지수로 강제 변환되는 경우를 막기위해서 Converter 사용
                value = NumberToTextConverter.toText(cell.getNumericCellValue()); break;
            case BOOLEAN:
                value = String.valueOf(cell.getBooleanCellValue()); break;
            case FORMULA:
                value = String.valueOf(cell.getCellFormula()); break;
            case ERROR:
                value = ErrorEval.getText(cell.getErrorCellValue()); break;
            case BLANK:
            case _NONE:
            default:
                value = null;
        }
        return value;
    }

    @Override
    public RoaUploadMVo getSavedData(RoaUploadMVo vo) {
        RoaUploadMVo roaUploadMVo = new RoaUploadMVo(); // 리턴
        List<RoaUploadMVo> savedRoaUploadList = roaUploadMDao.getRoaUploadList(vo.getMtrilSeqno());
        LinkedHashMap<String, String> expriemNmMap; //시험항목 코드, 시험항목 명
        List<Map<String, String>> expriemResultList = new ArrayList<>(); //시험 결과 값 리스트
        Map<String,String> expriemResultMap = null; //시험항목 코드, 시험 결과 값
        int initCnt = 0;
        
        if(savedRoaUploadList.size() > 0) {
            expriemNmMap = new LinkedHashMap<>();
            for (int i = 0; i < savedRoaUploadList.size(); i++) {
                //시험횟수가 1보다 큰 경우 시험항목 시퀀스 OR 시험항목 명 + # + 시험횟수로 구분 값 설정
                //시험항목 시퀀스, 시퀀스앞에 "Z"는 의미없는 문자이며 시퀀스 숫자로만 데이터가 넘어가면 자동 정렬되어서 안되도록 하기위한 문자정도..
                String expriemSeqno = "1".equals(savedRoaUploadList.get(i).getExprNumot()) ?
                        "Z" + savedRoaUploadList.get(i).getExpriemSeqno() : "Z" + savedRoaUploadList.get(i).getExpriemSeqno() + "#" + savedRoaUploadList.get(i).getExprNumot();
                //시험항목 명
                String expriemNm = "1".equals(savedRoaUploadList.get(i).getExprNumot()) ?
                        savedRoaUploadList.get(i).getExpriemNm() : savedRoaUploadList.get(i).getExpriemNm() + "#" + savedRoaUploadList.get(i).getExprNumot();
                //결과 값
                String resultValue = savedRoaUploadList.get(i).getResultValue();

                //객체에 시험항목 시퀀스, 시험항목 명 설정
                if (commonFunc.isEmpty(expriemNmMap.get(expriemSeqno)))
                    expriemNmMap.put(expriemSeqno, expriemNm);

                //시험결과값 리스트
                //순번(행 숫자)이 변경될 때 마다 Map을 생성하여 리스트의 행, 열을 구분 
                if (initCnt < Integer.parseInt(savedRoaUploadList.get(i).getSn())) {
                    expriemResultMap = new HashMap<>();
                    initCnt = Integer.parseInt(savedRoaUploadList.get(i).getSn());
                }

                expriemResultMap.put(expriemSeqno, resultValue);

                //마지막 인덱스의 값을 리스트에 설정
                if (i + 1 < savedRoaUploadList.size()) {
                    if (Integer.parseInt(savedRoaUploadList.get(i).getSn()) < Integer.parseInt(savedRoaUploadList.get(i + 1).getSn()))
                        expriemResultList.add(expriemResultMap);
                } else if (i == savedRoaUploadList.size() - 1) {
                    //i + 1에 IndexOutOfBoundsException 막기
                    expriemResultList.add(expriemResultMap);
                }
            }
            roaUploadMVo.setExpriemNmMap(expriemNmMap);
            roaUploadMVo.setExpriemResultList(expriemResultList);

            //ROA 업로드 조회 화면에서 사용한 행 구분하기 위해 USE_AT 리스트 넘겨서 그리드 색칠..
            List<RoaUploadMVo> usedRoaUploadChkList = roaUploadMDao.getUsedRoaUploadChkList(vo);
            roaUploadMVo.setUsedRoaUploadChkList(usedRoaUploadChkList);
        }

        return roaUploadMVo;
    }

    //DRM String -> Workbook
    public XSSFWorkbook getDRMStringToWorkBook(String drmString) {
        //<Table1 기준으로 split 해서 행 수 만큼 문자배열 뽑을 수 있음
        String[] rowSplitStr = drmString.split("<Table1");
        //엑셀 파일 쓰기
        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet xssfSheet = workbook.createSheet();
        //엑셀 스타일 직접 확인하기 위한 용도
        CellStyle style = workbook.createCellStyle(); //엑셀 스타일
        style.setAlignment(HorizontalAlignment.CENTER); //셀 가운데 정렬
        for (int i = 1; i < rowSplitStr.length; i++) {
            //split 으로 짤린 문자열 다시 채워주기, 큰 의미는 없지만 데이터 확인하기 위한 용도로 쓸 때..
            rowSplitStr[i] = "<Table1" + rowSplitStr[i];
            //Row 생성
            Row row = xssfSheet.createRow(i - 1); // i - 1 = 로우 시작점은 0부터 시작
            int columnLastIdx =
                    Integer.parseInt(rowSplitStr[i].substring(rowSplitStr[i].lastIndexOf("<Column") + 7, rowSplitStr[i].indexOf(">", rowSplitStr[i].lastIndexOf("<Column") + 8)));

            for (int j = 1; j <= columnLastIdx; j++) {
                //Cell 생성, i < 4 = 상위 정보 설정, i >= 4 = 실제 값 설정
                //<Column?>값</Column?> 값을 빼오거나 Null인 경우 엑셀에 쓰지 않도록
                int idx = String.valueOf(j).length() == 1 ? 9 : String.valueOf(j).length() == 2 ? 10 : 11;
                if (i == 2 || i == 3) {
                    if (j >= 4) {
                        if (rowSplitStr[i].contains("<Column" + j)) {
                            String cellVal = rowSplitStr[i].substring(rowSplitStr[i].indexOf("<Column" + j + ">") + idx, rowSplitStr[i].indexOf("</Column" + j + ">"));
                            if(!commonFunc.isEmpty(cellVal))
                                row.createCell(j - 1).setCellValue(cellVal); // 셀 생성 & 값 입력, j - 1 = 셀 시작점은 0부터 시작
                        }
                    }
                } else {
                    if (rowSplitStr[i].contains("<Column" + j)) {
                        String cellVal = rowSplitStr[i].substring(rowSplitStr[i].indexOf("<Column" + j + ">") + idx, rowSplitStr[i].indexOf("</Column" + j + ">"));
                        if (!commonFunc.isEmpty(cellVal))
                            row.createCell(j - 1).setCellValue(cellVal); // 셀 생성 & 값 입력, j - 1 = 셀 시작점은 0부터 시작
                    }
                }
            }
        }

        //셀 병합
        xssfSheet.addMergedRegion(new CellRangeAddress(0, 2, 0, 0));
        xssfSheet.addMergedRegion(new CellRangeAddress(0, 2, 1, 1));
        xssfSheet.addMergedRegion(new CellRangeAddress(0, 2, 2, 2));

        return workbook;
    }
}
