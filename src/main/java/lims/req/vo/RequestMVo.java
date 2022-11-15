package lims.req.vo;

import lims.test.vo.LotTraceMVo;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class RequestMVo extends LotTraceMVo {

	//PROGRS_SITTN_CODE,RM,LOCK_AT,DELETE_AT,LAST_CHANGER_ID,LAST_CHANGE_DT
	/* 의뢰 */
	private String reqestSeqno; //의뢰 일련번호
	private String bplcCode; //사업장 코드
	private String bplcNm; //사업장 코드
	private String reqestDeptCode; // 의뢰 부서 코드
	private String clientId; //의뢰자 ID
	private String reqestDte; //의뢰 일자
	private String reqestNo; //의뢰 번호
	private String inspctTyCode; //ZSY07 검사 유형 코드
	private String inspctTyCodeNm; //ZSY07 검사 유형 코드 명
	private String custlabSeqno;
	private String custlabNm;
	private String mtrilSeqno; //자재 일련번호
	private String mnfcturDte; //제조 일자
	private String sploreNm; // 시료 명
	private String mtrilCylndrSeqno;  //자재 실린더 일련번호
	private String mtrilItmSeqno;   //자재 아이템 일련번호
	private String elctcQy;   //충전 량
	private String elctcCn;   //충전 내용
	private String entrpsSeqno; //업체 일련번호
	private String entrpsNm;
	private String prductDc;   //제품 설명
	private String eqpmnSeqno;   //장비 일련번호
	private String eqpmnNm; // 장비 일련변호명
	private String rcepterId;   //접수자 ID
	private String rceptDt;   //접수 일시
	private String expriemCo;   //시험항목 수
	private String rereqestNum;   //재의뢰 건수
	private String roaCreatAt;   //ROA 생성 여부
	private String ctmmnyOthbcAt;   //고객사 공개 여부
	private String lastAnalsDt;   //최종 분석 일시
	private String vendorReqestAt;   //벤더 의뢰 여부
	private String vendorCoareqestSeqno;   //벤더 COA 의뢰 일련번호
	private String jdgmntWordCode;   //ZIM05 판정 용어 코드
	private String progrsSittnCode;   //ZIM03 진행 상황 코드
	private String lockAt;   //잠금 여부
	private String deleteAt;   // 삭제 여부

	private String mtrilNm; //자재명
	private String ordr; //순서
	private String lotNo; //LOT NO
	private String lotCode; //LOT CODE
	private String frstLotNo; //최초 LOT NO
	private String vendorLotNo; //벤더 LOT NO
	private String vendorCoaReqestSeqno; //벤더 의뢰 일련번호
	private String vendorEntrpsSeqno; // 벤더 업체 일련번호
	private String vendorEntrpsNm; // 벤더 업체 명
	private String vendorCoaAT; // 벤더 COA여부
	private String reqestDeptNm; //의뢰 부서 명
	private String clientNm; //의뢰자 명
	private String rm; //비고
	private String virtlLotAt; //가상 LOT 여부
	private String reReqestAt; //재 의뢰 여부
	private String progrsSittnCodeNm; //ZIM03 진행상황코드명
	private String lastChangerId; //최종 변경자 ID
	private String lastChangeDt; //최종 변경 일시
	private String validPdCycle; //유효 기간 주기
	private String validPdCycleCode; //ZSY14 유효 기간 주기 코드
	private String validDte; //유효 일자
	private String matchingLotNo; //Lot Trace 매칭된 Lot 있는지 구분하기 위한 컬럼
	private String rMatchingLotNo; //Lot Trace(Real) 매칭된 Lot 있는지 구분하기 위한 컬럼
	private String lotNoCphr; //LotNo 자리 수
	private String lblDcOutptAt; //라벨설명출력여부
	private String lotTraceAtmcReqestAt; //LOT TRACE 자동 의뢰 여부
	private String mtrilTyCode;	//자재 프로세스 코드
	private String prductSeCode;
	private Integer elctcSeqno; //충전 일렬번호

	/* 시험항목 */
		private String reqestExpriemSeqno;
		private String reqestCode;
		private String expriemSeqno;
		private String mtrilSdspcSeqno;
		private String sdspcNm;
		private String jdgMntFomCode;
		private String lclValue;
		private String lclValueSeCode;
		private String uclValue;
		private String uclValueSeCode;
		private String lslValue;
		private String lslValueSeCode;
		private String uslValue;
		private String uslValueSeCode;
		private String markCphr;
		private String textStdr;
		private String unitSeqno;
		private String lastResultRegisterId;
		private String lastResultRegistDte;
		private String lastQcResultRegisterId;
		private String lastQcResultRegistDte;
		private String eqpmnClCode;
		private String analsOpinion;
		private String coaUpdtPosblAt;
		private String coaUseAt;
		private String lastExprOdr;
		private String fstRoot;
		private String secRoot;
		private String expriemNm;
		private String unitNm;


	/* 검색 */
	private String bplcCodeSch; //사업장
	private String mtrilNmSch; //자재명
	private String reqestNoSch; //의뢰번호
	private String inspctTyCodeSch; //검사유형
	private String stReqestDteSch; //접수시작일
	private String enReqestDteSch; //접수종료일
	private String stMnfcturDteSch; //제조시작일
	private String enMnfcturDteSch;	//제조종료일
	private String reqestDeptCodeSch; //의뢰팀
	private String custlabSeqnoSch;//분석실

	/* 기타 */
	private String key;
	private String value;
	private String gubun;
	private String sameLotNoGubun; //의뢰 수정할 때 LotNo 동일한게있는지 확인하기위한 구분값
	private int putExpriemCnt; //시험항목등록 및 수정 개수 체크
	private String expriemCoChk; //그리드에 있는 모든 시험항목수
	private String mtrilCode; //자재코드
	private String lotDc; //Lot 설명
	private String rLotDc; //Real Lot 설명
	private String rLotNo; //Real Lot 번호
	private String rOrdr; //Real Lot 순서
	private String rLotIdReqestSeqno; //Real Lot 의뢰시퀀스
	private String rUpperMtrilCode; //Real Lot 자재코드
	private String resultCode; //등록,수정,삭제 결과값
	private String rSortOrdr;
	private String vendorlotNoSch; //협력사COA팝업 협력업체 LotNo 검색변수
	private String exprNumot; //시험횟수(초,중,말 에 대한 순번)

	/* 결재 */
	private String sanctnSeqno; //결재 일련번호
	private String sanctnRecommanId; //결재 상신자 ID
	private String sanctnRecomDte; //결재 상신 일자
	private String sanctnKndCode; //결재 종류 코드 CM05
	private String sanctnProgrsSittnCode; //결재 진행 상황 코드 CM01
	private String useAt; //사용 여부
	private String rtnResn; //반려사유

	/* 결재 정보 */
	private String userNm; //결재자명, 결재정보에 보여주기 위한 용도
	private String totSanctnerCo; //총 결재자 수
	private String sanctnOrdr; //결재 순서
	private String sanctnSeCode; //결재 구분 코드

	/* 결재 라인 */
	private String sanctnLineSeqno; //마스터 결재라인 테이블 시퀀스

	/* 의뢰 정보폼 */
	private RequestMVo formData;

	/* 시험항목 그리드 */
	private List<RequestMVo> addedRequestDtlList; //추가된 시험항목 정보
	private List<RequestMVo> editedRequestDtlList; //수정된 시험항목 정보
	private List<RequestMVo> removedRequestDtlList; //삭제된 시험항목 정보

	/* 상위 LOT 그리드 */
	private List<RequestMVo> addedRequestUpperLotList; //추가된 상위 LOT 정보
	private List<RequestMVo> editedRequestUpperLotList; //수정된 상위 LOT 정보
	private List<RequestMVo> removedRequestUpperLotList; //삭제된 상위 LOT 정보

	/* 상위 LOT(실제) 그리드 */
	private List<RequestMVo> addedRequestUpperRealLotList; //추가된 상위 LOT(실제) 정보
	private List<RequestMVo> editedRequestUpperRealLotList; //수정된 상위 LOT(실제) 정보
	private List<RequestMVo> removedRequestUpperRealLotList; //삭제된 상위 LOT(실제) 정보

	/* 결재상신 */
	private List<RequestMVo> addedSanctnList; // 결재자가 필요한 검사 유형에 대한 클라이언트에서 넘긴 결재자 리스트
	private String sanctnerId; //결재자

	private String tmprField3Value; //결재 여부


	//결재 배포
	private String sanctnSj;
	private String sanctnCn;
	private String wdtbPrearngeDt;
	private String wdtbDt;
	private String wdtbSeqno;

	/* 두번째문자가 대문자로 시작하는 컬럼있어서 lombok 사용안함. */

	public String getReqestSeqno() {
		return reqestSeqno;
	}

	public void setReqestSeqno(String reqestSeqno) {
		this.reqestSeqno = reqestSeqno;
	}

	public String getBplcCode() {
		return bplcCode;
	}

	public void setBplcCode(String bplcCode) {
		this.bplcCode = bplcCode;
	}

	public String getBplcNm() {
		return bplcNm;
	}

	public void setBplcNm(String bplcNm) {
		this.bplcNm = bplcNm;
	}


	public String getReqestNo() {
		return reqestNo;
	}

	public void setReqestNo(String reqestNo) {
		this.reqestNo = reqestNo;
	}

	public String getMtrilSeqno() {
		return mtrilSeqno;
	}

	public void setMtrilSeqno(String mtrilSeqno) {
		this.mtrilSeqno = mtrilSeqno;
	}

	public String getMtrilNm() {
		return mtrilNm;
	}

	public void setMtrilNm(String mtrilNm) {
		this.mtrilNm = mtrilNm;
	}

	public String getInspctTyCode() {
		return inspctTyCode;
	}

	public void setInspctTyCode(String inspctTyCode) {
		this.inspctTyCode = inspctTyCode;
	}

	public String getInspctTyCodeNm() {
		return inspctTyCodeNm;
	}

	public void setInspctTyCodeNm(String inspctTyCodeNm) {
		this.inspctTyCodeNm = inspctTyCodeNm;
	}


	public String getReqestDte() {
		return reqestDte;
	}

	public void setReqestDte(String reqestDte) {
		this.reqestDte = reqestDte;
	}

	public String getMnfcturDte() {
		return mnfcturDte;
	}

	public void setMnfcturDte(String mnfcturDte) {
		this.mnfcturDte = mnfcturDte;
	}


	public String getOrdr() {
		return ordr;
	}

	public void setOrdr(String ordr) {
		this.ordr = ordr;
	}

	public String getLotNo() {
		return lotNo;
	}

	public void setLotNo(String lotNo) {
		this.lotNo = lotNo;
	}

	public String getLotCode() {
		return lotCode;
	}

	public void setLotCode(String lotCode) {
		this.lotCode = lotCode;
	}

	public String getFrstLotNo() {
		return frstLotNo;
	}

	public void setFrstLotNo(String frstLotNo) {
		this.frstLotNo = frstLotNo;
	}

	public String getVendorLotNo() {
		return vendorLotNo;
	}

	public void setVendorLotNo(String vendorLotNo) {
		this.vendorLotNo = vendorLotNo;
	}

	public String getVendorCoaReqestSeqno() {
		return vendorCoaReqestSeqno;
	}

	public void setVendorCoaReqestSeqno(String vendorCoaReqestSeqno) {
		this.vendorCoaReqestSeqno = vendorCoaReqestSeqno;
	}

	public String getVendorEntrpsSeqno() {
		return vendorEntrpsSeqno;
	}

	public void setVendorEntrpsSeqno(String vendorEntrpsSeqno) {
		this.vendorEntrpsSeqno = vendorEntrpsSeqno;
	}

	public String getVendorEntrpsNm() {
		return vendorEntrpsNm;
	}

	public void setVendorEntrpsNm(String vendorEntrpsNm) {
		this.vendorEntrpsNm = vendorEntrpsNm;
	}

	public String getVendorCoaAT() {
		return vendorCoaAT;
	}

	public void setVendorCoaAT(String vendorCoaAT) {
		this.vendorCoaAT = vendorCoaAT;
	}

	public String getReqestDeptCode() {
		return reqestDeptCode;
	}

	public void setReqestDeptCode(String reqestDeptCode) {
		this.reqestDeptCode = reqestDeptCode;
	}

	public String getReqestDeptNm() {
		return reqestDeptNm;
	}

	public void setReqestDeptNm(String reqestDeptNm) {
		this.reqestDeptNm = reqestDeptNm;
	}

	public String getClientId() {
		return clientId;
	}

	public void setClientId(String clientId) {
		this.clientId = clientId;
	}

	public String getClientNm() {
		return clientNm;
	}

	public void setClientNm(String clientNm) {
		this.clientNm = clientNm;
	}

	public String getExpriemCo() {
		return expriemCo;
	}

	public void setExpriemCo(String expriemCo) {
		this.expriemCo = expriemCo;
	}

	public String getRm() {
		return rm;
	}

	public void setRm(String rm) {
		this.rm = rm;
	}

	public String getVirtlLotAt() {
		return virtlLotAt;
	}

	public void setVirtlLotAt(String virtlLotAt) {
		this.virtlLotAt = virtlLotAt;
	}

	public String getReReqestAt() {
		return reReqestAt;
	}

	public void setReReqestAt(String reReqestAt) {
		this.reReqestAt = reReqestAt;
	}

	public String getJdgmntWordCode() {
		return jdgmntWordCode;
	}

	public void setJdgmntWordCode(String jdgmntWordCode) {
		this.jdgmntWordCode = jdgmntWordCode;
	}

	public String getProgrsSittnCode() {
		return progrsSittnCode;
	}

	public void setProgrsSittnCode(String progrsSittnCode) {
		this.progrsSittnCode = progrsSittnCode;
	}

	public String getProgrsSittnCodeNm() {
		return progrsSittnCodeNm;
	}

	public void setProgrsSittnCodeNm(String progrsSittnCodeNm) {
		this.progrsSittnCodeNm = progrsSittnCodeNm;
	}

	public String getLastAnalsDt() {
		return lastAnalsDt;
	}

	public void setLastAnalsDt(String lastAnalsDt) {
		this.lastAnalsDt = lastAnalsDt;
	}

	public String getRereqestNum() {
		return rereqestNum;
	}

	public void setRereqestNum(String rereqestNum) {
		this.rereqestNum = rereqestNum;
	}

	public String getRoaCreatAt() {
		return roaCreatAt;
	}

	public void setRoaCreatAt(String roaCreatAt) {
		this.roaCreatAt = roaCreatAt;
	}

	public String getCtmmnyOthbcAt() {
		return ctmmnyOthbcAt;
	}

	public void setCtmmnyOthbcAt(String ctmmnyOthbcAt) {
		this.ctmmnyOthbcAt = ctmmnyOthbcAt;
	}

	public String getLockAt() {
		return lockAt;
	}

	public void setLockAt(String lockAt) {
		this.lockAt = lockAt;
	}

	public String getDeleteAt() {
		return deleteAt;
	}

	public void setDeleteAt(String deleteAt) {
		this.deleteAt = deleteAt;
	}

	public String getLastChangerId() {
		return lastChangerId;
	}

	public void setLastChangerId(String lastChangerId) {
		this.lastChangerId = lastChangerId;
	}

	public String getLastChangeDt() {
		return lastChangeDt;
	}

	public void setLastChangeDt(String lastChangeDt) {
		this.lastChangeDt = lastChangeDt;
	}

	public String getValidPdCycle() {
		return validPdCycle;
	}

	public void setValidPdCycle(String validPdCycle) {
		this.validPdCycle = validPdCycle;
	}

	public String getValidPdCycleCode() {
		return validPdCycleCode;
	}

	public void setValidPdCycleCode(String validPdCycleCode) {
		this.validPdCycleCode = validPdCycleCode;
	}

	public String getValidDte() {
		return validDte;
	}

	public void setValidDte(String validDte) {
		this.validDte = validDte;
	}

	public String getMatchingLotNo() {
		return matchingLotNo;
	}

	public void setMatchingLotNo(String matchingLotNo) {
		this.matchingLotNo = matchingLotNo;
	}

	public String getrMatchingLotNo() {
		return rMatchingLotNo;
	}

	public void setrMatchingLotNo(String rMatchingLotNo) {
		this.rMatchingLotNo = rMatchingLotNo;
	}

	public String getLotNoCphr() {
		return lotNoCphr;
	}

	public void setLotNoCphr(String lotNoCphr) {
		this.lotNoCphr = lotNoCphr;
	}

	public String getLblDcOutptAt() {
		return lblDcOutptAt;
	}

	public void setLblDcOutptAt(String lblDcOutptAt) {
		this.lblDcOutptAt = lblDcOutptAt;
	}

	public String getLotTraceAtmcReqestAt() {
		return lotTraceAtmcReqestAt;
	}

	public void setLotTraceAtmcReqestAt(String lotTraceAtmcReqestAt) {
		this.lotTraceAtmcReqestAt = lotTraceAtmcReqestAt;
	}

	public String getEqpmnSeqno() {
		return eqpmnSeqno;
	}

	public void setEqpmnSeqno(String eqpmnSeqno) {
		this.eqpmnSeqno = eqpmnSeqno;
	}


	public String getBplcCodeSch() {
		return bplcCodeSch;
	}

	public void setBplcCodeSch(String bplcCodeSch) {
		this.bplcCodeSch = bplcCodeSch;
	}

	public String getMtrilNmSch() {
		return mtrilNmSch;
	}

	public void setMtrilNmSch(String mtrilNmSch) {
		this.mtrilNmSch = mtrilNmSch;
	}
	public String getReqestNoSch() {
		return reqestNoSch;
	}

	public void setReqestNoSch(String reqestNoSch) {
		this.reqestNoSch = reqestNoSch;
	}

	public String getInspctTyCodeSch() {
		return inspctTyCodeSch;
	}

	public void setInspctTyCodeSch(String inspctTyCodeSch) {
		this.inspctTyCodeSch = inspctTyCodeSch;
	}

	public String getStReqestDteSch() {
		return stReqestDteSch;
	}

	public void setStReqestDteSch(String stReqestDteSch) {
		this.stReqestDteSch = stReqestDteSch;
	}

	public String getEnReqestDteSch() {
		return enReqestDteSch;
	}

	public void setEnReqestDteSch(String enReqestDteSch) {
		this.enReqestDteSch = enReqestDteSch;
	}

	public String getStMnfcturDteSch() {
		return stMnfcturDteSch;
	}

	public void setStMnfcturDteSch(String stMnfcturDteSch) {
		this.stMnfcturDteSch = stMnfcturDteSch;
	}

	public String getEnMnfcturDteSch() {
		return enMnfcturDteSch;
	}

	public void setEnMnfcturDteSch(String enMnfcturDteSch) {
		this.enMnfcturDteSch = enMnfcturDteSch;
	}

	public String getReqestDeptCodeSch() {
		return reqestDeptCodeSch;
	}

	public void setReqestDeptCodeSch(String reqestDeptCodeSch) {
		this.reqestDeptCodeSch = reqestDeptCodeSch;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getGubun() {
		return gubun;
	}

	public void setGubun(String gubun) {
		this.gubun = gubun;
	}

	public String getSameLotNoGubun() {
		return sameLotNoGubun;
	}

	public void setSameLotNoGubun(String sameLotNoGubun) {
		this.sameLotNoGubun = sameLotNoGubun;
	}

	public int getPutExpriemCnt() {
		return putExpriemCnt;
	}

	public void setPutExpriemCnt(int putExpriemCnt) {
		this.putExpriemCnt = putExpriemCnt;
	}

	public String getExpriemCoChk() {
		return expriemCoChk;
	}

	public void setExpriemCoChk(String expriemCoChk) {
		this.expriemCoChk = expriemCoChk;
	}

	public String getMtrilCode() {
		return mtrilCode;
	}

	public void setMtrilCode(String mtrilCode) {
		this.mtrilCode = mtrilCode;
	}

	public String getLotDc() {
		return lotDc;
	}

	public void setLotDc(String lotDc) {
		this.lotDc = lotDc;
	}

	public String getrLotDc() {
		return rLotDc;
	}

	public void setrLotDc(String rLotDc) {
		this.rLotDc = rLotDc;
	}

	public String getrLotNo() {
		return rLotNo;
	}

	public void setrLotNo(String rLotNo) {
		this.rLotNo = rLotNo;
	}

	public String getrOrdr() {
		return rOrdr;
	}

	public void setrOrdr(String rOrdr) {
		this.rOrdr = rOrdr;
	}

	public String getrLotIdReqestSeqno() {
		return rLotIdReqestSeqno;
	}

	public void setrLotIdReqestSeqno(String rLotIdReqestSeqno) {
		this.rLotIdReqestSeqno = rLotIdReqestSeqno;
	}

	public String getrUpperMtrilCode() {
		return rUpperMtrilCode;
	}

	public void setrUpperMtrilCode(String rUpperMtrilCode) {
		this.rUpperMtrilCode = rUpperMtrilCode;
	}

	public String getResultCode() {
		return resultCode;
	}

	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}

	public String getrSortOrdr() {
		return rSortOrdr;
	}

	public void setrSortOrdr(String rSortOrdr) {
		this.rSortOrdr = rSortOrdr;
	}

	public String getVendorlotNoSch() {
		return vendorlotNoSch;
	}

	public void setVendorlotNoSch(String vendorlotNoSch) {
		this.vendorlotNoSch = vendorlotNoSch;
	}

	public String getExprNumot() {
		return exprNumot;
	}

	public void setExprNumot(String exprNumot) {
		this.exprNumot = exprNumot;
	}

	public String getSanctnSeqno() {
		return sanctnSeqno;
	}

	public void setSanctnSeqno(String sanctnSeqno) {
		this.sanctnSeqno = sanctnSeqno;
	}

	public String getSanctnRecommanId() {
		return sanctnRecommanId;
	}

	public void setSanctnRecommanId(String sanctnRecommanId) {
		this.sanctnRecommanId = sanctnRecommanId;
	}

	public String getSanctnRecomDte() {
		return sanctnRecomDte;
	}

	public void setSanctnRecomDte(String sanctnRecomDte) {
		this.sanctnRecomDte = sanctnRecomDte;
	}

	public String getSanctnKndCode() {
		return sanctnKndCode;
	}

	public void setSanctnKndCode(String sanctnKndCode) {
		this.sanctnKndCode = sanctnKndCode;
	}

	public String getSanctnProgrsSittnCode() {
		return sanctnProgrsSittnCode;
	}

	public void setSanctnProgrsSittnCode(String sanctnProgrsSittnCode) {
		this.sanctnProgrsSittnCode = sanctnProgrsSittnCode;
	}

	public String getUseAt() {
		return useAt;
	}

	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}

	public String getRtnResn() {
		return rtnResn;
	}

	public void setRtnResn(String rtnResn) {
		this.rtnResn = rtnResn;
	}

	public String getUserNm() {
		return userNm;
	}

	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}

	public String getTotSanctnerCo() {
		return totSanctnerCo;
	}

	public void setTotSanctnerCo(String totSanctnerCo) {
		this.totSanctnerCo = totSanctnerCo;
	}

	public String getSanctnOrdr() {
		return sanctnOrdr;
	}

	public void setSanctnOrdr(String sanctnOrdr) {
		this.sanctnOrdr = sanctnOrdr;
	}

	public String getSanctnSeCode() {
		return sanctnSeCode;
	}

	public void setSanctnSeCode(String sanctnSeCode) {
		this.sanctnSeCode = sanctnSeCode;
	}

	public String getSanctnLineSeqno() {
		return sanctnLineSeqno;
	}

	public void setSanctnLineSeqno(String sanctnLineSeqno) {
		this.sanctnLineSeqno = sanctnLineSeqno;
	}

	public RequestMVo getFormData() {
		return formData;
	}

	public void setFormData(RequestMVo formData) {
		this.formData = formData;
	}

	public List<RequestMVo> getAddedRequestDtlList() {
		return addedRequestDtlList;
	}

	public void setAddedRequestDtlList(List<RequestMVo> addedRequestDtlList) {
		this.addedRequestDtlList = addedRequestDtlList;
	}

	public List<RequestMVo> getEditedRequestDtlList() {
		return editedRequestDtlList;
	}

	public void setEditedRequestDtlList(List<RequestMVo> editedRequestDtlList) {
		this.editedRequestDtlList = editedRequestDtlList;
	}

	public List<RequestMVo> getRemovedRequestDtlList() {
		return removedRequestDtlList;
	}

	public void setRemovedRequestDtlList(List<RequestMVo> removedRequestDtlList) {
		this.removedRequestDtlList = removedRequestDtlList;
	}

	public List<RequestMVo> getAddedRequestUpperLotList() {
		return addedRequestUpperLotList;
	}

	public void setAddedRequestUpperLotList(List<RequestMVo> addedRequestUpperLotList) {
		this.addedRequestUpperLotList = addedRequestUpperLotList;
	}

	public List<RequestMVo> getEditedRequestUpperLotList() {
		return editedRequestUpperLotList;
	}

	public void setEditedRequestUpperLotList(List<RequestMVo> editedRequestUpperLotList) {
		this.editedRequestUpperLotList = editedRequestUpperLotList;
	}

	public List<RequestMVo> getRemovedRequestUpperLotList() {
		return removedRequestUpperLotList;
	}

	public void setRemovedRequestUpperLotList(List<RequestMVo> removedRequestUpperLotList) {
		this.removedRequestUpperLotList = removedRequestUpperLotList;
	}

	public List<RequestMVo> getAddedRequestUpperRealLotList() {
		return addedRequestUpperRealLotList;
	}

	public void setAddedRequestUpperRealLotList(List<RequestMVo> addedRequestUpperRealLotList) {
		this.addedRequestUpperRealLotList = addedRequestUpperRealLotList;
	}

	public List<RequestMVo> getEditedRequestUpperRealLotList() {
		return editedRequestUpperRealLotList;
	}

	public void setEditedRequestUpperRealLotList(List<RequestMVo> editedRequestUpperRealLotList) {
		this.editedRequestUpperRealLotList = editedRequestUpperRealLotList;
	}

	public List<RequestMVo> getRemovedRequestUpperRealLotList() {
		return removedRequestUpperRealLotList;
	}

	public void setRemovedRequestUpperRealLotList(List<RequestMVo> removedRequestUpperRealLotList) {
		this.removedRequestUpperRealLotList = removedRequestUpperRealLotList;
	}

	public List<RequestMVo> getAddedSanctnList() {
		return addedSanctnList;
	}

	public void setAddedSanctnList(List<RequestMVo> addedSanctnList) {
		this.addedSanctnList = addedSanctnList;
	}

	public String getSanctnerId() {
		return sanctnerId;
	}

	public void setSanctnerId(String sanctnerId) {
		this.sanctnerId = sanctnerId;
	}

	public String getTmprField3Value() {
		return tmprField3Value;
	}

	public void setTmprField3Value(String tmprField3Value) {
		this.tmprField3Value = tmprField3Value;
	}

	public String getSanctnCn() {
		return sanctnCn;
	}

	public void setSanctnCn(String sanctnCn) {
		this.sanctnCn = sanctnCn;
	}

	public String getWdtbPrearngeDt() {
		return wdtbPrearngeDt;
	}

	public void setWdtbPrearngeDt(String wdtbPrearngeDt) {
		this.wdtbPrearngeDt = wdtbPrearngeDt;
	}

	public String getWdtbDt() {
		return wdtbDt;
	}

	public void setWdtbDt(String wdtbDt) {
		this.wdtbDt = wdtbDt;
	}

	public String getWdtbSeqno() {
		return wdtbSeqno;
	}

	public void setWdtbSeqno(String wdtbSeqno) {
		this.wdtbSeqno = wdtbSeqno;
	}

	public String getMtrilTyCode() {
		return mtrilTyCode;
	}

	public void setMtrilTyCode(String mtrilTyCode) {
		this.mtrilTyCode = mtrilTyCode;
	}

	public String getCustlabSeqno() {
		return custlabSeqno;
	}

	public void setCustlabSeqno(String custlabSeqno) {
		this.custlabSeqno = custlabSeqno;
	}

	public String getSploreNm() {
		return sploreNm;
	}

	public void setSploreNm(String sploreNm) {
		this.sploreNm = sploreNm;
	}

	public String getMtrilCylndrSeqno() {
		return mtrilCylndrSeqno;
	}

	public void setMtrilCylndrSeqno(String mtrilCylndrSeqno) {
		this.mtrilCylndrSeqno = mtrilCylndrSeqno;
	}

	public String getMtrilItmSeqno() {
		return mtrilItmSeqno;
	}

	public void setMtrilItmSeqno(String mtrilItmSeqno) {
		this.mtrilItmSeqno = mtrilItmSeqno;
	}

	public String getElctcQy() {
		return elctcQy;
	}

	public void setElctcQy(String elctcQy) {
		this.elctcQy = elctcQy;
	}

	public String getElctcCn() {
		return elctcCn;
	}

	public void setElctcCn(String elctcCn) {
		this.elctcCn = elctcCn;
	}
	public String getRcepterId() {
		return rcepterId;
	}

	public void setRcepterId(String rcepterId) {
		this.rcepterId = rcepterId;
	}

	public String getRceptDt() {
		return rceptDt;
	}

	public void setRceptDt(String rceptDt) {
		this.rceptDt = rceptDt;
	}

	public String getVendorReqestAt() {
		return vendorReqestAt;
	}

	public void setVendorReqestAt(String vendorReqestAt) {
		this.vendorReqestAt = vendorReqestAt;
	}

	public String getVendorCoareqestSeqno() {
		return vendorCoareqestSeqno;
	}

	public void setVendorCoareqestSeqno(String vendorCoareqestSeqno) {
		this.vendorCoareqestSeqno = vendorCoareqestSeqno;
	}

	public String getEntrpsSeqno() {
		return entrpsSeqno;
	}

	public void setEntrpsSeqno(String entrpsSeqno) {
		this.entrpsSeqno = entrpsSeqno;
	}

	public String getPrductDc() {
		return prductDc;
	}

	public void setPrductDc(String prductDc) {
		this.prductDc = prductDc;
	}

	public String getReqestExpriemSeqno() {
		return reqestExpriemSeqno;
	}

	public void setReqestExpriemSeqno(String reqestExpriemSeqno) {
		this.reqestExpriemSeqno = reqestExpriemSeqno;
	}

	public String getReqestCode() {
		return reqestCode;
	}

	public void setReqestCode(String reqestCode) {
		this.reqestCode = reqestCode;
	}

	public String getExpriemSeqno() {
		return expriemSeqno;
	}

	public void setExpriemSeqno(String expriemSeqno) {
		this.expriemSeqno = expriemSeqno;
	}

	public String getMtrilSdspcSeqno() {
		return mtrilSdspcSeqno;
	}

	public void setMtrilSdspcSeqno(String mtrilSdspcSeqno) {
		this.mtrilSdspcSeqno = mtrilSdspcSeqno;
	}

	public String getSdspcNm() {
		return sdspcNm;
	}

	public void setSdspcNm(String sdspcNm) {
		this.sdspcNm = sdspcNm;
	}

	public String getJdgMntFomCode() {
		return jdgMntFomCode;
	}

	public void setJdgMntFomCode(String jdgMntFomCode) {
		this.jdgMntFomCode = jdgMntFomCode;
	}

	public String getLclValue() {
		return lclValue;
	}

	public void setLclValue(String lclValue) {
		this.lclValue = lclValue;
	}

	public String getLclValueSeCode() {
		return lclValueSeCode;
	}

	public void setLclValueSeCode(String lclValueSeCode) {
		this.lclValueSeCode = lclValueSeCode;
	}

	public String getUclValue() {
		return uclValue;
	}

	public void setUclValue(String uclValue) {
		this.uclValue = uclValue;
	}

	public String getUclValueSeCode() {
		return uclValueSeCode;
	}

	public void setUclValueSeCode(String uclValueSeCode) {
		this.uclValueSeCode = uclValueSeCode;
	}

	public String getLslValue() {
		return lslValue;
	}

	public void setLslValue(String lslValue) {
		this.lslValue = lslValue;
	}

	public String getLslValueSeCode() {
		return lslValueSeCode;
	}

	public void setLslValueSeCode(String lslValueSeCode) {
		this.lslValueSeCode = lslValueSeCode;
	}

	public String getUslValue() {
		return uslValue;
	}

	public void setUslValue(String uslValue) {
		this.uslValue = uslValue;
	}

	public String getUslValueSeCode() {
		return uslValueSeCode;
	}

	public void setUslValueSeCode(String uslValueSeCode) {
		this.uslValueSeCode = uslValueSeCode;
	}

	public String getMarkCphr() {
		return markCphr;
	}

	public void setMarkCphr(String markCphr) {
		this.markCphr = markCphr;
	}

	public String getTextStdr() {
		return textStdr;
	}

	public void setTextStdr(String textStdr) {
		this.textStdr = textStdr;
	}

	public String getUnitSeqno() {
		return unitSeqno;
	}

	public void setUnitSeqno(String unitSeqno) {
		this.unitSeqno = unitSeqno;
	}

	public String getLastResultRegisterId() {
		return lastResultRegisterId;
	}

	public void setLastResultRegisterId(String lastResultRegisterId) {
		this.lastResultRegisterId = lastResultRegisterId;
	}

	public String getLastResultRegistDte() {
		return lastResultRegistDte;
	}

	public void setLastResultRegistDte(String lastResultRegistDte) {
		this.lastResultRegistDte = lastResultRegistDte;
	}

	public String getEqpmnClCode() {
		return eqpmnClCode;
	}

	public void setEqpmnClCode(String eqpmnClCode) {
		this.eqpmnClCode = eqpmnClCode;
	}

	public String getAnalsOpinion() {
		return analsOpinion;
	}

	public void setAnalsOpinion(String analsOpinion) {
		this.analsOpinion = analsOpinion;
	}

	public String getCoaUpdtPosblAt() {
		return coaUpdtPosblAt;
	}

	public void setCoaUpdtPosblAt(String coaUpdtPosblAt) {
		this.coaUpdtPosblAt = coaUpdtPosblAt;
	}

	public String getCoaUseAt() {
		return coaUseAt;
	}

	public void setCoaUseAt(String coaUseAt) {
		this.coaUseAt = coaUseAt;
	}

	public String getLastExprOdr() {
		return lastExprOdr;
	}

	public void setLastExprOdr(String lastExprOdr) {
		this.lastExprOdr = lastExprOdr;
	}

	public String getLastQcResultRegistDte() {
		return lastQcResultRegistDte;
	}

	public void setLastQcResultRegistDte(String lastQcResultRegistDte) {
		this.lastQcResultRegistDte = lastQcResultRegistDte;
	}

	public String getLastQcResultRegisterId() {
		return lastQcResultRegisterId;
	}

	public void setLastQcResultRegisterId(String lastQcResultRegisterId) {
		this.lastQcResultRegisterId = lastQcResultRegisterId;
	}

	public String getFstRoot() {
		return fstRoot;
	}

	public void setFstRoot(String fstRoot) {
		this.fstRoot = fstRoot;
	}

	public String getSecRoot() {
		return secRoot;
	}

	public void setSecRoot(String secRoot) {
		this.secRoot = secRoot;
	}

	public String getExpriemNm() {
		return expriemNm;
	}

	public void setExpriemNm(String expriemNm) {
		this.expriemNm = expriemNm;
	}

	public String getUnitNm() {
		return unitNm;
	}

	public void setUnitNm(String unitNm) {
		this.unitNm = unitNm;
	}

	public String getPrductSeCode() {
		return prductSeCode;
	}

	public void setPrductSeCode(String prductSeCode) {
		this.prductSeCode = prductSeCode;
	}

	public String getEntrpsNm() {
		return entrpsNm;
	}

	public void setEntrpsNm(String entrpsNm) {
		this.entrpsNm = entrpsNm;
	}
}
