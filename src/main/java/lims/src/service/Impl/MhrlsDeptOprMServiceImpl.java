package lims.src.service.Impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.src.dao.MhrlsDeptOprMDao;
import lims.src.service.MhrlsDeptOprMService;
import lims.src.vo.MhrlsDeptOprMVo;

@Service
public class MhrlsDeptOprMServiceImpl implements MhrlsDeptOprMService{

	@Autowired
	private MhrlsDeptOprMDao mhrlsDeptOprMDao;
	
	@Override
	public List<MhrlsDeptOprMVo> getmhrlsDeptOprList(MhrlsDeptOprMVo vo){
//		HashMap<String,Object> result = new HashMap<String,Object>();
//		HashMap<String,Object> result2 = new HashMap<String,Object>();
//		HashMap<String,Object> result3 = new HashMap<String,Object>();
//		HashMap<String,Object> result4 = new HashMap<String,Object>();
//		List<MhrlsDeptOprMVo> list = mhrlsDeptOprMDao.getmhrlsDeptOprList(vo);
//		for (int i=0; i<list.size(); i++ ) {
//			
//			result.put("mhrlsClNm", list.get(i).getMhrlsClNm());
//			 result2.put("mhrlsNm", list.get(i).getMhrlsNm());
//			 result3.put("reqestDept", list.get(i).getReqestDeptNm());
//			 result4.put("teamQy", list.get(i).getTeamQy());
//			 
//				result.putAll(result2);
//				result.putAll(result3);
//				result.putAll(result4);
//				System.out.println("가d>>>>"+result);
//				
//		}

		return mhrlsDeptOprMDao.getmhrlsDeptOprList(vo);
	}
}
