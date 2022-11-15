package lims.test.service;

import java.util.HashMap;

import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface ResultInputPfileMService {

	public HashMap<String, Object> fileTxtUpload(MultipartHttpServletRequest request)throws Exception;





}
