package lims.util;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * 에러로그가 남지 않고 Java단에서 알림을 사용자에게 바로 알려주기 위한 클래스
 *
 * @author shs
 */
@Slf4j
@Getter @Setter
public class CustomMessageException extends RuntimeException {

	private String developerDc; // 개발자 임의로 추가하고싶은 메세지
	private String stackTraceString; // stackTrace -> toString
	private String param;

	public CustomMessageException(String developerMessage ) {
		super(developerMessage);
		this.developerDc = developerMessage;
	}
}
