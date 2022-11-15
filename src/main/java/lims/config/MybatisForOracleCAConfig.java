package lims.config;

import javax.sql.DataSource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import lims.util.RefreshableSqlSessionFactoryBean;


@Configuration
@MapperScan(basePackages="rdms.ca" , sqlSessionFactoryRef="sqlSessionFactoryBeanCA")
public class MybatisForOracleCAConfig {
	
	@Value("${jdbc.driver}")
	private String jdbcDriver;
	@Value("${jdbc.urlCA}")
	private String jdbcUrl;
	@Value("${jdbc.usernameCA}")
	private String jdbcUsername;
	@Value("${jdbc.passwordCA}")
	private String jdbcPassword;

	@Autowired
	ApplicationContext applicationContext;
	
	@Bean
	public DataSource dataSourceCA() throws ClassNotFoundException {
		
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
	 public SqlSessionFactoryBean sqlSessionFactoryBeanCA() throws Exception {
	        
//	        SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
	        
	      //개발에서만 사용 운영 반영때는 주석처리(xml 서버 재시작 안하고 사용)
	        SqlSessionFactoryBean sessionFactory = new RefreshableSqlSessionFactoryBean();
	        
	        sessionFactory.setFailFast(true);
	        sessionFactory.setDataSource(dataSourceCA());
	        sessionFactory.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:mapperRDMS/ca/*.xml"));
	        sessionFactory.setConfigLocation(new PathMatchingResourcePatternResolver().getResource("classpath:spring/context-mybatis.xml"));

	        return sessionFactory;
	 }
}
