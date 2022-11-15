package lims.wrk.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ExcelFormMgmtMVo {

	//셀 관리
	private String excelSeqno; //EXCEL 일련번호
	private String excelFormNm; //EXCEL 양식 명
	private String excelFileNm; //EXCEL 파일 명
	private String histVer; //이력 버전
	private String sheetChoiseNm; //SHEET 선택 명
	private String sheetPrntngNm; //SHEET 인쇄 명
	private byte[] data; //데이터
	private String rm; //비고

	/* 엑셀 CELL 관리 */
	private String celSeqno; //셀 일련번호
	private String celCrdnt; //셀 좌표
	private String celDc; //셀 설명
	private String celBassValue; //셀 기본 값

	/* 엑셀이력 */
	private byte[] fileData; //파일 데이터

	/* 공통 */
	private String useAt; //사용여부
	private String deleteAt; //삭제여부
	private String lastChangerId; //최종 변경자 ID
	private String lastChangeDt; //최종 변경 일시

	/* 검색조건 */
	private String excelFileNmSch; //엑셀파일명
	private String excelFormNmSch; //엑셀양식명
	private String useAtSch; //사용여부

}
