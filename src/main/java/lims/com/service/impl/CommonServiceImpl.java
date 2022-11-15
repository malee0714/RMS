package lims.com.service.impl;

import com.itextpdf.text.Document;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfImportedPage;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfWriter;
import lims.com.dao.CommonDao;
import lims.com.service.CommonService;
import lims.com.vo.*;
import lims.dly.vo.DlivyMVo;
import lims.qa.vo.DocDto;
import lims.qa.vo.QlityDocHistVo;
import lims.req.vo.ReceiptManageDto;
import lims.rsc.vo.*;
import lims.sys.vo.*;
import lims.test.vo.IssueMVo;
import lims.test.vo.ResultInputMVo;
import lims.util.CommonFunc;
import lims.util.CustomException;
import lims.util.enumMapper.EnumRDMS;
import lims.wrk.vo.*;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import rdms.os.dao.RdmsOSMDao;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Pattern;

@Service
public class CommonServiceImpl implements CommonService {

	private final CommonDao commonDao;

	private final CommonFunc commonFunc;

	private final RdmsOSMDao rdmsMDao;

	@Autowired
	public CommonServiceImpl(CommonDao commonDao, CommonFunc commonFunc, RdmsOSMDao rdmsMDao) {
		this.commonDao = commonDao;
		this.commonFunc = commonFunc;
		this.rdmsMDao = rdmsMDao;
	}

	/**
	 * SY_SYS_MANGE 시스템관리 table의 모든 column 조회
	 */
	@Override
	public SysManageVo getSystemRule() {
		return commonDao.getSystemRule();
	}

	@Override
	public UserMVo getAuth() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(request);		// 현재 세션 사용자
		String menuCd = commonFunc.getRequestMenuCd(request);	// 현재 메뉴코드

		userMVo.setReqUrlParam((menuCd != null ? menuCd.toString() : null));
		UserMVo user = commonDao.getMenuAuth(userMVo);
		if(user.getInqireAuthorAt() != null && !"".equals(user.getInqireAuthorAt())){
			userMVo.setInqireAuthorAt(user.getInqireAuthorAt());
		}
		if(user.getStreAuthorAt() != null && !"".equals(user.getStreAuthorAt())){
			userMVo.setStreAuthorAt(user.getStreAuthorAt());
		}
		if(user.getDeleteAuthorAt() != null && !"".equals(user.getDeleteAuthorAt())){
			userMVo.setDeleteAuthorAt(user.getDeleteAuthorAt());
		}
		if(user.getOutptAuthorAt() != null && !"".equals(user.getOutptAuthorAt())){
			userMVo.setOutptAuthorAt(user.getOutptAuthorAt());
		}

		//UserMVo.setAuthorSeCode(menuAth);
		userMVo.setPassword(null); // 세션 password 제거

		return userMVo;
	}

	public String insErrorLog(ErrorLogVo param) {
		commonDao.insErrorLog(param);
		return param.getExcpLogSeqno();
	}

	//SELECT BOX (HTML)
	//공통 코드
	@Override
	public List<ComboVo> getCmmnCode(CmmnCodeMVo param) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(request);
		param.setNationLangCode(userMVo.getNationLangCode());
		return commonDao.getCmmnCode(param);
	}

	//부서기준 사용자조회
	@Override
	public List<InsttMVo> getDeptToUserLsit(InsttMVo param) {
		// TODO Auto-generated method stub
		return commonDao.getDeptToUserLsit(param);
	}

	@Override
	public List<InsttMVo> getUserNmCombo(InsttMVo vo) {
		return commonDao.getUserNmCombo(vo);
	}

	//로그인 로그 남기기
	@Override
	public void setLoginLog(UserMVo vo, String ip) {
		try {
			// IPv6 loopback 실제 ip로 치환
			if(ip.equals("0:0:0:0:0:0:0:1")){
				String addr = java.net.InetAddress.getLocalHost().getHostAddress();
				ip = addr;
			}
		} catch(UnknownHostException e) { e.printStackTrace();}
		LoginMVo lgvo = new LoginMVo();

		lgvo.setUserId(vo.getUserId());
		lgvo.setLoginId(vo.getLoginId());
		//lgvo.setJntIo("I");
		lgvo.setLoginIp(ip);

		commonDao.setLoginLog(lgvo);
	}
	/**
	 * 이메일 보낼사람 반환!
	 */
	@Override
	public EmailVo getEmail(EmailVo vo) {
		return commonDao.getEmail(vo);
	}

	@Override
	public EmailVo getEmailContents(EmailVo vo){
		return commonDao.getEmailContents(vo);
	}

	@Override
	public List<EqpmnInspcCrrctDto> getReqestListPop(EqpmnInspcCrrctDto eqpmnInspcCrrctDto) {
		return commonDao.getReqestListPop(eqpmnInspcCrrctDto);
	}

	// 사용자 목록 (팝업)
	@Override
	public List<UserMVo> getPopUpRqesterNmList(UserMVo vo) {
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		return commonDao.getPopUpRqesterNmList(vo);
	}

	@Override
	public List<RdmsMVo> getBinderitemValueId(RdmsMVo vo){
		return commonDao.getViewerList(vo);
	}

	// RDMS 뷰어
	@Override
	public int rdmsViewer(RdmsMVo map) {

		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		int check = 0;
		List<String> binderArr = new ArrayList<>();
		List<String> reqestArr = new ArrayList<>();
		List<String> l = new ArrayList<>();
		List<RdmsMVo> rmList = new ArrayList<>();
		String docIDs = "";

		map.setUserId(userMVo.getLoginId());
		map.setAuthorSeCode(userMVo.getAuthorSeCode());

		if(map.getGridData().size() > 0) {
			rmList = commonDao.getViewerList(map);
		}

		for(RdmsMVo vo : rmList) {
			if(vo.getBinderitemvalueId() != null && !vo.getBinderitemvalueId().equals("")) {
				binderArr.add(vo.getBinderitemvalueId());
			}else {
				reqestArr.add(vo.getReqestExpriemSeqno());
			}
		};



		map.setGridData((reqestArr.size() > 0 ) ? reqestArr : null);
		map.setGridData2((binderArr.size() > 0 ) ? binderArr : null);

		if(reqestArr.size() > 0 || binderArr.size() > 0) {
			l = rdmsMDao.selectRDMSViwer(map);
		}

		for (String s : l) {
			if(!docIDs.contains(s)) {
				docIDs += s + "|";
			}
		}

		if (docIDs != null && !docIDs.equals("")) {

			docIDs = docIDs.substring(0, docIDs.length() - 1);
			map.setDocIDs(docIDs);
			rdmsMDao.insertRDMSViewer(map);
			check = 1;
		}

		return check;
	}

	//auditTrail

	// AUDIT TRAIL
	public int insertAudit(AuditVo vo) throws RuntimeException{
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
//		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);

		vo.setMenuUrl(httpServletRequest.getRequestURI());
		try{ vo.setConectIp(java.net.InetAddress.getLocalHost().getHostAddress()); } catch(UnknownHostException e) { e.printStackTrace(); }
		if(!commonFunc.isEmpty(vo.getLastChangerId())){
			vo.setChangerId("ana");
			vo.setLastChangerId("ana");
		}
		return commonDao.insertAudit(vo);
	}

	// 업체 조회(시약 표준품 관리 팝업)
	public List<EntrpsMVo> getProductEntrpsFclty(EntrpsMVo vo) {
		return commonDao.getProductEntrpsFclty(vo);
	}

	@Override
	public String getAuditAt(CmmnCodeMVo vo) {
		return commonDao.getAuditAt(vo);
	}

	@Override
	public int insAuditAt(CmmnCodeMVo vo) {
		return commonDao.insAuditAt(vo);
	}

	// 업체 조회
	@Override
	public List<EntrpsMVo> getEntrpsFclty(EntrpsMVo vo) {
		// TODO Auto-generated method stub
		return commonDao.getEntrpsFclty(vo);
	}
	//d
	//기기 조회(팝업)
	@Override
	public List<EqpmnManageDto> getEqpmnList(EqpmnManageDto param) {
		return commonDao.getEqpmnList(param);
	}

	@Override
	public List<ComboVo> getEqpManageNoCombo(EqpmnGageDto eqpmnGageDto) {
		return commonDao.getEqpManageNoCombo(eqpmnGageDto);
	}

	//부서 조회(콤보)
	@Override
	public List<InsttMVo> getDeptCombo(InsttMVo vo) {
		return commonDao.getDeptCombo(vo);
	}

	//장비명 조회(콤보)
	@Override
	public List<EqpmnManageDto> getEqpmnNmCombo(EqpmnManageDto vo) {
		return commonDao.getEqpmnNmCombo(vo);
	}

	@Override
	public List<ComboVo> getCustLabCombo() {
		return commonDao.getCustLabCombo();
	}

	//시험항목조회(팝업)
	public List<ExpriemMVo> getExprIemListM(ExpriemMVo vo) {
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		vo.setInspctInsttCode(userMVo.getBestInspctInsttCode());
		return commonDao.getExprIemListM(vo);
	}


	@Override
	public List<ExpriemMVo> getAddExprIemListM(ExpriemMVo vo) {
		return commonDao.getAddExprIemListM(vo);
	}

	@Override
	public List<ExpriemMVo> getprductAddExprIemListM(WrhousngMVo vo) {
		return commonDao.getprductAddExprIemListM(vo);
	}

	//담당 팀 조회(콤보)
	@Override
	public List<ChrgTeamMVo> getChrgTeamCombo(ChrgTeamMVo param) {
		return commonDao.getChrgTeamCombo(param);
	}


	@Override
	public List<CmmnCodeMVo> getCmmnDteFileCombo(CmmnCodeMVo vo) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(request);
		vo.setNationLangCode(userMVo.getNationLangCode());
		return commonDao.getCmmnDteFileCombo(vo);
	}

//	//기기 조회(공조기 콤보)
//	@Override
//	public List<EqpmnManageDto> getEqpmnVal(EqpmnManageDto vo) {
//		return commonDao.getEqpmnVal(vo);
//	}

	/**
	 * 담당팀 콤보(의뢰 접수 기준)
	 * @param param
	 * @return
	 */
	@Override
	public List<ChrgTeamMVo> getAnalsTeamCombo(ChrgTeamMVo param) {
		return commonDao.getAnalsTeamCombo(param);
	}


	@Override
	public List<ExprMthMVo> getExprMthCombo(ExprMthMVo vo) {
		return commonDao.getExprMthCombo(vo);
	}

	@Override
	public List<ResultInputMVo> getDeProcessExpriem(ResultInputMVo vo) {
		return commonDao.getDeProcessExpriem(vo);
	}

	@Override
	public IssueMVo getWarningMailList(IssueMVo vo) {
		return commonDao.getWarningMailList(vo);
	}


	@Override
	public List<ResultInputMVo> getDeProcessExpriemEmail(ResultInputMVo vo) {
		return commonDao.getDeProcessExpriemEmail(vo);
	}
	@Override
	public Map<String, Object> getAllCmmnCodeMap() {
		Map<String, Object> map = new HashMap<String, Object>();
		for(ComboVo vo : commonDao.getAllCmmnCodeMap()){
			map.put(vo.getValue(), vo.getKey());
		}
		return map;
	}

	@Override
	public List<DlivyMVo> getDlivyTimeList(DlivyMVo vo) {
		return commonDao.getDlivyTimeList(vo);
	}

	@Override
	public List<ComboVo> getMhrlsNmCombo(CmpdsUseMVo vo) {
		return commonDao.getMhrlsNmCombo(vo);
	}

	@Override
	public List<ComboVo> getExpriemClComboList(CmmnCodeMVo vo) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(request);
		vo.setNationLangCode(userMVo.getNationLangCode());
		return commonDao.getExpriemClComboList(vo);
	}

	@Override
	public List<ComboVo> getPrevntMsgGbnList(CmmnCodeMVo vo) {
		return commonDao.getPrevntMsgGbnList(vo);
	}


	/**
	 * 부서별 알림대상자 조회
	 */
	@Override
	public List<DlivyMVo> getSyDeptAcctoNtcnTrgter(DlivyMVo vo) {

		return commonDao.getSyDeptAcctoNtcnTrgter(vo);
	}

	/**
	 * 알림대상자 저장
	 */
	@Override
	public int insSyDeptAcctoNtcnTrgter(DlivyMVo vo) {

		int result = 0;

		try{
			if(vo.getAddListGridData().size() > 0 || vo.getRemoveListGridData().size() > 0 || vo.getListGridData().size() > 0){
				//저장전 삭제
				result = commonDao.delSyDeptAcctoNtcnTrgter(vo);


				for(int i=0; i<vo.getListGridData().size(); i++){
					DlivyMVo gridDlivyMVo = new DlivyMVo();
					gridDlivyMVo = vo.getListGridData().get(i);
					gridDlivyMVo.setNtcnSeCode(vo.getNtcnSeCode());
					gridDlivyMVo.setDeptCode(vo.getDeptCode());

					result += commonDao.insSyDeptAcctoNtcnTrgter(gridDlivyMVo);
				}
			}
		}catch(Exception e){
			e.getStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			throw e;
		}



		return result;
	}

	@Override
	public List<CmmnCodeMVo> getCommonAllInfo(CmmnCodeMVo vo) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(request);
		vo.setNationLangCode(userMVo.getNationLangCode());
		return commonDao.getCommonAllInfo(vo);
	}

	@Override
	public int insertRoaAudit(AuditVo vo) {
		return commonDao.insertRoaAudit(vo);
	}

	//단위 (콤보)
	@Override
	public List<ComboVo> getUnitListCombo(UnitMVo vo) {
		return commonDao.getUnitListCombo(vo);
	}

	@Override
	public int colSanctnM(DocDto vo) {
		// TODO Auto-generated method stub
		return commonDao.colSanctnM(vo);
	}

	/**
	 * 원료사, 고객사 audit 접수번호 생성
	 * gbn = S (원료사), gbn = C (고객사)
	 * 접수번호 생성 규칙 [gbn + YYYYMMDD + "_" + 일련번호]
	 *
	 * @author 박기윤
	 * @return
	 */
	public String auditRceptNo(String gbn){
		String auditRceptNo = "";

		//YYYYMMDD 구하기
		SimpleDateFormat date = new SimpleDateFormat("yyMMdd");
		Calendar calendar = Calendar.getInstance();
		String yymmdd = date.format(calendar.getTime());

		//gbn + yyyymmdd로 마지막 일련번호 구하기
		String param = gbn+yymmdd+"_";
		String serialNo = commonDao.getSerialNo(param);

		auditRceptNo = param + serialNo;

		return auditRceptNo;
	}

	/**
	 * 원료사, 고객사 auditLgstr 접수번호 생성
	 *
	 * 접수번호 생성 규칙 [auditRceptNo + "_" + 일련번호 +]
	 *
	 * @author 박기윤
	 * @return
	 */
	public String auditLgstrNo(String auditRceptNo){
		String auditLgstrNo = "";

		//접수번호로 발행된 지적사항이 있는지 조회
		String lgstrSerialNo = commonDao.getLgstrSerialNo(auditRceptNo);

		auditLgstrNo = auditRceptNo + "_" + lgstrSerialNo;

		return auditLgstrNo;
	}

	public void saveWdtbList(HashMap<String, Object> map) {
		int wdtbCnt = 0;
		int result = 0;



		//배포처
		ArrayList<HashMap<String, String>> wdtbInfoList = (ArrayList<HashMap<String, String>>) map.get("wdtbInfoList");
		wdtbCnt = commonDao.wdtbTrgterLen(map);
		if(map.get("wdtbSeqno") != null && map.get("wdtbSeqno") != ""){
			String SwdtbSeqno = (String) map.get("wdtbSeqno");
			result += commonDao.updWdtb(map); //update Table

			for(int i=0; i<wdtbInfoList.size(); i++){
				String ordrs = Integer.toString(wdtbCnt);
				wdtbInfoList.get(i).put("wdtbSeqno",SwdtbSeqno);
				wdtbInfoList.get(i).put("ordr", ordrs);
				wdtbCnt += commonDao.insWdtbTrgter(wdtbInfoList.get(i)); //insert Trgter Table
			}
		}
		else{
			result += commonDao.insWdtb(map); //insert Table
			String SwdtbSeqno = (String) map.get("wdtbSeqno");

			for(int i=0; i<wdtbInfoList.size(); i++){
				String ordrs = Integer.toString(i);
				wdtbInfoList.get(i).put("wdtbSeqno",SwdtbSeqno);
				wdtbInfoList.get(i).put("ordr", ordrs);
				wdtbCnt += commonDao.insWdtbTrgter(wdtbInfoList.get(i)); //insert Trgter Table
			}
		}

	}

	@Override
	public List<PrductMVo> getMtrilComboList(PrductMVo vo) {
		// TODO Auto-generated method stub
		return commonDao.getMtrilComboList(vo);
	}

	@Override
	public int insWdtb(WdtbVo vo){
		int result = 0;

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(request);

		try {
			List<WdtbVo> customer = vo.getCustomerList();

			HashMap<String, Object> map = new HashMap<>();

			if(commonFunc.isEmpty(vo.getWdtbSeqno())){
				map.put("lastChangerId", userMVo.getUserId());
				map.put("wdtbPosblAt", "Y");
				map.put("cn", vo.getCn());
				map.put("sj", vo.getSj());

				result += commonDao.insWdtb(map);

				for(int i = 0; i < customer.size(); i++){
					HashMap<String, String> customerMap = new HashMap<>();

					int ordr = i + 1;
					String strOrdr = Integer.toString(ordr);

					customerMap.put("wdtbSeqno", (String) map.get("wdtbSeqno"));
					customerMap.put("chrctrTrnsmisAt", customer.get(i).getChrctrTrnsmisAt());
					customerMap.put("emailTrnsmisAt", customer.get(i).getEmailTrnsmisAt());
					customerMap.put("userId", customer.get(i).getUserId());
					customerMap.put("emailTrnsmisComptAt", "N");
					customerMap.put("chrctrTrnsmisComptAt", "N");
					customerMap.put("ordr", strOrdr);

					customerMap.put("lastChangerId", userMVo.getUserId());

					result += commonDao.insWdtbTrgter(customerMap);
				}

				/* dialog에서 보내준 화면구분으로 배포스퀀스 저장 테이블 분기처리 */
				HashMap<String, String> dataMap = new HashMap<>();
				if("audit".equals(vo.getView())){
					dataMap.put("auditSeqno", vo.getSeqNo());
					dataMap.put("wdtbSeqno", (String) map.get("wdtbSeqno"));

					if(commonFunc.isEmpty(vo.getWdtbSeqno())){
						result = commonDao.updAudit(dataMap);
					}
					/*VOC 등록 배포시퀀스 등록*/
				}else if("vocRegist".equals(vo.getView())){
					dataMap.put("vocRegistSeqno", vo.getSeqNo());
					dataMap.put("wdtbSeqno", (String) map.get("wdtbSeqno"));

					if(commonFunc.isEmpty(vo.getWdtbSeqno())){
						result = commonDao.updVocRegist(dataMap);
					}
					/*VOC 대책 수립 등록*/
				}else if("vocCntrplnFoundng".equals(vo.getView())){
					dataMap.put("vocCntrplnFoundngSeqno", vo.getSeqNo());
					dataMap.put("wdtbSeqno", (String) map.get("wdtbSeqno"));

					if(commonFunc.isEmpty(vo.getWdtbSeqno())){
						result = commonDao.updVocCntrplnFoundng(dataMap);
					}
					/*VOC 유효 검증*/
				}else if("vocValidVrify".equals(vo.getView())){
					dataMap.put("vocValidVrifySeqno", vo.getSeqNo());
					dataMap.put("wdtbSeqno", (String) map.get("wdtbSeqno"));

					if(commonFunc.isEmpty(vo.getWdtbSeqno())){
						result = commonDao.updVocValidVrify(dataMap);
					}
					/* PCN */
				}else if("pcn".equals(vo.getView())) {
					dataMap.put("pcnSeqno", vo.getSeqNo());
					dataMap.put("wdtbSeqno", (String) map.get("wdtbSeqno"));

					if(commonFunc.isEmpty(vo.getWdtbSeqno())) {
						result = commonDao.updPcnWdtbSeq(dataMap);
					}
				}
			}else{
				map.put("lastChangerId", userMVo.getUserId());
				map.put("wdtbPosblAt", "Y");
				map.put("wdtbSeqno", vo.getWdtbSeqno());
				map.put("sj",vo.getSj());
				map.put("cn", vo.getCn());

				result += commonDao.updWdtb(map);

				int ordr = commonDao.getTrgterCnt(vo);

				for(int i = 0; i < customer.size(); i++){
					HashMap<String, String> customerMap = new HashMap<>();

					/* 현재 배포대상자 수 구하기 */
					ordr += i + 1;
					String strOrdr = Integer.toString(ordr);

					customerMap.put("wdtbSeqno", (String) map.get("wdtbSeqno"));
					customerMap.put("chrctrTrnsmisAt", customer.get(i).getChrctrTrnsmisAt());
					customerMap.put("emailTrnsmisAt", customer.get(i).getEmailTrnsmisAt());
					customerMap.put("userId", customer.get(i).getUserId());
					customerMap.put("emailTrnsmisComptAt", "N");
					customerMap.put("chrctrTrnsmisComptAt", "N");
					customerMap.put("ordr", strOrdr);

					customerMap.put("lastChangerId", userMVo.getUserId());

					result += commonDao.insWdtbTrgter(customerMap);
				}
			}
		} catch (Exception e) {
			throw new CustomException(e, vo, "배포가 정상적으로 이루어지지 않았습니다.");
		}

		return result;
	}

	@Override
	public List<WdtbVo> getWdtbTrgterList(WdtbVo vo){
		return commonDao.getWdtbTrgterList(vo);
	}

	@Override
	public int delTrgterList(WdtbVo vo){
		int result = 0;

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(request);

		try{
			List<WdtbVo> trgterList = vo.getChkTrgterData();

			for(int i = 0; i < trgterList.size(); i++){
				WdtbVo trgterVo = trgterList.get(i);

				trgterVo.setLastChangerId(userMVo.getUserId());
				result += commonDao.delTrgterList(trgterVo);
			}
		} catch (Exception e) {
			throw new CustomException(e, vo, "삭제가 정상적으로 이루어지지 않았습니다.");
		}

		return result;
	}

	@Override
	public List<QlityDocHistVo> getQlityDocHistList(QlityDocHistVo vo) {
		return commonDao.getQlityDocHistList(vo);
	}

	@Override
	public List<ResultInputMVo> getPdfViewerBinderitemvalueId(List<ResultInputMVo> list) {

		//시험항목시퀀스, 시험항목순번 배열
		String[] exprIemInfoArr = new String[list.size() * 2];

		int arrCount = 0;
		for(ResultInputMVo vo : list) {
			exprIemInfoArr[arrCount] = vo.getReqestExpriemSeqno();
			arrCount++;
			exprIemInfoArr[arrCount] = vo.getExprOdr();
			arrCount++;
		}

		ResultInputMVo vo  = new ResultInputMVo();
		vo.setArrayExpriem(exprIemInfoArr);
		//"O" : RDMS 원본, "C" : RDMS 복사본, 구분 값은 버튼으로 구분하여 리스트 모두가 동일한 값 이므로 0번 값 사용
		vo.setType(list.get(0).getType());
		List<ResultInputMVo> binderitemvalueIdList = commonDao.getBinderitemvalueIdList(vo);

		return binderitemvalueIdList;
	}

	@Override
	public List<RdmsMVo> getPdfViewerRowData(ResultInputMVo vo) {

		String[] binderitemvalueIdArr = vo.getBinderitemvalueIdStr().split(",");
		List<RdmsMVo> binderColumnInfoList = new ArrayList<RdmsMVo>();
		List<RdmsMVo> pdfViewerGridData = new ArrayList<RdmsMVo>();
		String bplcCode = vo.getBplcCode();

		Optional<EnumRDMS> rdms = EnumRDMS.findRdmsPL(bplcCode);

		if(rdms.isPresent()) {
			int length = binderitemvalueIdArr.length;
			for(int i = 0; i < length; i++) {
				binderColumnInfoList = rdms.get().getBinderColumnInfo(binderitemvalueIdArr[i]);
				if(!commonFunc.isEmpty(binderColumnInfoList))
					break;
			}

			//빈배열에 컬럼네임 리스트를 담아서 foreach로 조회하기 위한 용도
			String[] columnInfoArr = new String[binderColumnInfoList.size()];
			int binderColumnInfolen = binderColumnInfoList.size();
			for(int i = 0; i < binderColumnInfolen; i++) {
				//R01 : 시험결과, R02 : 정보, R03 : 기타
				//컨버터에서 확인 가능하며 일반화면에서는 보여주지 않음
				//필요할 경우 분기처리 제거, xml에도 주석되어있는부분 제거해서 사용할 것.
				if(!"R01".equals(binderColumnInfoList.get(i).getItemName())
						&& !"R02".equals(binderColumnInfoList.get(i).getItemName())
						&& !"R03".equals(binderColumnInfoList.get(i).getItemName()))
					columnInfoArr[i] = binderColumnInfoList.get(i).getItemName();
			}
			HashMap<String,String[]> hashMap = new HashMap<>();
			hashMap.put("columnInfoMap", columnInfoArr);
			hashMap.put("binderitemvalueIdMap", binderitemvalueIdArr);

			//HashMap<참조명,{컬럼정보,바인더아이템벨류아이디정보}>로  mybatis에서 foreach로 동적 조회
			pdfViewerGridData = rdms.get().getPdfViewerGridData(hashMap);

			if(pdfViewerGridData.size() > 0) {
				//그리드화면 컬럼 세팅 값
				pdfViewerGridData.get(0).setColumnInfoList(binderColumnInfoList);
			}

		}

		return pdfViewerGridData;
	}

	@Override
	public FileDetailMVo getblobPdfViewer(RdmsMVo vo) {
		FileDetailMVo fileVo = new FileDetailMVo();

		Optional<EnumRDMS> rdms = EnumRDMS.findRdmsPL(vo.getBplcCode());

		if(rdms.isPresent()) {
			fileVo = rdms.get().getblobPdfViewer(vo);
		}

		return fileVo;
	}

	@Override
	public FileDetailMVo getCheckBlobPdfViewer(List<RdmsMVo> list) {

		FileDetailMVo mergeFileVo = new FileDetailMVo();

		String[] binderitemvalueIdArr = new String[list.size()];
		int len = list.size();
		for(int i = 0; i < len; i++)
			binderitemvalueIdArr[i] = list.get(i).getBinderitemvalueId();

		Optional<EnumRDMS> rdms = EnumRDMS.findRdmsPL(list.get(0).getBplcCode());

		if(rdms.isPresent()) {
			List<FileDetailMVo> fileDetailList = rdms.get().getCheckBlobPdfViewer(binderitemvalueIdArr);

			try {

				// 동일한 PDF 파일을 같은시간에 사용하는 사용자가 여러명일 경우 파일이 생성되면서 같은파일명으로 문제가 됨
				// 난수로 첨부파일 대체 작업해야함.
				String randomString = randomString();
				List<InputStream> inputPdfList = new ArrayList<InputStream>();
				OutputStream outputStream = new FileOutputStream("D:\\fileUpload\\AttachFile\\Temp\\" + randomString + ".pdf");

				String[] deletePathArr = new String[fileDetailList.size()];

				for(int i = 0; i < fileDetailList.size(); i++) {
					String filePath = "D:\\fileUpload\\AttachFile\\Temp\\" + fileDetailList.get(i).getOrginlFileNm();
					deletePathArr[i] = filePath;
					FileUtils.writeByteArrayToFile(new File(filePath), fileDetailList.get(i).getFileData());
					inputPdfList.add(new FileInputStream(filePath));
				}

				Document document = new Document();
				List<PdfReader> readers = new ArrayList<PdfReader>();

				int totalPages = 0;

				Iterator<InputStream> pdfIterator = inputPdfList.iterator();
				while (pdfIterator.hasNext()) {
					InputStream pdf = pdfIterator.next();
					PdfReader pdfReader = new PdfReader(pdf);
					readers.add(pdfReader);
					totalPages = totalPages + pdfReader.getNumberOfPages();
				}

				PdfWriter writer = PdfWriter.getInstance(document, outputStream);

				document.open();

				PdfContentByte pageContentByte = writer.getDirectContent();

				PdfImportedPage pdfImportedPage;
				int currentPdfReaderPage = 1;
				Iterator<PdfReader> iteratorPDFReader = readers.iterator();

				while (iteratorPDFReader.hasNext()) {
					PdfReader pdfReader = iteratorPDFReader.next();
					//Create page and add content.
					while (currentPdfReaderPage <= pdfReader.getNumberOfPages()) {
						document.newPage();
						pdfImportedPage = writer.getImportedPage(pdfReader,currentPdfReaderPage);
						pageContentByte.addTemplate(pdfImportedPage, 0, 0);
						currentPdfReaderPage++;
					}
					currentPdfReaderPage = 1;
				}

				outputStream.flush();
				document.close();
				outputStream.close();

				String mergeFilePath = "D:\\fileUpload\\AttachFile\\Temp\\" + randomString + ".pdf";
				File mergeFile = new File(mergeFilePath);
				byte[] mergePdfByteArr = FileUtils.readFileToByteArray(mergeFile);

				mergeFileVo.setFileData(mergePdfByteArr);

				for(int i = 0; i < deletePathArr.length; i++) {
					File file = new File(deletePathArr[i]);
					file.delete();
				}

				mergeFile.delete();

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return mergeFileVo;
	}

	// 시스템 설정에 따라 비밀번호 형식에 부합한지 체크
	@Override
	public int passwordPolicyCheck(String param) {
		int result = 0;

		// 시스템 설정 정보 조회
		SysEstbsMVo sysEstbsVo = commonDao.getSysManageInfo();
		String executAt = sysEstbsVo.getPasswordPolicyExecutAt(); // 비밀번호 정책 적용 여부

		if("Y".equals(executAt)) {

			String password = param.replaceAll("\"", "");

			// 비밀번호 최대 자릿수
			if(sysEstbsVo.getPasswordMxmmCphr() != 0) {
				if(!(password.length() <= sysEstbsVo.getPasswordMxmmCphr())) {
					result =+ 100;
					return result;
				}
			}

			// 비밀번호 특수문자 포함 여부
			if("Y".equals(sysEstbsVo.getPasswordSpclChrctrInclsAt())) {
				Pattern pattern = Pattern.compile("[ !@#$%^&*(),.?\":{}|<>]");

				if(!pattern.matcher(password).find()) {
					result += 101;
					return result;
				}
			}

			// 비밀번호 숫자 포함 여부
			if("Y".equals(sysEstbsVo.getPasswordNumberInclsAt())) {
				Pattern pattern = Pattern.compile("[0-9]");

				if(!pattern.matcher(password).find()) {
					result += 102;
					return result;
				}
			}

			// 비밀번호 대문자 포함 여부
			if("Y".equals(sysEstbsVo.getPasswordUpprsInclsAt())) {
				Pattern pattern = Pattern.compile("[A-Z]");

				if(!pattern.matcher(password).find()) {
					result += 103;
					return result;
				}
			}

		}

		return result;
	}

	@Override
	public List<PrintngMVO> printCours(PrintngMVO vo) {

		return commonDao.printCours(vo);
	}

	@Override
	public List<TrendStdrMVO> getScpExprList(TrendStdrMVO vo) {

		return commonDao.getScpExprList(vo);
	}

	public String randomString() {
		Random rnd =new Random();
		StringBuffer buf =new StringBuffer();
		for(int i=0;i<20;i++){
			if(rnd.nextBoolean()){
				buf.append((char)((int)(rnd.nextInt(26))+97));
			}else{
				buf.append((rnd.nextInt(10)));
			}
		}
		return buf.toString();
	}

	@Override
	public List<ReceiptManageDto> getCustlabCombo(ReceiptManageDto vo) {
		return commonDao.getCustlabCombo(vo);
	}

	@Override
	public List<SanctnCountDto> getSanctnCount() {
		return commonDao.getSanctnCount();
	}
}
