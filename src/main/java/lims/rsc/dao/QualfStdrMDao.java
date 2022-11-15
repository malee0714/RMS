package lims.rsc.dao;

import java.util.List;

import lims.rsc.vo.QualfStdrMVo;

public interface QualfStdrMDao {

	public List<QualfStdrMVo> getQualfStdr(QualfStdrMVo vo);

	public int saveQualfStdr(QualfStdrMVo vo);

	public int upQualfStdr(QualfStdrMVo vo);

	public int delQualfStdr(QualfStdrMVo vo);

	public List<QualfStdrMVo> getBaseLineList(QualfStdrMVo vo);

	public List<QualfStdrMVo> getScoreList(QualfStdrMVo vo);

	public int insQualfStdrSe(QualfStdrMVo qualfStdrMVo);

	public int updQualfStdrSe(QualfStdrMVo qualfStdrMVo);

	public int delQualfStdrSe(QualfStdrMVo qualfStdrMVo);

}
