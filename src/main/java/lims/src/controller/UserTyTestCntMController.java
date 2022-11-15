package lims.src.controller;

import lims.src.service.UserTyTestCntMService;
import lims.src.vo.UserTyTestCntMVo;
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
public class UserTyTestCntMController {

    @Autowired
    private UserTyTestCntMService userTyTestCntMServiceImpl;

    @SetLocale
    @RequestMapping(value = "UserTyTestCntM.lims")
    public String UserTyTestCntM(Model model) {
        return "src/UserTyTestCntM";
    }

    @RequestMapping(value = "getUserReqCntByMnth.lims")
    public @ResponseBody List<UserTyTestCntMVo> getReqCntByUser(@RequestBody UserTyTestCntMVo vo) {
        return userTyTestCntMServiceImpl.getReqCntByUser(vo);
    }

}
