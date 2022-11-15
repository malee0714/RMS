package lims.util.security;

import org.springframework.security.authentication.AccountStatusException;

/**
 * AccountStatusException class가 abstract class여서
 * 사용하기 불편하기 때문에 똑같은 기능의 class하나 만듦
 * 
 * @author shs
 */
public class CustomAccountStatusException extends AccountStatusException {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public CustomAccountStatusException(String msg) {
		super(msg);
	}
}
