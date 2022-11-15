package lims.qa.service;

import lims.qa.vo.EdcManageDto;

import java.util.List;

public interface EdcManageService {

    List<EdcManageDto> getEdcList(EdcManageDto edcManageDto);
    List<EdcManageDto> getEdcUserList(EdcManageDto edcManageDto);
    String saveEdc(EdcManageDto edcManageDto);

}
