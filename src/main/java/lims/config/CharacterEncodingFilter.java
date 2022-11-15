package lims.config;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import lombok.extern.slf4j.Slf4j;

/**
 * UTF-8 encoding
 * 
 * Spring에서 제공하는 CharacterEncodingFilter가 제대로 적용되지 않아서 javax.Filter를 상속받아서 적용
 * 
 * @author shs
 */
@Slf4j
public class CharacterEncodingFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		log.info("### CharacterEncodingFilter init.");
	}

	@Override
	public void destroy() {
		log.info("### CharacterEncodingFilter destroy.");
	}
}
