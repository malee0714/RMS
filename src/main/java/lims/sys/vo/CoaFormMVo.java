package lims.sys.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CoaFormMVo {

	private String printngSeqno; //출력물 일련번호
	private String printngSeCode; //ZSY15_출력물 구분 코드
	private String printngSeCodeNm; //출력물 구분 명
	private String printngNm; //출력물 명
	private String printngUploadFileNm; //출력물 업로드 파일 명
	private String printngOrginlFileNm; //출력물 원본 파일 명
	private String printngCours; //출력물 경로
	private String entrpsSeqno; //업체일련번호
	private String entrpsSeqnoNm; //업체명
	private String mtrilSeqno; //자재일련번호
	private String mtrilSeqnoNm; //자재명
	private String histVer; //이력 버전
	private String rm; //비고
	private String useAt; //사용 여부
	private String bplcCode; //사업장코드
	private String bplcCodeNm; //사업장명
	private String lastChangerId; //최종 변경자 ID
	private String lastChangeDt; //최종 변경 일시
	private String dwldFileSeCode; // SY17 다운로드 파일 구분 코드
	private String ctmmnyMtrilCode; //고객사 자재코드
	private String avrgApplcAt; //평균 적용여부

	// 조회조건 변수
	private String printngSeCodeSch; //ZSY15_출력물 구분 코드
	private String printngNmSch; //출력물 명
	private String printngUploadFileNmSch; //출력물 파일 명
	private String useAtSch; //사용여부
	private String entrpsNmSch; //업체명
	private String mtrilNmSch; //자재명
	private String bplcCodeSch; //사업장명

	//ERROR 처리용 COA 페이지 작업 시 수정 필요
	private String result;
	private String coaFormNm;

}
