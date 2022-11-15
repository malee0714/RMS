package lims.test.vo;

import java.util.List;

import lims.com.vo.ComboVo;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RoaMVo extends ResultInputMVo{
    private String lastChangerId;
    private String lastChangerNm;
    private String flag;
    private String updtResultValue;
    private String lslUsl;			/* 고객사 최저 기준규격 */
    private String lclUcl;			/* 내부 기준규격 */
    private String mtrilCode;
    private String processNm;
    private String changeAfterCn;
    private String changerId;
    private String histPblicteDt;


    private String no;
    private String key;
    private String value;
}

