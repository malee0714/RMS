package lims.dly.service.Impl;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Field;
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

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellValue;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.dly.dao.DlivyMDao;
import lims.dly.vo.DlivyMVo;
import lims.test.vo.CoaMVo;
import lims.util.ConverterUtils;
import lims.util.FasooExtract;

@Service("DlivyAllamExcelUpload")
public class DlivyAllamExcelUpload {
	
	@Autowired
	private DlivyMDao dlivyMDao;
	
	
	//미등록 알림 훽트팀
	private String[] dlivyAllimFT = {
			"qlyhghDocNm"    	 /* 출하문서 */
		   ,"dvyfgEntrpsCode" 	/* 납품처 */
		   ,"dvyfgEntrpsNm"	  	/* 납품처 명 */
		   ,"goodsReceiptLine"	/* 입고라인 */
		   ,"mtrilCode"		 	/* 자재 코드 */
		   ,"ctmmnyMtrilCode" 	/* 고객사 자재 코드 */
		   ,"poNo"  		  	/* PO NO */
		   ,"mtrilNm"         	/* 자재 명 */
		   ,"batchNo" 		  	/* BATCH NO */
		   ,"dlivyQy"    	  	/* 수량 */
		   ,"unitNm"  		  	/* 단위 */		   
		   ,"departuretime"     /* 출발시간 */		   
		   ,"arrivalTime"       /* 도착시간 */
		   ,"rm"                /* 전달사항 */
		   ,"updtCn"            /* 수정사항 */
		   ,"etc"               /* 비고 */
	};
		
	//미등록알림 엑셀 업로드
	public HashMap<String, Object> excelUpload(MultipartHttpServletRequest request){
		String formType = String.valueOf(request.getParameter("formType"));
		//view 로 리턴해줄 오브젝트
		HashMap<String, Object> result = new HashMap<String, Object>();
		//엑셀에서 추출한 값을 담을 vo list
		List<DlivyMVo> sampleVoList = new ArrayList<DlivyMVo>();
		//모든 엑셀 데이터를 성공적으로 불러왔을때 구분
		boolean resultBool = true;
		
		String[] dlibyHeaderList = {};		
		
		//2팀 훽트 동일 양식으로 변경한다함....
		dlibyHeaderList = dlivyAllimFT;
		
		//엑셀파일 읽어오기
		MultipartFile file = null;
		File convFile = null;
		Workbook workbook = null;
		
		try{
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
			int sheetIndex = workbook.getNumberOfSheets();			        
			//시트 수만큼 반복
			for(int shIndex=0; shIndex<sheetIndex; shIndex++){
				
				Sheet sheet = workbook.getSheetAt(shIndex); //각행을 읽어온다
				int rows = sheet.getPhysicalNumberOfRows(); // 정의 된 행의 수를 반환
				
				//실제 데이터가 작성되는 2번째 row 부터
				for(rowindex = 2; rowindex <= rows; rowindex++){
					Row row = sheet.getRow(rowindex);
					DlivyMVo dlivyVo = new DlivyMVo();
					
					if(row != null){
						boolean valueCnt = true;
						String valueMsg = "";
						String bachNoMsg = String.valueOf(rowindex+1) + "행" + " 마지막 행 " + rows;
						
						//컬럼수 만큼 반복
						for(int cols = 0; cols < dlibyHeaderList.length; cols++){
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
									continue;
//									evaluator.evaluateInCell(cell); 
//									CellValue cellValue = evaluator.evaluate(cell);
//									
//									if(String.valueOf(cellValue.getCellType()).equals("STRING")){
//										value = cellValue.getStringValue().trim();
//									}
//									else if(String.valueOf(cellValue.getCellType()).equals("BOOLEAN")){
//										value = String.valueOf(cellValue.getBooleanValue()).trim();
//									}
//									else if(String.valueOf(cellValue.getCellType()).equals("NUMERIC")){
//										NumberFormat f = NumberFormat.getInstance();
//										f.setGroupingUsed(false);
//										value = String.valueOf(f.format(cellValue.getNumberValue())).trim();
//									}
								}
								//출고일자							
								try{
									//날짜 형식이 맞으면..								
									if(DateUtil.isCellDateFormatted(sheet.getRow(0).getCell(0))){
										Date date = sheet.getRow(0).getCell(0).getDateCellValue();
										String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);																
										dlivyVo.setDlivyDte(cellString); 
									}
								}catch (Exception e){
									if(String.valueOf(sheet.getRow(0).getCell(0)).length() < 10){
										valueCnt = false;
										valueMsg = "dlivyDte";
										break;
									}
									
									DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");								
									String cellDate = String.valueOf(sheet.getRow(0).getCell(0)).substring(0,11);
									
									
									try{
										Date javaDate = sdf.parse(cellDate);
										String cellString = new SimpleDateFormat("yyyy-MM-dd").format(javaDate);
										dlivyVo.setDlivyDte(cellString); 
									}catch(ParseException e1){
								    	valueCnt = false;
										valueMsg = "dlivyDte";
										break;
									}
									
								}
								
								/* 출하 문서 명 */
								if(dlibyHeaderList[cols].equals("qlyhghDocNm")){
									dlivyVo.setQlyhghDocNm(value);
								}
								/* 납품 업체 코드 */
								else if(dlibyHeaderList[cols].equals("dvyfgEntrpsCode")){
									dlivyVo.setDvyfgEntrpsCode(value);
								}
								/* 납품 업체 명 */
								else if(dlibyHeaderList[cols].equals("dvyfgEntrpsNm")){
									dlivyVo.setDvyfgEntrpsNm(value);
								}
								/* 자재 코드 */
								else if(dlibyHeaderList[cols].equals("mtrilCode")){
									
									if(value == null || value.equals("") || value.length() > 8){
										valueCnt = false;
										valueMsg = "mtrilCode";
										break;
									}
									
									if(value.length() > 8){
										valueCnt = false;
										valueMsg = "mtrilCode2";
										break;
									}
									
									dlivyVo.setMtrilCode(value);
									
								}
								/* 고객사 자재 코드 */
								else if(dlibyHeaderList[cols].equals("ctmmnyMtrilCode")){
									dlivyVo.setCtmmnyMtrilCode(value);
								}
								/* PO NO */
								else if(dlibyHeaderList[cols].equals("poNo")){
									if(value.length() > 30){
										valueCnt = false;
										valueMsg = "poNo";
										break;										
									}
									dlivyVo.setPoNo(value);
								}
								/* 자재 명 */
								else if(dlibyHeaderList[cols].equals("mtrilNm")){
									dlivyVo.setMtrilNm(value);
								}
								/* BATCH NO */
								else if(dlibyHeaderList[cols].equals("batchNo")){
									if(value == null || value.equals("")){
										
//										valueCnt = false;
//										valueMsg = "batchNo";
//										break;
									}
									
									dlivyVo.setBatchNo(value);
									
									//자재코드 + Batch No. 조건으로 Lot Id 의뢰번호 조회  
									if(dlivyVo.getMtrilCode() != null && !dlivyVo.getMtrilCode().equals("")){
										
										
										if(value != null && !value.equals("")){
											dlivyVo.setBatchNo(value);
											String lotId = dlivyMDao.getReqestSeqno(dlivyVo);
											StringBuilder sb = new StringBuilder(dlivyVo.getMtrilCode());
											sb.append(dlivyVo.getBatchNo());
											dlivyVo.setReqestSeqno(lotId);
											dlivyVo.setLotId(dlivyMDao.getLotId(dlivyVo));
											dlivyVo.setMnfcturDte(dlivyMDao.getMnfcturDte(dlivyVo));
											
											CoaMVo coaVo = new CoaMVo();
											coaVo.setReqestSeqno(lotId);
										}
										
									}
								}
								/* 출고 량 */
								else if(dlibyHeaderList[cols].equals("dlivyQy")){
									dlivyVo.setDlivyQy(value);
								}
								/* 단위 명 */
								else if(dlibyHeaderList[cols].equals("unitNm")){
									dlivyVo.setUnitNm(value);										
								}
								/* 비고 */
								else if(dlibyHeaderList[cols].equals("rm")){
									dlivyVo.setRm(value);
								}
								/* 수정 내용 */
								else if(dlibyHeaderList[cols].equals("updtCn")){
									dlivyVo.setHour(value);
								}
								/*수정 사항 시간*/
								else if(dlibyHeaderList[cols].equals("hour")){
									if(value == null || value.equals("")){
										valueCnt = true;
										break;
									}
									
									
									dlivyVo.setHour(value);
								}
								/*수정 사항 분*/
								else if(dlibyHeaderList[cols].equals("minute") || dlibyHeaderList[cols].equals("etc")){
									if(value == null || value.equals("")){
										valueCnt = true;
										break;
									}
									
									
									//출고 시분은 출고 40분전 으로 계산하여 저장 ex) 00:00 면 23:20분으로
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
									}
									else{
										dlivyVo.setMinute(value);
										LocalTime dlivyHm = null;
										try{
											dlivyHm = LocalTime.of(Integer.valueOf(dlivyVo.getHour()), Integer.valueOf(value));			
										}catch(Exception e){
											valueCnt = false;
											valueMsg = "hourAndMin";											
											break;
										}
														
								        dlivyVo.setDlivyHm(hour+":"+minute);
								        dlivyVo.setEmailSndngTm("40");
//								        dlivyVo.setEmailSndngTm(String.valueOf(dlivyHm.minusMinutes(40)));
									}
								}
								
								
								
							} // cell end
						} //dlibyHeaderList end
						
						//엑셀의 데이터가 정확할때
						if(valueCnt == true){
							sampleVoList.add(dlivyVo);
							ConverterUtils converterUtils = new ConverterUtils();
							
							HashMap<String, Object> mergeMap = new HashMap<String, Object>();
							//merge 된 행이 있는지 감지
							mergeMap = getNbOfMergedRegions(sheet, rowindex, formType);
							
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
										HashMap<String, Object> rangeMap = getMergeValue(sheet, rowindex+j, rangeArray.get(a), tempDlivyVo, evaluator, formType);
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
							case "mtrilCode2" :
								result.put("msg", "자재 코드가 8자리 이상입니다. ");
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
								result.put("msg", "출고일자를 확인해주세요");
								break;
							case "poNo" :
								result.put("msg", "P/O No.는 30자까지만 입력하실 수 있습니다.");
								break;
							case "hourAndMin" : 
								result.put("msg", "수정사항쪽의 시간, 분을 확인해주세요.");
								break;
							}
						
							result.put("result", false);
							resultBool = false;
							return result;
						}
						
					} //row end
				} //rowindex end
			}
			
			//저장 성공여부
			
			//데이터를 성공적으로 담았는지 여부
			if(resultBool == true){		
				//정상적으로 저장되었을때
				result.put("params", sampleVoList);
				result.put("result", true);
				result.put("msg", "적용이 완료되었습니다. 목록 확인후 저장해 주세요.");
				return result;
			}
			else{
				return result;
			}
			
			
		}catch(Exception e){
			if(workbook != null){
				try {
					workbook.close();
				} catch (IOException e1) {						
					e1.printStackTrace();
				}
			}
			if(convFile != null){
				convFile.delete();
			}
			e.printStackTrace();
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
	 * 엑셀 파일에서 merge 된 row 와 col 반환
	 * @param sheet
	 * @param row
	 * @return
	 */
	private HashMap<String, Object> getNbOfMergedRegions(Sheet sheet, int row, String formType){
		
		String[] dlibyHeaderList = {};
		
		dlibyHeaderList = dlivyAllimFT;
				
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
        
        for(int i=0; i<dlibyHeaderList.length; i++){
        	
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
	 * merge안된 열의 값을 비교하여 덮어씀
	 * @param sheet - 엑셀 sheet
	 * @param rowIndex - merge된 현재행
	 * @param cols - 덮어쓸 열 번호
	 * @param resultDlivyVo - 저장할 vo
	 * @return
	 */
	private HashMap<String, Object> getMergeValue(Sheet sheet, int rowIndex, int cols, DlivyMVo resultDlivyVo, FormulaEvaluator evaluator, String formType){
		
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
				value = String.valueOf((int)cell.getNumericCellValue()).trim();
			}
			else if(String.valueOf(cell.getCellType()).equals("FORMULA")){
				value = "";
			}
			
			//출고일자			
			try{
				//날짜 형식이 맞으면..								
				if(DateUtil.isCellDateFormatted(sheet.getRow(0).getCell(0))){
					Date date = sheet.getRow(0).getCell(0).getDateCellValue();
					String cellString = new SimpleDateFormat("yyyy-MM-dd").format(date);																
					resultDlivyVo.setDlivyDte(cellString); 
				}
			}catch (Exception e){
				if(String.valueOf(sheet.getRow(0).getCell(0)).length() < 10){
					valueCnt = false;
					valueMsg = "dlivyDte";
				}
				
				DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");								
				String cellDate = String.valueOf(sheet.getRow(0).getCell(0)).substring(0,11);
				
				
				try{
					Date javaDate = sdf.parse(cellDate);
					String cellString = new SimpleDateFormat("yyyy-MM-dd").format(javaDate);
					resultDlivyVo.setDlivyDte(cellString); 
				}catch(ParseException e1){
			    	valueCnt = false;
					valueMsg = "dlivyDte";
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
			
			else if(cols == 3){				
			}
			/* 자재 코드 */
			else if(cols == 4){
				
				if(value == null || value.equals("")){
					valueCnt = false;
					valueMsg = "mtrilCode";
				}
				
				if(value.length() > 8){
					valueCnt = false;
					valueMsg = "mtrilCode2";
				}
				
				resultDlivyVo.setMtrilCode(value);
				
			}
			/* 고객사 자재 코드 */
			else if(cols == 5){
				resultDlivyVo.setCtmmnyMtrilCode(value);
			}
			/* PO NO */
			else if(cols == 6){
				if(value.length() > 30){
					valueCnt = false;
					valueMsg = "poNo";						
				}
				resultDlivyVo.setPoNo(value);				
			}
			/* 자재 명 */
			else if(cols == 7){			
				resultDlivyVo.setMtrilNm(value);				
			}
			/* BATCH NO */
			else if(cols == 8){
				if(value == null || value.equals("")){
//					
//					valueCnt = false;
//					valueMsg = "batchNo";
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
			else if(cols == 9){
				resultDlivyVo.setDlivyQy(value);				
			}
			/* 단위 명 */
			else if(cols == 10){
				resultDlivyVo.setUnitNm(value);				
			}
			/* 출발시간 */
			else if(cols == 11){
				
				
			}
			/*도착시간*/
			else if(cols == 12){
				
			}
			/*전달사항*/
			else if(cols == 13){
				resultDlivyVo.setRm(value);
			}
			/* 수정사항 */
			else if(cols == 14){
				if(value == null || value.equals("")){
					valueCnt = true;
				}
				else{
					resultDlivyVo.setHour(value);
				}
			}
			//비고
			else if(cols == 15){
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
					}
					else{
						resultDlivyVo.setMinute(value);							 
						LocalTime dlivyHm = null;
						try{
							dlivyHm = LocalTime.of(Integer.valueOf(resultDlivyVo.getHour()), Integer.valueOf(value));	
						}catch(Exception e){
							valueCnt = false;
							valueMsg = "hourAndMin";
						}
						resultDlivyVo.setDlivyHm(hour+":"+minute);
						resultDlivyVo.setEmailSndngTm("40");
					}
				}
			}
			
			switch(valueMsg){
				case "mtrilCode" :
					resultMap.put("valueMsg", "자재 코드를 확인 해주세요. " + bachNoMsg);
					break;
				case "mtrilCode2" :
					resultMap.put("msg", "자재 코드가 8자리 이상입니다. ");
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
				case "poNo" :
					resultMap.put("valueMsg", "P/O No.는 30자까지만 입력하실 수 있습니다.");
					break;
				case "hourAndMin" :
					resultMap.put("valueMsg", "수정사항쪽의 시간, 분을 확인해주세요.");
					break;
			}		
			
			resultMap.put("valueCnt", valueCnt); //false 면 오류	
		}
		else{
			resultMap.put("valueCnt", true);
			
		}
		return resultMap;
	}
		
}
