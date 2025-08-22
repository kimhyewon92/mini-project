package com.goodee.mini.configs;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.goodee.mini.interceptor.CheckAdminInterceptor;

@Configuration
public class InterceptorConfig implements WebMvcConfigurer {

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		registry.addInterceptor(new CheckAdminInterceptor())
		.addPathPatterns("/notice/add", 
				"/notice/update",
				"/notice/delete", 
				"/pet/add", 
				"/pet/update", 
				"/pet/delete",
				"/support/*");
	}
	
}
