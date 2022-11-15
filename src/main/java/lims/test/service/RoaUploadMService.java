package lims.test.service;

import lims.test.vo.RoaUploadMVo;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface RoaUploadMService {

    RoaUploadMVo getUploadAvailability(MultipartHttpServletRequest request) throws Exception;

    int insRoaUpload(MultipartHttpServletRequest request) throws Exception;

    RoaUploadMVo getSavedData(RoaUploadMVo vo);
}
