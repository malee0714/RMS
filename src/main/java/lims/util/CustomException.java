package lims.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

/**
 *
 * Exception 발생시 Request parameter와 개발자 임의의
 * 메세지를 Custom하기위한 Exception Class
 * 
 * Exception의 원형을 유지하기위해 모든 생성자는 Throwable Type으로 parameter를 받는다.
 *
 * @author shs
 */
@Slf4j
@Getter @Setter
public class CustomException extends RuntimeException {

	private String developerDc; // 개발자 임의로 추가하고싶은 메세지
	private String stackTraceString; // stackTrace -> toString
	private String param;
	
	public CustomException( Throwable cause ) {
		this(cause,null,"");
	}
	
	public CustomException( String developerMessage ) {
		super(developerMessage);
		this.developerDc = developerMessage;
	}
	
	public CustomException( Throwable cause, String developerMessage ) {
		this(cause,null,developerMessage);
	}
	
	/**
	 * 
	 * @param cause error 원인 객체
	 * @param vo domain 객체
	 * @param developerMessage 개발자 임의의 메세지
	 */
	@SuppressWarnings("unchecked")
	public CustomException( Throwable cause, Object vo, String developerMessage ) {
		super(cause);
		
		log.error(cause.toString());
		
		this.developerDc = developerMessage;
		this.stackTraceString = stackTraceToString(cause);
		
		//vo가 null이 아니라면 HashMap으로 변환
		if(vo != null){
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> convertVo = new HashMap<String, Object>(mapper.convertValue(vo, HashMap.class));
			Map<String, Object> ignoreListMap = getIgnoreList(convertVo);
			try {
				this.param = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(ignoreListMap); // Map 객체 JSON형태로 변환
			} catch (JsonProcessingException e1) {
				this.param = ignoreListMap.toString();
			}
		}
	}
	
	/**
	 * 
	 * @param cause error 원인 객체
	 * @param paramMap Map 객체
	 * @param developerMessage 개발자 임의의 메세지
	 */
	public CustomException( Throwable cause, Map<String, Object> paramMap, String developerMessage ) {
		super(cause);
		
		log.error(cause.toString());
		
		this.developerDc = developerMessage;
		this.stackTraceString = stackTraceToString(cause);
		
		//vo가 null이 아니라면 HashMap으로 변환
		if(paramMap != null){
			this.param = getIgnoreList(paramMap).toString();
		}
	}
	
	/**
	 * stackTrace를 String으로 return
	 */
	private String stackTraceToString(Throwable cause){
		
		StringBuilder stacktrace = new StringBuilder();
		
		StackTraceElement[] ste = cause.getStackTrace();
		for (StackTraceElement stackTraceElement : ste) {
			stacktrace.append(stackTraceElement.toString()).append("\n");
		}
		return stacktrace.toString();
	}

	/**
	 * List 객체를 제외한 Map객체를 return
	 */
	private Map<String, Object> getIgnoreList(Map<String, Object> map){

		//List객체를 삭제할 키를 모아놓은 list
		List<Object> list = new ArrayList<>();

		for(String key : map.keySet()){
			//map 객체에서 List발견되면 삭제 List객체는 에러로그에 쌓지 않을것임.
			if (map.get(key) instanceof List){
				list.add(key);
			}
		}
		
		if(list.size() != 0){
			int size = list.size();
			for (Object obj : list) {
				map.remove(obj.toString());
			}
		}
		return map;
	}
}
