package lims.test.service.Impl;

import lims.com.service.CommonService;
import lims.com.service.DragDropFileMService;
import lims.com.service.FileUpDownloadMService;
import lims.com.vo.ComboVo;
import lims.com.vo.FileDetailMVo;
import lims.test.dao.CoaMDao;
import lims.test.service.CoaMService;
import lims.test.vo.CoaMVo;
import lims.util.CommonFunc;
import lims.util.ExcelReading;
import lims.util.RowCopy;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.nio.channels.FileChannel;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class CoaMServiceImpl implements CoaMService {

	@Value("${file.upload.path}")
	private String fileUploadPath;
	private final CoaMDao coaMDao;
	private final CommonFunc commonFunc;
	private final CommonService commonService;
	private final DragDropFileMService dragDropFileMService;
	private final FileUpDownloadMService fileUpDownloadMService;

	@Autowired
	public CoaMServiceImpl(CoaMDao coaMDao, CommonFunc commonFunc, CommonService commonServiceImpl,
						   DragDropFileMService dragDropFileMServiceImpl, FileUpDownloadMService fileUpDownloadMServiceImpl) {
		this.coaMDao = coaMDao;
		this.commonFunc = commonFunc;
		this.commonService = commonServiceImpl;
		this.dragDropFileMService = dragDropFileMServiceImpl;
		this.fileUpDownloadMService = fileUpDownloadMServiceImpl;
	}

	@Override
	public List<CoaMVo> getCoaList(CoaMVo vo) {
		return coaMDao.getCoaList(vo);
	}

	@Override
	public HashMap<String, String> createExcelSample(List<CoaMVo> list, HttpServletResponse response) {

		HashMap<String, String> map = new HashMap<>();
		Workbook wb = null;

		//프로젝트 내에 엑셀샘플파일이 저장된 경로를 동적으로 가져옴
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String sampleFilePath = httpServletRequest.getServletContext().getRealPath("/sample");

		try {
			CoaMVo CoaVo = new CoaMVo();
			CoaVo.setLotList(list);
			List<CoaMVo> exprResultList = coaMDao.getExprResultList(CoaVo); //시험항목 결과 조회

			//저장해놓은 엑셀샘플파일
			File orginSampleFile = new File(sampleFilePath + File.separator + "COA_Excel_Sample.xlsx");
			if (!orginSampleFile.isFile()) {
				throw new FileNotFoundException();
			}

			//액셀샘플파일 복사할 경로
			String copyPath = sampleFilePath + File.separator + "COA_Excel_Sample_Copy.xlsx";
			File copyFile = new File(copyPath);

			FileOutputStream fos = new FileOutputStream(copyFile);
			FileInputStream fis = new FileInputStream(sampleFilePath + File.separator + "COA_Excel_Sample.xlsx");
			FileChannel fcin = fis.getChannel();
			FileChannel fcout = fos.getChannel();

			long size = fcin.size();
			fcin.transferTo(0, size, fcout);

			fcout.close();
			fcin.close();

			fos.close();
			fis.close();

			//복사된 성적서 파일을 가지고 핸들링 시작
			FileInputStream excelFis = new FileInputStream(copyPath);
			wb = WorkbookFactory.create(excelFis);

			//두번째 시트 고정
			Sheet sheet = wb.getSheetAt(1);

			//두번째 행만 반복
			for (int rowsIndex = 1; rowsIndex < 2; rowsIndex++) {
				Row row = sheet.getRow(rowsIndex);
				if (row == null) {
					continue;
				}

				//시험항목 갯수만큼 반복
				for (int cellIndex = 0; cellIndex < exprResultList.size(); cellIndex++) {
					CoaMVo exprData = exprResultList.get(cellIndex);
					Cell cell = row.getCell(cellIndex);

					//인덱스값 설정
					String indexStr = exprData.getLwprtSortOrdr().intValue() != 0
							? ", " + exprData.getLwprtSortOrdr().toString() + ")"
							: ")";

					String markValue = "##(" + exprData.getExpriemNm() + indexStr;
					cell.setCellValue(markValue);
				}
			}

			//임시파일명으로 수정된 xls 파일 저장
			FileOutputStream outExcelFile = new FileOutputStream(copyPath);
			wb.write(outExcelFile);

			outExcelFile.close();
			excelFis.close();

			map.put("fileName", "COA_Excel_Sample.xlsx");
			map.put("fileType", "xlsx");
			map.put("filePath", copyPath);

		} catch (FileNotFoundException e) {
			map.put("excpMsg", "유효하지 않은 파일명이 존재합니다.");
			e.printStackTrace();
		} catch (IOException e) {
			map.put("excpMsg", "읽거나 쓸 수 없는 파일이 존재합니다.");
			e.printStackTrace();
		} catch (Exception e) {
			map.put("excpMsg", "Excel Sample 생성 과정에서 예외가 발생했습니다.");
			e.printStackTrace();
		} finally {
			try {
				if (wb != null)
					wb.close();
			} catch (Exception e) {
				map.put("excpMsg", "예상치 못한 예외가 발생했습니다.");
				e.printStackTrace();
			}
		}

		return map;
	}

	public String getSaveDirPath() {
		Calendar cal = Calendar.getInstance();
		String folderYear;
		String folerMonth;

		folderYear = String.format("%04d", cal.get(Calendar.YEAR));
		folerMonth = String.format("%02d", cal.get(Calendar.MONTH) + 1);
		String uploadPath = File.separator + "coa"+File.separator  + folderYear + File.separator + folerMonth;

		return uploadPath;
	}

	/**
	 * 필수 확인 22-07-19
	 * ENF는 양식에 1줄을 적으면 COA화면의 우측하단 상위lot그리드 리스트 갯수만큼 행복사 하여 출력
	 * 반면에 후성은 제품lot 갯수만큼 추가를 시켜야 하며 그 제품에 상위lot 정보는 제품lot 정보 옆 컬럼에 나오게 변경
	 * -> 제품lot와 해당 제품lot의 상위lot 정보는 동일한 행에 출력되는 방식
	 * -------------------------------
	 * ENF기준 DL 적용 기준
	 * 자재관리 화면 DL적용여부, 장비관리 화면 DL적용여부, 시험항목 판정 최대/최소, 장비신뢰성평가에 DL등록
	 * 시험항목 DL관리에 표기값 등록, 결과입력에 장비명 등록, COA 화면 DL적용여부
	 * QC값이 DL관리 검출한계미만값 보다 작고 의뢰 제조일자가 적용시작일, 적용종료일에 해당될때 적용
	 * 위에 모든 조건이 충족되었을때, DL적용
	 */
	@Override
	public Map<String, String> getExpriemXls(List<CoaMVo> list, HttpServletResponse response) {

		Workbook wb = null;
		Map<String, String> map = new HashMap<String, String>();

		try {
			List<CoaMVo> lotList = new ArrayList<>(list.subList(0, list.size() - 1)); //상위lot 목록
			CoaMVo formData = list.get(list.size() - 1); //입력폼 데이터

			CoaMVo CoaVo = new CoaMVo();
			CoaVo.setLotList(lotList);

			List<CoaMVo> getReqestInfo = coaMDao.getReqestInfo(CoaVo); //의뢰정보 조회
			List<CoaMVo> exprResultList = coaMDao.getExprResultList(CoaVo); //시험항목 결과 조회

			//성적서 파일정보 조회. 성적서 양식 모아놓은 폴더에 해당 성적서양식 파일 생성
			FileDetailMVo fileVo = coaMDao.getCoaFileInfo(formData);
			File verificFile = new File(fileUploadPath + "\\" + "coa" + "\\" + fileVo.getPrintngCours());

			/******************************** 불러온 성적서파일 복사 시작 ********************************/
			String path = fileUploadPath + "\\" + "coa" + "\\" + fileVo.getPrintngOrginlFileNm();

			//성적서 파일이 없으면 다른 서버에서 가져옴 (이건 사용할지 안할지 모르겠음)
			if (verificFile.isFile() == false) {
				OutputStream outStream = null;
				URLConnection uCon = null;
				InputStream is = null;
				HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();

				try {
					String filePath = "";
					String uploadPath = fileUploadPath + fileVo.getPrintngCours();
					String[] uploadArray = fileVo.getPrintngCours().split("\\\\");
					filePath = "127.0.0.1:23001/AttachFile" + "/File" + fileVo.getPrintngCours();

					byte[] buf;
					int byteRead;
					int bufferSize = 1024;
					URL url = new URL("http://" + filePath.replaceAll("\\\\", "/"));

					//업로드 폴더 생성
					String saveDirPath = fileUploadPath + "\\" + uploadArray[1] + "\\" + uploadArray[2] + "\\";
					File saveFolder = new File(saveDirPath);
					if (!saveFolder.exists() || saveFolder.isFile())
						saveFolder.mkdirs();

					uCon = url.openConnection();
					is = uCon.getInputStream();
					buf = new byte[bufferSize];
					outStream = new BufferedOutputStream(new FileOutputStream(uploadPath));

					while ((byteRead = is.read(buf)) != -1) {
						outStream.write(buf, 0, byteRead);
					}

					outStream.close();
					is.close();

				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try {
						outStream.close();
						is.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}

			File copyFile = new File(path);
			FileOutputStream fos = new FileOutputStream(copyFile);
			FileInputStream fis = new FileInputStream(fileUploadPath + "\\" + "coa" + "\\" + fileVo.getPrintngCours());
			FileChannel fcin = fis.getChannel();
			FileChannel fcout = fos.getChannel();

			long size = fcin.size();
			fcin.transferTo(0, size, fcout);

			fcout.close();
			fcin.close();

			fos.close();
			fis.close();
			/******************************** 불러온 성적서파일 복사 종료 ********************************/

			//복사된 성적서 파일을 가지고 핸들링 시작
			FileInputStream excelFis = new FileInputStream(path);
			wb = WorkbookFactory.create(excelFis);

			//첫번째 시트 고정
			Sheet sheet = wb.getSheetAt(0);

			//제품lot 갯수 구하기 (상위lot 정렬순서값이 0이면 제품lot임을 의미)
			int prdctLotCnt = 0;
			for (CoaMVo item : lotList) {
				if (item.getLwprtSortOrdr() == 0)
					prdctLotCnt++;
			}

			int prdctLotRowNum = prdctLotCnt;
			int idx = path.indexOf(".");
			String fileExt = path.substring(idx + 1);

			//제품lot 갯수만큼 엑셀 행 복사 (상위lot는 묶여있는 제품lot 행 오른쪽에 순서대로 출력되므로 행복사 따로하지 않음)
			for (int i = 2; i < prdctLotRowNum + 1; i++) {
				if (fileExt.equals("xls")) {
					RowCopy.copyRow((HSSFWorkbook) wb, (HSSFSheet) sheet, 1, i);
				} else {
					RowCopy.copyRow2((XSSFWorkbook) wb, (XSSFSheet) sheet, 1, i);
				}
			}

			//전체 행 갯수만큼 반복
			int rows = sheet.getLastRowNum() + 1;
			for (int rowsIndex = 0; rowsIndex < rows; rowsIndex++) {
				Row row = sheet.getRow(rowsIndex);
				if (row == null)
					continue;

				//셀 갯수만큼 반복
				for (int cellIndex = 0; cellIndex < row.getLastCellNum() + 1; cellIndex++) {
					String value = "";

					//셀 서식에 맞게 셀 값 추출
					Cell cell = row.getCell(cellIndex);
					if (cell != null) {
						switch (String.valueOf(cell.getCellType())) {
							case "STRING":
								value = cell.getStringCellValue();
								break;
							case "BOOLEAN":
								value = String.valueOf(cell.getBooleanCellValue());
								break;
							case "NUMERIC":
								value = String.valueOf(cell.getNumericCellValue());
								break;
							case "FORMULA":
								value = String.valueOf(cell.getCellFormula());
								break;
							case "BLANK":
								value = String.valueOf(cell.getBooleanCellValue());
								break;
							case "ERROR":
								value = String.valueOf(cell.getErrorCellValue());
								break;
						}

						//모든 표기값은 "##("으로 시작
						if (value.length() > 3) {
							if (value.trim().substring(0, 3).equals("##(")) {
								//표기양식을 콤마를 기준으로 뜯어내 표기값과 인덱스값을 구분짓기 위함
								String temp[] = value.replace("##", "").split(",");

								//표기값
								String markValue = temp[0].toUpperCase().replace("(", "")
										.replace(")", "").replaceAll(" ", "");

								//인덱스 값
								String index = "0";
								if (temp.length > 1) {
									index = temp[1].replace("(", "")
											.replace(")", "").replaceAll(" ", "");
								}

								String resultCoaVal = ""; //마지막에 반환할 셀 출력값

								/******************************* 성적서 표기 형식별로 값 세팅 시작 ***********************************/

								//의뢰 데이터는 의뢰일렬번호로 조회한 데이터 양식에 맞게 세팅
								if (markValue.indexOf("제조일") != -1 || markValue.indexOf("검사일") != -1 || markValue.indexOf("VALVEM") != -1
										|| markValue.indexOf("VALVEMAKER") != -1 || markValue.indexOf("LOT") != -1) {

									for (int i = 0; i < getReqestInfo.size(); i++) {
										//행 수와 제품정렬순서, 양식에 표기된 인덱스 값과 상위정렬순서를 비교해 모두 일치한 의뢰정보를 매핑
										if (rowsIndex != getReqestInfo.get(i).getUpperSortOrdr() || !index.equals(getReqestInfo.get(i).getLwprtSortOrdr().toString())) {
											continue;
										} else {
											//매핑된 의뢰정보
											CoaMVo mapReqestInfo = getReqestInfo.get(i);

											//제조일
											if (markValue.indexOf("제조일") != -1) {
												switch (markValue) {
													case "제조일-YYYYMMDD":
														resultCoaVal = mapReqestInfo.getMnfcturDte().replaceAll("-", "");
														break;
													case "제조일-YYMMDD":
														resultCoaVal = mapReqestInfo.getMnfcturDte().substring(2).replaceAll("-", "");
														break;
													case "제조일-YYYY-MM-DD":
														resultCoaVal = mapReqestInfo.getMnfcturDte();
														break;
													case "제조일-YYYY.MM.DD":
														resultCoaVal = mapReqestInfo.getMnfcturDte().replaceAll("-", ".");
														break;
													case "제조일-YYYY년M월D일":
														String[] splitDte = mapReqestInfo.getMnfcturDte().split("-");
														resultCoaVal = splitDte[0] + "년 " + splitDte[1] + "월 " + splitDte[2] + "일";
														break;
													case "제조일-YYYY년MM월DD일":
														String[] dteArr = mapReqestInfo.getMnfcturDte().split("-");
														resultCoaVal = dteArr[0] + "년 " + dteArr[1] + "월 " + dteArr[2] + "일";
														break;
													case "제조일-YYYY/MM/DD":
														resultCoaVal = mapReqestInfo.getMnfcturDte().replaceAll("-", "/");
														break;
													default:
														resultCoaVal = value; //정해진 표기양식에 없는 표기라면 잘못된 표기 그대로 반환
														break;
												}
											}
											//검사일
											else if (markValue.indexOf("검사일") != -1) {
												switch (markValue) {
													case "검사일-YYYYMMDD":
														resultCoaVal = mapReqestInfo.getReqestDte().replaceAll("-", "");
														break;
													case "검사일-YYMMDD":
														resultCoaVal = mapReqestInfo.getReqestDte().substring(2).replaceAll("-", "");
														break;
													case "검사일-YYYY-MM-DD":
														resultCoaVal = mapReqestInfo.getReqestDte();
														break;
													case "검사일-YYYY.MM.DD":
														resultCoaVal = mapReqestInfo.getReqestDte().replaceAll("-", ".");
														break;
													case "검사일-YYYY년M월D일":
														String[] splitDte = mapReqestInfo.getReqestDte().split("-");
														resultCoaVal = splitDte[0] + "년 " + splitDte[1] + "월 " + splitDte[2] + "일";
														break;
													case "검사일-YYYY년MM월DD일":
														String[] dteArr = mapReqestInfo.getReqestDte().split("-");
														resultCoaVal = dteArr[0] + "년 " + dteArr[1] + "월 " + dteArr[2] + "일";
														break;
													case "검사일-YYYY/MM/DD":
														resultCoaVal = mapReqestInfo.getReqestDte().replaceAll("-", "/");
														break;
													default:
														resultCoaVal = value; //정해진 표기양식에 없는 표기라면 잘못된 표기 그대로 반환
														break;
												}
											}
											//VALVEM
											else if (markValue.equals("VALVEM")) {
												resultCoaVal = !commonFunc.isEmpty(mapReqestInfo.getValveMtrqltValue())
														? mapReqestInfo.getValveMtrqltValue() : value; //양식에 표기는 되어있지만 DB에 값이 없으면 표기 그대로 반환
												break;
											}
											//VALVE_MAKER
											else if (markValue.equals("VALVEMAKER")) {
												resultCoaVal = !commonFunc.isEmpty(mapReqestInfo.getValveMnfcturprofsNm())
														? mapReqestInfo.getValveMnfcturprofsNm() : value; //양식에 표기는 되어있지만 DB에 값이 없으면 표기 그대로 반환
												break;
											}
											//LOT NO
											else if (markValue.equals("LOT")) {
												resultCoaVal = !commonFunc.isEmpty(mapReqestInfo.getLotNo())
														? mapReqestInfo.getLotNo() : value; //양식에 표기는 되어있지만 DB에 값이 없으면 표기 그대로 반환
												break;
											}
										}
									}
								}

								//고객사 자재코드
								if (markValue.equals("고객사자재코드")) {
									if (!commonFunc.isEmpty(formData.getCtmmnyMtrilCode())) {
										resultCoaVal = formData.getCtmmnyMtrilCode();
									}
								}

								//출하일
								if (markValue.indexOf("출하일") != -1) {
									if (!commonFunc.isEmpty(formData.getShipmntDte())) {
										switch (markValue) {
											case "출하일-YYYYMMDD":
												resultCoaVal = formData.getShipmntDte().replaceAll("-", "");
												break;
											case "출하일-YYMMDD":
												resultCoaVal = formData.getShipmntDte().substring(2).replaceAll("-", "");
												break;
											case "출하일-YYYY-MM-DD":
												resultCoaVal = formData.getShipmntDte();
												break;
											case "출하일-YYYY.MM.DD":
												resultCoaVal = formData.getShipmntDte().replaceAll("-", ".");
												break;
											case "출하일-YYYY년M월D일":
												String[] splitDte = formData.getShipmntDte().split("-");
												resultCoaVal = splitDte[0] + "년 " + splitDte[1] + "월 " + splitDte[2] + "일";
												break;
											case "출하일-YYYY년MM월DD일":
												String[] dteArr = formData.getShipmntDte().split("-");
												resultCoaVal = dteArr[0] + "년 " + dteArr[1] + "월 " + dteArr[2] + "일";
												break;
											case "출하일-YYYY/MM/DD":
												resultCoaVal = formData.getShipmntDte().replaceAll("-", "/");
												break;
											default:
												resultCoaVal = value; //정해진 표기양식에 없는 표기라면 잘못된 표기 그대로 반환
												break;
										}
									} else {
										resultCoaVal = value; //양식에 표기는 되어있지만 화면에서 값이 없으면 표기 그대로 반환
									}
								}

								//출하량
								if (markValue.equals("출하량")) {
									//행 수와 제품정렬순서, 양식에 표기된 인덱스 값과 상위정렬순서를 비교해 모두 일치한 lotList를 매핑
									int rowNum = rowsIndex;
									String markIndex = index;
									resultCoaVal = lotList.stream()
											.filter(x -> x.getUpperSortOrdr() == rowNum
													&& markIndex.equals(x.getLwprtSortOrdr().toString()))
											.filter(x -> x.getShipmntQy() != null && !"".equals(x.getShipmntQy()))
											.map(x -> x.getShipmntQy())
											.findFirst()
											.orElse(value); //양식에 표기는 되어있지만 화면에서 값이 없으면 표기 그대로 반환
								}

								//PO No.
								if (markValue.equals("PO")) {
									//행 수와 제품정렬순서, 양식에 표기된 인덱스 값과 상위정렬순서를 비교해 모두 일치한 lotList를 매핑
									int rowNum = rowsIndex;
									String markIndex = index;
									resultCoaVal = lotList.stream()
											.filter(x -> x.getUpperSortOrdr() == rowNum
													&& markIndex.equals(x.getLwprtSortOrdr().toString()))
											.filter(x -> x.getPo() != null && !"".equals(x.getPo()))
											.map(x -> x.getPo())
											.findFirst()
											.orElse(value); //양식에 표기는 되어있지만 화면에서 값이 없으면 표기 그대로 반환
								}

								//시험항목
								//해당 분기까지 프로세스가 진행된 시점에, 마지막에 set해줄 셀값이 아직 null값이라면
								//이전 분기조건들은 모두 내부로직을 타지 않고 통과했음을 의미하므로 시험항목 표기로 간주
								if (commonFunc.isEmpty(resultCoaVal)) {
									CoaMVo exprParam = CoaMVo
											.builder()
											.expriemNm(markValue) //시험항목명
											.excelCellMarkIndex(index) //사용자 표기 인덱스 값
											.excelRowIndex(String.valueOf(rowsIndex)) //엑셀양식의 현재 행 인덱스
											.avrgApplcAt(formData.getAvrgApplcAt()) //입력폼 평균적용여부 선택값
											.build();

									resultCoaVal = getAvrgResultValueF(exprParam, exprResultList);
								}

								if (!commonFunc.isEmpty(resultCoaVal)) {
									if (markValue.indexOf("제조일") != -1 || markValue.indexOf("검사일") != -1
											|| markValue.indexOf("출하일") != -1 || markValue.equals("LOT")
											|| markValue.equals("VALVEMAKER") || markValue.equals("VALVEM")
											|| markValue.equals("고객사자재코드")) {
										cell.setCellValue(resultCoaVal);

										//시험항목, PO, 출하량은 셀에 세팅할 값의 타입 체크 후 세팅해줌
									} else {
										try {
											if (markValue.equals("PO") || markValue.equals("출하량")) {
												NumberFormat form = NumberFormat.getInstance();
												form.setGroupingUsed(false);
												resultCoaVal = String.valueOf(form.format(cell.getNumericCellValue())).trim();

												cell.setCellValue(resultCoaVal);
											}

											double doubleResultVal = Double.valueOf(resultCoaVal);
											cell.setCellValue(doubleResultVal);
										} catch (Exception e) {
											cell.setCellValue(resultCoaVal);
										}
									}

									//혹여라도 셀에 세팅할 resultCoaVal 값이 없다면, 처음에 받아온 사용자 표기 그대로 세팅
								} else {
									cell.setCellValue(value);
								}
							}
						}
					}
				}
			}

			//모든 시트의 셀을 다 가져와서 수식이 포함된 셀의 결과를 저장
			wb.getCreationHelper().createFormulaEvaluator().evaluateAll();
			//성적서 파일이 열릴 때 전체 수식을 재계산함
			wb.setForceFormulaRecalculation(true);

			//임시파일명으로 수정된 xls 파일 저장
			FileOutputStream outExcelFile = new FileOutputStream(path);
			wb.write(outExcelFile);

			outExcelFile.close();
			excelFis.close();

			//엑셀파일 확장자 csv로 변환
			String fileExtCode = formData.getExtAt();
			if (fileExtCode.equals("SY17000002"))
				ExcelReading.convertExcelToCSV(path);

			/** 원본파일명 설정 시작 **/
			SimpleDateFormat dateForm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date time = new Date();
			String frmSysDate = dateForm.format(time);

			File partFile = new File(path);
			String ext = "";
			if (partFile.getName().indexOf("xlsx") != -1)
				ext = (fileExtCode.equals("SY17000002")) == true ? "csv" : "xlsx";
			else if (partFile.getName().indexOf("xls") != -1)
				ext = (fileExtCode.equals("SY17000002")) == true ? "csv" : "xls";

			String tempFileName = getReqestInfo.get(0).getReqestNo() + "_" + frmSysDate + "." + ext;
			tempFileName = tempFileName.replaceAll("-", "").replaceAll(" ", "").replaceAll(":", "");
			/** 원본파일명 설정 끝 **/

			//COA 생성인 경우 DB에 파일정보 저장
			if (formData.getCoaType().equals("coaview")) {
				//업로드 폴더 생성
				String uploadPath = getSaveDirPath();
				File saveFolder = new File(fileUploadPath + uploadPath);
				if (!saveFolder.exists() || saveFolder.isFile())
					saveFolder.mkdirs();

				//파일경로 설정
				UUID uid = UUID.randomUUID(); //고유 파일명 랜덤 생성 (업로드 파일명 중복 방지)
				String filePath = "";
				filePath = uploadPath + File.separator + uid;

				String fisPath = "";
				fisPath = (fileExtCode.equals("SY17000002")) == true
						? path.substring(0, path.lastIndexOf(".")) + ".csv" : path;

				FileInputStream partfis = new FileInputStream(fisPath); //읽을 파일
				FileOutputStream partfos = new FileOutputStream(fileUploadPath + filePath); //복사 할 파일

				//파일 복사
				int fileByte = 0;
				while ((fileByte = partfis.read()) != -1) {
					partfos.write(fileByte);
				}
				partfis.close();
				partfos.close();

				//파일정보 세팅
				FileDetailMVo fileDetailMVo = FileDetailMVo
						.builder()
						.totFileCnt(1) //파일 갯수
						.totFileMg(Math.round(partFile.length())) //파일 크기
						.orginlFileNm(tempFileName) //원본 파일명
						.streFileNm(filePath) //저장되는 파일명 (경로)
						.fileMg(Math.round(partFile.length()))
						.build();

				//성적서 파일 정보 첨부파일 테이블에 등록
				coaMDao.insAtchmnfl(fileDetailMVo);
				coaMDao.insAtchmnflDetail(fileDetailMVo);

				//성적서 첨부파일 일렬번호
				map.put("atchmnflSeqno", String.valueOf(fileDetailMVo.getAtchmnflSeqno()));
			}

			//다운로드할 파일정보 map에 담아줌
			map.put("fileName", tempFileName);
			if (fileExtCode.equals("SY17000002")) {
				map.put("fileType", "csv");
				map.put("filePath", path.substring(0, path.lastIndexOf(".")) + ".csv");
			} else {
				String fileName = fileVo.getPrintngOrginlFileNm();
				map.put("fileType", fileName.substring(fileName.indexOf("."), fileName.length()).replace(".", ""));
				map.put("filePath", path);
			}

		} catch (FileNotFoundException e) {
			map.put("excpMsg", "유효하지 않은 파일명이 존재합니다.");
			e.getStackTrace();
		} catch (IOException e) {
			map.put("excpMsg", "읽거나 쓸 수 없는 파일이 존재합니다.");
			e.printStackTrace();
		} catch (Exception e) {
			map.put("excpMsg", "COA 성적서 미리보기 과정에서 예외가 발생했습니다.");
			e.printStackTrace();
		} finally {
			try {
				if (wb != null)
					wb.close();
			} catch (IOException e) {
				map.put("excpMsg", "예상치 못한 예외가 발생했습니다.");
				e.printStackTrace();
			}
		}

		return map;
	}

	/**
	 * 의뢰시험항목 리스트에 있는 데이터와 현재 처리할 셀의 표기정보를 비교하여 현재 셀에 세팅할 값 반환
	 * @param exprParam 비교할 데이터
	 * @param exprList 의뢰시험항목 리스트
	 * @return 엑셀 셀 출력값
	 */
	private String getAvrgResultValueF(CoaMVo exprParam, List<CoaMVo> exprList) {

		String resultCoaVal = ""; //리턴 값
		String getExpriemNm = ""; //시험항목명
		String getUpperSortOrdr = ""; //제품lot 정렬순서
		String getLwprtSortOrdr = ""; //상위lot 정렬순서
		String getInspctTyCode = ""; //검사유형
		String getAvrgApplcAt = ""; //평균값 적용여부
		String getAvrgResultVal = ""; //평균값
		String getFrmAvrgApplcAt = exprParam.getAvrgApplcAt(); //입력폼 평균적용여부 선택값
//		String getDlValue = exprParam.getDetectLimitApplcAt(); //DL 적용여부

		for (int i = 0; i < exprList.size(); i++) {
			getExpriemNm = exprList.get(i).getExpriemNm().toUpperCase().replaceAll(" ", "");
			getUpperSortOrdr = exprList.get(i).getUpperSortOrdr().toString();
			getLwprtSortOrdr = exprList.get(i).getLwprtSortOrdr().toString();

			//엑셀의 현재 행 수와 제품 정렬순서가 동일하고, 표기된 시험항목 인덱스 값과 상위정렬순서가 동일하고,
			//표기된 시험항목이 일치하면 결과값 반환
			if (!getUpperSortOrdr.equals(exprParam.getExcelRowIndex()) || !getLwprtSortOrdr.equals(exprParam.getExcelCellMarkIndex())
					|| !getExpriemNm.equals(exprParam.getExpriemNm())) {
				continue;

			} else {
				getInspctTyCode = exprList.get(i).getInspctTyCode();
				getAvrgApplcAt = exprList.get(i).getAvrgApplcAt();
				getAvrgResultVal = exprList.get(i).getAvrgResultValue();

				/**
				 * 평균값 반환 조건
				 * - lotNo가 동일한 제품lot 중
				 * - 시험항목의 평균적용여부 값이 'Y'이고
				 * - 화면 입력폼에 평균적용여부 값이 'Y'이고
				 * - 평균값이 null값이 아니어야 함
				 *
				 * 4개의 조건 중 하나라도 부합하지 않는다면 QC값 반환
				 */
				if (("SY07000003").equals(getInspctTyCode) && "Y".equals(getAvrgApplcAt)
						&& "Y".equals(getFrmAvrgApplcAt) && !commonFunc.isEmpty(getAvrgResultVal)) {
					resultCoaVal = exprList.get(i).getAvrgResultValue();
					break;
				} else {
					resultCoaVal = exprList.get(i).getQcResultValue();
					break;
				}
			}
		}

//			if (exprParam.getExpriemNm().toUpperCase().equals(getExpriemNm) && exprParam.getSortOrdr().equals(getSortOrdr)) {
//				//초중말 평균 값
//				if (type.equals("AVR")) {
//					//COA DL적용
//					if (getDlValue.equals("Y")) {
//						//자재 DL적용
//						if (expriemPreviewList.get(i).getDetectLimitApplcAt().equals("Y")) {
//							if (exprParam.getFmlCheck().equals("1")) { //초
//								resultCoaVal = expriemPreviewList.get(i).getDlfValue();
//							} else if (exprParam.getFmlCheck().equals("2")) { //중
//								resultCoaVal = expriemPreviewList.get(i).getDlmValue();
//							} else if(exprParam.getFmlCheck().equals("3")) { //말
//								resultCoaVal = expriemPreviewList.get(i).getDllValue();
//							} else {
//								resultCoaVal = expriemPreviewList.get(i).getDlValue(); //DL 적용
//							}
//						//COA DL적용이어도 자재 DL미적용이면 기본 결과값 세팅
//						} else {
//							if(exprParam.getFmlCheck().equals("1")) {
//								resultCoaVal = expriemPreviewList.get(i).getResultValueF();
//							} else if (exprParam.getFmlCheck().equals("2")) {
//								resultCoaVal = expriemPreviewList.get(i).getResultValueM();
//							} else if(exprParam.getFmlCheck().equals("3")) {
//								resultCoaVal = expriemPreviewList.get(i).getResultValueL();
//							} else {
//								resultCoaVal = expriemPreviewList.get(i).getAvrgResultValue(); // DL 미적용
//							}
//						}
//
//					//COA DL미적용
//					} else {
//						if (exprParam.getFmlCheck().equals("1")) {
//							resultCoaVal = expriemPreviewList.get(i).getResultValueF();
//						} else if (exprParam.getFmlCheck().equals("2")) {
//							resultCoaVal = expriemPreviewList.get(i).getResultValueM();
//						} else if(exprParam.getFmlCheck().equals("3")) {
//							resultCoaVal = expriemPreviewList.get(i).getResultValueL();
//						} else {
//							resultCoaVal = expriemPreviewList.get(i).getAvrgResultValue(); //DL 미적용
//						}
//					}
//				}
//
//				//QC 값
//				if (type.equals("QC")) {
//					//COA DL적용
//					if (getDlValue.equals("Y")) {
//						//자재 DL적용
//						if (expriemPreviewList.get(i).getDetectLimitApplcAt().equals("Y")) {
//							resultCoaVal = expriemPreviewList.get(i).getDlValue(); //DL 적용
//						//자재 DL미적용
//						} else {
//							resultCoaVal = expriemPreviewList.get(i).getQcResultValue(); //DL 미적용
//						}
//					//COA DL미적용
//					} else {
//						resultCoaVal = expriemPreviewList.get(i).getQcResultValue(); //DL 미적용
//					}
//				}
//
//				break;
//			}
//		}

		return resultCoaVal;
	}

	@Override
	public Map<String, String> insCoaInfo(List<CoaMVo> list, HttpServletResponse response) {

		Map<String, String> resultMap = new HashMap<>();

		try {
			List<CoaMVo> upperLotList = list.subList(0, list.size()-1); //상위lot 그리드 리스트
			CoaMVo formData = list.get(list.size()-1); //입력폼 데이터

			//COA정보 저장
			coaMDao.insCoaInfo(formData);

			//COA의뢰 등록
			for (int i = 0; i < upperLotList.size(); i++) {
				CoaMVo param = upperLotList.get(i);
				param.setCoaSeqno(formData.getCoaSeqno()); //저장한 COA일렬번호 세팅

				//제품lot
				if (commonFunc.isEmpty(param.getUpperReqestSeqno())) {
					coaMDao.insCoaReqPrdct(param); //COA의뢰 등록
					param.setRoaCreatAt("Y");
					coaMDao.updProgrsSittnCode(param); //의뢰진행상황 업데이트

				//상위lot
				} else {
					coaMDao.insCoaReqUpper(param); //COA의뢰 등록

					//진행상황이 ROA대기부터 ROA생성여부 "Y"로 설정
					String progrsCode = coaMDao.getProgrsSittnCode(param);
					if (progrsCode.equals("IM03000004") || progrsCode.equals("IM03000005") || progrsCode.equals("IM03000006"))
						param.setRoaCreatAt("Y");
					else
						param.setRoaCreatAt("N");

					coaMDao.updProgrsSittnCode(param); //의뢰진행상황 업데이트
				}
			}

			formData.setLotList(upperLotList);
			//의뢰시험항목 진행상황 업데이트
			coaMDao.upperExiemProgrsSittnCode(formData);

			//성적서 파일 출력
			resultMap = getExpriemXls(list, response);
			resultMap.put("coaSeqno", formData.getCoaSeqno());

			//COA 발행파일일렬번호 업데이트
			formData.setCoaPblicteAtchmnflSeqno(resultMap.get("atchmnflSeqno"));
			coaMDao.updCoaPblictAtchmnflSeqno(formData);

		} catch (Exception e) {
			resultMap.put("excpMsg", "COA 생성 과정에서 예외가 발생했습니다.");
			e.printStackTrace();
		}

		return resultMap;
	}

	@Override
	public List<CoaMVo> getReqUpperLotList(CoaMVo vo) {
		return coaMDao.getReqUpperLotList(vo);
	}

	@Override
	public List<CoaMVo> getCoaUpperList(CoaMVo vo) {
		return coaMDao.getCoaUpperList(vo);
	}

	@Override
	public List<CoaMVo> getEntrpsListHasPrint(CoaMVo vo) {
		return coaMDao.getEntrpsListHasPrint(vo);
	}

	@Override
	public List<ComboVo> getEntrpsPrintCombo(CoaMVo vo) {
		return coaMDao.getEntrpsPrintCombo(vo);
	}

	@Override
	public CoaMVo getEntrpsPrintInfo(CoaMVo vo) {
		return coaMDao.getEntrpsPrintInfo(vo);
	}

	@Override
	public int delCoaList(List<CoaMVo> list) {
		int count = 0;
		if (list.isEmpty())
			return count;

		for (CoaMVo vo : list) {
			count = coaMDao.delCoaList(vo);
		}

		return count;
	}

}
