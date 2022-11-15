package lims.test.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface ResultInputPscMService {
	
	/**
	 * 등록파일 업로드, 시험결과 저장
	 * @param request
	 * @return
	 */
	public HashMap<String, Object> paraUpload(MultipartHttpServletRequest request);
}
