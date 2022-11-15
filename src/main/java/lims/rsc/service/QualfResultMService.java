package lims.rsc.service;

import java.util.List;

import lims.rsc.vo.QualfStdrMVo;
import lims.rsc.vo.QualfResultMVo;

public interface QualfResultMService {
	//조회
	public List<QualfResultMVo> getQualfStdrReg(QualfResultMVo vo);
	
	public List<QualfResultMVo> getQualfRec(QualfResultMVo vo);
//	//tab2 조회
	public List<QualfResultMVo> getSkill(QualfResultMVo vo);

	public List<QualfResultMVo> getQualfElgblList(QualfResultMVo vo);
	public List<QualfResultMVo> getAbility(QualfResultMVo vo);
	public int saveQualfResult(QualfResultMVo vo);
	public List<QualfResultMVo> getQualfList(QualfResultMVo vo);
	public List<QualfResultMVo> getElgblList(QualfResultMVo vo);
	public int updQualfResult(QualfResultMVo vo);
	




}
