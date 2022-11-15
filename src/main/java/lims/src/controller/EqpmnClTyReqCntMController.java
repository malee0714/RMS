package lims.src.controller;

import lims.src.service.EqpmnClTyReqCntMService;
import lims.src.vo.EqpmnClTyReqCntMVo;
import lims.util.Locale.SetLocale;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/src")
public class EqpmnClTyReqCntMController {

    @Autowired
    private EqpmnClTyReqCntMService eqpmnClTyReqCntMServiceImpl;

    @SetLocale
    @RequestMapping(value = "EqpmnClTyReqCntM.lims")
    public String EqpmnClTyReqCntM(Model model) {
        return "src/EqpmnClTyReqCntM";
    }

    @RequestMapping(value = "getEqpClReqCntByMnth.lims")
    public @ResponseBody List<EqpmnClTyReqCntMVo> getEqpClReqCntByMnth(@RequestBody EqpmnClTyReqCntMVo vo) {
        return eqpmnClTyReqCntMServiceImpl.getEqpClReqCntByMnth(vo);
    }

}
