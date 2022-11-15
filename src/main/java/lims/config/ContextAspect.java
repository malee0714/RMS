package lims.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;


import lims.util.Locale.LocaleAop;

@Configuration
@EnableAspectJAutoProxy
public class ContextAspect {
	
	@Bean
	public LocaleAop localeAop(){
		LocaleAop localgeManager = new LocaleAop();
		return localgeManager;
	}
	
	
}
