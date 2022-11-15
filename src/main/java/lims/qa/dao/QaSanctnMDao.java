package lims.qa.dao;

import java.util.List;

import lims.qa.vo.DocDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QaSanctnMDao {

	List<DocDto> getQaSanctnList(DocDto vo);

	int approveSanctnInfo(DocDto docDto);

	int approveSanctnInfoNextAppn(DocDto docDto);

	int approveSanctn(DocDto docDto);

	int insRtnSanctn(DocDto docDto);

	int updSanctnInfoProgrsCode(DocDto docDto);

	int updSanctnProgrsCode(DocDto docDto);

	int updWdtbPosbAt(DocDto docDto);

	int updRtnSanctnUseAt(DocDto docDto);

	List<DocDto> getRtnList(DocDto vo);

	int insWdtbSanctn(DocDto docDto);

	int insWdtbTrgterSanctn(DocDto docDto);



}
