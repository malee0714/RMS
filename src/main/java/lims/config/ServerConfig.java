package lims.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JSR310Module;
import lims.util.SessionInterceptor;
import lims.util.enumMapper.EnumContract;
import lims.util.enumMapper.EnumMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.web.session.HttpSessionEventPublisher;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;
import org.springframework.web.servlet.view.tiles3.SimpleSpringPreparerFactory;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;

@Configuration
@ComponentScan("lims")
@EnableWebMvc
public class ServerConfig extends WebMvcConfigurerAdapter {
	
	@Override
	public void addResourceHandlers(final ResourceHandlerRegistry registry) {
	    registry.addResourceHandler("/AUIGrid/**").addResourceLocations("/AUIGrid/");
	    registry.addResourceHandler("/css/**").addResourceLocations("/css/");
	    registry.addResourceHandler("/assets/**").addResourceLocations("/assets/");
	}
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(sessionInterceptor())
				.excludePathPatterns("/login.lims", "/loginCheck.lims", "/logout.lims", "/las/*", "/req/insLoginReqestRcepr.lims");
	}
	
	@Bean
	public SessionInterceptor sessionInterceptor(){
		return new SessionInterceptor();
	}
	
	@Bean
	public TilesViewResolver tilesViewResolver() {
		TilesViewResolver  resolver = new TilesViewResolver();
		resolver.setOrder(1);
		return resolver;
	}

	@Bean
	public MultipartResolver multipartResolver() {
	    return new CommonsMultipartResolver();
	}
	
	@Bean
	public TilesConfigurer tilesConfigurer() {
		TilesConfigurer tilesConfigurer = new TilesConfigurer();
	    tilesConfigurer.setDefinitions(new String[] {"/WEB-INF/views/**/tiles.xml"});
	    tilesConfigurer.setCheckRefresh(true);
	    tilesConfigurer.setPreparerFactoryClass(SimpleSpringPreparerFactory.class); 
	    return tilesConfigurer;
	}
	
	@Bean
	public InternalResourceViewResolver  setInternalResourceViewResolver() {
		InternalResourceViewResolver  resolver = new InternalResourceViewResolver();
		resolver.setPrefix("/WEB-INF/views/pages/");
		resolver.setSuffix(".jsp");
		resolver.setOrder(2);
		resolver.setViewClass(JstlView.class);
		return resolver;
	}

	@Bean
    public HttpSessionEventPublisher httpSessionEventPublisher() {
        return new HttpSessionEventPublisher();
    }
	
	@Bean
	public EnumMapper enumMapper() {
		EnumMapper enumMapper = new EnumMapper();
		enumMapper.put("reqestType", EnumContract.ReqestType.class);
		return enumMapper;
	}
	
	@Bean
	public ObjectMapper objectMapper() {
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.registerModule(new JSR310Module());
		objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
		return objectMapper;
	}
}
