package lims.wrk.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.wrk.vo.PrintngMVO;

public interface PrintngMService {

	//출력물 정보 조회
	public List<PrintngMVO> getPrintngMList(PrintngMVO vo);
	
	//출력물 관리정보 저장
	public int savePrintngM(MultipartHttpServletRequest request);

	//출력물 삭제
	public int deletePrintngM(PrintngMVO vo);

	//파일 다운로드
	public void getRdDownload(String printngSeqno, String histVer, HttpServletResponse response);

}
