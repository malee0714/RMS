package lims.qa.service.Impl;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import lims.qa.dao.DocSeMDao;
import lims.qa.service.DocSeMService;
import lims.qa.vo.DocSeMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;

@Service
public class DocSeMServiceImpl implements DocSeMService {


	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Autowired
	private DocSeMDao docSeMDao;


	@Override
	public int confirmDocSeMGbnList(DocSeMVo vo){
		return docSeMDao.confirmDocSeMGbnList(vo);
	}

	// 그룹 코드 조회
	@Override
	public List<DocSeMVo> getDocSeMList(DocSeMVo vo){
		return docSeMDao.getDocSeMList(vo);
	}

	// 상세 코드 조회
	@Override
	public List<DocSeMVo> getDocSeMDetailList(DocSeMVo vo){
		return docSeMDao.getDocSeMDetailList(vo);
	}

	// 문서 구분 코드 입력 및 수정
	@Override
	public int putDocSeM(DocSeMVo vo) {
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);

		List<DocSeMVo> addedRowList = vo.getAddedRowList();
		List<DocSeMVo> removeRowList = vo.getRemovedRowList();
		
		int result = 0;
		
		for(int i=0; i < addedRowList.size(); i++) {
			String sLastChangerId = userMVo.getUserId();
			addedRowList.get(i).setLastChangerId(sLastChangerId); // 로그인 세션값 할당
			
			if(addedRowList.get(i).getGbnCrud() != "" && addedRowList.get(i).getGbnCrud() != null){
				
				if(addedRowList.get(i).getGbnCrud().equals("C")) { // CRUD 구분값이 C라면 insert
					// 행추가한 row는 i값으로 ordr 세팅
//					addedRowList.get(i).setSortOrdr(i+1);
					result = docSeMDao.insDocSeM(addedRowList.get(i));
				}
				
				if(addedRowList.get(i).getGbnCrud().equals("U")){ // CRUD 구분값이 U라면 update
					// 수정한 row는 그리드에 입력된 sortOrdr 값으로 세팅
//					addedRowList.get(i).setSortOrdr(addedRowList.get(i).getSortOrdr());  
					result = docSeMDao.updDocSeM(addedRowList.get(i));
				}
				
			// row 삭제하고 저장한 경우를 감안 => crud 구분값이 없어도 다시 순서대로 정렬
			}else {  
//				addedRowList.get(i).setSortOrdr(i);
				result = docSeMDao.updDocSeM(addedRowList.get(i));
			}
		}
		
		for(int i=0; i <removeRowList.size(); i++) {
			String sLastChangerId = userMVo.getUserId();
			addedRowList.get(i).setLastChangerId(sLastChangerId); // 로그인 세션값 할당
			result = docSeMDao.updDeleteAtSeM(removeRowList.get(i));
		}
		
		return result;
	}


	// 문서 구분 코드 상세 입력 및 수정
	@Override
	public int putDocSeMDetail(DocSeMVo vo) {
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		
		List<DocSeMVo> addedRowList = vo.getAddedRowList();
		List<DocSeMVo> removeRowList = vo.getRemovedRowList();
		
		int result = 0;
		
		for(int i=0; i <addedRowList.size(); i++) {
			String sLastChangerId = userMVo.getUserId();
			addedRowList.get(i).setLastChangerId(sLastChangerId); // 로그인 세션값 할당
			
			if(addedRowList.get(i).getGbnCrud() != "" && addedRowList.get(i).getGbnCrud()  != null){
				
				if(addedRowList.get(i).getGbnCrud().equals("C")) { // CRUD 구분값이 C라면 insert
					// 행추가한 row는 i값으로 ordr 세팅
					addedRowList.get(i).setSortOrdr(i);
					result = docSeMDao.insDocSeMDetail(addedRowList.get(i));
				}
				
				if(addedRowList.get(i).getGbnCrud().equals("U")){ // CRUD 구분값이 U라면 update
					// 수정한 row는 그리드에 입력된 sortOrdr 값으로 세팅
					addedRowList.get(i).setSortOrdr(addedRowList.get(i).getSortOrdr());
					result = docSeMDao.updDocSeMDetail(addedRowList.get(i));
				}
			
			// row 삭제하고 저장한 경우를 감안 => crud 구분값이 없어도 다시 순서대로 정렬
			}else {
				addedRowList.get(i).setSortOrdr(i);
				result = docSeMDao.updDocSeMDetail(addedRowList.get(i));
			}
		} 
		
		for(int i=0; i <removeRowList.size(); i++) {
			String sLastChangerId = userMVo.getUserId();
			removeRowList.get(i).setLastChangerId(sLastChangerId); // 로그인 세션값 할당
			result = docSeMDao.updDeleteAtSeDetailM(removeRowList.get(i));
		}
		
		return result;
	}

}
