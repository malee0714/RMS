package lims.com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;



import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.util.Util;

@Controller
@RequestMapping("/com")
public class RdController {
	
	private Util util = Util.getInstance();
	
	
	@RequestMapping("/Rd")
	public String Rd(HttpServletRequest request, Model model){
		return "com/Rd";
	}

	/**
	 * html5 RD viewer
	 */
	@RequestMapping("html5Viewer.lims")
	public @ResponseBody Map<String, String> html5Viewer(@RequestBody HashMap<String, String> map, HttpServletRequest request) throws Exception {
		String fileUrl = request.getServletContext().getRealPath("");
		map.put("loginParameter", "/rcontype ["+util.getRdContype()+"] /rf ["+ util.getDATA_SERVER() +"] /rsn ["+ util.getRdServiceNm() +"] /rui [" + util.getReportID() + "] /rpw [" + util.getReportPW() + "]");
		map.put("reportingServerPath", util.getREPORTING_SERVER());		
		map.put("rdPath", util.getSERVER_IP());
		map.put("fileUrl", fileUrl);
		return map;
	}

}
