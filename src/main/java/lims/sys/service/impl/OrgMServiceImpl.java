package lims.sys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.sys.dao.OrgMDao;
import lims.sys.service.OrgMService;
import lims.sys.vo.OrgMVo;

@Service
public class OrgMServiceImpl implements OrgMService {

	@Autowired
    private OrgMDao OrgMDao;

	@Override
	public List<OrgMVo> getBestComboList(OrgMVo vo) {
		return OrgMDao.getBestComboList(vo);
	}

	@Override
	public List<OrgMVo> getAuthorCodeList(OrgMVo vo) {
		return OrgMDao.getAuthorCodeList(vo);
	}
	
	@Override
	public List<OrgMVo> getUpperComboList(OrgMVo vo) {
		return OrgMDao.getUpperComboList(vo);
	}
	
	@Override
	public List<OrgMVo> getUpperComboListAll(OrgMVo vo) {
		return OrgMDao.getUpperComboListAll(vo);
	}

	@Override
	public List<OrgMVo> getOrgMList(OrgMVo vo) {
		return OrgMDao.getOrgMList(vo);
	}

	@Override
	public int insOrgM(OrgMVo vo) {
		return OrgMDao.insOrgM(vo);
	}

	@Override
	public int updOrgM(OrgMVo vo) {
		return OrgMDao.updOrgM(vo);
	}

}