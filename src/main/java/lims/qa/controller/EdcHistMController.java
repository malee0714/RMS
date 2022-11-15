package lims.qa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.qa.service.EdcHistMService;
import lims.qa.vo.EdcManageDto;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/qa")
public class EdcHistMController {

    private final EdcHistMService edcHistMServiceImpl;

    @Autowired
    public EdcHistMController(EdcHistMService edcHistMServiceImpl) {
        this.edcHistMServiceImpl = edcHistMServiceImpl;
    }
    
    @SetLocale()
    @RequestMapping("EdcHistM.lims")
    public String EdcHistM(Model model) {
        return "qa/EdcHistM";
    }
    
    @RequestMapping("getEdcAllList.lims")
    @ResponseBody
    public List<EdcManageDto> getEdcAllList(@RequestBody EdcManageDto edcManageDto) {
        try {
            return edcHistMServiceImpl.getEdcAllList(edcManageDto);
        } catch (Exception e) {
            throw new CustomException(e, edcManageDto, "교육대상자 조회에 실패하였습니다.");
        }
    }
    
}
