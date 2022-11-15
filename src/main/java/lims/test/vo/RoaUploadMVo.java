package lims.test.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Getter
@Setter
@ToString
public class RoaUploadMVo {

    private String mtrilClManageSeqno;	// 자재 CL 관리 일련번호
    private String mtrilSeqno;			// 자재 일련번호
    private String lotNum;				// LOT 건수
    private String searchCycle;         // 검색 주기
    private String sgmLevl;				// 시그마 수준
    private String lastExecutDte;		// 최종 실행 일자
    private String nextExecutDte;		// 다음 실행 일자
    private String executCycle;			// 실행 주기
    private String cycleCode;			// ZSY14 주기 코드
    private String mtrilCode;			// 자재 코드
    private String mtrilNm;				// 자재 명
    private String useAt;				// 사용 여부
    private String mmnySeCode; 			// ZSY01 자사 구분 코드
    private String mmnySeCodeNm;		// ZSY01 자사 구분 코드 명
    private String lastChangerId;		// 최종 변경자 ID
    private String lastChangeDt;		// 최종 변경 일시

    //조회조건
    private String mmnySeCodeSch;		// 자재구분 코드
    private String bplcCodeSch;			// 사업장 코드
    private String mtrilTyCodeSch;		// 자재유형 코드, 프로세스 타입. SY02
    private String mtrilCodeSch;		// 자재 코드
    private String mtrilNmSch;			// 자재 명
    private String cntnrSeCodeSch;		// ZSY10 용기 구분 코드
    private String useAtSch;			// 사용 여부

    //Spc ryle 검색 시작일 종료일
    private String searchBeginDte;      // 검색 시작일 (제조일자)
    private String searchEndDte;        // 검색 종료일 (제조일자)
    
    private String gbnMsg;              //상태 구분 값
    private String sn;                  //순번
    private String exprNumot;           //시험 횟수
    private String expriemSeqno;        //시험항목 일련번호
    private String resultValue;         //결과 값
    private String expriemNm;           //시험항목 명
    private String sortOrdr;            //ROA 업로드 결과 순서정렬용

    //ROA 업로드에 그려줄 데이터
    LinkedHashMap<String, String> expriemNmMap;   //시험항목 명 맵
    List<Map<String, String>> expriemResultList; //시험 결과 값 리스트

    List<RoaUploadMVo> usedRoaUploadChkList;

}
