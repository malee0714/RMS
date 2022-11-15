package lims.sys.service.impl;

import lims.sys.dao.CmmnCodeMDao;
import lims.sys.service.CmmnCodeMService;
import lims.sys.vo.CmmnCodeMVo;
import lims.util.CommonFunc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.net.UnknownHostException;
import java.util.List;

@Service
public class CmmnCodeMServiceImpl implements CmmnCodeMService {

	private final CommonFunc commonFunc;
	private final CmmnCodeMDao cmmnCodeMDao;

	@Autowired
	public CmmnCodeMServiceImpl(CommonFunc commonFunc, CmmnCodeMDao cmmnCodeMDao) {
		this.commonFunc = commonFunc;
		this.cmmnCodeMDao = cmmnCodeMDao;
	}

	@Override
	public String getHostAddress(String ip) {
		try {
			// IPv6 loopback 실제 ip로 치환
			if (ip.equals("0:0:0:0:0:0:0:1")) {
				ip = java.net.InetAddress.getLocalHost().getHostAddress();
			}
		} catch(UnknownHostException e) {
			e.printStackTrace();
		}

		return ip;
	}

	@Override
	public int confirmCmmnCodeMGbnList(CmmnCodeMVo vo){
		return cmmnCodeMDao.confirmCmmnCodeMGbnList(vo);
	}
	
	@Override
	public List<CmmnCodeMVo> getCmmnCodeMTreeList(CmmnCodeMVo vo){
		return cmmnCodeMDao.getCmmnCodeMTreeList(vo);
	}

	@Override
	public int saveCmmnCodeM(List<CmmnCodeMVo> list) {
		int result = 0;

		for (CmmnCodeMVo vo : list) {
			if (!commonFunc.isEmpty(vo.getGbnCrud())) {

				// 상위그룹코드 값이 없는 객체는 상위그룹코드로 등록
				if (commonFunc.isEmpty(vo.getUpperCmmnCode())) {
					if (("C").equals(vo.getGbnCrud())) {
						result += cmmnCodeMDao.insCmmnCodeM(vo);
					} else {
						result += cmmnCodeMDao.updCmmnCodeM(vo);
					}

					// 상위그룹코드 값이 있는 객체는 해당 상위그룹에 하위코드로 등록
				} else {
					if (("C").equals(vo.getGbnCrud())) {
						result += cmmnCodeMDao.insCmmnCodeMDetail(vo);
					} else {
						result += cmmnCodeMDao.updCmmnCodeMDetail(vo);
					}
				}
			}
		}
		
		return result;
	}

	@Override
	public int sortCmmnCodeOrdr(List<CmmnCodeMVo> list) {
		int result = 0;
		int uppperOrdr = 1;
		int lowerOrdr = 1;

		for (CmmnCodeMVo vo : list) {
			if (commonFunc.isEmpty(vo.getUpperCmmnCode())) {
				vo.setSortOrdr(uppperOrdr);
				result += cmmnCodeMDao.updCmmnCodeOrdr(vo);

				uppperOrdr++;
				lowerOrdr = 1;

			} else {
				vo.setSortOrdr(lowerOrdr);
				result += cmmnCodeMDao.updCmmnCodeOrdr(vo);

				lowerOrdr++;
			}

		}

		return result;
	}


//	@Override
//	public List<CmmnCodeMVo> getCmmnCodeMList(CmmnCodeMVo vo){
//		return cmmnCodeMDao.getCmmnCodeMList(vo);
//	}

//	@Override
//	public int putCmmnCodeM(List<CmmnCodeMVo> vo) {
//		int result = 0;
//
//		for(int i=0; i < vo.size(); i++) {
//			if(vo.get(i).getGbnCrud() != "" && vo.get(i).getGbnCrud() != null){
//				if(vo.get(i).getGbnCrud().equals("C")) {
//					result += cmmnCodeMDao.insCmmnCodeM(vo.get(i));
//				}else if (vo.get(i).getGbnCrud().equals("U")) {
//					result += cmmnCodeMDao.updCmmnCodeM(vo.get(i));
//				}
//			}
//		}
//
//		return result;
//	}

//	@Override
//	public List<CmmnCodeMVo> getCmmnCodeMDetailList(CmmnCodeMVo vo){
//		return cmmnCodeMDao.getCmmnCodeMDetailList(vo);
//	}


//	@Override
//	public int putCmmnCodeMDetail(List<CmmnCodeMVo> vo) {
//		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
//		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
//
//		int result = 0;
//
//		for(int i=0; i < vo.size(); i++) {
//			String sLastChangerId = userMVo.getUserId();
//			vo.get(i).setLastChangerId(sLastChangerId);
//
//			if(vo.get(i).getGbnCrud() != "" && vo.get(i).getGbnCrud() != null){
//
//				if(vo.get(i).getGbnCrud().equals("C")) {
//					result += cmmnCodeMDao.insCmmnCodeMDetail(vo.get(i));
//				}else if (vo.get(i).getGbnCrud().equals("U")) {
//					result += cmmnCodeMDao.updCmmnCodeMDetail(vo.get(i));
//				}
//			}
//		}
//
//		return result;
//	}

}
