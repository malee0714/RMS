package lims.qa.dao;

import lims.com.vo.CmExmntDto;
import lims.qa.vo.DocDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface DocMDao {
	List<DocDto> getDocList(DocDto vo);

	List<DocDto> getDocHistList(DocDto vo);

	int insDocM(DocDto vo);

	int updDeleteAt(DocDto vo);

	int updLastAt(DocDto vo);

	List<DocDto> getDocSanctnLineCombo(DocDto vo);

	int updSanctnSeqno(DocDto vo);

	int updDocM(DocDto vo);

	List<DocDto> getSanctnInfo(DocDto vo);

	List<DocDto> getMtrilNmCombo(DocDto vo);
	
	int updWdtbSeqno(DocDto vo);

	List<DocDto> getEntrpsNmCombo(DocDto vo);

	int docNoChk(DocDto vo);

	void updateDocExmnt(CmExmntDto cmExmntDto);
}
