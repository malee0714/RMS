package lims.com.controller;

import lims.com.service.CmExmntDataService;
import lims.com.vo.CmExmntDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/com")
public class CmExmntDataController {

	private final CmExmntDataService cmExmntDataServiceImpl;

	@Autowired
	public CmExmntDataController(CmExmntDataService cmExmntDataServiceImpl) {
		this.cmExmntDataServiceImpl = cmExmntDataServiceImpl;
	}

	@RequestMapping("/getExmntHistory.lims")
	@ResponseBody
	public List<CmExmntDto> getExmntHistory(@RequestBody CmExmntDto cmExmntDto) {
		return cmExmntDataServiceImpl.getExmntHistory(cmExmntDto);
	}
	
}
