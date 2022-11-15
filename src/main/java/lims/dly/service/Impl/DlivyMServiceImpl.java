package lims.dly.service.Impl;

import lims.dly.dao.DlivyBrcdMDao;
import lims.dly.dao.DlivyMDao;
import lims.dly.service.DlivyBrcdMService;
import lims.dly.service.DlivyMService;
import lims.dly.vo.DlivyMVo;
import lims.test.dao.CoaMDao;
import lims.test.dao.IssueMDao;
import lims.test.vo.CoaMVo;
import lims.util.ConverterUtils;
import lims.util.FasooExtract;
import lims.util.GetUserSession;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Service("DlivyMService")
public class DlivyMServiceImpl implements DlivyMService{

	@Autowired
	private DlivyMDao dlivyMDao;	
	
	@Autowired
	private IssueMDao issueMDao;

	@Autowired
	private CoaMDao coaMDao;
	
	@Resource(name = "DlivyBrcdMService")
	private DlivyBrcdMService dlivyBrcdMService;
	
	@Autowired
	private DlivyBrcdMDao dlivyBrcdMDao;
	
	//엑셀 list
	private static String[] sampleList = {
			"qlyhghDocNm"     /* 품고 문서 명 */
		   ,"dvyfgEntrpsCode" /* 납품 업체 코드 */
		   ,"dvyfgEntrpsNm"	  /* 납품 업체 명 */
		   ,"mtrilCode"		  /* 자재 코드 */
		   ,"ctmmnyMtrilCode" /* 고객사 자재 코드 */
		   ,"poNo"  		  /* PO NO */
		   ,"mtrilNm"         /* 자재 명 */
		   ,"batchNo" 		  /* BATCH NO */
		   ,"dlivyQy"    	  /* 출고 량 */
		   ,"unitNm"  		  /* 단위 명 */
		   ,"rm"		      /* 비고 */
		   ,"errorAt"		  /*오류여부*/
		   ,"relcoDlivyDocNm" /* 관계사 출고 문서 명 */
		   ,"relcoDlivyQy" 	  /* 관계사 출고 량 */
		   ,"unprogrsRequstDc"/* 미진행 요청 설명 */
	};
	
	private static String[] sampleList2 = {
			"qlyhghDocNm"     /* 품고 문서 명 */
		   ,"dvyfgEntrpsCode" /* 납품 업체 코드 */
		   ,"dvyfgEntrpsNm"	  /* 납품 업체 명 */
		   ,"mtrilCode"		  /* 자재 코드 */
		   ,"ctmmnyMtrilCode" /* 고객사 자재 코드 */
		   ,"poNo"  		  /* PO NO */
		   ,"mtrilNm"         /* 자재 명 */
		   ,"batchNo" 		  /* BATCH NO */
		   ,"dlivyQy"    	  /* 출고 량 */
		   ,"unitNm"  		  /* 단위 명 */
		   ,"rm"		      /* 비고 */
		   ,"dispatch"		  /* 배차 */	
		   ,"carNo"			  /* 차량번호 */
		   ,"invoice"		  /* invoice */
		   ,"invoiceNo"		  /* invoiceNo */	
	};
	
	private static String[] sampleList3 = {
			"status"     
		   ,"gbm" 
		   ,"buyer"	 
		   ,"plant"		 
		   ,"plantName" 
		   ,"seller"  		  
		   ,"sellerName"        
		   ,"proType" 		 
		   ,"invoiceNo"  /*배차지시서 인보이스와 여기 인보이스 비교해서 값 넣어줄거*/   	 
		   ,"invoiceDate"  		  
		   ,"Material"		     
		   ,"specification"		 
		   ,"description"			
		   ,"doNo"		  /* 실질적인 사용 */
		   ,"doSeq"	
		   ,"currency"
		   ,"uprice"
		   ,"invoiceAmount"
		   ,"um"
		   ,"invoiceQty"
		   ,"grDate"
		   ,"grTime"
		   ,"grQty"
		   ,"qaFlag"
		   ,"uc"
		   ,"de"
		   ,"vendorItem"
		   ,"controller"
		   ,"woNo"
		   ,"poNo" /* 실질적인 사용 */
		   ,"poSeq"
	};
	
	
	/**
	 * 양식 파일 업로드
	 */
	@Override
	public HashMap<String, Object> applyFormFile(MultipartHttpServletRequest request) {
		//view 로 리턴해줄 오브젝트
		HashMap<String, Object> result = new HashMap<String, Object>();
		//엑셀에서 추출한 값을 담을 vo list
		List<DlivyMVo> sampleVoList = new ArrayList<DlivyMVo>();
		//모든 엑셀 데이터를 성공적으로 불러왔을때 구분
		boolean resultBool = true;
		List<String> requestSeq = new ArrayList<String>();
		
		
		//엑셀파일 읽어오기
		MultipartFile file = null;
		File convFile = null;
		Workbook workbook = null;
		
		try {
			file = request.getFile("formFile");
			
			convFile = new File(file.getOriginalFilename());
			file.transferTo(convFile);
			
			FasooExtract fasooExtract = new FasooExtract();
			fasooExtract.DoExtract(convFile.getAbsoluteFile().toString());
			
			//Workbook 로 해야 xls, xlsx 두개다 됨
			workbook = WorkbookFactory.create(convFile);
			FormulaEvaluator evaluator = workbook.getCreationHelper().createFormulaEvaluator();
			workbook.setForceFormulaRecalculation(true);

			int rowindex = 0;
			//시트 수 (지금은 시트 하나만 업로드함)			
			int sheetIndex = 1;//workbook.getNumberOfSheets();			        
			//시트 수만큼 반복
			for(int shIndex=0; shIndex<sheetIndex; shIndex++){
				
				Sheet sheet = workbook.getSheetAt(shIndex); //각행을 읽어온다
				int rows = sheet.getPhysicalNumberOfRows(); // 정의 된 행의 수를 반환.	

			
				//실제 데이터가 작성되는 2번째 row 부터
				for(rowindex = 3; rowindex <= rows; rowindex++){
					
					Row row = sheet.getRow(rowindex);
		
					DlivyMVo dlivyVo = new DlivyMVo();
					
					if(row != null){
						boolean valueCnt = true;
						String valueMsg = "";
						String bachNoMsg = String.valueOf(rowindex+1) + "행" + " 마지막 행 " + rows;		
				
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
								else if(String.valueOf(cell.getCellType()).equals("FORMULA")){
									
									try{
										evaluator.evaluateInCell(cell);
										CellValue cellValue = evaluator.evaluate(cell);
										
										if(String.valueOf(cellValue.getCellType()).equals("STRING")){
											value = cellValue.getStringValue().trim();
										}
										else if(String.valueOf(cellValue.getCellType()).equals("BOOLEAN")){
											value = String.valueOf(cellValue.getBooleanValue()).trim();
										}
										else if(String.valueOf(cellValue.getCellType()).equals("NUMERIC")){
											NumberFormat f = NumberFormat.getInstance();
											f.setGroupingUsed(false);
											value = String.valueOf(f.format(cellValue.getNumberValue())).trim();
										}
									}catch(Exception e){
										if(String.valueOf(cell.getCachedFormulaResultType()).equals("NUMERIC")){
											value = String.valueOf(cell.getNumericCellValue()).trim();
										} else if(String.valueOf(cell.getCachedFormulaResultType()).equals("STRING")) {
											value = String.valueOf(cell.getStringCellValue()).trim();
										}
									}
								}
								else if(String.valueOf(cell.getCellType()).equals("BLANK")){
									value = "";
								}
							}
						
							//출고일자	 셀서식이 사용자 날짜면			 			
							try{
								//셀서식이 사용자 날짜면
								if (DateUtil.isValidExcelDate(Double.valueOf(String.valueOf(sheet.getRow(0).getCell(0))))){
									SimpleDateFormat fommatter = new SimpleDateFormat("yyyy-MM-dd");
									dlivyVo.setDlivyDte(fommatter.format(sheet.getRow(0).getCell(0).getDateCellValue()));
								}
								
							}catch (Exception e){
								
								try{
									if(DateUtil.isCellDateFormatted(sheet.getRow(0).getCell(0))){
										Date date = sheet.getRow(0).getCell(0).getDateCellValue();
										String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);																
										dlivyVo.setDlivyDte(cellString); 
									}
								}catch(Exception e2){
									HashMap<String, Object> excelDateMap = new HashMap<String, Object>();									
									excelDateMap = excelDateConverter(sheet.getRow(0).getCell(0), dlivyVo);								
									boolean excelDateBool = (boolean) excelDateMap.get("valueCnt");
									
									if(excelDateBool ==  false){
										valueCnt = false;
										valueMsg = (String) excelDateMap.get("valueMsg");
										break;
									}
								}																
							}
							
							
		
							/* 품고 문서 명 */
							if(sampleList[cols].equals("qlyhghDocNm")){
								dlivyVo.setQlyhghDocNm(value);
							}
							/* 납품 업체 코드 */
							else if(sampleList[cols].equals("dvyfgEntrpsCode")){
								dlivyVo.setDvyfgEntrpsCode(value);
							}
							/* 납품 업체 명 */
							else if(sampleList[cols].equals("dvyfgEntrpsNm")){
								dlivyVo.setDvyfgEntrpsNm(value);
								if(dlivyVo.getDvyfgEntrpsNm().indexOf("삼성전자") != -1 && dlivyVo.getDvyfgEntrpsNm().indexOf("화성") != -1) {
									dlivyVo.setShipmntLcCode("P1C1");
								}else if(dlivyVo.getDvyfgEntrpsNm().indexOf("삼성전자") != -1 && dlivyVo.getDvyfgEntrpsNm().indexOf("LSI") != -1) {
									dlivyVo.setShipmntLcCode("P1C3");
								}else if(dlivyVo.getDvyfgEntrpsNm().indexOf("삼성전자") != -1 && dlivyVo.getDvyfgEntrpsNm().indexOf("평택") != -1) {
									dlivyVo.setShipmntLcCode("P1C4");
								}else if(dlivyVo.getDvyfgEntrpsNm().indexOf("삼성전자") != -1 && dlivyVo.getDvyfgEntrpsNm().indexOf("천안") != -1) {
									dlivyVo.setShipmntLcCode("P1C2");
								}
							}
							/* 자재 코드 */
							else if(sampleList[cols].equals("mtrilCode")){
								if(value == null || value.equals("")){
									valueCnt = false;
									valueMsg = "mtrilCode";
									break;
								}
							
								dlivyVo.setMtrilCode(value);
							}
							/* 고객사 자재 코드 */
							else if(sampleList[cols].equals("ctmmnyMtrilCode")){
								dlivyVo.setCtmmnyMtrilCode(value);
							}

							/* PO NO */
							else if(sampleList[cols].equals("poNo")){
								dlivyVo.setPoNo(value);
								if(dlivyVo.getPoNo().toUpperCase().indexOf("HIR") != -1){
									dlivyVo.setSkAt("Y");
									
									//업체코드 여부 확인
									String dvyfgEntrpsCode = dlivyBrcdMDao.getDvyfgEntrpsCode(dlivyVo);
									
									//HIR은 SK만붙음
									if(dvyfgEntrpsCode == null || dvyfgEntrpsCode.equals("") || !dvyfgEntrpsCode.equals("SY17000002")){
										valueCnt = false;
										valueMsg = "hir";
										break;
									}
								}
								else{
									dlivyVo.setSkAt("N");	
									if(!dlivyVo.getMtrilCode().equals("자재코드")) {

										//업체코드 여부 확인	
										String dvyfgEntrpsCode = dlivyBrcdMDao.getDvyfgEntrpsCode(dlivyVo);
	
										dlivyVo.setDeptCode(request.getParameter("inspctInsttCode"));
								        
									
										if(dlivyVo.getDeptCode().equals("3977") ) {
											
										}else {
											
											if(dvyfgEntrpsCode == null || dvyfgEntrpsCode.equals("")){
												valueCnt = false;
												valueMsg = "poNo";
												break;
											}
										}
	
									}
									
								}	
								
							}
							/* 자재 명 */
							else if(sampleList[cols].equals("mtrilNm")){
								dlivyVo.setMtrilNm(value);
							}
							/* BATCH NO */
							else if(sampleList[cols].equals("batchNo")){
								if(value == null || value.equals("")){
									valueCnt = false;
									valueMsg = "batchNo";
									break;
								}
								
								dlivyVo.setBatchNo(value);
								//자재코드 + Batch No. 조건으로 Lot Id 의뢰번호 조회  
								if(dlivyVo.getMtrilCode() != null && !dlivyVo.getMtrilCode().equals("")){									
									
									if(value != null && !value.equals("")){
										dlivyVo.setBatchNo(value);
										String lotId = dlivyMDao.getReqestSeqno(dlivyVo);
										
										dlivyVo.setReqestSeqno(lotId);
										dlivyVo.setLotId(dlivyMDao.getLotId(dlivyVo));
										dlivyVo.setMnfcturDte(dlivyMDao.getMnfcturDte(dlivyVo));
										
										CoaMVo coaVo = new CoaMVo();
										coaVo.setReqestSeqno(lotId);
										//String lockAt = coaMDao.getLockAt(coaVo);
										
										if(lotId != null && !lotId.equals("")){
											requestSeq.add(lotId);
										}
										
									}
									
								}
							}
							/* 출고 량 */
							else if(sampleList[cols].equals("dlivyQy")){
								dlivyVo.setDlivyQy(value);
								dlivyVo.setOrginlDlivyQy(value);

							}
							/* 단위 명 */
							else if(sampleList[cols].equals("unitNm")){
								dlivyVo.setUnitNm(value);
								dlivyVo.setDlivyQy(getDlivyQy(dlivyVo));	
								
							}
							/* 비고 */
							else if(sampleList[cols].equals("rm")){
								dlivyVo.setRm(value);
							}
						
							/* 오류여부 */	
							else if(sampleList[cols].equals("errorAt")){
								dlivyVo.setErrorAt(value);	
							}
							
							/* 관계사 출고문서 */
							else if(sampleList[cols].equals("relcoDlivyDocNm")){
								dlivyVo.setRelcoDlivyDocNm(value);
							}
							/* 관계사출고량*/
							else if(sampleList[cols].equals("relcoDlivyQy")){
								dlivyVo.setRelcoDlivyQy(value);
							}
							/* 미진행요청 */
							else if(sampleList[cols].equals("unprogrsRequstDc")){
								dlivyVo.setUnprogrsRequstDc(value);
							}

		
							/* 수정 내용 */
							else if(sampleList[cols].equals("updtCn")){
								dlivyVo.setUpdtCn(value);
							}
							
							/*수정 사항 시간*/
							else if(sampleList[cols].equals("hour")){
								if(value == null || value.equals("")){
									valueCnt = true;
									break;
								}
								
								dlivyVo.setHour(value);
							}
							/*수정 사항 분*/
							else if(sampleList[cols].equals("minute")){
								if(value == null || value.equals("")){
									valueCnt = true;
									break;
								}
								
								
								//출고 시분은 출고 40분전 으로 계산하여 저장 ex) 12:00 면 23:20분으로
								//자정 12:00 ~ 09:00 사이 시간에는 전날 40분 전으로 저장해야함 DLIVY_DTE -> 전날로 저장, DLIVY_HM -> 23:20 으로
								String[] str = dlivyVo.getDlivyDte().split("-");
								int str1 = Integer.valueOf(str[0]);
								int str2 = Integer.valueOf(str[1]);
								int str3 = Integer.valueOf(str[2]);
								
								String hour = dlivyVo.getHour();
								String minute = value;
								
								if(hour.length() == 1){
									hour = "0" + hour;
								}
								
								if(minute.length() == 1){
									minute = "0" + minute;
								}
								
								//시간이 9시 보다 작으면
								if(Integer.valueOf(dlivyVo.getHour()) <= 9 ){
									LocalDate localDate = LocalDate.of(str1, str2, str3);								
									dlivyVo.setDlivyDte(localDate.toString()); 
									dlivyVo.setDlivyHm(hour+":"+minute);
									dlivyVo.setEmailSndngTm("");
									dlivyVo.setEmailSndngTm("11:20");
								}
								else{
									dlivyVo.setMinute(value);							 
									LocalTime dlivyHm = LocalTime.of(Integer.valueOf(dlivyVo.getHour()), Integer.valueOf(value));							
							        dlivyVo.setDlivyHm(hour+":"+minute);
							        dlivyVo.setEmailSndngTm("40");
							        dlivyVo.setEmailSndngTm(String.valueOf(dlivyHm.minusMinutes(40)));
								}
								
							}	

						}//cols 종료
					
						//엑셀의 데이터가 정확할때
						if(valueCnt == true){
							sampleVoList.add(dlivyVo);
							ConverterUtils converterUtils = new ConverterUtils();
							
							HashMap<String, Object> mergeMap = new HashMap<String, Object>();
							//merge 된 행이 있는지 감지
							mergeMap = getNbOfMergedRegions(sheet, rowindex);

							//count가 0이상이면 merge 된 행이 있는거임
							if(Integer.valueOf(mergeMap.get("count").toString()) > 0){

								//현제 읽고 있는 엑셀의 행과 merge된 마지막 행의 차수를 구해서 루프 돌려줌(merge된 행까지 루프)
								int mergeIndex = Integer.valueOf(mergeMap.get("index").toString()) - rowindex;
								ArrayList<Integer> rangeArray = (ArrayList<Integer>) mergeMap.get("range");

								for(int j=1; j<=mergeIndex; j++){
									DlivyMVo tempDlivyVo = new DlivyMVo();
									
									HashMap<String, Object> tempMap = new HashMap<String, Object>();

									try{
										//DlivyMVo 의 필드 변수명과 값을 가져와서 맵에 담음
										// merge 기준이 되는 첫번째 행의 값을 merge 된 행 전체에 담는다.
										for (Field field : tempDlivyVo.getClass().getDeclaredFields()) {
							                field.setAccessible(true);
							                // 필드에 해당하는 값
											Object objVal = field.get(dlivyVo);

											//field.getName() <- 필드명 , field.get(dlivyVo) <- 값
											tempMap.put(field.getName(), objVal);
										}
										
										//맵에 담은 값을 다시 vo 로 변환해준다.
										converterUtils.convertHashMapToVo(tempMap, tempDlivyVo);
										
									}catch(Exception e){
										e.printStackTrace();
									}
									
									//merge된 값은 처음 행의 값을 가져와 담았지만 merge가 안된 행도 있으므로 merge가 되었는지 구분하여 현재 열의 값으로 덮어쓴다.
									for(int a=0; a<rangeArray.size(); a++){
										HashMap<String, Object> rangeMap = getMergeValue(sheet, rowindex+j, rangeArray.get(a), tempDlivyVo, evaluator);
										if((boolean)rangeMap.get("valueCnt") == false){										
											result.put("result", false);
											result.put("msg", rangeMap.get("valueMsg"));
											resultBool = false;
											return result;
										}
									}

									//리스트에 값 넣어서 마무리
									sampleVoList.add(tempDlivyVo);
									
								}
								//merge된 행은 이미 리스트에 담았으므로 건너뛰어서 다음행을 저장할 수 있도록 하기
								rowindex = rowindex + mergeIndex;
							}
		
						}
						else{
							switch(valueMsg){
							case "mtrilCode" :
								result.put("msg", "자재 코드를 확인 해주세요. " + bachNoMsg);
								break;
							case "batchNo" :
								result.put("msg", "Batch No. 를 확인해 주세요.");
								break;
							case "hour" :
								result.put("msg", "수정사항의 시간을 확인해 주세요.");
								break;								
							case "minute" :
								result.put("msg", "수정사항의 분을 확인해 주세요.");
								break;
							case "prducyUpperSeqNo" :
								result.put("msg", "자재코드가 정확하지 않습니다.");
								break;
							case "lotId" :								
								result.put("msg", "Batch No.가 정확하지 않습니다.");
								break;
							case "lockAt" :
								result.put("msg", "잠금된 의뢰가 있습니다. " + bachNoMsg);
								break;
							case "dlivyDte" :
								result.put("msg", "출고일자를 확인해주세요.");
								break;
							case "hir" :
								result.put("msg", "P/O No.를 확인해 주세요 HIR문자가 에스케이 하이닉스가 아닌 다른 업체에 입력되어 있습니다.");
								break;
							case "poNo" :
								result.put("msg", "납품 업체 목록에 등록되지 않은 자재 코드입니다.");
								break;
							}
							result.put("result", false);
							resultBool = false;
							break;
						}
					}
					
				}
			
			}
			
			//저장 성공여부
			int resultCnt = 0;
			
			//데이터를 성공적으로 담았는지 여부
			if(resultBool == true){
				for(int i=0; i<sampleVoList.size(); i++){
					if(!sampleVoList.get(i).getMtrilCode().equals("자재코드")) {

					String dvyfgEntrpsCode = dlivyBrcdMDao.getDvyfgEntrpsCode(sampleVoList.get(i));						
					
					// 제조4팀이면
					if(request.getParameter("inspctInsttCode").equals("3977")) {
						//자재코드 없는지 확인하고
						if(dvyfgEntrpsCode == null || dvyfgEntrpsCode.equals("")){
							//비고가 값이 있으면 비고값으로 (비고에 값이 없으면 true, 잇으면 false)
							if(sampleVoList.get(i).getRm().isEmpty() == false ) {
								sampleVoList.get(i).setInspctInsttCode(request.getParameter("inspctInsttCode")); 
								resultCnt = dlivyBrcdMService.insBrcdFormDlivy(sampleVoList.get(i));
							} 

						//자재코드 있으면
						} else {
							//자재코드가 있고 비고에도 값이 있는것만
							if(sampleVoList.get(i).getRm().isEmpty() == false ) {
								sampleVoList.get(i).setInspctInsttCode(request.getParameter("inspctInsttCode")); 
								resultCnt = dlivyBrcdMService.insBrcdFormDlivy(sampleVoList.get(i));								
							}
						}
					//제조4팀이 아닌 다른 부서일경우	
					}else {
						//자재코드 없으면 그냥 빠꾸임
						if(dvyfgEntrpsCode == null || dvyfgEntrpsCode.equals("")){
							result.put("result", false);
							result.put("msg", "납품 업체 목록에 등록되지 않은 자재 코드입니다. " + sampleVoList.get(i).getMtrilCode());
							return result;
						}
						//자재코드 있으면 
						else{
							sampleVoList.get(i).setInspctInsttCode(request.getParameter("inspctInsttCode"));
							resultCnt = dlivyBrcdMService.insBrcdFormDlivy(sampleVoList.get(i));
						}
					}

				}
					
				}
				
				//정상적으로 저장되었을때
				if(resultCnt > 0){
					
					DlivyMVo reqestSeVo = new DlivyMVo();
					//의뢰 변경점이나, 기타면 문자발송
					for(int i=0; i<requestSeq.size(); i++){
						reqestSeVo.setReqestSeqno(requestSeq.get(i));
						reqestSeVo.setDeptCode(request.getParameter("inspctInsttCode"));
						int cnt = dlivyMDao.getReqestSeCodeCnt(reqestSeVo);
						
						if(cnt > 0){
							DlivyMVo resultVo = dlivyMDao.getReqNtcnInfo(reqestSeVo);
							String smsMsg = "[미세변경점]" + resultVo.getDeptNm() + "-" + resultVo.getMtrilNm() + "(" + resultVo.getLotId() + ")";
							
							resultVo.setSmsMsg(smsMsg);
							resultVo.setNtcnSeCode("SY18000001");
							
							issueMDao.insMobphonNtcn(resultVo);
							
						}
					}
					
					result.put("result", true);
					result.put("msg", "업로드를 완료 하였습니다.");
				}
				//비정상 저장
				else{
					result.put("result", false);
					result.put("msg", "업로드를 실패 하였습니다.");
					return result;
				}
			}
			else{
				return result;
			}
			
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}finally{
			try {
				if(workbook != null){
					workbook.close();
				}
				if(convFile != null){
					convFile.delete();
				}
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			}
		}
		return result;
	}

	



	/**
	 * merge안된 열의 값을 비교하여 덮어씀
	 * @param sheet - 엑셀 sheet
	 * @param rowIndex - merge된 현재행
	 * @param cols - 덮어쓸 열 번호
	 * @param resultDlivyVo - 저장할 vo
	 * @return
	 */
	private HashMap<String, Object> getMergeValue(Sheet sheet, int rowIndex, int cols, DlivyMVo resultDlivyVo, FormulaEvaluator evaluator){
		Cell cell = sheet.getRow(rowIndex).getCell(cols); //셀에 담겨있는 값을 읽는다.
	
		String value = "";
		boolean valueCnt = true;
		String valueMsg = "";
		String bachNoMsg = String.valueOf(rowIndex+1) + "행 " + "마지막 행 " + sheet.getPhysicalNumberOfRows();
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		if(cell != null){		
			if(String.valueOf(cell.getCellType()).equals("STRING")){
				value = cell.getStringCellValue().trim();
			}
			else if(String.valueOf(cell.getCellType()).equals("BOOLEAN")){
				value = String.valueOf(cell.getBooleanCellValue()).trim();
			}
			else if(String.valueOf(cell.getCellType()).equals("NUMERIC")){
				value = String.valueOf((long)cell.getNumericCellValue()).trim();
			}

			else if(String.valueOf(cell.getCellType()).equals("FORMULA")){

				try{
					evaluator.evaluateInCell(cell);
					CellValue cellValue = evaluator.evaluate(cell);
					if(String.valueOf(cellValue.getCellType()).equals("STRING")){
						value = cellValue.getStringValue().trim();						
					}
					else if(String.valueOf(cellValue.getCellType()).equals("BOOLEAN")){
						value = String.valueOf(cellValue.getBooleanValue()).trim();
					}
					else if(String.valueOf(cellValue.getCellType()).equals("NUMERIC")){
						NumberFormat f = NumberFormat.getInstance();
						f.setGroupingUsed(false);
						value = String.valueOf(f.format(cellValue.getNumberValue())).trim();		
					}
				}catch(Exception e){

					if(String.valueOf(cell.getCachedFormulaResultType()).equals("NUMERIC")){
						value = String.valueOf(cell.getNumericCellValue()).trim();
					} else if(String.valueOf(cell.getCachedFormulaResultType()).equals("STRING")) {
						value = String.valueOf(cell.getStringCellValue()).trim();
					}
				}
			}

			
			//출고일자	 셀서식이 사용자 날짜면			 			
			try{
				//셀서식이 사용자 날짜면
 				if (DateUtil.isValidExcelDate(Double.valueOf(String.valueOf(sheet.getRow(0).getCell(0))))){
					SimpleDateFormat fommatter = new SimpleDateFormat("yyyy-MM-dd");
					resultDlivyVo.setDlivyDte(fommatter.format(sheet.getRow(0).getCell(0).getDateCellValue()));
				}
				
			}catch (Exception e){
				
				try{
                     					if(DateUtil.isCellDateFormatted(sheet.getRow(0).getCell(0))){
						Date date = sheet.getRow(0).getCell(0).getDateCellValue();
						String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);																
						resultDlivyVo.setDlivyDte(cellString); 
					}
				}catch(Exception e2){
					HashMap<String, Object> excelDateMap = new HashMap<String, Object>();
					excelDateMap = excelDateConverter(sheet.getRow(0).getCell(0), resultDlivyVo);								
					boolean excelDateBool = (boolean) excelDateMap.get("valueCnt");
					
					if(excelDateBool ==  false){
						valueCnt = false;
						valueMsg = (String) excelDateMap.get("valueMsg");
					}
				}																
			}

			/* 품고 문서 명 */
			if(cols == 0){
				resultDlivyVo.setQlyhghDocNm(value);
			}
			/* 납품 업체 코드 */
			else if(cols == 1){
				resultDlivyVo.setDvyfgEntrpsCode(value);
			}
			/* 납품 업체 명 */
			else if(cols == 2){
				resultDlivyVo.setDvyfgEntrpsNm(value);
			}
			/* 자재 코드 */
			else if(cols == 3){
				
				if(value == null || value.equals("")){
					valueCnt = false;
					valueMsg = "mtrilCode";
				}

				resultDlivyVo.setMtrilCode(value);
				
			}
			/* 고객사 자재 코드 */
			else if(cols == 4){
				resultDlivyVo.setCtmmnyMtrilCode(value);
			}
			/* PO NO */
			else if(cols == 5){
				resultDlivyVo.setPoNo(value);
				
				resultDlivyVo.setPoNo(value);
				
				if(resultDlivyVo.getPoNo().toUpperCase().indexOf("HIR") != -1){
					resultDlivyVo.setSkAt("Y");
					
					//업체코드 여부 확인
					String dvyfgEntrpsCode = dlivyBrcdMDao.getDvyfgEntrpsCode(resultDlivyVo);
					
					//HIR은 SK만붙음
					if(dvyfgEntrpsCode == null || dvyfgEntrpsCode.equals("") || !dvyfgEntrpsCode.equals("SY17000002")){
						valueCnt = false;
						valueMsg = "hir";
					}
				}
				else{
					resultDlivyVo.setSkAt("N");

					//업체코드 여부 확인
					String dvyfgEntrpsCode = dlivyBrcdMDao.getDvyfgEntrpsCode(resultDlivyVo);

					if(dvyfgEntrpsCode == null || dvyfgEntrpsCode.equals("")){
						valueCnt = false;
						valueMsg = "poNo";
					}
				}
			}
			/* 자재 명 */
			else if(cols == 6){
				resultDlivyVo.setMtrilNm(value);
			}
			/* BATCH NO */
			else if(cols == 7){
				if(value == null || value.equals("")){
					valueCnt = false;
					valueMsg = "batchNo";
				}
				
				resultDlivyVo.setBatchNo(value);


				bachNoMsg = resultDlivyVo.getBatchNo();
				
				//자재코드 + Batch No. 조건으로 Lot Id 의뢰번호 조회  
				if(resultDlivyVo.getMtrilCode() != null && !resultDlivyVo.getMtrilCode().equals("")){
					
					if(value != null && !value.equals("")){
						resultDlivyVo.setBatchNo(value);
						String lotId = dlivyMDao.getReqestSeqno(resultDlivyVo);
											
						resultDlivyVo.setReqestSeqno(lotId);
						resultDlivyVo.setLotId(dlivyMDao.getLotId(resultDlivyVo));
						resultDlivyVo.setMnfcturDte(dlivyMDao.getMnfcturDte(resultDlivyVo));
					}
					
				}
			}
			/* 출고 량 */
			else if(cols == 8){
				resultDlivyVo.setDlivyQy(value);
				resultDlivyVo.setOrginlDlivyQy(value);
			}
			/* 단위 명 */
			else if(cols == 9){
				resultDlivyVo.setUnitNm(value);
				//출고량 저장 단위가 KG, G 이면 계산하여 넣어야 하므로 단위 다음으로 처리함
				
				resultDlivyVo.setDlivyQy(getDlivyQy(resultDlivyVo));
			}
			/* 비고 */
			else if(cols == 10){
				resultDlivyVo.setRm(value);
			}
			
			/* 오류여부 */	
			else if(cols == 11){
				resultDlivyVo.setErrorAt(value);
			}
			
			/* 관계사 출고문서 */
			else if(cols == 12){
				resultDlivyVo.setRelcoDlivyDocNm(value);		
			}
			/* 관계사출고량*/
			else if(cols == 13){
				resultDlivyVo.setRelcoDlivyQy(value);
			}
			/* 미진행요청 */
			else if(cols == 14){
				resultDlivyVo.setUnprogrsRequstDc(value);
				
			}

			
			/* 수정 내용 */
			else if(cols == 15){
				resultDlivyVo.setUpdtCn(value);
			}
			/*수정 사항 시간*/
			else if(cols == 16){
				if(value == null || value.equals("")){
					valueCnt = true;
				}
				else{
					resultDlivyVo.setHour(value);
				}
			}
			/*수정 사항 분*/
			else if(cols == 17){
				if(value == null || value.equals("")){
					valueCnt = true;
				}
				else{
					//출고 시분은 출고 40분전 으로 계산하여 저장 ex) 12:00 면 23:20분으로
					//자정 12:00 ~ 09:00 사이 시간에는 전날 40분 전으로 저장해야함 DLIVY_DTE -> 전날로 저장, DLIVY_HM -> 23:20 으로
					String[] str = resultDlivyVo.getDlivyDte().split("-");
					int str1 = Integer.valueOf(str[0]);
					int str2 = Integer.valueOf(str[1]);
					int str3 = Integer.valueOf(str[2]);
					
					String hour = resultDlivyVo.getHour();
					String minute = value;
					
					if(hour.length() == 1){
						hour = "0" + hour;
					}
					
					if(minute.length() == 1){
						minute = "0" + minute;
					}
					
					//시간이 9시 보다 작으면
					if(Integer.valueOf(resultDlivyVo.getHour()) <= 9 ){
						LocalDate localDate = LocalDate.of(str1, str2, str3);								
						resultDlivyVo.setDlivyDte(localDate.toString()); 
						resultDlivyVo.setDlivyHm(hour+":"+minute);
						resultDlivyVo.setEmailSndngTm("");
						resultDlivyVo.setEmailSndngTm("11:20");
					}
					else{
						resultDlivyVo.setMinute(value);							 
						LocalTime dlivyHm = LocalTime.of(Integer.valueOf(resultDlivyVo.getHour()), Integer.valueOf(value));							
						resultDlivyVo.setDlivyHm(hour+":"+minute);
						resultDlivyVo.setEmailSndngTm("40");
						resultDlivyVo.setEmailSndngTm(String.valueOf(dlivyHm.minusMinutes(40)));
					}
				}
				
				
			}
			
			
			
			switch(valueMsg){
				case "mtrilCode" :
					resultMap.put("valueMsg", "자재 코드를 확인 해주세요. " + bachNoMsg);
					break;
				case "batchNo" :
					resultMap.put("valueMsg", "Batch No. 를 확인해 주세요.");
					break;
				case "hour" :
					resultMap.put("valueMsg", "수정사항의 시간을 확인해 주세요.");
					break;								
				case "minute" :
					resultMap.put("valueMsg", "수정사항의 분을 확인해 주세요.");
					break;
				case "prducyUpperSeqNo" :
					resultMap.put("valueMsg", "자재코드가 정확하지 않습니다.");
					break;
				case "lotId" :								
					resultMap.put("valueMsg", "Batch No.가 정확하지 않습니다.");
					break;
				case "dlivyDte" :
					resultMap.put("valueMsg", "출고일자를 확인해주세요");
					break;
				case "hir" :
					resultMap.put("msg", "P/O No.를 확인해 주세요 HIR문자가 에스케이 하이닉스가 아닌 다른 업체에 입력되어 있습니다.");
					break;
				case "poNo" :
					resultMap.put("msg", "납품 업체 목록에 등록되지 않은 자재 코드입니다.");
					break;
			}		
			
			resultMap.put("valueCnt", valueCnt); //false 면 오류	
		}
		else{
			resultMap.put("valueCnt", true);
			
		}
		return resultMap;
	}
	
	
	private HashMap<String, Object> excelDateConverter(Cell cell, DlivyMVo vo){
		
		boolean valueCnt = true;
		String valueMsg = "";
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		if(String.valueOf(cell).length() < 10){
			valueCnt = false;
			valueMsg = "dlivyDte";
		}		

		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String cellDate = String.valueOf(cell).substring(0,11);		
	
		try{
			Date javaDate = sdf.parse(cellDate);
			String cellString = new SimpleDateFormat("yyyy-MM-dd").format(javaDate);
			vo.setDlivyDte(cellString);
		}catch(ParseException e1){
	    	valueCnt = false;
			valueMsg = "dlivyDte";
		}
		
		resultMap.put("valueCnt", valueCnt);
		resultMap.put("valueMsg", valueMsg);
		
		return resultMap;
	}
	
	
	/**
	 * 출고량 KG, G 일때 계산하여 반환
	 * @return
	 */
	private String getDlivyQy(DlivyMVo vo){
		double qy = 0;
		
		//쉼표로 구분하여 split함
		if(vo.getUnitNm().toUpperCase().indexOf("BT") != -1){		
			return String.valueOf(vo.getDlivyQy());
		}
		
		String[] mtrilNm = vo.getMtrilNm().split(",");
		
		//KG 일때
		if(vo.getUnitNm().equals("KG")){
			if(vo.getDlivyQy() != null && !vo.getDlivyQy().equals("")){
				qy = Double.valueOf(vo.getDlivyQy());
			}
		}
		else if(vo.getUnitNm().equals("G")){
			//자재명의 kg을 g 으로 변경후 수량을 나누기 해준다
			qy = (Integer.valueOf(mtrilNm[2].replace("kg", "")) * 1000) / Integer.valueOf(vo.getDlivyQy().replaceAll(",", ""));
		}
		else if(vo.getUnitNm().equals("DR")){
			//자재명의 kg을 g 으로 변경후 수량을 나누기 해준다
			qy = Integer.valueOf(vo.getDlivyQy());
		}
		else if(vo.getUnitNm().equals("EA")){
			qy = Integer.valueOf(vo.getDlivyQy());
		}
		else if(vo.getUnitNm().equals("IBC")){
			qy = Integer.valueOf(vo.getDlivyQy());
		}
		else{
			for(int i=0; i<mtrilNm.length; i++){
				if(mtrilNm[i].indexOf("kg") != -1){
					//자재명의 kg을 g 으로 변경후 수량을 나누기 해준다
					//qy = (Integer.valueOf(mtrilNm[i].replace("kg", "")) * 1000) / Integer.valueOf(vo.getDlivyQy().replaceAll(",", ""));
					qy = 1;
				}
			}
		}
		
		return String.valueOf(qy);
		
	}
	
	/**
	 * 엑셀 파일에서 merge 된 row 와 col 반환
	 * @param sheet
	 * @param row
	 * @return
	 */
	private HashMap<String, Object> getNbOfMergedRegions(Sheet sheet, int row){
        int count = 0;
        int index = 0;
        
        HashMap<String, Object> map = new HashMap<String, Object>();
        ArrayList<Object> reangeList = new ArrayList<Object>();
        ArrayList<Object> tempList = new ArrayList<Object>();
        
        for(int i = 0; i < sheet.getNumMergedRegions(); i++){
            CellRangeAddress range = sheet.getMergedRegion(i);
            if (range.getFirstRow() <= row && range.getLastRow() >= row){            	
            	index = range.getLastRow();            	
            	tempList.add(range.getFirstColumn());
            	count++;
            }                
        }
        
        tempList.sort(null);
        
        for(int i=0; i<sampleList.length; i++){
        	
        	int cnt = 0;
        	
        	 for(int j=0; j<tempList.size(); j++){
        		 if(i == (int)tempList.get(j)){
        			 cnt++;
        			 break;
        		 }
        	 }
        	 
        	 if(cnt == 0){
         		reangeList.add(i);
         	}
        }
        
        map.put("count", count);
        map.put("range", reangeList);
        map.put("index", index);
        
        return map;
    }
	
	private HashMap<String, Object> getNbOfMergedRegions2(Sheet sheet, int row){
        int count = 0;
        int index = 0;
    
        HashMap<String, Object> map = new HashMap<String, Object>();
        ArrayList<Object> reangeList = new ArrayList<Object>();
        ArrayList<Object> tempList = new ArrayList<Object>();
        
       
		String value = "";
		boolean valueCnt = true;
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String tempInnerMtrilCode = null;
		String tempInnerPo = null;
		String tempInnerInvoice = null;

	
        
        for(int i = 0; i < sheet.getNumMergedRegions(); i++){
        	//머지 범위?
            CellRangeAddress range = sheet.getMergedRegion(i);

            //병합된 셀의 첫번째 행					  병합된 셀의 마지막행	
            //row에 속해있을떄?
            if (range.getFirstRow() <= row && range.getLastRow() >= row){
            	//병합된 셀의 마지막행
            	index = range.getLastRow();          	
            	//첫번째 열번호를 넣는다
            	tempList.add(range.getFirstColumn());
            	//count는 올라가면 머지된행 있는지 위에서 확인
            	count++;
            	
            }                
        }

        tempList.sort(null);

        // 컬럼수만큼 반복
        for(int i=0; i<sampleList2.length; i++){
        
        	int cnt = 0;
        	 for(int j=0; j<tempList.size(); j++){
        		
        		 if(i == (int)tempList.get(j)){
        			 cnt++;
        			 break;
        		 }
        	 }
        	 
        	 if(cnt == 0){
         		reangeList.add(i);	
         	}
        }
        
        map.put("count", count);
        map.put("range", reangeList);
        map.put("index", index);
        return map;
    }

	/**
	 * 미등록 알림 리스트 조회
	 */
	@Override
	public List<DlivyMVo> getDlivyList(DlivyMVo vo) {
		GetUserSession sessionD = new GetUserSession();
		vo.setAuthorSeCode(sessionD.getAuthorSeCode());
		return dlivyMDao.getDlivyList(vo);
	}

	/**
	 * 출고 이메일 이용자 리스트 조회
	 */
	@Override
	public List<DlivyMVo> getEmailDlivyList(DlivyMVo vo) {
		return dlivyMDao.getEmailDlivyList(vo);
	}

	
	/**
	 * 미등록 알림 리스트 저장
	 */
	@Override
	public int insDlivyInfo(DlivyMVo vo) {
		
		int result = 0;
		
		try{
			//수정
			for(int i=0; i<vo.getListGridData().size(); i++){
				String requestSeqNo = dlivyMDao.getLotToRequestSeqno(vo.getListGridData().get(i));
				vo.getListGridData().get(i).setReqestSeqno(requestSeqNo);
				result = dlivyMDao.updDlivyInfo(vo.getListGridData().get(i));
			}
			
			//삭제
			for(int i=0; i<vo.getRemoveListGridData().size(); i++){
				result = dlivyMDao.delDlivyInfo(vo.getRemoveListGridData().get(i));
			}
			
			//추가저장
			for(int i=0; i<vo.getAddListGridData().size(); i++){				
				result = dlivyMDao.insDlivy(vo.getAddListGridData().get(i));
				
				List<DlivyMVo> dlivyMVoList = dlivyMDao.getEmailSyDlivyList(vo.getAddListGridData().get(i));
				//자재관리에서 등록한 미등록알림 대상자 저장
				for(int j=0; j<dlivyMVoList.size(); j++){
					DlivyMVo insVo = new DlivyMVo();
					insVo.setUserId(dlivyMVoList.get(j).getUserId());
					insVo.setDlivyOrdeSeqno(vo.getAddListGridData().get(i).getDlivyOrdeSeqno());
					result = dlivyMDao.insAddDlivyEmail(insVo);
				}
			}
			
			
			
		}catch(Exception e){
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			throw e;
		}
		
		return result;
	}

	/**
	 * 출고 이메일 이용자 저장
	 */
	@Override
	public int insAddDlivyEmail(DlivyMVo vo) {		
		int result = 0;
		
		//저장 전삭제
		result = dlivyMDao.delDlivyEmailList(vo);
		
		for(int i=0; i<vo.getListGridData().size(); i++){
			DlivyMVo insVo = vo.getListGridData().get(i);
			insVo.setDlivyOrdeSeqno(vo.getDlivyOrdeSeqno());
			result = dlivyMDao.insAddDlivyEmail(insVo);
		}
		
		return result;
	}


	/**
	 * lot 유효성 체크
	 */
	@Override
	public int getLotValidation(DlivyMVo vo) {		
		return dlivyMDao.getLotValidation(vo);
	}
	
	/**
	 * INVOICE 생성
	 */
	@Override
	public HashMap<String, Object> applyFormFile2(MultipartHttpServletRequest request) {
		//view 로 리턴해줄 오브젝트
		HashMap<String, Object> result = new HashMap<String, Object>();
		//엑셀에서 추출한 값을 담을 vo list
		List<DlivyMVo> sampleVoList = new ArrayList<DlivyMVo>();
		//모든 엑셀 데이터를 성공적으로 불러왔을때 구분
		boolean resultBool = true;
		List<String> requestSeq = new ArrayList<String>();
		
		List<DlivyMVo> vrfctDetailList =  new ArrayList<DlivyMVo>();
		List<DlivyMVo> vrfctList =  new ArrayList<DlivyMVo>();
		
		
		//엑셀파일 읽어오기
		MultipartFile file = null;
		File convFile = null;
		Workbook workbook = null;
		
		try {
			file = request.getFile("formFile2");
			
			convFile = new File(file.getOriginalFilename());
			file.transferTo(convFile);
			
			FasooExtract fasooExtract = new FasooExtract();
			fasooExtract.DoExtract(convFile.getAbsoluteFile().toString());
			
			//Workbook 로 해야 xls, xlsx 두개다 됨
			workbook = WorkbookFactory.create(convFile);
			FormulaEvaluator evaluator = workbook.getCreationHelper().createFormulaEvaluator();
			workbook.setForceFormulaRecalculation(true);
			
			int rowindex = 0;
			//시트 수 (지금은 시트 하나만 업로드함)			
			int sheetIndex = 1;//workbook.getNumberOfSheets();			        
			
	        
			//시트 수만큼 반복
			for(int shIndex=0; shIndex<sheetIndex; shIndex++){
			
				Sheet sheet = workbook.getSheetAt(shIndex); //각행을 읽어온다
				int rows = sheet.getPhysicalNumberOfRows(); // 정의 된 행의 수를 반환.	

				
				//실제 데이터가 작성되는 7번째 row 부터
				for(rowindex = 7; rowindex <= rows; rowindex++){
					Row row = sheet.getRow(rowindex);
					
					DlivyMVo dlivyVo = new DlivyMVo();
	
					if(row != null){
	
						boolean valueCnt = true;

						//컬럼수 만큼 반복
						for(int cols = 0; cols < sampleList2.length; cols++){
							
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
								else if(String.valueOf(cell.getCellType()).equals("FORMULA")){

									try{
										evaluator.evaluateInCell(cell);
										CellValue cellValue = evaluator.evaluate(cell);
										
										if(String.valueOf(cellValue.getCellType()).equals("STRING")){
											value = cellValue.getStringValue().trim();
										}
										else if(String.valueOf(cellValue.getCellType()).equals("BOOLEAN")){
											value = String.valueOf(cellValue.getBooleanValue()).trim();
										}
										else if(String.valueOf(cellValue.getCellType()).equals("NUMERIC")){
											NumberFormat f = NumberFormat.getInstance();
											f.setGroupingUsed(false);
											value = String.valueOf(f.format(cellValue.getNumberValue())).trim();
										}
									}catch(Exception e){
										if(String.valueOf(cell.getCachedFormulaResultType()).equals("NUMERIC")){
											value = String.valueOf(cell.getNumericCellValue()).trim();
										}
									}
								}
								else if(String.valueOf(cell.getCellType()).equals("BLANK")){
									value = "";
								}
							}
							
							

							//출고일자	 셀서식이 사용자 날짜면			 			
							try{

								//셀서식이 사용자 날짜면
								if (DateUtil.isValidExcelDate(Double.valueOf(String.valueOf(sheet.getRow(0).getCell(6))))){
									SimpleDateFormat fommatter = new SimpleDateFormat("yyyy-MM-dd");
									dlivyVo.setDlivyDte(fommatter.format(sheet.getRow(0).getCell(6).getDateCellValue()));	
								}
								
								
								
							}catch (Exception e){
								
								try{
									if(DateUtil.isCellDateFormatted(sheet.getRow(0).getCell(6))){
										Date date = sheet.getRow(0).getCell(6).getDateCellValue();
										String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);																
										dlivyVo.setDlivyDte(cellString); 
									}
								}catch(Exception e2){
									HashMap<String, Object> excelDateMap = new HashMap<String, Object>();									
									excelDateMap = excelDateConverter(sheet.getRow(0).getCell(6), dlivyVo);								
									boolean excelDateBool = (boolean) excelDateMap.get("valueCnt");
									
									if(excelDateBool ==  false){
										valueCnt = false;
										break;
									}
								}																
							}
							
							
							/* 품고 문서 명 */
							if(sampleList2[cols].equals("qlyhghDocNm")){
								dlivyVo.setQlyhghDocNm(value);
							}
							/* 납품 업체 코드 */
							else if(sampleList2[cols].equals("dvyfgEntrpsCode")){
								dlivyVo.setDvyfgEntrpsCode(value);
							}
							/* 납품 업체 명 */
							else if(sampleList2[cols].equals("dvyfgEntrpsNm")){
								dlivyVo.setDvyfgEntrpsNm(value);
							}
							/* 자재 코드 */
							else if(sampleList2[cols].equals("mtrilCode")){
								dlivyVo.setMtrilCode(value);									
							}
							/* 고객사 자재 코드 */
							else if(sampleList2[cols].equals("ctmmnyMtrilCode")){
								dlivyVo.setCtmmnyMtrilCode(value);
							}

							/* PO NO */
							else if(sampleList2[cols].equals("poNo")){				
								dlivyVo.setPoNo(value);
							}
							/* 자재 명 */
							else if(sampleList2[cols].equals("mtrilNm")){
								dlivyVo.setMtrilNm(value);
							}
							/* BATCH NO */
							else if(sampleList2[cols].equals("batchNo")){
								dlivyVo.setBatchNo(value);
							}
							
							/* 출고 량 */
							else if(sampleList2[cols].equals("dlivyQy")){
								dlivyVo.setDlivyQy(value);
								dlivyVo.setOrginlDlivyQy(value);
							}
							/* 단위 명 */
							else if(sampleList2[cols].equals("unitNm")){
								dlivyVo.setUnitNm(value);
								dlivyVo.setDlivyQy(getDlivyQy(dlivyVo));
								
							}
							/* 비고 */
							else if(sampleList2[cols].equals("rm")){
								dlivyVo.setRm(value);
							}
							
							/* 배차 */	
							else if(sampleList2[cols].equals("dispatch")){
								dlivyVo.setDispatch(value);	
							}
							
							/* 차량번호  */
							else if(sampleList2[cols].equals("carNo")){
								dlivyVo.setCarNo(value);
							}
							/* invoice */
							else if(sampleList2[cols].equals("invoice")){
								dlivyVo.setInvoice(value);
							}
							/* full invoice No */
							else if(sampleList2[cols].equals("invoiceNo")){				
								dlivyVo.setInvoiceNo(value);
								StringBuilder sb = new StringBuilder();
								if(dlivyVo.getInvoiceNo().length() == 11) {
									sb.append(value);
									sb.insert(10, "0");
									dlivyVo.setInvoiceNo(sb.toString());
								}
							}
	
						}//cols 종료
						
						int resultCnt = 0;
						//엑셀의 데이터가 정확할때
						if(valueCnt == true){
							sampleVoList.add(dlivyVo);
							ConverterUtils converterUtils = new ConverterUtils();
							HashMap<String, Object> mergeMap = new HashMap<String, Object>();
					
	
							//merge 된 행이 있는지 감지
							mergeMap = getNbOfMergedRegions2(sheet, rowindex);
							
							//count가 0이상이면 merge 된 행이 있는거임
							if(Integer.valueOf(mergeMap.get("count").toString()) > 0){
								
								//현제 읽고 있는 엑셀의 행과 merge된 마지막 행의 차수를 구해서 루프 돌려줌(merge된 행까지 루프)
								int mergeIndex = Integer.valueOf(mergeMap.get("index").toString()) - rowindex;
								ArrayList<Integer> rangeArray = (ArrayList<Integer>) mergeMap.get("range");

								for(int j=1; j<=mergeIndex; j++){
									DlivyMVo tempDlivyVo = new DlivyMVo();
									
									HashMap<String, Object> tempMap = new HashMap<String, Object>();
								
									try{
										//DlivyMVo 의 필드 변수명과 값을 가져와서 맵에 담음
										// merge 기준이 되는 첫번째 행의 값을 merge 된 행 전체에 담는다.
										for (Field field : tempDlivyVo.getClass().getDeclaredFields()) {
							                field.setAccessible(true);
							                // 필드에 해당하는 값
											Object objVal = field.get(dlivyVo);
											tempMap.put(field.getName(), objVal);
										
										}
										//맵에 담은 값을 다시 vo 로 변환해준다.
										converterUtils.convertHashMapToVo(tempMap, tempDlivyVo);
									}catch(Exception e){
										e.printStackTrace();
									}
									
									
									
									//merge된 값은 처음 행의 값을 가져와 담았지만 merge가 안된 행도 있으므로 merge가 되었는지 구분하여 현재 열의 값으로 덮어쓴다.
									for(int a=0; a<rangeArray.size(); a++){
									
										HashMap<String, Object> rangeMap = getMergeValue2(sheet, rowindex+j, rangeArray.get(a), tempDlivyVo, evaluator);
										if((boolean)rangeMap.get("valueCnt") == false){										
											result.put("result", false);
											result.put("msg", rangeMap.get("valueMsg"));
											resultBool = false;
											return result;
										}
									}
									
							
									//리스트에 값 넣어서 마무리
									sampleVoList.add(tempDlivyVo);
								}
								
								//merge된 행은 이미 리스트에 담았으므로 건너뛰어서 다음행을 저장할 수 있도록 하기
								rowindex = rowindex + mergeIndex;
							}

							
						}
					}
					
				}
			}
			
			//저장 성공여부
			int resultCnt = 0;
			//데이터를 성공적으로 담았는지 여부
			if(resultBool == true){

				
				for(int i=0; i<sampleVoList.size(); i++){
					if(sampleVoList.get(i).getInvoiceNo().isEmpty() == false) {
//						//배차지시서 자재 po batch 조합으로 출고바코드 일련번호 조회
						vrfctDetailList = dlivyMDao.getVrfctChk(sampleVoList.get(i));

						
						for(int j=0; j < vrfctDetailList.size(); j++) {
							if(vrfctDetailList.get(j).getDlivyBrcdSttusCode().equals("IM16000001")) {
								vrfctDetailList.get(j).setInvoiceNo(sampleVoList.get(i).getInvoiceNo());
								dlivyMDao.getInvoDeailSeq(vrfctDetailList.get(j));	
							}
						}
		
						//마스터 인보이스 업데이트
						resultCnt = dlivyMDao.getInvoSeq(sampleVoList.get(i));			
					}
				}
				result.put("result", true);
				result.put("msg", "업로드를 완료 하였습니다.");
			}
			else{
				return result;
			}
			
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}finally{
			try {
				if(workbook != null){
					workbook.close();
				}
				if(convFile != null){
					convFile.delete();
				}
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			}
		}
		return result;
	}
	
	/**
	 * D/O NO 생성
	 */
	@Override
	public HashMap<String, Object> applyFormFile3(MultipartHttpServletRequest request) {
		//view 로 리턴해줄 오브젝트
		HashMap<String, Object> result = new HashMap<String, Object>();
		//엑셀에서 추출한 값을 담을 vo list
		List<DlivyMVo> sampleVoList = new ArrayList<DlivyMVo>();
		//모든 엑셀 데이터를 성공적으로 불러왔을때 구분
		boolean resultBool = true;
		List<DlivyMVo> brcdInvoDetail = new ArrayList<DlivyMVo>();

		//엑셀파일 읽어오기
		MultipartFile file = null;
		File convFile = null;
		Workbook workbook = null;
		
		try {
			file = request.getFile("formFile3");
			
			convFile = new File(file.getOriginalFilename());
			file.transferTo(convFile);
			
			FasooExtract fasooExtract = new FasooExtract();
			fasooExtract.DoExtract(convFile.getAbsoluteFile().toString());
			
			//Workbook 로 해야 xls, xlsx 두개다 됨
			workbook = WorkbookFactory.create(convFile);
			FormulaEvaluator evaluator = workbook.getCreationHelper().createFormulaEvaluator();
			workbook.setForceFormulaRecalculation(true);
			
			int rowindex = 0;
			//시트 수 (DO값은 1번째 시트)			
			int sheetIndex = 1;//workbook.getNumberOfSheets();			        
			int sheetTotalCount = workbook.getNumberOfSheets();
	       
			if(sheetTotalCount > 1) {
				result.put("result", false);
				result.put("msg", "D/O가 포함된 sheet를 하나만 넣어주세요.");
				return result;
			}
			//시트 수만큼 반복
			for(int shIndex=0; shIndex<sheetIndex; shIndex++){
			
				Sheet sheet = workbook.getSheetAt(shIndex); //각행을 읽어온다
				int rows = sheet.getPhysicalNumberOfRows(); // 정의 된 행의 수를 반환.	

				
				//실제 데이터가 작성되는 2번째 row 부터
				for(rowindex = 2; rowindex <= rows; rowindex++){
					Row row = sheet.getRow(rowindex);
					
					DlivyMVo dlivyVo = new DlivyMVo();
	
					if(row != null){
	
						boolean valueCnt = true;

						//컬럼수 만큼 반복
						for(int cols = 0; cols < sampleList3.length; cols++){
							
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
								else if(String.valueOf(cell.getCellType()).equals("FORMULA")){

									try{
										evaluator.evaluateInCell(cell);
										CellValue cellValue = evaluator.evaluate(cell);
										
										if(String.valueOf(cellValue.getCellType()).equals("STRING")){
											value = cellValue.getStringValue().trim();
										}
										else if(String.valueOf(cellValue.getCellType()).equals("BOOLEAN")){
											value = String.valueOf(cellValue.getBooleanValue()).trim();
										}
										else if(String.valueOf(cellValue.getCellType()).equals("NUMERIC")){
											NumberFormat f = NumberFormat.getInstance();
											f.setGroupingUsed(false);
											value = String.valueOf(f.format(cellValue.getNumberValue())).trim();
										}
									}catch(Exception e){
										if(String.valueOf(cell.getCachedFormulaResultType()).equals("NUMERIC")){
											value = String.valueOf(cell.getNumericCellValue()).trim();
										}
									}
								}
								else if(String.valueOf(cell.getCellType()).equals("BLANK")){
									value = "";
								}
							}
							
							

						//출고일자	 셀서식이 사용자 날짜면 (DO는 날짜 안쓰는데 혹시 몰라서 주석만 해둠)			 			
//							try{
//
//								//셀서식이 사용자 날짜면
//								if (DateUtil.isValidExcelDate(Double.valueOf(String.valueOf(sheet.getRow(0).getCell(6))))){
//									SimpleDateFormat fommatter = new SimpleDateFormat("yyyy-MM-dd");
//									dlivyVo.setDlivyDte(fommatter.format(sheet.getRow(0).getCell(6).getDateCellValue()));	
//								}
//								
//								
//								
//							}catch (Exception e){
//								
//								try{
//									if(DateUtil.isCellDateFormatted(sheet.getRow(0).getCell(6))){
//										Date date = sheet.getRow(0).getCell(6).getDateCellValue();
//										String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);																
//										dlivyVo.setDlivyDte(cellString); 
//									}
//								}catch(Exception e2){
//									HashMap<String, Object> excelDateMap = new HashMap<String, Object>();									
//									excelDateMap = excelDateConverter(sheet.getRow(0).getCell(6), dlivyVo);								
//									boolean excelDateBool = (boolean) excelDateMap.get("valueCnt");
//									
//									if(excelDateBool ==  false){
//										valueCnt = false;
//										break;
//									}
//								}																
//							}
							
							
							/* 인보이스 값 넣어주기 */
							if(sampleList3[cols].equals("invoiceNo")){
								dlivyVo.setInvoiceNo(value);
							}
							/* D/O No */
							else if(sampleList3[cols].equals("doNo")){
								dlivyVo.setDoNo(value);
							}
							/* P/O No */
							else if(sampleList3[cols].equals("poNo")){
								dlivyVo.setPoNo(value);
							}		
	
						}//cols 종료
						
						//엑셀의 데이터가 정확할때
						if(valueCnt == true){
							sampleVoList.add(dlivyVo);

						}
					}
					
				}
			}
			
			//저장 성공여부
			int resultCnt = 0;
			int cmpResult = 0;
			//데이터를 성공적으로 담았는지 여부
			if(resultBool == true){
				
				for(int i=0; i<sampleVoList.size(); i++){
					// 인보이스를 보내서 값이 있을경우 업데이트 시켜주려고 count 조회해옴
					cmpResult = dlivyMDao.getCmpResult(sampleVoList.get(i));
					if(cmpResult > 0) {
						//인보이스를 가지고 DO,PO 업데이트
						resultCnt = dlivyMDao.getInvoDetail(sampleVoList.get(i));
					}

				}
				result.put("result", true);
				result.put("msg", "업로드를 완료 하였습니다.");
			}
			else{
				return result;
			}
			
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}finally{
			try {
				if(workbook != null){
					workbook.close();
				}
				if(convFile != null){
					convFile.delete();
				}
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			}
		}
		return result;
	}
	
	/**
	 * merge안된 열의 값을 비교하여 덮어씀
	 * invoice에서 사용할것
	 * @param sheet - 엑셀 sheet
	 * @param rowIndex - merge된 현재행
	 * @param cols - 덮어쓸 열 번호
	 * @param resultDlivyVo - 저장할 vo
	 * @return
	 */
private HashMap<String, Object> getMergeValue2(Sheet sheet, int rowIndex, int cols, DlivyMVo resultDlivyVo, FormulaEvaluator evaluator){

		NumberFormat format = NumberFormat.getInstance();
		format.setGroupingUsed(false);
		
		Cell cell = sheet.getRow(rowIndex).getCell(cols); //셀에 담겨있는 값을 읽는다.
		String value = "";
		boolean valueCnt = true;
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String tempInnerMtrilCode = null;
		String tempInnerPo = null;
		String tempInnerInvoice = null;
		
		
		for(int i = 0; i < 14; i++) {

			while(sheet.getNumMergedRegions() > 0) {
				CellRangeAddress addr = sheet.getMergedRegion(0);
				
				int firstRow = addr.getFirstRow();
				int lastRow = addr.getLastRow();
				int firstCol = addr.getFirstColumn();
				int lastCol = addr.getLastColumn();
				
				sheet.removeMergedRegion(0);
				
			

				if (sheet.getRow(firstRow).getCell(firstCol).getCellType() == CellType.STRING) {
					value = sheet.getRow(firstRow).getCell(firstCol).getStringCellValue();
				}else if (sheet.getRow(firstRow).getCell(firstCol).getCellType() == CellType.NUMERIC) {
					double d = sheet.getRow(firstRow).getCell(firstCol).getNumericCellValue();
					Long l = Long.parseLong(format.format(d));
					value = Long.toString(l);
				}
	
				for(int x = firstRow; x <= lastRow; x++) {
					for(int y = firstCol; y <= lastCol; y++) {
						sheet.getRow(x).getCell(y).setCellValue(value);
						
					}
				}
			}
			
			i++;
		
		
		
		

		if(cell != null){		
			
			if(String.valueOf(cell.getCellType()).equals("STRING")){
				value = cell.getStringCellValue().trim();
			}
			else if(String.valueOf(cell.getCellType()).equals("BOOLEAN")){
				value = String.valueOf(cell.getBooleanCellValue()).trim();
			}
			else if(String.valueOf(cell.getCellType()).equals("NUMERIC")){
				
				BigDecimal bigDecimal = new BigDecimal(String.valueOf(cell));
				DataFormatter fmt = new DataFormatter();
				value = fmt.formatCellValue(cell);
				
			}
			else if(String.valueOf(cell.getCellType()).equals("FORMULA")){
				evaluator.evaluateInCell(cell); 
				CellValue cellValue = evaluator.evaluate(cell);
				
				if(String.valueOf(cellValue.getCellType()).equals("STRING")){
					value = cellValue.getStringValue().trim();
				}
				else if(String.valueOf(cellValue.getCellType()).equals("BOOLEAN")){
					value = String.valueOf(cellValue.getBooleanValue()).trim();
				}
				else if(String.valueOf(cellValue.getCellType()).equals("NUMERIC")){
					NumberFormat f = NumberFormat.getInstance();
					f.setGroupingUsed(false);
					value = String.valueOf(f.format(cellValue.getNumberValue())).trim();
				}
			}


	
			//출고일자	 셀서식이 사용자 날짜면			 			
			try{
				//셀서식이 사용자 날짜면
				if (DateUtil.isValidExcelDate(Double.valueOf(String.valueOf(sheet.getRow(0).getCell(6))))){
					SimpleDateFormat fommatter = new SimpleDateFormat("yyyy-MM-dd");
					resultDlivyVo.setDlivyDte(fommatter.format(sheet.getRow(0).getCell(6).getDateCellValue()));
				}

				
			}catch (Exception e){
				
				try{
					if(DateUtil.isCellDateFormatted(sheet.getRow(0).getCell(6))){
						Date date = sheet.getRow(0).getCell(6).getDateCellValue();
						String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);
						resultDlivyVo.setDlivyDte(cellString); 
					}
			
				}catch(Exception e2){
					HashMap<String, Object> excelDateMap = new HashMap<String, Object>();
					excelDateMap = excelDateConverter(sheet.getRow(0).getCell(6), resultDlivyVo);								
					boolean excelDateBool = (boolean) excelDateMap.get("valueCnt");
					
					if(excelDateBool ==  false){
						valueCnt = false;
					}
				}																
			}
			
			
			/* 품고 문서 명 */
			if(cols == 0){
				resultDlivyVo.setQlyhghDocNm(value);
			}
			/* 납품 업체 코드 */
			else if(cols == 1){
				resultDlivyVo.setDvyfgEntrpsCode(value);
			}
			/* 납품 업체 명 */
			else if(cols == 2){
				resultDlivyVo.setDvyfgEntrpsNm(value);
			}
			/* 자재 코드 */
			else if(cols == 3){
				resultDlivyVo.setMtrilCode(value);

			}
			/* 고객사 자재 코드 */
			else if(cols == 4){
				resultDlivyVo.setCtmmnyMtrilCode(value);
			}
			/* PO NO */
			else if(cols == 5){
				resultDlivyVo.setPoNo(value);

			}
			/* 자재 명 */
			else if(cols == 6){
				resultDlivyVo.setMtrilNm(value);
			}
			/* BATCH NO */
			else if(cols == 7){
				resultDlivyVo.setBatchNo(value);
			}
			/* 출고 량 */
			else if(cols == 8){
				resultDlivyVo.setDlivyQy(value);
				resultDlivyVo.setOrginlDlivyQy(value);
			}
			/* 단위 명 */
			else if(cols == 9){
				resultDlivyVo.setUnitNm(value);
				//출고량 저장 단위가 KG, G 이면 계산하여 넣어야 하므로 단위 다음으로 처리함
				
//				resultDlivyVo.setDlivyQy(getDlivyQy(resultDlivyVo));
			}
			/* 비고 */
			else if(cols == 10){
				resultDlivyVo.setRm(value);
			}
			
			/* 배차  */	
			else if(cols == 11){
				resultDlivyVo.setDispatch(value);
			}
			
			/* 차량번호 */
			else if(cols == 12){
				resultDlivyVo.setCarNo(value);		
			}
			/* invoice*/
			else if(cols == 13){
				resultDlivyVo.setInvoice(value);
			}
			/* fullinvoice */
			else if(cols == 14){
				resultDlivyVo.setInvoiceNo(value);
				
			}

		
			resultMap.put("valueCnt", valueCnt); //false 면 오류	
	
		}
		else{
			resultMap.put("valueCnt", true);

		}
	}	
		return resultMap;
	}





}


