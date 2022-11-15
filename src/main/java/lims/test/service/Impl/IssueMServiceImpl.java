package lims.test.service.Impl;

import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.annotation.Resource;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import javax.imageio.ImageIO;
import javax.script.Invocable;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.binary.Hex;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.view.AbstractView;

import lims.com.service.CommonService;
import lims.com.vo.ChartVo;
import lims.sys.vo.UserMVo;
import lims.test.dao.IssueMDao;
import lims.test.service.IssueMService;
import lims.test.vo.IssueMVo;
import lims.test.vo.ResultInputMVo;
import lims.util.AES256Cipher;
import lims.util.GetUserSession;

@Service("IssueMService")
public class IssueMServiceImpl implements IssueMService{

	@Autowired
	private IssueMDao issueMDao;

	@Value("${chart.img.download}")
	private String chartImgPath;

	@Resource(name="commonServiceImpl")
	private CommonService commonService;

	/**
	 * 이슈관리 리스트 조회
	 */
	public List<IssueMVo> getIssueMList(IssueMVo vo){
		GetUserSession sessionD = new GetUserSession();
		vo.setAuthorSeCode(sessionD.getAuthorSeCode());
		List<IssueMVo> issueVo = new ArrayList<>();

		try{
			issueVo = issueMDao.getIssueMList(vo);

			for(int i=0; i<issueVo.size(); i++){
				String c = AES256Cipher.AES_Encode(issueVo.get(i).getIssueSeqno());
				issueVo.get(i).setC(c);
			}
		}catch(Exception e){
			e.getStackTrace();
		}

		return issueVo;

	}

	public static String getCurrentData(){

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");

        return sdf.format(new Date());

	}

	/**
	 * 이슈관리 차트 조회
	 */
	@Override
	public List<ChartVo> getIssueMChart(IssueMVo vo) {

		return issueMDao.getIssueMChart(vo);
	}



	@Override
	public List<ChartVo> getIssueMChartData(IssueMVo vo) {
		List<ChartVo> list = issueMDao.getIssueMChartData(vo);
		return list;
	}

	/**
	 * 이슈정보 신규 저장
	 */
	@Override
	public int insIssueInfo(IssueMVo vo) {
		// TODO Auto-generated method stub
		return issueMDao.insIssueInfo(vo);
	}

	/**
	 * 이슈 정보 수정
	 */
	@Override
	public int updIssueInfo(IssueMVo vo) {
		int result = 0;

		try{
			//A 승인 아니면 수정
			if(vo.getCrud().equals("A")){
				//승인자와 로그인한 사용자가 같으면 프로세스 올림
				if(vo.getIssueConfmerId().equals(GetUserSession.getUserId())){
					vo.setAppAt("Y");
				}
				else{
					vo.setAppAt("N");
				}

				result = issueMDao.updIssueInfo(vo);
				result = issueMDao.updImReqestLockAt(vo);

			}
			else{
				//저장 버튼 눌렀을때 이슈 등록 이면 이슈 처리로 프로세스 올림
				if(vo.getIssueProgrsSittnCodeIns().equals("IM11000002")){
					vo.setAppAt("Y");
				}
				//저장버튼 눌렀을때 이슈 처리면 프로세스 그대로 유지
				else if(vo.getIssueProgrsSittnCodeIns().equals("IM11000003")){
					vo.setAppAt("N");
				}

				result = issueMDao.updIssueInfo(vo);
				result = issueMDao.updImReqestLockAt(vo);

			}


		}catch(Exception e){
			e.getStackTrace();
		}

		return result;
	}


	//이메일전송 완료된 이슈 이메일전송 완료 여부 Y처리
	@Override
	public int updIssueExpriemAt(IssueMVo vo) {
		issueMDao.updIssueAt(vo);
		return issueMDao.updIssueExpriemAt(vo);
	}

	@Override
	public List<IssueMVo> getSendEmailInfo(ResultInputMVo vo) {
		return issueMDao.getSendEmailInfo(vo);
	}

	@Override
	public String getIssueMailCn(String vo){
		return issueMDao.getIssueMailCn(vo);
	}

	@Override
	public String saveChartImg(IssueMVo vo) {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		String time = sdf.format(cal.getTime());

		StringBuffer fileName = new StringBuffer();

		fileName.append(UUID.randomUUID().toString());
		fileName.append(".png");

		StringBuffer sb = new StringBuffer();

		byte[] imgData = Base64.decodeBase64(vo.getChartData().replaceAll("data:image/png;base64,", ""));


		ByteArrayInputStream inputStream = new ByteArrayInputStream(imgData);
		BufferedImage bufferedImage;
		try {

			StringBuffer root =  new StringBuffer();
//			root.append(chartImgPath);
			root.append("D:\\enf\\apache-tomcat-8.5.50\\webapps\\lims_chart\\");
			root.append(time);
			root.append("/");

			File folder = new File(root.toString());

			if(!folder.exists()) {
				folder.mkdirs();
			}

			bufferedImage = ImageIO.read(inputStream);
			sb.append(root);
			sb.append(fileName.toString());
			ImageIO.write(bufferedImage, "png", new File( sb.toString() ) ); //저장하고자 하는 파일 경로를 입력합니다.
		} catch (IOException e) {
			e.printStackTrace();
		}
		return sb.toString().replace("D:\\WebService\\apache-tomcat-8.5.40\\webapps\\lims_chart\\", "http://203.229.218.224:23001/lims_chart/");
	}

	@Override
	public int updMailCn(IssueMVo vo) {
		return issueMDao.updMailCn(vo);
	}

	@Override
	public List<IssueMVo> mainLcountList(IssueMVo vo) {

		return issueMDao.mainLcountList(vo);
	}

	@Override
	public List<IssueMVo> mainCcountList(IssueMVo vo) {

		return issueMDao.mainCcountList(vo);
	}

	@Override
	public int insMobphonCn(ResultInputMVo vo) {
		return issueMDao.insMobphonCn(vo);
	}

	@Override
	public String getMessageTitle(ResultInputMVo vo) {
		return issueMDao.getMessageTitle(vo);
	}

	/**
	 * 결재자 수정
	 */
	@Override
	public int approvedChange(IssueMVo vo) {
		return issueMDao.approvedChange(vo);
	}

}
