package lims.src.controller;

import lims.src.service.QCConditionMService;
import lims.src.vo.QCConditionMVo;
import lims.util.Locale.SetLocale;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;


@Controller
@RequestMapping("/src")
public class QCConditionMController {

    @Resource(name="QCConditionMServiceImpl")
    private QCConditionMService qCConditionMService;

    @SetLocale()
    @RequestMapping(value="/QCConditionM.lims")
    public String QCConditionM(Model model){
        return"src/QCConditionM";
    }

    @SetLocale()
    @RequestMapping(value = "QCConditionChartM.lims")
    public String ChartM(Model model, HttpServletRequest request) {
        return "src/QCConditionChartM";
    }

    @RequestMapping(value="getQcconditionList.lims")
    public @ResponseBody
    List<QCConditionMVo> getQcconditionList(@RequestBody QCConditionMVo vo){
        return qCConditionMService.getQcconditionList(vo);
}

    @RequestMapping(value="getQcconditionInspctList.lims")
    public @ResponseBody
    List<QCConditionMVo> getQcconditionInspctList(@RequestBody QCConditionMVo vo){
        return qCConditionMService.getQcconditionInspctList(vo);
    }
    @RequestMapping(value="getQcconditionMtrilList.lims")
    public @ResponseBody
    List<QCConditionMVo> getQcconditionMtrilList(@RequestBody QCConditionMVo vo){
        return qCConditionMService.getQcconditionMtrilList(vo);
    }

    @RequestMapping(value="getQcconditionPrductList.lims")
    public @ResponseBody
    List<QCConditionMVo> getQcconditionPrductList(@RequestBody QCConditionMVo vo){
        return qCConditionMService.getQcconditionPrductList(vo);
    }


}
