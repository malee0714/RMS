package lims.sys.service.impl;

import lims.sys.dao.NoticeWriteMDao;
import lims.sys.service.NoticeWriteMService;
import lims.sys.vo.NoticeWriteMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public class NoticeWriteMServiceImpl implements NoticeWriteMService{


	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Autowired
	private NoticeWriteMDao noticeWriteMDao;

	@Override
	public List<NoticeWriteMVo> getBbsCode(NoticeWriteMVo vo) {
		return noticeWriteMDao.getBbsCode(vo);
	}

	@Override
	public List<NoticeWriteMVo> getNoticeWriteMList(NoticeWriteMVo vo) {
		String authorCd = noticeWriteMDao.chkLoginAuthor();
		vo.setAuthorCd(authorCd);
		List<NoticeWriteMVo> transBlobToStringList = noticeWriteMDao.getNoticeWriteMList(vo);
		for(int i = 0; i < transBlobToStringList.size(); i++) {
			if(transBlobToStringList.get(i).getBlobCn() != null)
				transBlobToStringList.get(i).setCn(new String(transBlobToStringList.get(i).getBlobCn()));
		}
		return transBlobToStringList;
	}

	// 저장 및 수정
	@Override
	public int saveNoticeWriteM(NoticeWriteMVo vo) {
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		int result = 0;

		String sLastChangerId = userMVo.getUserId();
		String sUserNm = userMVo.getUserNm();
		vo.setLastChangerId(sLastChangerId); // 로그인 세션값 할당
		vo.setWrterId(sLastChangerId); // 작성자 ID값 할당
		vo.setWrterNm(sUserNm); // 작성자 명 할당
		if(vo.getCn() != null)
			vo.setBlobCn(vo.getCn().getBytes());
		System.out.println("cn : " + vo.getCn());
		if(vo.getGridCrud() != "" && vo.getGridCrud()  != null){
			if(vo.getGridCrud().equals("C")){ // CRUD 구분값이 C라면 insert
				result = noticeWriteMDao.insNoticeWriteM(vo);
			}

			if(vo.getGridCrud().equals("U")){ // CRUD 구분값이 U라면 update
				result = noticeWriteMDao.updNoticeWriteM(vo);
			}

			if(vo.getGridCrud().equals("D")){ // CRUD 구분값이 D라면 delete
				result = noticeWriteMDao.delNoticeWriteM(vo);
			}
		}

		// 저장로직에 사용한 게시글을 화면에서 셀선택표시 해주기 위해 리턴값으로 게시글 시퀀스를 반환
		return (result > 0) ? vo.getSntncSeqno() : result;
	}

	// 조회수 증가
	public int countNoticeWriteM(NoticeWriteMVo vo) {
		return noticeWriteMDao.countNoticeWriteM(vo);
	}

	// 답변 조회
	public NoticeWriteMVo getNoticeAnswerM(NoticeWriteMVo vo) {
		NoticeWriteMVo transBlobToStringVo = noticeWriteMDao.getNoticeAnswerM(vo);
		if(transBlobToStringVo.getBlobAnswerCn() != null)
			transBlobToStringVo.setAnswerCn(new String(transBlobToStringVo.getBlobAnswerCn()));
		return transBlobToStringVo;
	}

	// 답변 저장 및 수정
	public int saveNoticeAnswerM(NoticeWriteMVo vo) {
		//Service에서 세션값 받아오기
		HttpServletRequest httpServletRequest = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		UserMVo userMVo = commonFunc.getLoginUser(httpServletRequest);
		int result = 0;

		String sLastChangerId = userMVo.getUserId();
		vo.setLastChangerId(sLastChangerId); // 로그인 세션값 할당
		vo.setAnswrrId(sLastChangerId); // 작성자 ID값 할당
		if(vo.getAnswerCn() != null)
			vo.setBlobAnswerCn(vo.getAnswerCn().getBytes());

		if(vo.getGridCrud() != "" && vo.getGridCrud()  != null){
			if(vo.getGridCrud().equals("C")){ // CRUD 구분값이 C라면 insert
				result = noticeWriteMDao.insNoticeAnswerM(vo);
			}

			if(vo.getGridCrud().equals("U")){ // CRUD 구분값이 U라면 update
				result = noticeWriteMDao.updNoticeAnswerM(vo);
			}

			if(vo.getGridCrud().equals("D")){ // CRUD 구분값이 D라면 delete
				result = noticeWriteMDao.delNoticeAnswerM(vo);
			}
		}

		return result;
	}

}
