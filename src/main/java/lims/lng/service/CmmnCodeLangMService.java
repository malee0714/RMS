package lims.lng.service;

import java.util.List;

import lims.lng.vo.CmmnCodeLangMVo;
import lims.sys.vo.MenuMVo;

public interface CmmnCodeLangMService {

	public List<CmmnCodeLangMVo> getCmmnLang(CmmnCodeLangMVo vo);

	public int saveCmmnlang(List<CmmnCodeLangMVo> list, CmmnCodeLangMVo vo);

}
