package com.kh.idolsns.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.idolsns.advice.RequireLoginException;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberInterceptor implements HandlerInterceptor{

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        //로그인 상태 = 세션에 있는 memberId가 null이 아닌 경우
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("memberId");
		
		if(memberId != null) {//회원이라면
			return true;
		}
		else {//비회원이라면 - 로그인 페이지로 이동시키면서 차단
			//리다이렉트 코드
			//response.sendRedirect("/member/login");//return "redirect:/member/login"
			//response.sendError(401);
			//return false;
			log.debug("로그인 후 이용 가능합니다");
			throw new RequireLoginException("로그인 후 이용 가능합니다");
		}   
    }
    
}
