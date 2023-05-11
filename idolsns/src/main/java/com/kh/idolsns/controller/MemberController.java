package com.kh.idolsns.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.idolsns.dto.MemberDto;
import com.kh.idolsns.repo.MemberRepo;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberRepo memberRepo;
	
	//회원가입
	@GetMapping("/join")
	public String join() {
		return "member/join";
	}
	
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto) {
		memberRepo.insert(memberDto);
		return "member/joinFinish";
	}
	
	@GetMapping("/joinFinish")
	public String joinFinish() {
		return "member/joinFinish";
	}
	
	//로그인
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
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("memberId");
		session.removeAttribute("memberLevel");
		return "redirect:/";
	}
	
	//마이페이지
	@GetMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		String memberId = (String) session.getAttribute("memberId");
		MemberDto memberDto = memberRepo.selectOne(memberId);
		model.addAttribute("memberDto", memberDto);
		return "member/mypage";
	}
	
	//회원탈퇴
	@GetMapping("/exit")
	public String exit(HttpSession session) {
		return "member/exit";
	}
	
	@PostMapping("/exit")
	public String exit(HttpSession session,
						@RequestParam String memberPw,
						RedirectAttributes attr) {
		String memberId = (String) session.getAttribute("memberId");
		MemberDto memberDto = memberRepo.selectOne(memberId);
		
		if(!memberDto.getMemberPw().equals(memberPw)) {
			attr.addAttribute("mode", "error");
			return "redirect:exit";
		}
		
		memberRepo.delete(memberId);
		
		session.removeAttribute("memberId");
		session.removeAttribute("memberLevel");
		
		return "redirect:exitFinish";
	}
	
	@GetMapping("/exitFinish")
	public String exit() {
		return "member/exitFinish";
	}
	
	//비밀번호 변경
	@GetMapping("/password")
	public String password() {
		return "member/password";
	}
	
	@PostMapping("/password")
	public String password(HttpSession session, 
							@RequestParam String currentPw,
							@RequestParam String changePw,
							RedirectAttributes attr) {
		String memberId = (String) session.getAttribute("memberId");
		MemberDto memberDto = memberRepo.selectOne(memberId);
		
		if(!memberDto.getMemberPw().equals(currentPw)) {
			attr.addAttribute("mode", "error");
			return "redirect:password";
		}
		
		memberRepo.updatePw(memberId, changePw);
		
		return "redirect:passwordFinish";
	}
	
	@GetMapping("/passwordFinish")
	public String passwordFinish() {
		return "member/passwordFinish";
	}
	
	//닉네임 변경
	@GetMapping("/nickname")
	public String nickname() {
		return "member/nickname";
	}
	
	@PostMapping("/nickname")
	public String nickname(HttpSession session,
							@RequestParam String changeNick,
							RedirectAttributes attr) {
		String memberId = (String) session.getAttribute("memberId");
		MemberDto memberDto = memberRepo.selectOne(memberId);
		
		if(memberDto.getMemberNick().equals(changeNick)) {
			attr.addAttribute("mode", "error");
		}
		
		memberRepo.updateNick(memberId, changeNick);
		
		return "redirect:nicknameFinish";
	}
	
	@GetMapping("/nicknameFinish")
	public String nicknameFinish() {
		return "member/nicknameFinish";
	}
	
	//아이디 찾기
	@GetMapping("/findId")
	public String findId() {
		return "member/findId";
	}
	
	@PostMapping("/findId")
	public String findId(@RequestParam String memberEmail,
							RedirectAttributes attr) {
		MemberDto memberDto = memberRepo.findId(memberEmail);
		System.out.println(memberDto.getMemberId());
		attr.addAttribute("memberId", memberDto.getMemberId());
		return "redirect:findIdFinish";
	}
	
	@GetMapping("/findIdFinish")
	public String findIdFinish(@RequestParam String memberId,
								Model model) {
		model.addAttribute("memberId", memberId);
		return "member/findIdFinish";
	}
	
}
