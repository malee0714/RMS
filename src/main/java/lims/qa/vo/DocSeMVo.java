package lims.qa.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DocSeMVo {
	
	private String docSeSeqno;            	/* 문서일련번호 */
	private String docSeCode;            	/* 문서구분코드 */
	private String docSeDetailCode;         /* 문서구분상세코드 */
	private String docSeNm;            		/* 문서명 */
	private String useAt;            		/* 사용 여부 */
	private String deleteAt;            	/* 삭제 여부 */
	private String lastChangerId;           /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	private int sortOrdr;                   /* 정렬 순서 */
	
	private String docSeDetailNm;
	private String docSeDetailSeqno;
	private String wdtbEstbsAt;
	
	private String gbnCrud;
	private String docSeNmSch;
	private String useAtSch;
	private String entrpsChoiseEssntlAt;
    private String mtrilChoiseEssntlAt;
	
	
	List<DocSeMVo> addedRowList;
	List<DocSeMVo> removedRowList;
}
