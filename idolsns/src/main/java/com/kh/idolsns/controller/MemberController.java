package com.kh.idolsns.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.idolsns.dto.MemberDto;
import com.kh.idolsns.repo.MemberRepo;
import com.kh.idolsns.service.emailService;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberRepo memberRepo;
	
	@Autowired
	private emailService emailService;
	
	@Autowired
	private JavaMailSender sender;
	
	//회원가입
	@GetMapping("/join")
	public String join() {
		return "member/join";
	}
	
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto) {
		
		// 멤버 생성
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
			RedirectAttributes attr, HttpSession session, @RequestParam(required = false, defaultValue = "") String prevPage) {
		MemberDto findDto = memberRepo.selectOne(userDto.getMemberId());
		
		if(findDto == null) {
			attr.addAttribute("mode", "error");
			attr.addAttribute("msg", "존재하지 않는 아이디입니다.");
			return "redirect:login";
		}
		
		if(!userDto.getMemberPw().equals(findDto.getMemberPw())) {
			attr.addAttribute("mode", "error");
			attr.addAttribute("msg", "아이디 또는 비밀번호를 잘못입력하였습니다.");
			return "redirect:login";
		}
		
		session.setAttribute("memberId", findDto.getMemberId());
		session.setAttribute("memberLevel", findDto.getMemberLevel());
		
		String memberId = findDto.getMemberId();
		if(!(findDto.getMemberExitDate() == null)) {
			memberRepo.cancelExit(memberId	);
			String alertMessage = "회원 탈퇴가 취소되었습니다!";
		    attr.addAttribute("mode", "cancel");
		    attr.addAttribute("mmssgg", alertMessage);
		    return "redirect:login";
		}
		
		return "redirect:" + prevPage;
	}
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session, HttpServletRequest request) {
		session.removeAttribute("memberId");
		session.removeAttribute("memberLevel");
		return "redirect:" + request.getHeader("Referer");
	}
	
	//마이페이지
	@GetMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		String memberId = (String) session.getAttribute("memberId");
		MemberDto memberDto = memberRepo.selectOne(memberId);
		model.addAttribute("memberDto", memberDto);
		return "member/mypage";
	}
	
	@GetMapping("/profile")
	@ResponseBody
	public Map<String, String> profile(HttpSession session) {
		String memberId = (String) session.getAttribute("memberId");
		
		MemberDto memberDto = memberRepo.emailExist(memberId);
		
		Map<String, String> result = new HashMap<>();
		result.put("memberId", memberDto.getMemberId());
		result.put("memberNick", memberDto.getMemberNick());
		
		return result;
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
		
			memberRepo.exitDate(memberId);
			
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
	
//	@PostMapping("/findId")
//	public String findId(@RequestParam String memberEmail,
//							RedirectAttributes attr) {
//		MemberDto memberDto = memberRepo.findId(memberEmail);
//		System.out.println(memberDto.getMemberId());
//		attr.addAttribute("memberId", memberDto.getMemberId());
//		return "redirect:findIdFinish";
//	}
//	
	@GetMapping("/findIdFinish")
	@ResponseBody
	public String findIdFinish(@RequestParam String memberEmail) {
		MemberDto memberDto = memberRepo.findId(memberEmail);
		return memberDto.getMemberId();
	}
	
	@GetMapping("/findPw")
	public String findPw() {
		return "member/findPw";
	}
	
	@GetMapping("/emailExist")
	@ResponseBody
	public String emailExist(@RequestParam String memberId) {
		MemberDto memberDto = memberRepo.emailExist(memberId);
		return memberDto.getMemberEmail();
	}
	
	
	
	
	//중복 검사
	@GetMapping("/idDuplicatedCheck")
	@ResponseBody
	public String idDuplicatedCheck(@RequestParam String memberId) {
		int result = memberRepo.idDuplicatedCheck(memberId);
		
		if(result == 0) {
			return "Y";
		}
		else {
			return "N";
		}
	}
	
	@GetMapping("nickDuplicatedCheck")
	@ResponseBody
	public String nickDuplicatedCheck(@RequestParam String memberNick) {
		int result = memberRepo.nickDuplicatedCheck(memberNick);
		if(result == 0) {
			return "Y";
		}
		else {
			return "N";
		}
	}
	
	@GetMapping("/emailDuplicatedCheck")
	@ResponseBody
	public String emailDuplicatedCheck(@RequestParam String memberEmail) {
		int result = memberRepo.emailDuplicatedCheck(memberEmail);
		
//		if(result == 0) {
//			return "Y";
//		}
//		else {
//			return "N";
//		}
		return result == 0 ? "Y" : "N";
	}
	
	//이메일 인증번호 발급
	@GetMapping("/emailSend")
	@ResponseBody
	public String emailSend(@RequestParam String memberEmail) throws Exception {
		
		String key = emailService.createKey();
		emailService.sendEmail(memberEmail,key);
		
		return key;
	}
	
	@GetMapping("/sendEmailPassword")
	@ResponseBody
	public String sendEmailPassword(@RequestParam String memberEmail) throws Exception {
		
		String newPassword = emailService.CreatePassword();
		emailService.sendEmailPassword(memberEmail, newPassword);
		memberRepo.editPassword(memberEmail, newPassword);
		return newPassword;
		
	}
}