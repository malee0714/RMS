package lims.qa.dao;

import lims.qa.vo.EdcManageDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EdcManageDao {

    List<EdcManageDto> getEdcList(EdcManageDto edcManageDto);
    int insEdc(EdcManageDto edcManageDto);
    int updEdc(EdcManageDto edcManageDto);
    List<EdcManageDto> getEdcUserList(EdcManageDto edcManageDto);
    int insEdcUser(EdcManageDto edcManageDto);
    int updEdcUser(EdcManageDto edcManageDto);

}
