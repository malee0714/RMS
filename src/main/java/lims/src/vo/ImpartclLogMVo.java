package lims.src.vo;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class ImpartclLogMVo {
	String partclMntrngSeqno;	// 키값
	String mhrlsSeqno;	// 기기 키값
	String mesureDt; /* 측정 일시 */
	String mesure1Value; /* 측정1 값 */
	String mesure2Value; /* 측정2 값 */
	String mesure3Value; /* 측정3 값 */
	String mesure4Value; /* 측정4 값 */
	String mhrlsNm;		// 기기명
	String stMesureDt;	// 측정일 시작일
	String endMesureDt;	// 측정일 종료일
	String stMesureP;
	
	String key;	//콤보키
	String value; // 콤보밸유
	
	String chartImg;	// 차트 이미지 데이터
	
	//메인 화면 알림팝업 변수
	String partclSeCodeNm;
	String mesureExpriemNm;
	String mesureValue;
}