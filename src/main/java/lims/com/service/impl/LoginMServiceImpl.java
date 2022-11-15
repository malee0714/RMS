package lims.com.service.impl;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import javax.annotation.Resource;
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.com.service.LoginMService;
import lims.com.vo.LoginMVo;
import lims.sys.service.CmmnCodeMService;
import lims.sys.vo.MenuMVo;
import lims.sys.vo.UserMVo;
import lims.util.AES256Cipher;



@Service
public class LoginMServiceImpl implements LoginMService {
	
	
	@Autowired
    private lims.com.dao.LoginMDao LoginMDao;
	
	@Resource(name ="cmmnCodeMServiceImpl")
	private CmmnCodeMService cmmnCodeMService;
	
	
	public UserMVo getUser(UserMVo param) {
		UserMVo result = LoginMDao.getUser(param);
		try {
			if(result != null){
				result.setEncryptRdmsLoginID(AES256Cipher.AES_Encode(result.getLoginId()));
			}
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			e.printStackTrace();
		} catch (InvalidAlgorithmParameterException e) {
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			e.printStackTrace();
		} catch (BadPaddingException e) {
			e.printStackTrace();
		}
		return result;
	}

	public void udtLogout(UserMVo vo) {
		LoginMVo lgvo = new LoginMVo();
		
		lgvo.setUserId(vo.getUserId());
		lgvo.setLoginId(vo.getLoginId());
		//lgvo.setJntIo("I");
		lgvo.setLoginIp(vo.getLoginIp());
		System.out.println("updLogout ::: ");
		LoginMDao.udtLogout(lgvo);
	}
	
	public int loginFailureCount(UserMVo vo){
		int  result = LoginMDao.loginFailureCount(vo);
		
		return result;
	}
	
	public int loginSucceedOrFailure(UserMVo vo){
		int  result = LoginMDao.loginSucceedOrFailure(vo);
		
		return result;
	}
	

	@Override
	public int getChkAthMenu(MenuMVo param) {
		return LoginMDao.getChkAthMenu(param);
	}

	@Override
	public int updateLastLoginDate(UserMVo vo) {
		return LoginMDao.updateLastLoginDate(vo);
	}
}
