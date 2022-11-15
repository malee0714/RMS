package lims.qa.dao;
import lims.com.vo.CmExmntDto;
import lims.qa.vo.NcrMVo;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface NcrMDao {
    void updateExmntSeqno(CmExmntDto cmExmntDto);

    List<NcrMVo> getNcrList(NcrMVo vo);

    void insertNcr(NcrMVo ncrMVo);

    void updateNcr(NcrMVo ncrMVo);

    void updateNcrSanctn(NcrMVo ncrMVo);

    List<NcrMVo> getExprGrid(NcrMVo vo);

    List<NcrMVo> ncrExpriemGrid(NcrMVo vo);

    void insNcrExpriem(NcrMVo row);

    void updNcrExpriem(NcrMVo ncrMVo);

    int deleteNcr(NcrMVo ncrMVo);

    void delNcrExpriem(NcrMVo row);
}
