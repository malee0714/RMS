package lims.req.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RequestSanctnMVo {

    /* 의뢰 */
    private String reqestSeqno; //의뢰 일련번호
    private String bplcCode; //사업장 코드
    private String bplcNm; //사업장 명
    private String upperReqestSeqno; //상위 의뢰 일련번호
    private String reqestNo; //의뢰 번호
    private String mtrilSeqno; //자재 일련번호
    private String mtrilNm; //자재 명
    private String inspctTyCode; //ZSY07 검사 유형 코드
    private String inspctTyCodeNm; //ZSY07 검사 유형 명
    private String partclrMatterCode; //ZIM99 특이 사항 코드
    private String reqestDte; //의뢰 일자
    private String mnfcturDte; //제조 일자
    private String emrgncyAt; //긴급 여부
    private String ordr; //순서
    private String mtrilEqpSeSeqno; //자재 설비 구분 일련번호
    private String mtrilVendorSeqno; //자재 벤더 일련번호
    private String lotNo; //LOT NO
    private String frstLotNo; //최초 LOT NO
    private String vendorLotNo; //벤더 LOT NO
    private String reqestDeptCode; //의뢰 부서 코드
    private String reqestDeptNm; //의뢰 부서 명
    private String clientId; //의뢰자 ID
    private String clientNm; //의뢰자 명
    private String expriemCo; //시험항목 수
    private String rm; //비고
    private String virtlLotAt; //가상 LOT 여부
    private String reReqestAt; //재 의뢰 여부
    private String jdgmntWordCode; //ZIM05 판정 용어 코드
    private String progrsSittnCode; //ZIM03 진행 상황 코드
    private String progrsSittnCodeNm; //ZIM03 진행 상황 코드 명
    private String lastAnalsDt; //최종 분석 일시
    private String rereqestNum; //재의뢰 건수
    private String roaCreatAt; //ROA 생성 여부
    private String ctmmnyOthbcAt; //고객사 공개 여부
    private String lockAt; //잠금 여부
    private String deleteAt; //삭제 여부
    private String lastChangerId; //최종 변경자 ID
    private String lastChangeDt; //최종 변경 일시
    private String vendorEntrpsSeqno; //벤더 업체 일련번호
    private String vendorCoaAt; //벤더 COA 여부
    private String vendorCoaReqestSeqno; //벤더 COA 의뢰 일련번호
    private String validPdCycle; //유효 기간 주기
    private String validPdCycleCode; //ZSY14 유효 기간 주기 코드
    private String validDte; //유효 일자
    private String dsuseDte; //폐기 일자
    private String duspsnId; //폐기자 ID
    private String rceptDt; //접수 일시
    private String rcepterId; //접수자 ID
    private String sanctnSeqno; //결재 일련번호
    private String analsComptPrearngeDte; //분석 완료 예정 일시

    /* 의뢰 시험항목 */
	private String reqestExpriemSeqno; //의뢰시험항목 일련번호
	private String expriemSeqno; //시험항목 일련번호
	private String expriemNm; //시험항목 명
	private String frstAnalsAt; //시험여부 초
	private String middleAnalsAt; //시험여부 중
	private String lastAnalsAt; //시험여부 말

    /* 의뢰 결재 */
    private String sanctnRecommanId; //결재 상신자 ID
    private String sanctnRecomDte; //결재 상신 일자
    private String sanctnKndCode; //결재 종류 코드(CM05)
    private String sanctnProgrsSittnCode; //결재 진행 상황 코드(CM01)
    private String useAt; //사용 여부

    /* 의뢰 결재 상세 */
    private String totSanctnerCo; //총 결재자 수
    private String sanctnOrdr; //결재 순서
    private String sanctnSeCode; //결재 구분 코드(CM02)
    private String sanctnerId; //결재자 ID
    private String sanctnDte; //결재 일자

    /* 반려 */
    private String returnerId; //반려자 ID
    private String rtnResn; //반려 사유

    /* 검색 조건 */
    private String bplcCodeSch; //사업장 명
    private String mtrilNmSch; //자재 명
    private String lotNoSch; //Lot No.
    private String reqestNoSch; //의뢰 번호
    private String inspctTyCodeSch; //검사 유형
    private String stReqestDteSch; //의뢰 시작 일자
    private String enReqestDteSch; //의뢰 종료 일자
    private String stMnfcturDteSch; //제조 시작 일자
    private String enMnfcturDteSch; //제조 종료 일자
    private String reqestDeptCodeSch; //의뢰팀

}
