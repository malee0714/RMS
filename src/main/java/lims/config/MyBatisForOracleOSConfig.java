package lims.config;

import javax.sql.DataSource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import lims.util.RefreshableSqlSessionFactoryBean;


@Configuration
@MapperScan(basePackages="rdms.os" , sqlSessionFactoryRef="sqlSessionFactoryBeanOS")
public class MyBatisForOracleOSConfig {
	
	@Value("${jdbc.driver}")
	private String jdbcDriver;
	@Value("${jdbc.urlOS}")
	private String jdbcUrl;
	@Value("${jdbc.usernameOS}")
	private String jdbcUsername;
	@Value("${jdbc.passwordOS}")
	private String jdbcPassword;

	@Bean
	public DataSource dataSourceRm() throws ClassNotFoundException {
		
		BasicDataSource dataSource = new BasicDataSource();
		dataSource.setDriverClassName(jdbcDriver);
        dataSource.setUrl(jdbcUrl);
        dataSource.setUsername(jdbcUsername);
        dataSource.setPassword(jdbcPassword);
        dataSource.setValidationQuery("SELECT 1 FROM DUAL");
		dataSource.setTestWhileIdle(true);
		dataSource.setTestOnBorrow(true);
		dataSource.setTestOnReturn(false);
		dataSource.setMaxWaitMillis(3000);
	     
	        return dataSource;
	 }
	     
	 @Bean
	 public SqlSessionFactoryBean sqlSessionFactoryBeanOS() throws Exception {
	        
//	        SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
	        
	      //개발에서만 사용 운영 반영때는 주석처리(xml 서버 재시작 안하고 사용)
	        SqlSessionFactoryBean sessionFactory = new RefreshableSqlSessionFactoryBean();
	        
	        sessionFactory.setFailFast(true);
	        sessionFactory.setDataSource(dataSourceRm());
	        sessionFactory.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:mapperRDMS/os/*.xml"));
	        sessionFactory.setConfigLocation(new PathMatchingResourcePatternResolver().getResource("classpath:spring/context-mybatis.xml"));

	        return sessionFactory;
	 }
	 
	 
}
