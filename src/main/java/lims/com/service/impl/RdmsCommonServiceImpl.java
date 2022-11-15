package lims.com.service.impl;

import lims.com.dao.RdmsCommonDao;
import lims.com.service.CommonService;
import lims.com.service.RdmsCommonService;
import lims.com.vo.RdmsMVo;
import lims.test.dao.ResultInputMDao;
import lims.util.CommonFunc;
import lims.util.CustomException;
import lims.util.ScriptEngineUtil;
import lims.util.enumMapper.EnumRDMS;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.omg.CosNaming.NamingContextPackage.NotFound;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import rdms.ca.dao.RdmsCAMDao;
import rdms.os.dao.RdmsOSMDao;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class RdmsCommonServiceImpl implements RdmsCommonService {
	
    private final RdmsCommonDao rdmsCommonDao;
	
    private final ResultInputMDao resultInputMDao;
    
    private final CommonFunc commonFunc;
	
	private final RdmsCAMDao rdmsMDao2;
	
	private final RdmsOSMDao rdmsMDao;

	private final ScriptEngineUtil scriptEngineUtil;
	
	@Autowired
	public RdmsCommonServiceImpl(RdmsCommonDao rdmsCommonDao, ResultInputMDao resultInputMDao, RdmsCAMDao rdmsMDao2, RdmsOSMDao rdmsMDao, CommonFunc commonFunc) {
		this.rdmsCommonDao = rdmsCommonDao;
		this.resultInputMDao = resultInputMDao;
		this.rdmsMDao = rdmsMDao;
		this.commonFunc = commonFunc;
		this.rdmsMDao2 = rdmsMDao2;

		scriptEngineUtil = new ScriptEngineUtil();
	}
	
	@Override
	public void getRdmsResultData(List<RdmsMVo> ls, String ip) {
		JSONParser parser = new JSONParser();
		System.out.println(">> : " + ls.get(0).getBinderItemValueA());
		System.out.println(">> : " + ls.get(0).getBinderItemValueB());
		//binderitemvalue_id 원본/복사본과 기기 일련번호가 없는건 로직을 걸러 버림.
		ls.stream()
		.filter(x -> !this.commonFunc.isEmpty(x.getBinderItemValueA()))
		.forEach(x -> {
			List<HashMap<String,Object>> data = new ArrayList<HashMap<String,Object>>();
			String bplcCode = rdmsCommonDao.getBplcCode(ip);

			if(bplcCode == null || bplcCode.equals(""))
				throw new CustomException(new NotFound(), bplcCode, "사업장을 찾을수 없습니다.");

			//BINDERITEMVALUE_ID로 RDMS에서 정보를 조회해 온다.
			Optional<EnumRDMS> rdms = EnumRDMS.findRdmsPL(bplcCode);
			if(rdms.isPresent()) {
				data = rdms.get().getRdmsResultData(x);
			}
			
			data.stream().findFirst()
			.ifPresent(y -> {
				try {

					//2번째 BINDER에서 올린것으로 판단해서 결과는 넣지 않고
					//BINDERITEMVALUE_ID만 복사본으로 수정하고 넘긴다.
					if("Excel".equals(y.get("EXCEL_AT"))){
						//컨버터에서 선택한 항목을찾아 해당 UPDT_BINDERITEMVALUE_ID를 BINDERITEMVALUEID_A값으로 변경한다.
						rdmsCommonDao.updtExcelUploadData(y);
					}else{
						y.put("BPLC_CODE", bplcCode);

						//사용 기기 저장
						rdmsCommonDao.insEqpmnOprSplore(y);

						String templateNm = y.get("TEMPLATE_NM").toString();

						//RDF의 LIST값을 담을 변수
						JSONArray rdmsData = new JSONArray();
						//RDF의 DATE값을 담을 변수
						JSONArray rdmsDt = new JSONArray();
						//RDF의 LOT_NO값을 담을 변수
						JSONArray rdmsLotNo = new JSONArray();
						//RDMS에서 추출된 항목들을 담을 변수
						List<HashMap<String,Object>> lstList = new ArrayList<HashMap<String,Object>>();
						//RDMS에서 추출된 날짜들을 담을 변수
						List<HashMap<String,Object>> lstDate = new ArrayList<HashMap<String,Object>>();
						//RDMS DATA SET할 변수
						List<HashMap<String,Object>> lstDb = new ArrayList<HashMap<String,Object>>();

						if(!this.commonFunc.isEmpty(y.get("RDMS_DATA")))
							rdmsData = (JSONArray)parser.parse(y.get("RDMS_DATA").toString());
						if(!this.commonFunc.isEmpty(y.get("RDMS_DT")))
							rdmsDt = (JSONArray)parser.parse(y.get("RDMS_DT").toString());
						if(!this.commonFunc.isEmpty(y.get("RDMS_LOT")))
							rdmsLotNo = (JSONArray)parser.parse(y.get("RDMS_LOT").toString());


						for(Object obj : rdmsData) {
							JSONObject iObj = (JSONObject) obj;
							HashMap<String,Object> rdmsMap = new HashMap<String,Object>();
							for(Object obj2 : iObj.keySet()) {
								rdmsMap.put(obj2.toString(), iObj.get(obj2));
							}
							lstList.add(rdmsMap);
						}

						for(Object obj : rdmsLotNo) {
							JSONObject inObj = (JSONObject)obj;
							if(inObj.containsKey("REQEST_NO")){
								HashMap<String, Object> rdmsMap = new HashMap<String, Object>();
								rdmsMap.put("NAME","REQEST_NO");
								rdmsMap.put("VALUE", String.valueOf(inObj.get("REQEST_NO")));
								rdmsMap.put("VALUE_UUID", String.valueOf(inObj.get("REQEST_NO_uuid")));
								rdmsMap.put("ORIGINAL_BINDER", y.get("ORIGINAL_BINDER"));
								rdmsMap.put("COPY_BINDER", y.get("COPY_BINDER"));
								rdmsMap.put("REQEST_EXPRIEM_SEQNO", y.get("REQEST_EXPRIEM_SEQNO"));
								rdmsMap.put("EXPR_NUMOT", y.get("EXPR_NUMOT"));
								rdmsMap.put("LOGIN_ID", y.get("LOGIN_ID"));
								rdmsMap.put("BPLC_CODE", bplcCode);
								lstDate.add(rdmsMap);
							}
						}

						for(Object obj : rdmsDt) {
							JSONObject iObj = (JSONObject) obj;
							HashMap<String,Object> rdmsMap = new HashMap<String,Object>();

							if(!this.commonFunc.isEmpty(iObj.get("Value"))) {
								rdmsMap.put("NAME", iObj.get("Name"));
								rdmsMap.put("VALUE", iObj.get("Value"));
								rdmsMap.put("VALUE_UUID", iObj.get("Value_uuid"));
								rdmsMap.put("ORIGINAL_BINDER", y.get("ORIGINAL_BINDER"));
								rdmsMap.put("COPY_BINDER", y.get("COPY_BINDER"));
								rdmsMap.put("REQEST_EXPRIEM_SEQNO", y.get("REQEST_EXPRIEM_SEQNO"));
								rdmsMap.put("EXPR_NUMOT", y.get("EXPR_NUMOT"));
								rdmsMap.put("LOGIN_ID", y.get("LOGIN_ID"));
								rdmsMap.put("BPLC_CODE", bplcCode);
								lstDate.add(rdmsMap);
							}
						}

						findTemplateData(y, lstList, templateNm)
						.ifPresent(template -> {
							//시험항목 및 결과 값 저장
							dataProxy(y, template, lstDate);
							//날짜 데이터 저장
							dateProxy(lstDate);
						});
					}


				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			});
		});
	}
  
	private void dateProxy(List<HashMap<String, Object>> lstDate) {
		
		lstDate.stream().findFirst().ifPresent(x -> {
			//기존에 등록된 날짜가 있을 수도 있기때문에 일단 시험항목의 데이터 전체 삭제한다.
			this.rdmsCommonDao.deleteRdmsDate(x);

			lstDate.stream().forEach(y -> {
				this.rdmsCommonDao.insRdmsDate(y);
			});
		});
	}

	/**
	 * 
	 * @param binderItem RDMS BINDERITEMVALUE 정보
	 * @param lstDb PDF에서 추출된 데이터
	 * @param lstDate PDF에서 추출된 날짜 및 LOT_NO 
	 */
	//데이터 저장 메소드
	private void dataProxy(HashMap<String, Object> binderItem, List<HashMap<String, Object>> lstDb, List<HashMap<String, Object>> lstDate) {
		
		lstDb.forEach(extractItem -> {
			HashMap<String, Object> item = new HashMap<String, Object>();
			//항목명으로 조회하기위해 항목명 넣어주기
			item = binderItem;
			item.put("EXPRIEM_NM", extractItem.get("RDMS_NM"));   
			item.put("REQEST_EXPRIEM_SEQNO", extractItem.get("REQEST_EXPRIEM_SEQNO"));
			item.put("RESULT_VALUE", extractItem.get("RESULT_VALUE"));
			item.put("RDMS_UUID", extractItem.get("RESULT_VALUE_UUID"));
			//lstDb에 담긴 항목들이 Lot No에 의뢰된 항목들인지 찾아서 데이터 넣어줘야함.
			List<HashMap<String, Object>> allExpriemList = this.rdmsCommonDao.getChkRdmsInfo(item);

			if(allExpriemList.size() > 0 ) {
				//계산식이 있는 시험항목 빼놓기
				List<HashMap<String,Object>> calcList = allExpriemList.stream()
								.filter(z -> !this.commonFunc.isEmpty(z.get("CALC_LAW_SEQNO")))
								.collect(Collectors.toList());
				
				if(calcList.size() > 0) {
					//계산식이 이미 등록된 시험항목들은 업데이트만 처주기 위해 따로 모음
					updateVriablExpriem(calcList);
				}
				
				//계산식이 없는 시험항목 뺴놓기
				List<HashMap<String,Object>> expriemList = allExpriemList.stream()
						.filter(z -> this.commonFunc.isEmpty(z.get("CALC_LAW_SEQNO")))
						.collect(Collectors.toList());

				if(expriemList.size() > 0) {
					//계산식이 없는 시험항목들은 마스터 계산식이 있으면 계산식 insert, 마스터 계산식 없으면 IM_REQEST_EXPRIEM_RESULT에 결과값 업데이트
					updateExpriem(expriemList);
				}



				//특정 템플릿은 (항목 : 날짜) 인 구조가 M:N으로 들어가는 경우가 있음. 그떄 여기를 태울거임
				if(binderItem.get("TEMPLATE_NM").equals("")) {
					
				}
			}else {
				List<HashMap<String,Object>> masterCalcList = this.rdmsCommonDao.getchkRdmsMasterCalcInfo(item);

				if(masterCalcList.size() > 0) {
					updateExpriem(masterCalcList);
				}
			}
			
			
		});
		
	}

	@Override
	public int updateCloseCnvt(RdmsMVo vo) {
		return rdmsMDao.updateCloseCnvt(vo);
	}
	  
	@Override
	public int delBinderChck(List<RdmsMVo> vo) {
		int num = 0;
		for(int i = 0; i < vo.size(); i++) {
			if(vo.get(i).getBinderItemValue() != null && !vo.get(i).getBinderItemValue().equals("")) {
				num += rdmsCommonDao.delBinderChck(vo.get(i));
			}
		}
		return num;
	}
	
	@Override
	public Integer delRdmsResultData(List<RdmsMVo> vo) {
		int returns=0;
		for(int i=0; i<vo.size(); i ++){
			vo.get(i).setBinderItemValue(vo.get(i).getBinderitemvalueId());
			Optional<EnumRDMS> rdms = EnumRDMS.findRdmsPL(vo.get(i).getBplcCode());
			if(rdms.isPresent()) {
				rdms.get().delRdmsResultData(vo.get(i));
				returns +=rdmsCommonDao.delBinderChck(vo.get(i));
			}

		}
		return returns;
		
	}
	
	//-------------------- 메소드 모음 ---------------------//

	private void nomfrmCnCalc(HashMap<String, Object> expriem) {
		//계산식으로 결과값을 계산하기 위해 저장된 변수들 조회해온다.
		List<HashMap<String,Object>> calcList = this.rdmsCommonDao.getCalcLawInfo(expriem);
		int cnt = 0;
		if(calcList.size() > 0) {
			HashMap<String,Object> calc = calcList.get(0);
			
			//변수들과 변수 값을 replace하여 사용할 계산식 변수
			String nomfrmCn = calc.get("NOMFRM_CN").toString();
			String markCphr = (calc.get("VRIABL_ID").equals("MASTER_VRIABL_ID")) ? calc.get("MARK_CPHR").toString() :  "4";
			//계산식 변수들을 결과값으로 계산식에 replace친다.
			
			for(HashMap<String,Object> map : calcList) {
				if(!this.commonFunc.isEmpty(map.get("VRIABL_VALUE"))) {
					cnt ++;
					nomfrmCn = nomfrmCn.replaceAll(map.get("VRIABL_ID").toString(), "("+map.get("VRIABL_VALUE").toString() + " + "+ scriptEngineUtil.epcilon() + ")");
				}
			}
			
			//총 변수의 개수와 결과값이 있는 변수의 개수가 일치하면 계산을 실시한다.
			//일치하지않는데 계산시 오류 발생함.
			if(cnt == calcList.size()) {
				expriem.put("RESULT_VALUE", scriptEngineUtil.round(nomfrmCn, markCphr));
				this.rdmsCommonDao.updateResultValue(expriem);
			}
		}
		
	}

	private void updateVriablExpriem(List<HashMap<String, Object>> calcList) {
		calcList.forEach(calcInfo -> {
			this.rdmsCommonDao.updateCalcInfo(calcInfo);
			
			nomfrmCnCalc(calcInfo);
		});
	}

	//계산식이 없는 시험항목들은 마스터 계산식이 있으면 계산식 insert, 마스터 계산식 없으면 IM_REQEST_EXPRIEM_RESULT에 결과값 업데이트
	private void updateExpriem(List<HashMap<String, Object>> expriemList) {
		expriemList.forEach(expriem -> {
			List<HashMap<String,Object>> masterInfo = this.rdmsCommonDao.getPrductCalcSeqno(expriem);
			HashMap<String, Object> info = new HashMap<String,Object>(); 
			//마스터 계산식이 있는 경우는 마스터 계산식을 insert해준다.
			if(masterInfo.size() > 0) {
				info = masterInfo.get(0);
				
				masterInfo.forEach(y -> {
					//계산식 변수와 RAW DATA에서 추출해온 시험항목명이 같으면 결과 값을 넣어준다.
					if(expriem.get("EXPRIEM_NM").equals(y.get("VRIABL_NM"))) {
						y.put("RESULT_VALUE", expriem.get("RESULT_VALUE"));  
						y.put("RDMS_UUID", expriem.get("RDMS_UUID"));
						y.put("ORIGINAL_BINDER", expriem.get("ORIGINAL_BINDER"));
						y.put("COPY_BINDER", expriem.get("COPY_BINDER"));
					}
					
					insertMasterCalcInfo(y);
				});
				
				
				this.rdmsCommonDao.updateCalcLawSeqno(info);
				
				nomfrmCnCalc(expriem);
			}else {
				//마스터 계산식이 없을때
				this.rdmsCommonDao.updRdmsData(expriem);
			}
		});
	}

	//마스터에 계산식이 존재 할경우 
	private void insertMasterCalcInfo(HashMap<String, Object> mtrcalcMap) {
		
			//계산식 변수 insert
			this.rdmsCommonDao.insRdmsCalData(mtrcalcMap);
	}

	//----------- 템플릿 별 데이터 추출 메소드 모음 -----------------//
	private Optional<List<HashMap<String,Object>>> findTemplateData(HashMap<String, Object> y, List<HashMap<String, Object>> lstList, String templateNm) {
		System.out.println(">>> : " +  templateNm);
		switch (templateNm) {
		case "BID":
			return Optional.ofNullable(name_conc(lstList));
		case "DID":
			return Optional.ofNullable(name_amountP(lstList));
		case "FID, PDD, TCD":
			return Optional.ofNullable(name_amount(lstList));
		/*case "Halo, Aquavolt":
			return Optional.ofNullable(name_Area(lstList));*/
		case "IC":
			return Optional.ofNullable(name_amount(lstList));
		default:
			return Optional.ofNullable(null);
		}
	}

	private List<HashMap<String,Object>> name_amount(List<HashMap<String, Object>> lstList) {
		List<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		lstList.forEach(item -> {
			if(item.containsKey("Name") && item.containsKey("Amount")
					&& (!this.commonFunc.isEmpty(item.get("Name")) && !this.commonFunc.isEmpty(item.get("Amount")))) {
				HashMap<String,Object> map = new HashMap<String,Object>();
				map.put("RDMS_NM", item.get("Name"));
				map.put("RESULT_VALUE", item.get("Amount"));//결과값
				map.put("RESULT_VALUE_UUID", item.get("Amount_uuid"));//결과값 UUID
				list.add(map);
			}
		});

		return list;
	}

	private List<HashMap<String,Object>> name_amountP(List<HashMap<String, Object>> lstList) {
		List<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		lstList.forEach(item -> {
			if(item.containsKey("Name") && item.containsKey("Amount%")
					&& (!this.commonFunc.isEmpty(item.get("Name")) && !this.commonFunc.isEmpty(item.get("Amount%")))) {
				HashMap<String,Object> map = new HashMap<String,Object>();
				map.put("RDMS_NM", item.get("Name"));
				map.put("RESULT_VALUE", item.get("Amount%"));//결과값
				map.put("RESULT_VALUE_UUID", item.get("Amount%_uuid"));//결과값 UUID
				list.add(map);
			}
		});

		return list;
	}

	private List<HashMap<String,Object>> name_conc(List<HashMap<String, Object>> lstList) {
		List<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		lstList.forEach(item -> {
			if(item.containsKey("Name") && item.containsKey("Conc.")
					&& (!this.commonFunc.isEmpty(item.get("Name")) && !this.commonFunc.isEmpty(item.get("Conc.")))) {
				HashMap<String,Object> map = new HashMap<String,Object>();
				map.put("RDMS_NM", item.get("Name"));
				map.put("RESULT_VALUE", item.get("Conc."));//결과값
				map.put("RESULT_VALUE_UUID", item.get("Conc._uuid"));//결과값 UUID
				list.add(map);
			}
		});
		return list;
	}


	private List<HashMap<String,Object>> title_mean(List<HashMap<String, Object>> lstList) {
		List<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		lstList.forEach(item -> {
			if(item.containsKey("Mean") && item.containsKey("Result Title")
					&& (!this.commonFunc.isEmpty(item.get("Mean")) && !this.commonFunc.isEmpty(item.get("Result Title")))) {
				HashMap<String,Object> map = new HashMap<String,Object>();
				map.put("RDMS_NM", item.get("Result Title"));
				map.put("RESULT_VALUE", item.get("Mean"));//결과값
				map.put("RESULT_VALUE_UUID", item.get("Mean_uuid"));//결과값 UUID
				list.add(map);
			}
		});

		return list;
	}
}
