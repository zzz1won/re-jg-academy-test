package kr.disable.jugd.academy.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import kr.disable.jugd.academy.interceptor.AuthInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer  {

	/**
     * 로그인 인증 Interceptor 설정
     */
	@Autowired
	private AuthInterceptor authInterceptor;
    
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(authInterceptor)
                .addPathPatterns("/**/*")
                .excludePathPatterns("/resources/**")
                .excludePathPatterns("/**/index")
                .excludePathPatterns("/**/login")
                .excludePathPatterns("/**/detail")
                .excludePathPatterns("/**/popup/**")
                ;
    }
}
