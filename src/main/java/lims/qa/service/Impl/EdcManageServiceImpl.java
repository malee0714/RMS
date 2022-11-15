package lims.qa.service.Impl;

import lims.qa.dao.EdcManageDao;
import lims.qa.service.EdcManageService;
import lims.qa.vo.EdcManageDto;
import lims.util.CommonFunc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EdcManageServiceImpl implements EdcManageService {

    private final EdcManageDao edcManageDao;

    private final CommonFunc commonFunc;

    @Autowired
    public EdcManageServiceImpl(EdcManageDao edcManageDao, CommonFunc commonFunc) {
        this.edcManageDao = edcManageDao;
        this.commonFunc = commonFunc;
    }

    @Override
    public List<EdcManageDto> getEdcList(EdcManageDto edcManageDto) {
        return edcManageDao.getEdcList(edcManageDto);
    }

    @Override
    public List<EdcManageDto> getEdcUserList(EdcManageDto edcManageDto) {
        return edcManageDao.getEdcUserList(edcManageDto);
    }

    @Override
    public String saveEdc(EdcManageDto edcManageDto) {
        String crudStr = "";

        List<EdcManageDto> gridData = edcManageDto.getGridData();
        List<EdcManageDto> addedRow = edcManageDto.getAddedRow();
        List<EdcManageDto> editedRow = edcManageDto.getEditedRow();
        List<EdcManageDto> removedRow = edcManageDto.getRemovedRow();
        
        // 교육정보 삭제
        if (("Y").equals(edcManageDto.getDeleteAt())) {
            edcManageDao.updEdc(edcManageDto);

            for (EdcManageDto dto : gridData) {
                if (!commonFunc.isEmpty(dto.getEdcUserSeqno())) {
                    dto.setDeleteAt("y");
                    edcManageDao.updEdcUser(dto);
                }
            }

            return "delete";
        }

        // 신규등록
        if (edcManageDto.isNew()) {
            edcManageDao.insEdc(edcManageDto);

            if (edcManageDto.isAdded()) {
                for (EdcManageDto row : addedRow) {
                    row.setEdcSeqno(edcManageDto.getEdcSeqno());
                    edcManageDao.insEdcUser(row);
                }
            }

            crudStr = "save";

        // 수정
        } else {
            edcManageDao.updEdc(edcManageDto);

            // 추가된 row insert
            if (edcManageDto.isAdded()) {
                for (EdcManageDto row : addedRow) {
                    row.setEdcSeqno(edcManageDto.getEdcSeqno());
                    edcManageDao.insEdcUser(row);
                }
            }

            // 수정된 row update
            if (edcManageDto.isEdited()) {
                for (EdcManageDto row : editedRow) {
                    row.setEdcSeqno(edcManageDto.getEdcSeqno());
                    edcManageDao.updEdcUser(row);
                }
            }

            // 삭제된 row delete
            if (edcManageDto.isRemoved()) {
                for (EdcManageDto row : removedRow) {
                    row.setEdcSeqno(edcManageDto.getEdcSeqno());
                    row.setDeleteAt("Y");
                    edcManageDao.updEdcUser(row);
                }
            }

            crudStr = "save";
        }

        return crudStr;
    }

}
