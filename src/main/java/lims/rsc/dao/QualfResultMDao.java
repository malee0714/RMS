package lims.rsc.dao;

import java.util.List;

import lims.rsc.vo.QualfStdrMVo;
import lims.rsc.vo.QualfResultMVo;


public interface QualfResultMDao {

	public List<QualfResultMVo> getQualfStdrReg(QualfResultMVo vo);

	public List<QualfStdrMVo> getUserCombo(QualfStdrMVo vo);
	//tab1 조회
	public List<QualfResultMVo> getQualification(QualfResultMVo vo);
	//tab2 조회
	public List<QualfResultMVo> getSkill(QualfResultMVo vo);
	//tab3 조회
	public List<QualfResultMVo> getEducation(QualfResultMVo vo);
	

	public List<QualfResultMVo> getQualfElgblList(QualfResultMVo vo);

	public List<QualfResultMVo> getAbility(QualfResultMVo vo);


	public int insQualfResult(QualfResultMVo vo);

	public List<QualfResultMVo> getQualfList(QualfResultMVo vo);

	public List<QualfResultMVo> getElgblList(QualfResultMVo vo);

	public int insQualfRegist(QualfResultMVo vo);

	public int updRegist(QualfResultMVo vo);

	public int updQualfResult(QualfResultMVo qualfResultMVo);

	public int delQualfResult(QualfResultMVo qualfResultMVo);

	public String getUserQualf(QualfResultMVo vo);

	public int updRegistSeqno(QualfResultMVo vo);

	public List<QualfResultMVo> getQualfRec(QualfResultMVo vo);
	




}
