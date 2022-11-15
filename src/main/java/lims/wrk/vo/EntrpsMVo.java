package lims.wrk.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class EntrpsMVo {
	private String entrpsSeqno;            /* 업체 일련번호 */
	private String entrpsNm;            /* 업체 명 */
	private String entrpsEngNm;            /* 업체 영문 명 */
	private String bizcndNm;            /* 업태 명 */
	private String itemNm;            /* 종목 명 */
	private String bsnmRegistNo;            /* 사업자 등록 번호 */
	private String indutyNm;            /* 업종 명 */
	private String rprsntvNm;            /* 대표자 명 */
	private String rprsntvEngNm;            /* 대표자 영문 명 */
	private String sttemntOrPrmisnNo;            /* 신고 또는 허가 번호 */
	private String email;            /* 이메일 */
	private String telno;            /* 전화번호 */
	private String fxnum;            /* 팩스번호 */
	private String zip;            /* 우편번호 */
	private String adres;            /* 주소 */
	private String detailAdres;            /* 상세 주소 */
	private String delngBgnde;            /* 거래 시작일 */
	private String useAt;            /* 사용 여부 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	
	private String chargerSeqno;            /* 담당자 일련번호 */
	private String rs09ChrgSeCode;            /* RS09 담당 구분 코드 */
	private String chargerNm;            /* 담당자 명 */
	private String chargerDeptNm;            /* 담당자 부서 명 */
	private String chargerTelno;            /* 담당자 전화번호 */
	private String chargerFxnum;            /* 담당자 팩스번호 */
	private String chargerMoblphon;            /* 담당자 이동전화 */
	private String chargerEmail;            /* 담당자 이메일 */
	private String bassChargerAt;            /* 기본 담당자 여부 */
	private String rm;            /* 비고 */
	
	private String userId;
	private String udtId;
	private String Crud;
	private String gbnCrud;
	
	private String value;
	private String key;
	private String entrpsSeCode;			//업체 구분 코드
	private String entrpsSeNm;					//업체 구분 코드 명
	private String cmmncode;
	private String cmmnCodeNm;
	private String yn;
    private String srchentrpsNm; //조회 업체명
    private String srchrprsntvNm; //조회 대표자명
    private String srchbsnmRegistNo; //조회 사업자등록번호
    
    
    private String estmtEntrpsSeqno;		//견적 업체 일련 번호
	private String writngDeptCode;			//작성 부서 코드
	private String prqudoSeqno;				//견적 일련번호
	private String reqestSeqno;			//의뢰 일련번호
	
    // 06-16 추가
	private String sapCode;            /* SAP 코드 */
	private String deleteAt;            /* 삭제 여부 */
	private String entrpsSeCodeSch; 	// 업체구분 조회 	
	private String srcUseAt;			// 사용여부 조회

	private String bplcCode;
	private String mtrilSeqno;
	private String printngSeqno;
	private String printngSeCode;

}