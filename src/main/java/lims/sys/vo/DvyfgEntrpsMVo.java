package lims.sys.vo;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class DvyfgEntrpsMVo {
	
	private String dlivyDvyfgEntrpsSeqno; /* 출고 납품 업체 일련번호 */
	private String dvyfgEntrpsCode; /* 납품 업체 코드 */
	private String dvyfgEntrpsNm; /* 납품 업체 명 */
	private String deleteAt; /* 삭제 여부 */
	private String dvyfgEntrpsSeCode; /*납품업체 구분 코드*/
	private String dvyfgEntrpsSeNm; /*납품업체 구분 코드 명*/
	private String crud;
	
	private String shrDvyfgEntrpsCode;
	private String shrDvyfgEntrpsNm;
}
