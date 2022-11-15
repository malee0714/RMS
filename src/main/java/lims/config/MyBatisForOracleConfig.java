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
@MapperScan(basePackages="lims" , sqlSessionFactoryRef="sqlSessionFactoryBean")
public class MyBatisForOracleConfig {
	
	@Value("${jdbc.driver}")
	private String jdbcDriver;
	@Value("${jdbc.url}")
	private String jdbcUrl;
	@Value("${jdbc.username}")
	private String jdbcUsername;
	@Value("${jdbc.password}")
	private String jdbcPassword;

	@Bean
	public DataSource dataSource() throws ClassNotFoundException {
		
		BasicDataSource dataSource = new BasicDataSource();
		dataSource.setDriverClassName(jdbcDriver);
        dataSource.setUrl(jdbcUrl);
        dataSource.setUsername(jdbcUsername);
        dataSource.setPassword(jdbcPassword);
        
        /**
         * validationQuery						유효성 검증 쿼리. 가장 간단한 쿼리를 사용하는것이 좋다. 실제 사용중인 테이블 조회 금지
         * 										유효성 검증을 통해 connection이 유효하지않으면 connection pool에서 제외한다.
         * 
         * testWhileIdle						connection이 유효한지 확인하여 유효하지않으면 pool에서 제거한다.
         * 
         * testOnBorrow							pool에서 connection을 가져올때 유효한지 확인. 유효한 connection이 아니면 pool에서 제거하고 다른 connection 객체 획득
         * 										유효하지않은 connection일 경우 Exception이 발생한다. Exception이 발생하면 새로운 Connection을 맺어 return한다.
         * 
         * testOnReturn							pool에 connection을 반납할 때 유효한지 확인한다. false로 설정한 이유는 testWhileIdle, testOnBorrow설정이 true인데
         * 										testOnReturn까지 true이면은 커넥션 유효성 검사에 너무많은 자원소모가 이루어지기 때문에 false. validationQuery 까지 3개의 설정으로 충분히 체크 잘됨.
         * 
         * MaxWaitMillis(dbpc 1.x -> maxWait)	예외 발생 전 연결이 반환될때까지 풀이 대기하는 최대시간 (무기한 대기는 -1) - default : 무기한
         * 
         * MaxIdle								커넥션 풀에 반납할 때 최대로 유지될 수 있는 커넥션 개수(기본값: 8)
         * 
         * MaxTotal(dbcp 1.x -> maxActive)		동시에 사용할 수 있는 최대 커넥션 개수(기본값: 8)
         */
		dataSource.setValidationQuery("SELECT 1 FROM DUAL");
		dataSource.setTestWhileIdle(true);
		dataSource.setTestOnBorrow(true);
		dataSource.setTestOnReturn(false);
		dataSource.setMaxWaitMillis(3000);
//		dataSource.setMaxIdle(200);
//		dataSource.setMaxTotal(200);
		
		return dataSource;
	 }
	     
	 @Bean
	 public SqlSessionFactoryBean sqlSessionFactoryBean() throws Exception {
	        
	        // 운영 반영할때 주석 풀기
//	        SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
	        		 
		 	//개발에서만 사용 운영 반영때는 주석처리(xml 서버 재시작 안하고 사용)
	        SqlSessionFactoryBean sessionFactory = new RefreshableSqlSessionFactoryBean();
	        
	        sessionFactory.setFailFast(true);
	        sessionFactory.setDataSource(dataSource());
	        sessionFactory.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:mapper/*/*.xml"));
	        sessionFactory.setConfigLocation(new PathMatchingResourcePatternResolver().getResource("classpath:spring/context-mybatis.xml"));

	        return sessionFactory;
	 }
	 
	 
}
