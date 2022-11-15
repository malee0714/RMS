package lims.sys.dao;

import java.util.List;

import lims.sys.vo.CoaFormMVo;

public interface CoaFormMDao {

	//출력물 정보 조회
	public List<CoaFormMVo> getCoaFormMList(CoaFormMVo vo);

	//출력물 정보 저장
	public int insCoaFormM(CoaFormMVo vo);

	//출력물 정보 수정
	public int updCoaFormM(CoaFormMVo vo);

	//출력물 이력 저장
	public void insCoaFormHistM(CoaFormMVo vo);

	//출력물 삭제
	public int deleteCoaFormM(CoaFormMVo vo);

	//최신 이력버전 조회
	public int getMaxHistVer(CoaFormMVo vo);

	//시퀀스에 해당하는 출력물 정보
	public CoaFormMVo getCoaFormSeqnoInfo(String printngSeqno);

}
