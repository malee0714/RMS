package lims.sys.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Setter
@Getter
@ToString
public class MenuMVo {
	private String menuSeqno;						/* 메뉴 일련번호 */
	private int upperMenuSeqno;					/* 상위 메뉴 일련번호 */
	private String menuChildSeqno;
	private String menuNm;						/* 메뉴명 */
	private String menuDc;						/* 메뉴 설명 */
	private String mnlCn;						/* 매뉴얼 내용 */
	private byte[] blobMnlCn;					/* BLOB 메뉴얼 내용 */
	private String menuUrl;						/* 메뉴 URL */
	private String menuLv;						/* 메뉴 분류 */
	private String sortOrdr;					/* 정렬 순서 */
	private String useAt;						/* 사용 여부 */
	private String mnlUseAt;					/* 매뉴얼 사용 여부 */
	private String lastChangerId;				/* 최종 변경자 ID */
	private String lastChangeDt;				/* 최종 변경 일시 */
	private String menuAth;						/* 조회 사용 여부 */
	private String value;
	private String key;
	private String bestInspctInsttCode;
	private String ctmmnyOthbcAt;

	private String userId;
	private String menuOne;						/* 메뉴1차 분류 */
	private String menuTwo;						/* 메뉴2차 분류 */
	private String menuNmSearch;				/* 메뉴 명(검색용) */

	private String menuCd1;
	private String menuNm1;
	private String menuCd2;
	private String menuNm2;
	private String menuCd3;
	private String menuNm3;
	private String menuCd4;
	private String menuNm4;

	private String locale;

	private String langMenuSeqno;            /* 언어 메뉴 일련번호 */
	private String nationLangCode;            /* ZSY06 국가 언어 코드 */
	private String langNm;            /* 언어 명 */
	private String deleteAt;            /* 삭제 여부 */
	private String langCode;

	private List<MenuMVo> children;
	private List<MenuMVo> topMenu;
	private List<MenuMVo> leftMenu;
	private String returnStr;

	private String langCodeNm;
	private String menuSeqnoSch;
	private String langNmSch;
	private String useAtSch;
	private String nationLangCodeSch;

	private String auditAt; /*audit 여부*/
}
