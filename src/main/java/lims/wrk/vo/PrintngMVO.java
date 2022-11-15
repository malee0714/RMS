package lims.wrk.vo;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@JsonInclude(Include.NON_NULL)
public class PrintngMVO {

	private String printngSeqno; //출력물 일련번호
	private String printngSeCode; //ZSY15_출력물 구분 코드
	private String printngSeCodeNm; //출력물 구분 명
	private String printngNm; //출력물 명
	private String printngUploadFileNm; //출력물 업로드 파일 명
	private String printngOrginlFileNm; //출력물 원본 파일 명
	private String printngCours; //출력물 경로
	private String histVer; //이력 버전
	private String rm; //비고
	private String useAt; //사용 여부
	private String lastChangerId; //최종 변경자 ID
	private String lastChangeDt; //최종 변경 일시

	// 조회조건 변수
	private String printngSeCodeSch; //ZSY15_출력물 구분 코드
	private String printngNmSch; //출력물 명
	private String printngUploadFileNmSch; //출력물 파일 명
	private String useAtSch; //사용여부

	private String lblDcOutptAtVal; //의뢰화면에서 사용할 프린팅 URL을 가져오기 위한 구분값

}
