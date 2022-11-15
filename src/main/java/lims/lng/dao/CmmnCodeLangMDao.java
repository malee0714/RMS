package lims.lng.dao;

import java.util.List;

import lims.lng.vo.CmmnCodeLangMVo;
import lims.sys.vo.MenuMVo;

public interface CmmnCodeLangMDao {

	public List<CmmnCodeLangMVo> getCmmnLang(CmmnCodeLangMVo vo);

	public int saveCmmnlang(CmmnCodeLangMVo cmmnCodeLangMVo);

	public int upCmmnlang(CmmnCodeLangMVo cmmnCodeLangMVo);

}
