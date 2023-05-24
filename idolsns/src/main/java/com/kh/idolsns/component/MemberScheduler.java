package com.kh.idolsns.component;

import javax.servlet.http.HttpSession;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.idolsns.dto.MemberDto;
import com.kh.idolsns.repo.MemberRepo;

@Component
public class MemberScheduler {

	private final MemberRepo memberRepo;
	
	public MemberScheduler(MemberRepo memberRepo) {
		this.memberRepo = memberRepo;
	}
	
	@Scheduled(fixedDelay = 30000)
	public void executeMemberExit() {
		long currentTime = System.currentTimeMillis();
		
	}
}
//public String login(
//		@ModelAttribute MemberDto userDto,
//		RedirectAttributes attr, HttpSession session, @RequestParam(required = false, defaultValue = "") String prevPage) {
//	MemberDto findDto = memberRepo.selectOne(userDto.getMemberId());
//	
//	if(findDto == null) {
//		attr.addAttribute("mode", "error");
//		attr.addAttribute("msg", "존재하지 않는 아이디입니다.");
//		return "redirect:login";
//	}
//	
//	if(!userDto.getMemberPw().equals(findDto.getMemberPw())) {
//		attr.addAttribute("mode", "error");
//		attr.addAttribute("msg", "아이디 또는 비밀번호를 잘못입력하였습니다.");
//		return "redirect:login";
//	}
//	
//	session.setAttribute("memberId", findDto.getMemberId());
//	session.setAttribute("memberLevel", findDto.getMemberLevel());
//	
//	return "redirect:" + prevPage;