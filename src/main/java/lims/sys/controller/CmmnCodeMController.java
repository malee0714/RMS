package lims.sys.controller;

import lims.com.vo.EmailVo;
import lims.sys.service.CmmnCodeMService;
import lims.sys.vo.CmmnCodeMVo;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Properties;

@Slf4j
@Controller
@RequestMapping(value="/sys")
public class CmmnCodeMController {

	private final CmmnCodeMService cmmnCodeMService;

	@Autowired
	public CmmnCodeMController(CmmnCodeMService cmmnCodeMServiceImpl) {
		this.cmmnCodeMService = cmmnCodeMServiceImpl;
	}

//	@SetLocale()
//	@RequestMapping(value = "CmmnCodeM.lims")
//	public String cmmnCodeM(Model model) {
//		return "sys/CmmnCodeM";
//	}
	
	@SetLocale()
	@RequestMapping(value = "CmmnCodeM.lims")
	public String cmmnCodeM(Model model) {
		return "sys/CmmnCodeMTree";
	}

	@RequestMapping(value = "confirmCmmnCodeMGbnList.lims")
	@ResponseBody
	public int confirmCmmnCodeMGbnList(@RequestBody CmmnCodeMVo vo) {
		try {
			return cmmnCodeMService.confirmCmmnCodeMGbnList(vo);
		} catch (Exception e) {
			throw new CustomException(e, vo, "그룹코드 중복여부 검증에 실패하였습니다.");
		}
	}

	@RequestMapping(value="getCmmnCodeMTreeList.lims")
	@ResponseBody
	public List<CmmnCodeMVo> getCmmnCodeMTreeList(@RequestBody CmmnCodeMVo vo) {
		try {
			return cmmnCodeMService.getCmmnCodeMTreeList(vo);
		} catch (Exception e) {
			throw new CustomException(e, vo, "그룹코드 조회에 실패하였습니다.");
		}
	}

	@RequestMapping(value = "saveCmmnCodeM.lims")
	@ResponseBody
	public int saveCmmnCodeM(@RequestBody List<CmmnCodeMVo> list) {
		try {
			return cmmnCodeMService.saveCmmnCodeM(list);
		} catch (Exception e) {
			throw new CustomException(e, list, "그룹코드 등록에 실패하였습니다");
		}
	}

	@RequestMapping(value = "sortCmmnCodeOrdr.lims")
	@ResponseBody
	public int sortCmmnCodeOrdr(@RequestBody List<CmmnCodeMVo> list) {
		try {
			return cmmnCodeMService.sortCmmnCodeOrdr(list);
		} catch (Exception e) {
			throw new CustomException(e, list, "정렬순서 저장에 실패하였습니다.");
		}
	}

//	@RequestMapping(value = "getCmmnCodeMDetailList.lims")
//	@ResponseBody
//	public List<CmmnCodeMVo> getCmmnCodeMDetailList(@RequestBody CmmnCodeMVo vo) {
//		return cmmnCodeMService.getCmmnCodeMDetailList(vo);
//	}

//	@RequestMapping(value="getCmmnCodeMList.lims")
//	@ResponseBody
//	public List<CmmnCodeMVo> getCmmnCodeMList(@RequestBody CmmnCodeMVo vo) {
//		return cmmnCodeMService.getCmmnCodeMList(vo);
//	}

//	@RequestMapping(value = "putCmmnCodeM.lims")
//	public @ResponseBody int putCmmnCodeM(@RequestBody List<CmmnCodeMVo> vo) {
//		return cmmnCodeMService.putCmmnCodeM(vo);
//	}
//
//	@RequestMapping(value = "putCmmnCodeMDetail.lims")
//	public @ResponseBody int putCmmnCodeMDetail(@RequestBody List<CmmnCodeMVo> vo) {
//		return cmmnCodeMService.putCmmnCodeMDetail(vo);
//	}

	/** 자바 메일 발송 * @throws MessagingException * @throws AddressException **/
	@RequestMapping(value = "mailSender.lims")
	public void mailSender(HttpServletRequest request) throws AddressException, MessagingException {
		// 네이버일 경우 smtp.naver.com 을 입력합니다.
		// Google일 경우 smtp.gmail.com 을 입력합니다.
		String host = "smtp.naver.com";
		final String username = "jessic32";  //네이버 아이디를 입력해주세요. @nave.com은 입력하지 마시구요.
		final String password = "kim4071!@#";  //네이버 이메일 비밀번호를 입력해주세요.
		int port=465; //포트번호
		//587
		//465

		// 메일 내용
		String recipient = "jessic32@naver.com"; //받는 사람의 메일주소를 입력해주세요.
		String subject = "메일테스트"; //메일 제목 입력해주세요.
		String body = username+"님으로 부터 메일을 받았습니다."; //메일 내용 입력해주세요.

		Properties props = System.getProperties(); // 정보를 담기 위한 객체 생성

		// SMTP 서버 정보 설정
		props.put("mail.smtp.host", "smtp.naver.com");
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", host);

		//Session 생성
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			String un=username;
			String pw=password;
			protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
				System.out.println("로그인 인증 : " + new javax.mail.PasswordAuthentication(un, pw));
				return new javax.mail.PasswordAuthentication(un, pw);
			}
		});

		session.setDebug(true); //for debug

		MimeMessage mimeMessage = new MimeMessage(session); //MimeMessage 생성

		//발신자 셋팅 , 보내는 사람의 이메일주소를 한번 더 입력합니다. 이때는 이메일 풀 주소를 다 작성해주세요.
		mimeMessage.setFrom(new InternetAddress("jessic32@naver.com"));

		//수신자셋팅
		//.TO 외에 .CC(참조) .BCC(숨은참조) 도 있음
		mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress("sykim1@interfaceit.co.kr"));


		mimeMessage.setSubject("테스트 메일 전송 제목", "UTF-8"); //제목셋팅
		mimeMessage.setText("테스트메일전송 내용","UTF-8"); //내용셋팅
		//mimeMessage.setContent("<a href='http://www.google.co.kr'>테스트메일전송 내용</a>".toString(), "text/html; charset=UTF-8");


		mimeMessage.setHeader("content-Type", "text/html");

		Transport.send(mimeMessage); //javax.mail.Transport.send() 이용

	}

	@RequestMapping(value = "senderMail.lims")
	public ModelAndView senderMail(@RequestBody EmailVo vo, ModelAndView model) {

//		util.sendMail(vo.getTo(), vo.getCc(), vo.getSubject(), vo.getMsg());

		model.addObject("result", "메일 전송이 완료되었습니다.");

		return model;
	}

}

