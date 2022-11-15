package lims.com.dao;

import lims.com.vo.*;
import lims.dly.vo.DlivyMVo;
import lims.qa.vo.DocDto;
import lims.qa.vo.QlityDocHistVo;
import lims.req.vo.ReceiptManageDto;
import lims.rsc.vo.*;
import lims.sys.vo.*;
import lims.test.vo.IssueMVo;
import lims.test.vo.ResultInputMVo;
import lims.wrk.vo.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface CommonDao {

	public SysManageVo getSystemRule();

	public String getCmTable(CmCdNmVo cmCdNmVO);

	public String getErrorLogIdMax();
	public int insErrorLog(ErrorLogVo param);

	public void setLoginLog(LoginMVo vo);

	//SELECT BOX (HTML)
	//공통 코드
	public List<ComboVo> getCmmnCode(CmmnCodeMVo param);

	//공통 코드
	public List<ComboVo> getMhrlsNmCombo(CmpdsUseMVo param);

	public String getAuditAt(CmmnCodeMVo vo);

	public int insAuditAt(CmmnCodeMVo vo);

	public List<EqpmnManageDto> getMhrlsCombo(EqpmnManageDto vo);

	//파트별 사용자 목록
	public List<ComboVo> getPartUserList(UserMVo vo);

	//부서기준 사용자 조회
	public List<InsttMVo> getDeptToUserLsit(InsttMVo vo);

	public List<InsttMVo> getUserNmCombo(InsttMVo vo);

	//이메일 가져옴
	public EmailVo getEmail(EmailVo vo);
	public EmailVo getEmailContents(EmailVo vo);

	List<EqpmnInspcCrrctDto> getReqestListPop(EqpmnInspcCrrctDto eqpmnInspcCrrctDto);

	// 사용자 목록 (팝업)
	public List<UserMVo> getPopUpRqesterNmList(UserMVo vo);

	//업체 조회(팝업)
	public List<EntrpsMVo> getEntrpsFclty(EntrpsMVo vo);


	//Audit 생성
	public int insertAudit(AuditVo vo);

	/**
	 *
	 * @param vo
	 * @return 오디트레일 생성. 변경 이전 , 이후 모두넣을수있음
	 */
	public int insAudit(AuditVo vo);

	public UserMVo getMenuAuth(UserMVo vo);

	// 업체 조회(시약 표준품 관리 팝업)
	public List<EntrpsMVo> getProductEntrpsFclty(EntrpsMVo vo);

	//장비 조회(팝업)
	public List<EqpmnManageDto> getEqpmnList(EqpmnManageDto param);
	
	// 장비관리번호 콤보
	List<ComboVo> getEqpManageNoCombo(EqpmnGageDto eqpmnGageDto);

	//부서 콤보 조회
	public List<InsttMVo> getDeptCombo(InsttMVo vo);

	//장비명 콤보 조회
	public List<EqpmnManageDto> getEqpmnNmCombo(EqpmnManageDto vo);

//	public List<EqpmnManageDto> getEqpmnCombo(EqpmnManageDto vo);

	//시험항목조회-기준규격관리(팝업)
	public List<ExpriemMVo> getExprIemListM(ExpriemMVo vo);

	// 시험항목조회- 시험항목 리스트가져와서 제품별 시험항목 추가용 (팝업)
	public List<ExpriemMVo> getAddExprIemListM(ExpriemMVo vo);

	// 시험항목조회 - 제품 일련번호를 통해 시험항목 추가용(팝업)
	public List<ExpriemMVo> getprductAddExprIemListM(WrhousngMVo vo);

	// 담당팀 콤보
	public List<ChrgTeamMVo> getChrgTeamCombo(ChrgTeamMVo param);

//	//장비명 콤보
//	public List<EqpmnManageDto> getEqpmnVal(EqpmnManageDto vo);

	public List<CmmnCodeMVo> getCmmnDteFileCombo(CmmnCodeMVo vo);

	// 담당팀 콤보(의뢰 접수 기준)
	public List<ChrgTeamMVo> getAnalsTeamCombo(ChrgTeamMVo param);

	//시험방법 콤보
	public List<ExprMthMVo> getExprMthCombo(ExprMthMVo vo);

	public List<ResultInputMVo> getDeProcessExpriem(ResultInputMVo vo);

	/**
	 *
	 * @return 모든 공통코드를 가져옵니다
	 */
	public List<ComboVo> getAllCmmnCodeMap();

	public List<ResultInputMVo> getDeProcessExpriemEmail(ResultInputMVo vo);

	public IssueMVo getWarningMailList(IssueMVo vo);

	public List<DlivyMVo> getDlivyTimeList(DlivyMVo vo);

	public int updateMsUser(HashMap<String,Object> map);

	public void updateMsDept();

	//RDMS 뷰어 조회
	public List<String> selectRDMSViwer(HashMap<String, String> map);

	public int delMsDeptData (HashMap<String,Object> map);

	public int insMsDeptData (HashMap<String,Object> map);

	public int delMsUserData (HashMap<String,Object> map);

	public int insMsUserData (HashMap<String,Object> map);

	public int updateDeptInfo (HashMap<String,Object> map);


	public List<HashMap<String,Object>> getUserList ();

	public String getAdminEmail();

	public String getExpriemNm(String nm);

	/**
	 *
	 * @param vo
	 * @return 시험항목 분류 콤보 리스트
	 */
	public List<ComboVo> getExpriemClComboList(CmmnCodeMVo vo);

	public List<ComboVo> getCustLabCombo();

	/**
	 *
	 * @param vo
	 * @return 예방 조치 문구 콤보 리스트
	 */
	public List<ComboVo> getPrevntMsgGbnList(CmmnCodeMVo vo);

	/**
	 * 부서별 알림대상자 조회
	 * @param vo
	 * @return
	 */
	public List<DlivyMVo> getSyDeptAcctoNtcnTrgter(DlivyMVo vo);

	/**
	 * 부서별 알림대상자 저장
	 * @param vo
	 * @return
	 */
	public int insSyDeptAcctoNtcnTrgter(DlivyMVo vo);

	/**
	 * 부서별 알림대상자 삭제
	 * @param vo
	 * @return
	 */
	public int delSyDeptAcctoNtcnTrgter(DlivyMVo vo);

	public List<CmmnCodeMVo> getCommonAllInfo(CmmnCodeMVo vo);

	public int insertMsUser(HashMap<String,Object> map);

	public List<HashMap<String,Object>> chkUserInfo(HashMap<String,Object> map);

	// AUDIT ROA TRAIL
	public int insertRoaAudit(AuditVo vo);

	public int userChk(DlivyMVo gridDlivyMVo);

	//단위 콤보 조회
	public List<ComboVo> getUnitListCombo(UnitMVo param);

	public List<RdmsMVo> getViewerList(RdmsMVo vo);

	public int colSanctnM(DocDto vo);

	public String getSerialNo(String param);

	public String getLgstrSerialNo(String auditRceptNo);

	public int updWdtb(HashMap<String, Object> map);

	public int delWdtbTrgter(HashMap<String, String> hashMap);

	public int insWdtbTrgter(DocDto docDto);

	public int insWdtb(HashMap<String, Object> map);

	public int updWdtbSeqno(DocDto vo);

	public int insWdtbTrgter(HashMap<String, String> hashMap);

	public List<PrductMVo> getMtrilComboList(PrductMVo vo);

	public int insWdtb(WdtbVo vo);

	public int insWdtbTrgter(WdtbVo vo);

	public int delTrgterList(WdtbVo vo);

	public List<WdtbVo> getWdtbTrgterList(WdtbVo vo);

	public int updAudit(HashMap<String, String> map);

	public int updVocRegist(HashMap<String, String> map);

	public int updVocCntrplnFoundng(HashMap<String, String> map);

	public int updVocValidVrify(HashMap<String, String> map);

	public int updPcnWdtbSeq(HashMap<String, String> map);

	public int getTrgterCnt(WdtbVo vo);

	public List<QlityDocHistVo> getQlityDocHistList(QlityDocHistVo vo);

	/**
	 *
	 * @param
	 * @return 시스템 설정 정보 조회
	 */
	public SysEstbsMVo getSysManageInfo();

	/**
	 *
	 * @param vo
	 * @return 시험항목 시퀀스 , 시험항목 순번 배열로 바인더아이템벨류아이디 리스트 조회
	 */
	public List<ResultInputMVo> getBinderitemvalueIdList(ResultInputMVo vo);

	public int wdtbTrgterLen(HashMap<String, Object> map);

	public List<PrintngMVO> printCours(PrintngMVO vo);

	public List<TrendStdrMVO> getScpExprList(TrendStdrMVO vo);

	public List<ReceiptManageDto> getCustlabCombo(ReceiptManageDto vo);

	List<SanctnCountDto> getSanctnCount();
}
