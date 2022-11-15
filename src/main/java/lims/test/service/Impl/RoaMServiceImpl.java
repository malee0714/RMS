package lims.test.service.Impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lims.com.dao.CommonDao;
import lims.com.service.CommonService;
import lims.com.vo.AuditVo;
import lims.com.vo.RdmsMVo;
import lims.spc.enm.ResultValueType;
import lims.spc.service.SpcRuleTestService;
import lims.spc.vo.SpcMtrilExpriem;
import lims.spc.vo.SpcParam;
import lims.spc.vo.SpcRuleTestDto;
import lims.test.dao.ResultInputMDao;
import lims.test.dao.RoaMDao;
import lims.test.service.RoaMService;
import lims.test.vo.ResultInputMVo;
import lims.test.vo.RoaMSubVo;
import lims.test.vo.RoaMVo;
import lims.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import java.io.*;
import java.math.BigDecimal;
import java.net.*;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class RoaMServiceImpl implements RoaMService{

	private final RoaMDao roaMDao;
	private final CommonDao commonDao;
	private final CommonFunc commonFunc;
	private final ResultInputMDao resultInputMDao;
	private final SpcRuleTestService spcRuleTestService;
	private final CommonService commonService;

//	//JS ENGINE 호출
	private ScriptEngineUtil seu = null;
    
	
    @Autowired
	public RoaMServiceImpl(RoaMDao roaMDao, CommonDao commonDao, CommonFunc commonFunc, ResultInputMDao resultInputMDao, SpcRuleTestService spcRuleTestServiceImpl, CommonService commonServiceImpl) {
		this.roaMDao = roaMDao;
		this.commonDao = commonDao;
		this.commonFunc = commonFunc;
		this.resultInputMDao = resultInputMDao;
		this.spcRuleTestService = spcRuleTestServiceImpl;
		this.commonService = commonServiceImpl;
		
		seu = new ScriptEngineUtil();
	}

	@Override
	public List<RoaMVo> roaList(RoaMVo vo) {
		return roaMDao.roaList(vo);
	}

	@Override
	public List<RoaMVo> resultRegisterUserList() {
		return roaMDao.resultRegisterUserList();
	}
	

	@Override
	public List<RoaMVo> getEntrpsList(RoaMVo vo) {
		return roaMDao.getEntrpsList(vo);
	}

	@Override
	public List<RoaMVo> getUpperLotList(RoaMVo vo) {
		return roaMDao.getUpperLotList(vo);
	}


	@Override
	public List<RoaMVo> getReqList(RoaMVo vo) {
		GetUserSession sessionD = new GetUserSession();
		//vo.setAuthorSeCode(sessionD.getAuthorSeCode());
		return roaMDao.getReqList(vo);
	}
	

	@Override
	public Void updRoaData(List<RoaMVo> list) {
		//return 해줄 변수
		HashMap<String, Object> resultMap = new HashMap<String,Object>();
		//binderitemvalue_id만 모아놧다가 마지막에 distinct 처서 중복제거 할거임
		List<String> binderArr = new ArrayList<String>();
		//rdms에 QC_RESULT_VALUE, UPDT_RDMS_DOC_NO, RDMS_UUID 값을 모아서 던져주기 위한 변수
		List<RdmsMVo> rdmsList = new ArrayList<RdmsMVo>();
		List<RoaMSubVo> sendRdmsList = new ArrayList<RoaMSubVo>();

		RoaMVo firstVo = list.get(0);

		checkReqestProGrs(firstVo, new String[]{"IM03000004"});

		for(RoaMVo vo : list) {
			//시험항목 결과 업데이트치기
			this.roaMDao.updRoaResultData(vo);

			//계산식에 역산있는 항목은 역산 로직 실행
			if(!this.commonFunc.isEmpty(vo.getCalcLawSeqno())) {
				//역산식 계산 하기
				Optional<RdmsMVo> rdms = rvsopProxy(vo);
				
				//NULL이 아닐때만 돌기 위한 IF문과 같은 기능
				rdms.ifPresent(x -> {
					//역산 계산한 값을 역산 변수로 지정된 변수 값으로 엎어 친다.
					vo.setUpdtResultValue(x.getChangeVal());
					//역산식 계산된 값으로 IM_REQEST_EXPRIEM_VRIABL테이블에 QC_RESULT_VALUE 업데이트 치기
					this.roaMDao.updtRvsopVriablValue(vo);
					this.commonFunc.auditTrail("CM03000008", "ROA 역산 결과 저장", vo.getReqestSeqno(), vo.getReqestExpriemSeqno(), vo.getExpriemSeqno(), vo.getExprOdr(), vo.getBplcCode(), vo.getVriablId(), null, null);


					if(!this.commonFunc.isEmpty(x.getBinderitemvalueId())) {
						binderArr.add(x.getBinderitemvalueId());
						rdmsList.add(x);
					}
				});
			}else if(!this.commonFunc.isEmpty(vo.getRdmsDocNo())){//계산식 없이 결과를 가지는 시험항목에 RDMS DATA SET
				if(!this.commonFunc.isEmpty(vo.getUpdtRdmsDocNo())) {
					
					RdmsMVo rdmsMVo = new RdmsMVo();
					
					binderArr.add(vo.getUpdtRdmsDocNo());
					rdmsMVo.setBinderitemvalueId(vo.getUpdtRdmsDocNo());
					rdmsMVo.setUuid(vo.getRdmsUuid());
					rdmsMVo.setChangeVal(vo.getResultValue());
					rdmsList.add(rdmsMVo);
				}
			}

			//시험항목 정보 업데이트치기
			this.roaMDao.updRoaData(vo);
			//---로그 남기기
			this.commonFunc.auditTrail("CM03000008", "ROA 저장", vo.getReqestSeqno(), vo.getReqestExpriemSeqno(), vo.getExpriemSeqno(), vo.getExprOdr(), vo.getBplcCode(), null, null, null);
		}

		this.roaMDao.updReqFailAt(firstVo);

		if(binderArr.size() > 0 && rdmsList.size() > 0) {
			sendRdmsList = settingRdmsData(binderArr, rdmsList);
			sendRdmsData(sendRdmsList, firstVo); //RDMS에 RAWDATA 수정 데이터 전송 메서드
		}

		return null;
	}

	
	@Override
	public Map<String, Object> resultOfAnalysisGenerator_aka_genRoa(RoaMVo vo) {
		// RETURN할녀석
		Map<String, Object> map = new HashMap<String, Object>();

		ResultInputMVo rv = new ResultInputMVo();
		rv.setReqestSeqno(vo.getReqestSeqno());
		
		checkReqestProGrs(vo, new String[]{"IM03000004"});

		//ROA 결과입력한거 가져옴
		List<RoaMVo> list = roaList(vo);

		// list 가 null이 아닐때만 한다.
		if(list != null){
			List<HashMap<String, Object>> failList = new ArrayList<>();
			HashMap<String, Object> failItem = new HashMap<String, Object>();

			//자재시퀀스 lotNo

			list.stream().peek(System.out::println).forEach(x -> {

				SpcRuleTestDto spcRuleTestDto = SpcRuleTestDto
						.builder()
						.inspctTyCode(x.getInspctTyCode()) //검사유형
						.entrpsSeqno(x.getEntrpsSeqno()) //업체 일련번호
						.reqestSeqno(x.getReqestSeqno())
						.qc(true)
						.build();

				SpcMtrilExpriem spcMtrilExpriem = SpcMtrilExpriem.builder()
						.mtrilSeqno(x.getMtrilSeqno()) //자재 일련번호
						.mtrilSdspcSeqno(x.getMtrilSdspcSeqno()) //기준규격일련번호
						.build();

				SpcParam spcParam = SpcParam
						.builder()
						.spcRuleTestDto(spcRuleTestDto)
						.spcMtrilExpriem(spcMtrilExpriem)
						.resultValueType(ResultValueType.RESULT_VALUE)
						.build();

				Optional<SpcRuleTestDto> spcRule = this.spcRuleTestService.resultValueSpcTest(spcParam);

				spcRule.ifPresent(y -> {
					failItem.put("expriemNm", y.getExpriemNm()); //시험항목 명
					failItem.put("failRule", y.getRuleName()); //실패 룰

					failList.add(failItem);
				});
			});

			if(failList.size() > 0){
				map.put("flag", "fail");
				map.put("failList", failList);
			}
		}

		//맵이 비어있는가? 안 비어있으면 검증실패한놈이 들어있는것임.
		if(!map.isEmpty() && "fail".equals(map.get("flag"))){
			// 실패한 시험항목 넣어뒀던거 로직 끝내고 보내버림
			return map;
		} else{
			genRoa(vo);
			return map;
		}
	}

	//ROA대기 -> COA대기로 진행상황을 넘긴다.
	@Override
	public void genRoa(RoaMVo vo){
		//접수 상태  coa 대기로 바꿈
		this.roaMDao.genRoa(vo);

		//셤항목 전부다 coa대기로 만듬
		roaMDao.genRoaExpriem(vo);
		this.commonFunc.auditTrail("CM03000008", "ROA대기 -> COA대기", vo.getReqestSeqno(), null, null, null, vo.getBplcCode(), null, null, null);

	}


	@Override
	public List<RoaMVo> getLotChartList(RoaMVo vo) {
		return roaMDao.getLotChartList(vo);
	}

	@Override
	public List<RoaMVo> getRdmsDateList(RoaMVo vo) {
		return roaMDao.getRdmsDateList(vo);
	}

	@Override
	public HashMap<String,Object> setChangeNowData(RoaMVo vo) {

		HashMap<String,Object> resultMap = new HashMap<String,Object>();

		//업데이트칠 분기 부분
		int insPosition = 0;

		//현재 의뢰값으로 최신화된 마스터 데이터 가져왔음 1,2차 규격, 오차범위, 등등등 포함해서 가져옴
		List<RoaMVo> prductSdspcList = roaMDao.getPrductSdspcList(vo);
		//현재 의뢰값으로 의뢰된 1,2차규격 오차범위등등을 똑같이 가져옴
		List<RoaMVo> reqestExpriemList = roaMDao.getReqestExpriemList(vo);

		//이미 등록된 시험항목의 기준규격 정보만 업데이트
		prductSdspcList.stream().forEach(x -> {
			reqestExpriemList.stream()
			.filter(y -> x.getMtrilSdspcSeqno().equals(y.getMtrilSdspcSeqno()))
			.forEach(y -> {
				y.setFlag("N");
				x.setFlag("N");
				roaMDao.updReqestExpriem(x);
				this.commonFunc.auditTrail("CM03000008", "기준규격 동기화(데이터 수정)", y.getReqestSeqno(), y.getReqestExpriemSeqno(), y.getExpriemSeqno(), null, y.getBplcCode(), null, null, null);
			});
		});
		
		//추가된건 추가
		prductSdspcList.stream()
			.filter(x -> x.getFlag().startsWith("Y"))
			.forEach(x -> {
				
				this.roaMDao.insReqestExpriem(x);
				
				this.roaMDao.insReqestExpriemResult(x);

//				this.roaMDao.insResultAvrg(x);
					
			});
		
		reqestExpriemList.stream()
		.filter(x -> x.getFlag().startsWith("Y"))
		.forEach(x -> {
			roaMDao.delReqestExpriem(x);
			this.commonFunc.auditTrail("CM03000008", "기준규격 동기화(데이터 삭제)", x.getReqestSeqno(), x.getReqestExpriemSeqno(), x.getExpriemSeqno(), null, x.getBplcCode(), null, null, null);
		});
		
		
		//진행상황 업데이트하기.
		roaMDao.updExpriemProgrs(vo);
		this.commonFunc.auditTrail("CM03000008", "ROA 진행상황 변경", vo.getReqestSeqno(), vo.getReqestExpriemSeqno(), vo.getExpriemSeqno(), null, vo.getBplcCode(), null, null, null);
		
		//추가된 내역이 있는지 체크(추가된 항목이 있으면 진행상황이 변경되어 알림을 주기 위함)
		insPosition = (int) prductSdspcList.stream()
				.filter(x -> x.getFlag().equals("Y")).count();

		resultMap.put("insPosition", insPosition);
		return resultMap;
	}

	@Override
	public Map<String, Object> getRealAnalsData(RoaMVo vo) {
		return roaMDao.getRealAnalsData(vo);
	}

	@Override
	public List<RoaMVo> getRoaEditHistList(RoaMVo vo) {
		return roaMDao.getRoaEditHistList(vo);
	}


	@Override
	public HashMap<String,Object> updRdmsDate(List<RoaMVo> vo) {
		List<String> binderArr = new ArrayList<String>();
		List<RdmsMVo> rdmsList = new ArrayList<RdmsMVo>();
		List<RoaMSubVo> sendRdmsList = new ArrayList<RoaMSubVo>();
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		
		Optional<RoaMVo> firstVo = vo.stream().findFirst();
		
		checkReqestProGrs(firstVo.get(), new String[]{"IM03000004", "IM03000005"});

		vo.forEach(x -> {
			RdmsMVo rdmsMVo = new RdmsMVo();
			//날짜 수정
			this.roaMDao.updRdmsDate(x);
			//-----로그
			this.commonFunc.auditTrail("CM03000008", "ROA 날짜 변경", x.getReqestSeqno(), x.getReqestExpriemSeqno(), x.getExpriemSeqno(), x.getNo(), x.getBplcCode(), null, null, null);
			
			//RDMS_DOC_NO있는것만 추려서 데이터셋 만들기
			binderArr.add(x.getUpdtRdmsDocNo());
			rdmsMVo.setUuid(x.getRdmsUuid());
			rdmsMVo.setChangeVal(x.getQcResultValue());
			rdmsMVo.setBinderitemvalueId(x.getUpdtRdmsDocNo());
			rdmsList.add(rdmsMVo);
		});
		
		sendRdmsList = settingRdmsData(binderArr, rdmsList);
		sendRdmsData(sendRdmsList, firstVo.get());
		
		resultMap.put("success", 1);
		resultMap.put("msg", "저장되었습니다.");
		
		return resultMap;
	}

	private void checkReqestProGrs(RoaMVo firstVo, String[] value) {

		String progrsSittn = this.resultInputMDao.checkReqestProGrs(firstVo);
		System.out.println(">>> : " + progrsSittn);
		if(Arrays.stream(value)
				.filter(filter -> filter.equals(progrsSittn))
				.collect(Collectors.toList())
				.isEmpty()){
			throw new CustomMessageException("진행상황을 확인해주세요");
		};
	}

	@Override
	public void setRoaRollback(List<RoaMVo> vo) {
		if(vo != null) {
			for(RoaMVo ivo : vo) {
				
				checkReqestProGrs(ivo, new String[]{"IM03000005"});

				roaMDao.setRoaRollback(ivo);
				this.commonFunc.auditTrail("CM03000008", "ROA 되돌리기", ivo.getReqestSeqno(), null,null, null, ivo.getBplcCode(), null, null, null);
			}
		}

	}

	//-------------------------------------------------------------------------------
	//							사용 메소드 모음
	//-------------------------------------------------------------------------------
	
	
	
	public List<RoaMSubVo> settingRdmsData(List<String> binderArr, List<RdmsMVo> rdmsList){
		
		/* RDMS DATA SET EXAMPLE
		 * {
				"binderitemvalue_id":"0000002184",
				"valueinfo":[
					{
						"uuid":"D131_시험결과_Conc. Mean_32",
						"change_val":"-0.00000"
					},
					{
						"uuid":"D135_시험결과_Conc. Mean_33",
						"change_val":"-Infinity"
					}
				]
			},
			{
				"binderitemvalue_id":"0000038830",
				"valueinfo":[
					{
						"uuid":"D78_시험결과_Conc. Mean_15",
						"change_val":"1554.000"
					}
				]
			},
		 * 
		 * */
		
		List<RoaMSubVo> resultList = new ArrayList<RoaMSubVo>();
		//위 주석과 같이 데이터를 세팅해서 RDMS에 던져 줘야됨.
		/*
		 * binderArr : RDMS_DOC_NO만 모아 놓은 Array
		 * rdmsList : 수정된 값과 RAW DATA에 위치 값(UUID)를 담고 있는 Array
		 * 
		 * - 같은 RDMS_DOC_NO(Binderitemvalue_id)들을 모아 (binderitemvalue_id) 1 : (change_val, uuid) N 구조로 만들어주기 위한 로직
		 * 
		 * */
		binderArr.stream().distinct().forEach(binder -> {
			RoaMSubVo binderVo = new RoaMSubVo();
			List<RoaMSubVo> valueInfo = new ArrayList<RoaMSubVo>();
			binderVo.setBinderitemvalue_id(binder);
			rdmsList.stream()
				.filter(x -> binder.equals(x.getBinderitemvalueId()))
				.forEach(x -> {
					RoaMSubVo valueSubInfo = new RoaMSubVo();
					
					valueSubInfo.setUuid(x.getUuid());
					valueSubInfo.setChange_val(x.getChangeVal());
					valueInfo.add(valueSubInfo);
					
				});
			
			if(valueInfo.size() > 0) {
				binderVo.setValueinfo(valueInfo);
				resultList.add(binderVo);
			}
		});
		
		return resultList;
	}
	
	//역산식 계산
	private Optional<RdmsMVo> rvsopProxy(RoaMVo resultData) {
		//역산 수식
		String rvsopCn = resultData.getRvsopCn();
		//소수점 표기 자리수
		String markCphr = (this.commonFunc.isEmpty(resultData.getMarkCphr()))? "4" : resultData.getMarkCphr();
		//시험항목에 등록된 계산식 변수 조회
		List<RoaMVo> list = this.roaMDao.getCalcInfo(resultData);
		//화면에서 사용자가 등록한 결과값
		String resultValue = resultData.getResultValue();
		//return할 변수
		RdmsMVo rdmsMVo = null;

		//시험항목에 등록된 계산식 변수가 있는지 체크
		if(list.size() > 0){
			//랜덤값을 적용할지 여부(Y값이면 결과값에 랜덤함수를 더해서 값을 매끄럽게 만들기 위함)
			String randomAt = list.get(0).getRvsopCphrRandomCreatAt();

			//Y일때 랜덤함수 적용
			if(!this.commonFunc.isEmpty(randomAt) && randomAt.equals("Y")) {
				resultValue = randomCheck(resultValue, markCphr);
			}

			//(A00 / A01) 결과값은 A00변수와 REPLACE
			rvsopCn = rvsopCn.replaceAll("A00", "("+resultValue + "+" + seu.epcilon() + ")");

			//값이 있는 변수가 몇개인지 구하기
			int calcCnt = (int) list.stream().filter(x -> !this.commonFunc.isEmpty(x.getQcVriablValue())).count();

			//계산식 변수의 개수와 값이 있는 변수의 수가 같으면 모두 입력된것으로 판단하고 역산식을 계산함.
			if(list.size() == calcCnt) {
				rdmsMVo = new RdmsMVo();

				//변수id에 맞는 결과값으로 치환
				for(int i = 0; i < list.size(); i++) {
					RoaMVo vo = list.get(i);
					//QC_VRIABL_VALUE값이 있으면 변수와 치환
					if(!this.commonFunc.isEmpty(vo.getQcVriablValue()))
						rvsopCn = rvsopCn.replace(vo.getVriablId(), "("+vo.getQcVriablValue() + "+"+ seu.epcilon() + ")");
				}

				//javascript engine을 이용하여 replace한 계산식을 계산시킨다.
				resultValue = seu.round(rvsopCn, markCphr);

				//rdms doc no가 있으면 rdms 결과를 보내줘야해서 데이터 세팅
				for(int i = 0; i < list.size(); i++) {
					RoaMVo vo = list.get(i);

					//UPDT_RDMS_DOC_NO가 값이 있으면 RDMS로 들어온 값임으로 결과값을 다시 RDMS에 보내주기 위해 값 세팅
					if(!this.commonFunc.isEmpty(vo.getUpdtRdmsDocNo()) && vo.getVriablId().equals(resultData.getVriablId())) {
						rdmsMVo.setBinderitemvalueId(vo.getUpdtRdmsDocNo());
						rdmsMVo.setUuid(vo.getRdmsUuid());
					}
				}

				rdmsMVo.setChangeVal(resultValue);
			}
		};
		return Optional.ofNullable(rdmsMVo);
	}


	private String randomCheck(String resultValue, String markCphr) {
		String[] strArr = resultValue.split("\\.");
		String result = "";
		if(strArr.length > 1 ) {
			int dotLen = strArr[1].length();
			//랜덤함수가 길게 나오면 값이 지수로 표현되서 제대로된 소수점 계산이 안됨.(꼭 bigdecimal사용 해야함)
			BigDecimal random = new BigDecimal(Math.abs((Math.random()-0.5)/Math.pow(10, dotLen)));
			//roa입력 결과값과 랜덤함수의 값을 더함.
			result = random.add(new BigDecimal(resultValue)).toString();
		}else {//소수점이 없으면(정수이면).
			//랜덤함수가 길게 나오면 값이 지수로 표현되서 제대로된 소수점 계산이 안됨.(꼭 bigdecimal사용 해야함)
			BigDecimal random = new BigDecimal(Math.abs((Math.random()-0.5)));
			//roa입력 결과값과 랜덤함수의 값을 더함.
			result = random.add(new BigDecimal(resultValue)).toString();
		}
		
		return result;
	}

	private void sendRdmsData(List<RoaMSubVo> sendRdmsList, RoaMVo vo) {
		ObjectMapper mapper = new ObjectMapper();
		
		HttpURLConnection conn = null;
		BufferedReader br = null;
		
		StringBuffer sb = null;
		String line = null;
		
		String resultStr = "";
		
		//RDMS랑 통신 결과 값
		int code = 0;
		
		try {
			//List<RoaSubVo> 형태를 ObjectMapper가 String으로 형변환을 쉽게 도와준다.
			resultStr = mapper.writeValueAsString(sendRdmsList);
			//URLEncoder.encode : 암호화된 값으로 변경해준다.
			String json = URLEncoder.encode(resultStr,"UTF-8");
			json = "rawdataInfo=" + json;

			String bplcAddress = roaMDao.getBplcAddress(vo);

			URL url = new URL("http://203.229.218.224:23002/RDMSWS/RDMSWS.asmx/ChangeRawData");
//			URL url = new URL("http://"+ bplcAddress +":23002/RDMSWS/RDMSWS.asmx/ChangeRawData");
			conn = (HttpURLConnection)url.openConnection();
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded");
			conn.setRequestMethod("POST");
			conn.setDoInput(true);
			conn.setDoOutput(true);
			conn.setFixedLengthStreamingMode(json.getBytes().length);
			
			PrintWriter printWriter = new PrintWriter(conn.getOutputStream());
			printWriter.print(json);
			printWriter.close();
			
			conn.connect();
			
			code = conn.getResponseCode();
			
			
			if(code != 200) {
				//아예 트랜잭션 빠꾸먹이게 다털어버림
				throw new RuntimeException();
			}
			
			sb = new StringBuffer();
			
			br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			
			while((line = br.readLine()) != null) {
				sb.append(line + "\n");
			}
			
			//--오딧 남기기
			AuditVo evo = new AuditVo();

			evo.setReqestSeqno(vo.getReqestSeqno());
			evo.setRoaDataCn(" HTTP CODE : " + code + "\n" + resultStr);
			evo.setErrorAt("N");
//			this.commonService.insertRoaAudit(evo);
			this.commonFunc.auditTrail("CM03000008", "RDMS 수정", vo.getReqestSeqno(), null, null, null, null, resultStr, null, null);
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		catch(ConnectException e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			throw new CustomException(e, "♥♥ HTTP CODE : " + code + "\n" + resultStr);
		}
		catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		catch (MalformedURLException e) {
			e.printStackTrace();
		}
		catch (IOException e) {
			e.printStackTrace();
		} finally {
			if(conn != null)
				conn.disconnect();  
			
			try {
				if(br != null)
					br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

}
