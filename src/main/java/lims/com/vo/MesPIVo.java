package lims.com.vo;

import lombok.Data;

@Data
public class MesPIVo {
	private String intrfcKey;            /* 인터페이스 키 */
	private String intrfcRecptnDt;            /* 인터페이스 수신 일시 */
	private String fctryCode;            /* 공장 코드 */
	private String reqestSeqNo;            /* 의뢰 일련 번호 */
	private String reqestSeText;            /* 의뢰 구분 텍스트 */
	private String mtrilCode;            /* 자재 코드 */
	private String inspctRequstQtt;            /* 검사 요청 수량 */
	private String inspctProgrsSttusCode;            /* 검사 진행 상태 코드 */
	private String reqestDte;            /* 의뢰 일자 */
	private String clientNm;            /* 의뢰자 명 */
	private String reqestSeDc;            /* 의뢰 구분 설명 */
	private String mnfcturDte;            /* 제조 일자 */
	private String processTyCode;            /* 프로세스 타입 코드 */
	private String prductSeCode;            /* 제품 구분 코드 */
	private String reqestDeptCode;            /* 의뢰 부서 코드 */
	private String tankNm;            /* TANK 명 */
	private String infTranType;            /* 인터페이스 처리유형 */
	private String infKey;            /* 인터페이스 처리 키 */
	private String infResult;            /* EAI 처리 결과 */
	private String infErrMsg;            /* 에러 메시지 */
	private String infDatetime;            /* EAI 처리 시간 */

	private String reqestSeqno;            /* 의뢰 일련번호 */
	private String lotId;            /* LOT_ID */
	private String expriemSeCode;            /* 시험항목 구분 코드 */
	private String inspctVer;            /* 검사 버전 */
	private String expriemSeqno;            /* 시험항목 일련번호 */
	private String sortOrdr;            /* 정렬 순서 */
	private String exprNumot;            /* 시험 횟수 */
	private String processTime;            /* 처리 시간 */
	private String unitSeqno;            /* 단위 일련번호 */
	private String mhrlsSeqno;            /* 기기 일련번호 */
	private String expriemSeNm;            /* 시험항목 구분 명 */
	private String expriemNm;            /* 시험항목 명 */
	private String jdgmntWordCode;            /* 판정 용어 코드 */
	private String dataDcsnAt;            /* 데이터 확정 여부 */
	private String reqestExpriemSeqno;            /* 의뢰 시험항목 일련번호 */
	private String resultRegisterNm;            /* 결과 등록자 명 */
	private String exprOdr;            /* 시험 차수 */
	private String firstManagelnMummValue;            /* 1차 관리선 최소 값 */
	private String firstManagelnMxmmValue;            /* 1차 관리선 최대 값 */
	private String scdManagelnMummValue;            /* 2차 관리선 최소 값 */
	private String scdManagelnMxmmValue;            /* 2차 관리선 최대 값 */
	private String resultValue1;            /* 결과 값 1 */
	private String resultValue2;            /* 결과 값 2 */
	private String resultValue3;            /* 결과 값 3 */
	private String resultValue4;            /* 결과 값 4 */
	private String resultValue5;            /* 결과 값 5 */
	private String resultValue6;            /* 결과 값 6 */
	private String resultValue7;            /* 결과 값 7 */
	private String resultValue8;            /* 결과 값 8 */
	private String resultValue9;            /* 결과 값 9 */
	private String resultValue10;            /* 결과 값 10 */
	private String resultValue11;            /* 결과 값 11 */
	private String resultValue12;            /* 결과 값 12 */
	private String resultValue13;            /* 결과 값 13 */
	private String resultValue14;            /* 결과 값 14 */
}
