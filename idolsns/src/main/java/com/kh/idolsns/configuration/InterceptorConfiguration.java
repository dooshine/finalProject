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
                //"/admin/**",
                // "/board/**",
                // "/rest/follow/**",               
        		"/rest/post/**", // PostRestController전체 memberInterceptor 처리
        		"/rest/attachment/upload2/**",
        		"/rest/post/reply/delete/**",
        		"/rest/post/rereply/**",
        		"/rest/post/reply/redelete/**",
                "/chat/**",
                "/calendar/**",
        		"/rest/point/**",
        		"/rest/fund/**",
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
                 
                 
                 "/fund/list",
                 "/fund/detail",
                 
                // "/board/list",
                // "/board/detail"
                // "/rest/follow/test",
        		"/rest/post/all/**", // 전체 목록 조회 페이지
        		"/rest/post/page/**", // 게시물 전체 목록 페이지
        		"/rest/post/pageReload/**", // 게시물 목록 페이지 불러오기
        		"/rest/post/pageReload/memberLikePost/**", // 특정 맴버가 좋아요한 페이지 리로드
        		"/rest/post/pageReload/memberWritePost/**", // 특정 맴버가 작성한 페이지 리로드
        		"/rest/post/pageReload/fixedTagPost/**", // 특정 코정 태그 게시물 리로드 
        		"/rest/post/like/update/**", // 특정 게시물 좋아요 확인
        		"/rest/post/reply/**"
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
