package lims.config;

import lims.util.security.SessionDestoryListener;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

import javax.servlet.DispatcherType;
import javax.servlet.FilterRegistration;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration.Dynamic;
import java.util.EnumSet;

public class WebInitializer implements WebApplicationInitializer {
	
	@Override
	public void onStartup(ServletContext servletContext) throws ServletException {
		AnnotationConfigWebApplicationContext context = new AnnotationConfigWebApplicationContext();
		context.setServletContext(servletContext);
		context.register(ServerConfig.class);
		context.refresh();
		
		servletContext.addListener(new ContextLoaderListener(context));
		servletContext.addListener(new SessionDestoryListener());

		/**
		 * 메인 Thread 하위 child Thread에서도 RequestContextHolder의 Request 객체를 사용할 수 있다.
		 * 설정한 이유에 대해서 궁금한게 있다면 심현섭에게 너무 길어서 쓸수가없음
		 */
		DispatcherServlet dispatcher = new DispatcherServlet(context);
		dispatcher.setThreadContextInheritable(true);
		
		Dynamic servlet = servletContext.addServlet("dispatcher", dispatcher);
		servlet.addMapping("*.lims");
		servlet.setLoadOnStartup(1);
		
		// CORS 허용하고싶으면 쓰시오.
		FilterRegistration.Dynamic corsFilter = servletContext.addFilter("corsFilter", new CustomCORSFilter());
		corsFilter.addMappingForUrlPatterns(EnumSet.allOf(DispatcherType.class), true, "/com/getRdmsResultData.lims");
		corsFilter.setInitParameter("RDMS", "true");
		
		// uf8 encodig filter
		servletContext.addFilter("CharacterEncodingFilter", CharacterEncodingFilter.class).addMappingForUrlPatterns(EnumSet.allOf(DispatcherType.class), false, "/*");
		
		/*FilterRegistration.Dynamic MultipartFilter = servletContext.addFilter("multipartFilter", new MultipartFilter());
		MultipartFilter.addMappingForUrlPatterns(EnumSet.allOf(DispatcherType.class), true, "/*");*/
	}
}
