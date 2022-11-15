package lims.qa.vo;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class QlityDocHistVo {
	
	private int qlityDocHistSeqno; // 품질 문서 이력 일련번호
	private String tableNm;        // 테이블 명
	private String tableCmNm;	   // 테이블 주석 명
	private String columnNm;       // 컬럼 명
	private String columnCmNm;     // 컬럼 주석 명
	private int seqno;             // 일련번호
	private String changeBfeCn;    // 변경 전 내용
	private String changeAfterCn;  // 변경 후 내용
	private String lastChangerId;  // 최종 변경자 ID
	private String changerNm;      // 최종 변경자 명
	private String lastChangeDt;   // 최종 변경 일시
	
	private String pageNm;         /* VOC 관련 테이블 이력 한번에 끌고 오기 위함 */
	
}
