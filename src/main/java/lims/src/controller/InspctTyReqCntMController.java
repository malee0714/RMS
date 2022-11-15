package lims.src.controller;

import lims.src.service.InspctTyReqCntMService;
import lims.src.vo.InspctTyReqCntMVo;
import lims.util.Locale.SetLocale;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/src")
public class InspctTyReqCntMController {

    @Autowired
    private InspctTyReqCntMService inspctTyReqCntMServiceImpl;

    @SetLocale
    @RequestMapping(value = "InspctTyReqCntM.lims")
    public String InspctTyReqCntM(Model model) {
        return "src/InspctTyReqCntM";
    }

    @RequestMapping(value = "/getReqCntByInspctTy.lims")
    public @ResponseBody InspctTyReqCntMVo getReqCntByInspctTy(@RequestBody InspctTyReqCntMVo vo) {
        return inspctTyReqCntMServiceImpl.getReqCntByInspctTy(vo);
    }

}
