package lims.qa.service;

import java.util.List;

import lims.com.vo.CmExmntDto;
import lims.qa.vo.DocDto;

public interface DocMService {
	List<DocDto> getDocList(DocDto vo);

	List<DocDto> getDocHistList(DocDto vo);

	int insDocM(DocDto vo);

	List<DocDto> getDocSanctnLineCombo(DocDto vo);

	int insConfirmM(DocDto vo);

	List<DocDto> getMtrilNmCombo(DocDto vo);

	List<DocDto> getEntrpsNmCombo(DocDto vo);

	int docNoChk(DocDto vo);


	void saveExmnt(CmExmntDto cmExmntDto);

	void revertDoc(DocDto docDto);
}
