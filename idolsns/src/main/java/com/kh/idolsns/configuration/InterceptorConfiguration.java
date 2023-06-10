package com.kh.idolsns.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.idolsns.interceptor.AdminInterceptor;
import com.kh.idolsns.interceptor.MemberInterceptor;
import com.kh.idolsns.interceptor.PostManageInterceptor;
import com.kh.idolsns.interceptor.TestInterceptor;

@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer{

    @Autowired
	private TestInterceptor testInterceptor;

    @Autowired
    private MemberInterceptor memberInterceptor;

    @Autowired
	private AdminInterceptor adminInterceptor;
	
	@Autowired
	private PostManageInterceptor postManageInterceptor;
	
	// @Autowired
	// private AdminNoticeInterceptor adminNoticeInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        //인터셉터 등록 메소드
		//- 매개변수에 있는 registry를 사용하여 원하는 인터셉터를 원하는 주소에 설정
		
		//주소 패턴 설정
		//- Spring표현식 사용
		//- *가 1개면 해당 엔드포인트의 모든 내용을 의미
		//- *가 2개면 해당 엔드포인트와 그 이하의 모든 내용을 의미
		
		// [1] TestInterceptor를 모든 주소에 설정하겠다!
		// registry.addInterceptor(testInterceptor)
		// 			.addPathPatterns("/**");
					
		// [2] MemberInterceptor를 다음 페이지에 설정하겠다!
		// - /member로 시작하는 주소 중에서 비회원 페이지 제거
		// - /admin으로 시작하는 주소 전체
        
		registry.addInterceptor(memberInterceptor)
        .addPathPatterns(
                "/member/**",           
        		"/point/**",
        		"/fund/**"
        )       
        .excludePathPatterns(
                 "/member/join",
                 "/member/joinFinish",
                 "/member/login",
                 "/member/goToLoginPage",
                 "/member/find",
                 "/member/exitFinish",
                 "/member/findId",
                 "/member/findIdFinish",
                 "/member/findPw",
                 "/member/findPwFinish",
                 "/member/exitFinish",
                 "/member/emailExist",
                 "/member/idDuplicatedCheck",
                 "/member/idDuplicatedCheck2",
                 "/member/nickDuplicatedCheck",
                 "/member/emailDuplicatedCheck",
                 "/member/emailSend",
                 "/member/sendEmailPassword",
                 "/member/mypage1",
                 
                 "/fund/list",
                 "/fund/detail",
                 "/fund/order"
                 
        );


        //[3] 관리자 전용 검사 인터셉터
        registry.addInterceptor(adminInterceptor)
                .addPathPatterns(
                        "/admin/**"
//                        "/rest/post/reply/**",
//                        "/rest/reply/fund/**"
                );
        
        // //[4] 작성자 본인 및 관리자 검사 인터셉터
        // registry.addInterceptor(postManageInterceptor)
        //         .addPathPatterns("/board/edit", "/board/delete");

        // //[5] 관리자만 공지사항 등록 및 수정이 가능하도록 구현
        // registry.addInterceptor(adminNoticeInterceptor)
        //         .addPathPatterns("/board/write", "/board/edit");
    }
    
}