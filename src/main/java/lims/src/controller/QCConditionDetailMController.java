package lims.src.controller;


import lims.src.service.QCConditionDetailMService;

import lims.src.vo.PedigeeMVo;
import lims.src.vo.QCConditionDetailMVo;
import lims.util.Locale.SetLocale;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/src")
public class QCConditionDetailMController {

    @Resource(name="QCConditionDetailMServiceImpl")
    private QCConditionDetailMService qCConditionDetailMService;

    @SetLocale()
    @RequestMapping(value="/QCConditionDetailM.lims")
    public String QCConditionDetailM(Model model){
        return"src/QCConditionDetailM";
    }

    @RequestMapping(value="getQcconditionDetailList.lims")
    public @ResponseBody
    List<QCConditionDetailMVo> getQcconditionDetailList(@RequestBody QCConditionDetailMVo vo){
        return qCConditionDetailMService.getQcconditionDetailList(vo);
    }
    @RequestMapping(value="getQcconditionDetailData.lims")
    public @ResponseBody
    List<QCConditionDetailMVo> getQcconditionDetailData(@RequestBody QCConditionDetailMVo vo){
        return qCConditionDetailMService.getQcconditionDetailData(vo);
    }

}
