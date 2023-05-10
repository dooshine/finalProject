package com.kh.idolsns.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpHeaders;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.reactive.function.client.WebClient;





@Configuration
public class KakaoPayConfiguration {

	
	@Autowired
	private KakaoPayProperties props;
	
	@Bean
	public HttpHeaders httpHeaders() {
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK " + props.getKey());
		headers.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		return headers;
	}
	
	@Bean
	public RestTemplate restTemplate() {
		RestTemplate template = new RestTemplate();
		return template;
	}
	
	@Bean
	public WebClient webClient() {
		return WebClient.builder()
			.baseUrl("https://kapi.kakao.com")
			.defaultHeader("Authorization", "KakaoAK " + props.getKey())
			.defaultHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8")
		.build();
	}
}
