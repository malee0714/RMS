package lims.test.service.Impl;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.test.dao.ResultInputMDao;
import lims.test.dao.ResultInputPscMDao;
import lims.test.service.ResultInputPscMService;
import lims.test.vo.ResultInputMVo;
import lims.test.vo.ResultInputPscMVo;
import lims.util.FasooExtract;

@Service("ResultInputPscMService")
public class ResultInputPscMServiceImpl implements ResultInputPscMService{

	@Autowired
	private ResultInputPscMDao resultInputPscMDao;
	
	@Autowired
	private ResultInputMDao resultinputMDao;
	
	/**
	 * 등록파일 업로드, 시험결과 저장
	 */
	@Override
	public HashMap<String, Object> paraUpload(MultipartHttpServletRequest request) {
		String paraType = String.valueOf(request.getParameter("paraType"));
		
		List<HashMap<String, String>> expriemList =  new ArrayList<HashMap<String, String>>(); // 엑셀에서 뽑아낸 시험항목 정보 리스트				
		List<HashMap<String, String>> resultRoaList = new ArrayList<HashMap<String, String>>(); //진행상황 ROA 여부 리스트		
		List<HashMap<String, String>> resultValueList = new ArrayList<HashMap<String, String>>(); //결과값 여부 리스트
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>(); //리턴해줄 hashmap
		
		int colCnt = 2;
		
		//오늘날짜
		SimpleDateFormat format = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
		Date _time = new Date();
		String time = format.format(_time);
		
		MultipartFile file = null;
		Workbook workbook = null;
		File convFile = null;
		
		try{
			
			//엑셀파일 읽어오기
			file = request.getFile("formFile");			
			
			convFile = new File(file.getOriginalFilename());
			file.transferTo(convFile);
			
			FasooExtract fasooExtract = new FasooExtract();
			fasooExtract.DoExtract(convFile.getAbsoluteFile().toString());
			
			//Workbook 로 해야 xls, xlsx 두개다 됨
			workbook = WorkbookFactory.create(convFile);
			Sheet sheet = workbook.getSheetAt(0); // 해당 엑셀파일의 시트(Sheet) 수
			 
			//시트 수
 			int rows = sheet.getPhysicalNumberOfRows();
 			
 			for (int rowIndex = 1; rowIndex < rows; rowIndex++) {//행 개수 만큼 루프 실행
 				
 				Row row = sheet.getRow(rowIndex); // 각 행을 읽어온다
 				
  				if (row != null) {//로우의 값이 널이 아닌지 체크
 					Cell cell = row.getCell(1);
 					
 					//엑셀에 블링크 들어가있음..
 					if(cell == null || cell.toString().trim().equals("")){
 						continue;
 					} 					
 					
 					//cell, colCnt 엑셀 분류에따라서 시작하는 cell 순서가 다름
 					for(int cellIndex=colCnt ; cellIndex<row.getLastCellNum()+1; cellIndex++){
 						
 						Cell cell2 = sheet.getRow(0).getCell(cellIndex);
 						
 						if(cell2 == null || cell2.toString().trim().equals("")){
 							continue;
 						}
 						
 						ResultInputPscMVo pscVo = new ResultInputPscMVo();
 						HashMap<String, String> expriemMap = new HashMap<String, String>(); //엑셀에서 뽑아낸 시험항목 정보
 						
 						//LOT ID
 						expriemMap.put("lotId", String.valueOf(sheet.getRow(0).getCell(cellIndex))); 						
 						//시험항목 명
 						expriemMap.put("expriemNm", row.getCell(0) + "_" + row.getCell(1)); 						
 						//결과 값
 						expriemMap.put("resultValue", String.valueOf(row.getCell(cellIndex)));
 						//qc 결과 값
 						expriemMap.put("qcResultValue", String.valueOf(row.getCell(cellIndex)));
 						
 						pscVo.setLotId(String.valueOf(sheet.getRow(0).getCell(cellIndex)));
 						pscVo.setExpriemNm(String.valueOf(row.getCell(0) + "_" + row.getCell(1)));
 						
 						//의뢰 시험항목 일련번호
 						pscVo.setReqestExpriemSeqno(resultInputPscMDao.getImReqestExpriemPsc(pscVo));
 						expriemMap.put("reqestExpriemSeqno", pscVo.getReqestExpriemSeqno());
 						
 						String reqestExpriem = resultInputPscMDao.getReqestExpriemPsc(pscVo);
 						
 						if(reqestExpriem != null && !reqestExpriem.equals("")){
 							expriemMap.put("reqestExpriemSeqnoAt", resultInputPscMDao.getReqestExpriemPsc(pscVo));
 						}
 						else{
 							expriemMap.put("reqestExpriemSeqnoAt", "error");
 						}
 						
 						 						
 						//Name + "_" + PARA <- 시험항목명 
 						expriemList.add(expriemMap);
 					} 					
 				}
 			}			
 			
			//엑셀에서 뽑아낸 시험항목 값 저장
 			for(int i=0; i<expriemList.size(); i++){
				ResultInputPscMVo resultInputMVo = new ResultInputPscMVo();
				ResultInputMVo rVo = new ResultInputMVo();
				//시험 항목명
				resultInputMVo.setExpriemNm(String.valueOf(expriemList.get(i).get("expriemNm")));
				//LOT ID
				resultInputMVo.setLotId(String.valueOf(expriemList.get(i).get("lotId")));				
				//시험항목 일련번호
				resultInputMVo.setReqestExpriemSeqno(String.valueOf(expriemList.get(i).get("reqestExpriemSeqno")));
				//결과값
				resultInputMVo.setResultValue(String.valueOf(expriemList.get(i).get("resultValue")));
				//QC 결과값
				resultInputMVo.setQcResultValue(String.valueOf(expriemList.get(i).get("qcResultValue")));
				
				//의뢰 진행상황 조회
				String sittnCode = resultInputPscMDao.getProgrsSittnCodePsc(resultInputMVo);
				HashMap<String, String> resultRoaMap = new HashMap<String, String>(); //진행상황 ROA 여부
				HashMap<String, String> resultValueMap = new HashMap<String, String>(); //결과값 여부
				
				if(sittnCode == null || sittnCode.equals("")){
					resultRoaMap.put("lotId", resultInputMVo.getLotId());
					resultRoaMap.put("msg", "유효하지 않은 LOT ID 입니다.");
					
					resultRoaList.add(resultRoaMap);
					continue;
				}
				
				if(resultInputMVo.getReqestExpriemSeqno() == null || resultInputMVo.getReqestExpriemSeqno().equals("null")){
					resultRoaMap.put("lotId", resultInputMVo.getLotId());
					resultRoaMap.put("msg", resultInputMVo.getExpriemNm() + " 항목은 "  +  "없는 시험항목 입니다.");
					
					resultRoaList.add(resultRoaMap);
					continue;
				}
				
				//ROA 부터 막음 IM03000004 ROA , IM03000005 COA 대기, IM03000006 COA 완료
				if(sittnCode.equals("IM03000004") || sittnCode.equals("IM03000005")|| sittnCode.equals("IM03000006")){
					
					
					resultRoaMap.put("lotId", resultInputMVo.getLotId());
					resultRoaMap.put("msg", "ROA Created");
					
					resultRoaList.add(resultRoaMap);
				}
				else{					
					//결과값이 NULL(Y) 일때  저장함 ROA 생성할때까지는 덮어서 저장해야 한다고함
					if(expriemList.get(i).get("reqestExpriemSeqnoAt").equals("Y") || expriemList.get(i).get("reqestExpriemSeqnoAt").equals("N")){
						
						//의뢰 시험항목 테이블 저장
						resultInputPscMDao.updReqestExpriemResultPsc(resultInputMVo);
						//의뢰 시험항목 평균 테이블 저장
						resultInputPscMDao.updReqestExpriemResultAvrgPsc(resultInputMVo);
						//의뢰 진행상황 업데이트
						resultInputPscMDao.updReqestExpriemProgrsPsc(resultInputMVo);
						
						rVo.setReqestExpriemSeqno(resultInputMVo.getReqestExpriemSeqno());
						rVo.setExprOdr("1");
//						resultinputMDao.insertMesInfo(rVo);
						
						resultValueMap.put("lotId", resultInputMVo.getLotId()); //LOT ID
						resultValueMap.put("expriemNm", resultInputMVo.getExpriemNm()); //시험항목
						resultValueMap.put("Date", time); //저장 시간
						resultValueMap.put("result", "정상"); //정상여부
						resultValueMap.put("ErrorMsg", ""); //에러 메시지
						
						resultValueList.add(resultValueMap);
					}
					else if(expriemList.get(i).get("reqestExpriemSeqnoAt").equals("error")){
						resultRoaMap.put("lotId", resultInputMVo.getLotId());
						resultRoaMap.put("msg", String.valueOf(expriemList.get(i).get("expriemNm")) + " 항목은 "  +  "없는 시험항목 입니다.");
						
						resultRoaList.add(resultRoaMap);
					}
					//값이 있을때는 저장안함
					else{
						resultValueMap.put("lotId", resultInputMVo.getLotId()); //LOT ID
						resultValueMap.put("expriemNm", resultInputMVo.getExpriemNm()); //시험항목
						resultValueMap.put("Date", time); //저장 시간
						resultValueMap.put("result", "오류"); //정상여부
						resultValueMap.put("ErrorMsg", "저장된 데이터가 있습니다."); //에러 메시지
						
						resultValueList.add(resultValueMap);
					}
					
				}
			}
			
			//ROA 오류
			List<HashMap<String, String>> _resultRoaList = new ArrayList<HashMap<String, String>>();
			
			//Roa 는 의로 기준이므로 중복 제거하여 출력한다.
			for( int i=0; i<resultRoaList.size(); i++){
				if(!_resultRoaList.contains(resultRoaList.get(i))){
					_resultRoaList.add(resultRoaList.get(i));
				}
			}
			
			resultMap.put("resultRoaList", _resultRoaList);
			//결과값 저장 여부
			resultMap.put("resultValueList", resultValueList);
			
			
		}catch(Exception e){
			e.getStackTrace();
			System.out.println(e);
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}finally {
			if(workbook != null){
				try {
					workbook.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(convFile != null){
				convFile.delete();
			}
			
		}
		
		return resultMap;
	}

}
