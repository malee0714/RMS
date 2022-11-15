package lims.sys.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.sys.vo.CoaFormMVo;

public interface CoaFormMService {

	//출력물 정보 조회
	public List<CoaFormMVo> getCoaFormMList(CoaFormMVo vo);

	//출력물 관리정보 저장
	public int saveCoaFormM(MultipartHttpServletRequest request);

	//출력물 삭제
	public int deleteCoaFormM(CoaFormMVo vo);

	//파일 다운로드
	public void getCoaDownload(String printngSeqno, String histVer, HttpServletResponse response);

}
