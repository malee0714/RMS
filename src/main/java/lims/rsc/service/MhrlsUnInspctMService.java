package lims.rsc.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import lims.rsc.vo.MhrlsUnInspctMVo;

public interface MhrlsUnInspctMService {
	
	/**
	 * 미등록 설비 검교정 목록 조회
	 * @param vo
	 * @return
	 */
	public List<MhrlsUnInspctMVo> getMhrlsUnInspctM(MhrlsUnInspctMVo vo);
	
	/**
	 * 미등록 설비 검교정 목록 조회 (월별)
	 * @param vo
	 * @return
	 */
	public List<MhrlsUnInspctMVo> getMonthMhrlsUnInspctM(MhrlsUnInspctMVo vo);
	
	/**
	 * 미등록 설비 검교정 목록 조회 (부서별)
	 * @param vo
	 * @return
	 */
	public List<MhrlsUnInspctMVo> getdeptMhrlsUnInspctM(MhrlsUnInspctMVo vo);
	
	/**
	 * 미등록 설비 검교정 목록 저장
	 * @param vo
	 * @return
	 */
	public int saveMhrlsUnInspctM(MhrlsUnInspctMVo vo);
	
	/**
	 * 양식 파일 업로드
	 * @param request
	 * @return
	 * @throws Exception 
	 */
	public int applyFormFile(MultipartHttpServletRequest request) throws Exception;

	

	
	
}
