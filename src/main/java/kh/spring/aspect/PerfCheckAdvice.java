package kh.spring.aspect;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class PerfCheckAdvice {
	
	@Around("execution(* kh.spring.practice.HomeController.*(..))")
	public Object perfCheck(ProceedingJoinPoint pjp) {
		long start = System.currentTimeMillis();
		Object retVal = null;
		try {
			retVal = pjp.proceed();
		}catch(Throwable t) {
			t.printStackTrace();
		}
		long end = System.currentTimeMillis();
		System.out.println((end - start)/1000.0 + "초 수행");
		return retVal;
	}
	
}
