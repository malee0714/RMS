package lims.rsc.vo;

import java.util.Date;
import java.util.List;

import lims.req.vo.RequestMVo;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
@SuppressWarnings("unused")
public class MhrlsOprRequestMVo {
	
	private String oprDte;			 /*가동 일자*/
	private String mhrlsSeqno;		 /*기기 일련번호*/
	private String userId;			 /*이용자 ID*/
	private String oprNum;			 /*가동 건수*/
	private String ordr;			 /*순서*/
	private String reqestSeqno;		 /*의뢰 일련번호*/
	private String deleteAt;		 /*삭제 여부*/
	private String lastChangerId;	 /*최종 변경자 ID*/
	private String lastChangeDt;	 /*최종 변경 일시*/
	private String shrMhrlsManageNo; /*기기 관리 번호 검색*/
	private String shrMhrlsNm;		 /*기기 명 검색*/
	private String shrModlNo;		 /*모델 번호 검색*/
	private String shrOprBeginDteDte;/*가동 일자 시작일 검색*/
	private String shrOprEndDteDte;	 /*가동 일자 종료일 검색*/
	private String mhrlsManageNo;	 /*기기 관리 번호*/
	private String mhrlsNm;			 /*기기 명*/
	private String modlNo;			 /*모델 번호*/
	private String brcd;             /*바코드*/
	private String beginDt;			 /*시작일시*/
	private String endDt;				 /*종료일시*/
	private double oprTime;			 /*가동시간*/
	private String analsTeamSeqno;
	private List<MhrlsOprRequestMVo> gridData1; /*의뢰정보 그리드 행추가 저장*/
	private List<MhrlsOprRequestMVo> gridData2; /*의뢰정보 그리드 행삭제 저장*/
	private String mhrlsBrcd; 		/*바코드*/
	private String mhrlsBrcdSch; /*바코드 조회*/
}
