package kh.spring.aspect;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class LoginCheckAdvice {
	
	@Around("execution(* kh.spring.practice.*.*Login(..))")
	public Object loginCheck(ProceedingJoinPoint pjp) throws Throwable {
		HttpServletRequest request = (HttpServletRequest)pjp.getArgs()[0];
		String loginId = (String)request.getSession().getAttribute("loginId");
		if(loginId == null) {
			request.setAttribute("msg", "로그인하세요");
			return "home";
		}else {
			return pjp.proceed();
		}
	}
}
