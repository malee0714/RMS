package lims.util.security;

import javax.servlet.http.HttpSessionEvent;



import org.springframework.security.web.session.HttpSessionEventPublisher;
import org.springframework.stereotype.Component;


@Component
public class SessionDestoryListener extends HttpSessionEventPublisher{
	
	static final long serialVersionUID = 1L;
	
	@Override
	public void sessionCreated(HttpSessionEvent event) {
		event.getSession().setMaxInactiveInterval(60 * 60 * 8); // 6시간
		super.sessionCreated(event);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		super.sessionDestroyed(event);
	}

}
