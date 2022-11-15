package lims.com.vo;

import lombok.*;

@Getter @Setter @ToString
@Builder @NoArgsConstructor @AllArgsConstructor
public class FileDetailMVo {
	private int atchmnflSeqno;            /* 첨부파일 일련번호 */
	private int oldAtchmnflSeqno;     /*신규 첨부파일 일련번호*/
	private int fileSeqno;            /* 파일 일련번호 */
	private String streFileNm;            /* 저장 파일 명 */
	private String orginlFileNm;            /* 원본 파일 명 */
//	private String fileData;            /* 파일 데이터 */
	private byte[] fileData;            /* 파일 데이터 */
	private long fileMg;            /* 파일 크기 */
	private float formatFileMg;		/* 메가바이트로 변환된 크기 kkh */
	private String useAt;            /* 사용 여부 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	private String uuid;
	private int totFileMg;			/*총 개수*/
	private int totFileCnt;			/*총 크기*/
	private int offcsFileSeqno;		/*직인 일련번호*/
	private int logoFileSeqno;		/*로고 일련번호*/
	private boolean revision;       /*개정 모드*/
	private String prductUpperSeqno;
	
	private int printngSeqno;
	private String printngOrginlFileNm;
	private String printngUploadFileNm;
	private String printngCours;
	private String coaPblicteAtchmnflSeqno;
	private String coaEvdncAtchmnflSeqno;
}
