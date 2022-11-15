package lims.com.service;

import lims.com.vo.*;
import lims.dly.vo.DlivyMVo;
import lims.qa.vo.DocDto;
import lims.qa.vo.QlityDocHistVo;
import lims.req.vo.ReceiptManageDto;
import lims.rsc.vo.*;
import lims.sys.vo.CmmnCodeMVo;
import lims.sys.vo.InsttMVo;
import lims.sys.vo.SysManageVo;
import lims.sys.vo.UserMVo;
import lims.test.vo.IssueMVo;
import lims.test.vo.ResultInputMVo;
import lims.wrk.vo.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface CommonService {

	public SysManageVo getSystemRule();

	public String insErrorLog(ErrorLogVo param);

	//SELECT BOX (HTML)
	//공통 코드
	public List<ComboVo> getCmmnCode(CmmnCodeMVo param);

	//담당팀 콤보 조회
	public List<ChrgTeamMVo> getChrgTeamCombo(ChrgTeamMVo param);

	//부서기준 사용자 조회
	public List<InsttMVo> getDeptToUserLsit(InsttMVo param);

	public List<InsttMVo> getUserNmCombo(InsttMVo vo);

	// 장비 조회(팝업)
	public List<EqpmnManageDto> getEqpmnList(EqpmnManageDto param);

	//권한이 제대로 있는지 확인!
	public UserMVo getAuth();

	//로그인 내역 오딧
	public void setLoginLog(UserMVo vo, String ip);

	public EmailVo getEmail(EmailVo vo);

	public EmailVo getEmailContents(EmailVo vo);

	List<EqpmnInspcCrrctDto> getReqestListPop(EqpmnInspcCrrctDto eqpmnInspcCrrctDto);

	// 시험항목조회-기준규격관리(팝업)
	public List<ExpriemMVo> getExprIemListM(ExpriemMVo vo);

	// 시험항목조회- 시험항목 리스트가져와서 제품별 시험항목 추가용 (팝업)
	public List<ExpriemMVo> getAddExprIemListM(ExpriemMVo vo);

	// 시험항목조회 - 제품 일련번호를 통해 시험항목 추가용(팝업)
	public List<ExpriemMVo> getprductAddExprIemListM(WrhousngMVo vo);

	// 사용자 목록(팝업)
	public List<UserMVo> getPopUpRqesterNmList(UserMVo vo);

	// 업체 조회(팝업)
	public List<EntrpsMVo> getEntrpsFclty(EntrpsMVo param);

	// RDMS 뷰어
	public int rdmsViewer(RdmsMVo map);

	// AUDIT TRAIL
	public int insertAudit(AuditVo vo);

	// AUDIT ROA TRAIL
	public int insertRoaAudit(AuditVo vo);

	// 업체 조회(시약 표준품 관리 팝업)
	public List<EntrpsMVo> getProductEntrpsFclty(EntrpsMVo param);

	public String getAuditAt(CmmnCodeMVo vo);

	public int insAuditAt(CmmnCodeMVo vo);

	List<ComboVo> getEqpManageNoCombo(EqpmnGageDto eqpmnGageDto);

	//부서 콤보 조회
	public List<InsttMVo> getDeptCombo(InsttMVo vo);

	//장비명 콤보 조회
	public List<EqpmnManageDto> getEqpmnNmCombo(EqpmnManageDto vo);

	public List<ComboVo> getCustLabCombo();

	public List<CmmnCodeMVo> getCmmnDteFileCombo(CmmnCodeMVo vo);

	//담당팀 콤보(의뢰 접수 기준)
	public List<ChrgTeamMVo> getAnalsTeamCombo(ChrgTeamMVo param);

	//시험방법 콤보
	public List<ExprMthMVo> getExprMthCombo(ExprMthMVo vo);

	//RDMS 부서 콤보
	public List<ComboVo> getMhrlsNmCombo(CmpdsUseMVo vo);

	//처리기한 임박 시험항목 조회(스케쥴러)
	public List<ResultInputMVo> getDeProcessExpriem(ResultInputMVo vo);

	/**
	 *
	 * @return 모든 공통코드를 가져옵니다
	 */
	public Map<String, Object> getAllCmmnCodeMap();

	//처리기한 임박 시험항목 보낼 사용자 이메일 조회(스케쥴러)
	public List<ResultInputMVo> getDeProcessExpriemEmail(ResultInputMVo vo);

	public IssueMVo getWarningMailList(IssueMVo vo);

	public List<DlivyMVo> getDlivyTimeList(DlivyMVo vo);


	/**
	 *
	 * @param vo
	 * @return 시험항목 분류 콤보 리스트
	 */
	public List<ComboVo> getExpriemClComboList(CmmnCodeMVo vo);

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

	public List<CmmnCodeMVo> getCommonAllInfo(CmmnCodeMVo vo);

	// 단위 (콤보)
	public List<ComboVo> getUnitListCombo(UnitMVo vo);

	public int colSanctnM(DocDto vo);

	public String auditRceptNo(String param);

	public String auditLgstrNo(String auditRceptNo);

	public void saveWdtbList(HashMap<String, Object> map);
	//getMtrilComboList

	public List<PrductMVo> getMtrilComboList(PrductMVo vo);

	public int insWdtb(WdtbVo vo);

	public int delTrgterList(WdtbVo vo);

	public List<WdtbVo> getWdtbTrgterList(WdtbVo vo);

	public List<QlityDocHistVo> getQlityDocHistList(QlityDocHistVo vo);

	public List<RdmsMVo> getBinderitemValueId(RdmsMVo vo);

	/**
	 *
	 * @param List<vo>
	 * @return 시험항목 체크리스트에 바인더아이템벨류아이디 유/무 확인하기위한 리스트
	 */
	public List<ResultInputMVo> getPdfViewerBinderitemvalueId(List<ResultInputMVo> list);

	/**
	 *
	 * @param List<vo>
	 * @return PDF Viewer 팝업에 RowData 리스트
	 */
	public List<RdmsMVo> getPdfViewerRowData(ResultInputMVo vo);

	/**
	 *
	 * @param vo
	 * @return PDF Viewer Data
	 */
	public FileDetailMVo getblobPdfViewer(RdmsMVo vo);

	/**
	 *
	 * @param List<vo>
	 * @return PDF Viewer Data
	 */
	public FileDetailMVo getCheckBlobPdfViewer(List<RdmsMVo> vo);

	/**
	 *
	 * @param String - 사용자 입력  패스워드
	 * @return int
	 */
	public int passwordPolicyCheck(String param);

	public List<PrintngMVO> printCours(PrintngMVO vo);

	public List<TrendStdrMVO> getScpExprList(TrendStdrMVO vo);

	public List<ReceiptManageDto> getCustlabCombo(ReceiptManageDto vo);

	List<SanctnCountDto> getSanctnCount();
	
}
