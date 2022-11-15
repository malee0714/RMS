package lims.rsc.service;

import java.util.List;

import lims.rsc.vo.QualfStdrMVo;

public interface QualfStdrMService {
	//조회
	public List<QualfStdrMVo> getQualfStdr(QualfStdrMVo vo);
	//저장
	public int saveQualfStdr(QualfStdrMVo vo);
	//삭제
	public int delQualfStdr(QualfStdrMVo vo);
	
	public List<QualfStdrMVo> getScoreList(QualfStdrMVo vo);
	public List<QualfStdrMVo> getBaseLineList(QualfStdrMVo vo);

}
