package lims.test.controller;

import lims.test.service.RoaUploadMService;
import lims.test.vo.RoaUploadMVo;
import lims.util.Locale.SetLocale;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;

@Controller
@RequestMapping("/test")
public class RoaUploadMController {

    @Resource(name = "roaUploadMServiceImpl")
    private RoaUploadMService roaUploadMServiceImpl;

    //SetLocale 을 Model 객체에 넣어서 DispathcerServlet을 통해 뷰페이지에 전달
    @SetLocale
    @RequestMapping(value = "/RoaUploadM.lims")
    public String RoaM(Model model){    
        return "test/RoaUploadM";
    }

    @RequestMapping(value = "/getUploadAvailability.lims")
    public @ResponseBody RoaUploadMVo getUploadAvailability(MultipartHttpServletRequest request) throws Exception {
        return roaUploadMServiceImpl.getUploadAvailability(request);
    }

    @RequestMapping(value = "/insRoaUpload.lims")
    public @ResponseBody int insRoaUpload(MultipartHttpServletRequest request) throws Exception {
        return roaUploadMServiceImpl.insRoaUpload(request);
    }

    @RequestMapping(value = "/getSavedData.lims")
    public @ResponseBody RoaUploadMVo getSavedData(@RequestBody RoaUploadMVo vo) {
        return roaUploadMServiceImpl.getSavedData(vo);
    }

    @RequestMapping(value = "getSampleRoaDownload.lims")
    public void getRdDownload(HttpServletResponse response) {
        try {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-Disposition", "attachment;filename=sample_roa.xlsx;");
            response.setHeader("Content-Transfer-Encoding", "binary");

            File file = new File("D:\\fileUpload\\SampleFile\\sample_roa.xlsx");
            InputStream is = new ByteArrayInputStream(FileUtils.readFileToByteArray(file));
            ServletOutputStream os = response.getOutputStream();
            int binaryRead;

            while ((binaryRead = is.read()) != -1) {
                os.write(binaryRead);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
