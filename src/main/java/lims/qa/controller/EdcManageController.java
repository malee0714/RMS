package lims.qa.controller;

import lims.qa.service.EdcManageService;
import lims.qa.vo.EdcManageDto;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Slf4j
@Controller
@RequestMapping(value = "/qa")
public class EdcManageController {

    private final EdcManageService edcManageService;

    @Autowired
    public EdcManageController(EdcManageService edcManageServiceImpl) {
        this.edcManageService = edcManageServiceImpl;
    }

    @SetLocale()
    @RequestMapping("EdcM.lims")
    public String EdcM(Model model) {
        return "qa/EdcM";
    }

    @RequestMapping(value = "getEdcList.lims")
    @ResponseBody
    public List<EdcManageDto> getEdcList(@RequestBody EdcManageDto edcManageDto) {
        try {
            return edcManageService.getEdcList(edcManageDto);
        } catch (Exception e) {
            throw new CustomException(e, edcManageDto, "교육목록 조회에 실패하였습니다.");
        }
    }

    @RequestMapping(value = "getEdcUserList.lims")
    @ResponseBody
    public List<EdcManageDto> getEdcUserList(@RequestBody EdcManageDto edcManageDto) {
        try {
            return edcManageService.getEdcUserList(edcManageDto);
        } catch (Exception e) {
            throw new CustomException(e, edcManageDto, "교육대상자 조회에 실패하였습니다.");
        }
    }

    @RequestMapping(value = "saveEdc.lims")
    @ResponseBody
    public String saveEdc(@RequestBody EdcManageDto edcManageDto) {
        try {
            return edcManageService.saveEdc(edcManageDto);
        } catch (Exception e) {
            throw new CustomException(e, edcManageDto, "교육정보 등록에 실패하였습니다.");
        }
    }

}
