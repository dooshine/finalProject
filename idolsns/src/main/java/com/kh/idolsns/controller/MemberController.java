package com.kh.idolsns.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.idolsns.dto.MemberDto;
import com.kh.idolsns.repo.MemberRepo;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberRepo memberRepo;
	
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	
	@PostMapping("/login")
	public String login(
			@ModelAttribute MemberDto userDto,
			RedirectAttributes attr, HttpSession session) {
		MemberDto findDto = memberRepo.selectOne(userDto.getMemberId());
		
		if(findDto == null) {
			attr.addAttribute("mode", "error");
			return "redirect:login";
		}
		
		if(!userDto.getMemberPw().equals(findDto.getMemberPw())) {
			attr.addAttribute("mode", "error");
			return "redirect:login";
		}
		
		session.setAttribute("memberId", findDto.getMemberId());
		session.setAttribute("memberLevel", findDto.getMemberLevel());
		
		return "redirect:/";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("memberId");
		session.removeAttribute("memberLevel");
		return "redirect:/";
	}
	
	

	
	
	
	
}
