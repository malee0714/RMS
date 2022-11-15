package lims.util.security;

import lims.com.service.LoginMService;
import lims.sys.vo.SysManageVo;
import lims.sys.vo.UserMVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Optional;

@Slf4j
@Component
public class CustomAuthenticationProvider implements AuthenticationProvider {
	
	private final CustomUserDetailsService userDetailsService;
	private final LoginMService loginMService;
	
	@Autowired
	public CustomAuthenticationProvider(LoginMService loginMServiceImpl, CustomUserDetailsService userDetailsService) {
		this.loginMService = loginMServiceImpl;
		this.userDetailsService = userDetailsService;
	}
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {

		try {
			String password = (String) authentication.getCredentials();

			UserMVo user = Optional
					.ofNullable(userDetailsService.loadUserByUsername(authentication.getName()))
					.orElseThrow(() -> new CustomAccountStatusException("로그인 정보가 없습니다."));

			//ENF 시스템 룰 적용
			SysManageVo systemRule = userDetailsService.getSystemRule();

			if ("N".equals(user.getSbscrbConfmAt()))
				throw new CustomAccountStatusException("가입 승인이 완료되지 않아 로그인이 불가합니다.");

			//SY 시스템관리.로그인 실패 잠금여부가 Y일때만 잠금여부를 체크합니다.
			if (user.getLockAt().equals("Y"))
				throw new CustomAccountStatusException("계정이 잠겨서 로그인이 불가합니다.");

			//password check
			if (!password.equals(user.getPassword())) {

				int loginFailrLockNumot = systemRule.getLoginFailrLockNumot(); // SY_SYS_MANAGE login 실패 잠금 횟수
				if (loginFailrLockNumot > 0 && "Y".equals(systemRule.getLoginFailrLockAt())) { // login 실패 잠금 횟수가 설정되어있지 않거나, 잠금여부 설정 안되어있으면 실패카운트 update안침.
					loginMService.loginFailureCount(user);
				}

				if (user.getPasswordFailrCo() > loginFailrLockNumot) { //login 실패 잠금횟수 보다 크면 계정잠금처리
					user.setGbnFailure("Y"); // 로그인 실패 구분값 할당 (실패: Y, 성공: null)
					loginMService.loginSucceedOrFailure(user); // 계정 lock_yn = 'Y' update query 실행.
					throw new CustomAccountStatusException("계정이 잠금처리 되었습니다. 관리자에게 문의해 주세요.");
				}
				throw new CustomAccountStatusException("비밀번호가 일치하지 않습니다.");
			}
			return new UsernamePasswordAuthenticationToken(user, password, new ArrayList<>());

		} catch (UsernameNotFoundException | BadCredentialsException | CustomAccountStatusException e ) {
			log.info(e.getMessage(), e);
			throw e;
		}
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}
}