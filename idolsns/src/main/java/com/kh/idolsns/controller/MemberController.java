package com.kh.idolsns.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.idolsns.configuration.CustomEmailProperties;
import com.kh.idolsns.configuration.CustomFileuploadProperties;
import com.kh.idolsns.dto.AttachmentDto;
import com.kh.idolsns.dto.FollowDto;
import com.kh.idolsns.dto.MemberDto;
import com.kh.idolsns.dto.MemberFollowCntDto;
import com.kh.idolsns.dto.MemberFollowInfoDto;
import com.kh.idolsns.dto.MemberProfileImageDto;
import com.kh.idolsns.repo.AttachmentRepo;
import com.kh.idolsns.repo.MemberFollowCntRepo;
import com.kh.idolsns.repo.MemberProfileImageRepo;
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
	
	@Autowired
	private AttachmentRepo attachmentRepo;
	
	@Autowired
	private CustomEmailProperties customEmailProperties;
	
	@Autowired
	private MemberProfileImageRepo memberProfileImageRepo;
	
	@Autowired
	private CustomFileuploadProperties customFileuploadProperties;
	
	@Autowired
	private MemberFollowCntRepo memberFollowCntRepo;
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private PasswordEncoder encoder;
	
	private File dir;
	@PostConstruct
	public void init() {
		dir = new File(customFileuploadProperties.getPath());
	}
	
	//회원가입
	@GetMapping("/join")
	public String join() {
		return "member/join";
	}
	
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto) {
		String encrypt  = encoder.encode(memberDto.getMemberPw());
		memberDto.setMemberPw(encrypt);
		
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
		
		return "redirect:/";
	}
	
	//로그인 상태인지 아닌지 구분
	@GetMapping("/goToLoginPage")
	@ResponseBody
	public String goToLoginPage(HttpSession session) {
		String memberId = (String) session.getAttribute("memberId");
		return memberId;
	}
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session, HttpServletRequest request) {
		session.removeAttribute("memberId");
		session.removeAttribute("memberLevel");
		return "redirect:" + request.getHeader("Referer");
	}
	
	//마이페이지
	@GetMapping("/mypage/{memberId}")
	public String mypage(@PathVariable String memberId, HttpSession session, Model model) {
		MemberDto memberDto = memberRepo.selectOne(memberId);
		System.out.println(memberDto);
		model.addAttribute("memberDto", memberDto);
		return "member/mypage";
	}
	
	//마이페이지 - 아이디, 닉네임 조회
	@GetMapping("/profile")
	@ResponseBody
	public MemberDto profile(HttpSession session ,@RequestParam String memberId) {
//		String memberId = (String) session.getAttribute("memberId");
		
//		MemberDto memberDto = memberRepo.emailExist(memberId);
//		
//		Map<String, String> result = new HashMap<>();
//		result.put("memberId", memberDto.getMemberId());
//		result.put("memberNick", memberDto.getMemberNick());
		
		MemberDto memberDto = memberRepo.selectOne(memberId);
		System.out.println(memberDto);
		
		return memberDto;
	}
	
	//마이페이지 - 프로필 사진 조회
	@GetMapping("/profileImage")
	@ResponseBody
	public MemberProfileImageDto memberProfileExist(HttpSession session, @RequestParam String memberId) {
//		String memberId = (String) session.getAttribute("memberId");
		MemberProfileImageDto memberProfileImageDto = memberProfileImageRepo.MemberImageExist(memberId);
		return memberProfileImageDto;
	}
	
	//마이페이지 - 닉네임 수정
	@GetMapping("/nickname")
	@ResponseBody
	public String nickname(HttpSession session,
			@RequestParam String memberNick,
			RedirectAttributes attr) {
		String memberId = (String) session.getAttribute("memberId");
		
		memberRepo.updateNick(memberId, memberNick);
		
		return "success";
	}
	
	//마이페이지 - 프로필 사진 수정
	@GetMapping("/editImage")
	@ResponseBody
	public String editImage(HttpSession session,
													@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		String memberId = (String) session.getAttribute("memberId");
		if(!attach.isEmpty()) {
			int attachmentNo1=attachmentRepo.sequence();
			File target = new File(dir, String.valueOf(attachmentNo1));
			attach.transferTo(target);
			
			attachmentRepo.insert(AttachmentDto.builder()
					.attachmentNo(attachmentNo1)
					.attachmentName(attach.getOriginalFilename())
					.attachmentType(attach.getContentType())
					.attachmentSize(attach.getSize())
					.build()
					);
			memberProfileImageRepo.insert(MemberProfileImageDto.builder()
						.attachmentNo(attachmentNo1)
						.memberId(memberId)
						.build()
					);
		}
		return memberId;
	}
	

//	//마이페이지 - 프로필 사진 수정
//	@GetMapping("/editImage")
//	@ResponseBody
//	public String editImage(HttpSession session,
//													@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
//		String memberId = (String) session.getAttribute("memberId");
//		if(!attach.isEmpty()) {
//			int attachmentNo1=attachmentRepo.sequence();
//			File target = new File(dir, String.valueOf(attachmentNo1));
//			attach.transferTo(target);
//			
//			attachmentRepo.insert(AttachmentDto.builder()
//					.attachmentNo(attachmentNo1)
//					.attachmentName(attach.getOriginalFilename())
//					.attachmentType(attach.getContentType())
//					.attachmentSize(attach.getSize())
//					.build()
//					);
//			memberProfileImageRepo.insert(MemberProfileImageDto.builder()
//						.attachmentNo(attachmentNo1)
//						.memberId(memberId)
//						.build()
//					);
//		}
//		return memberId;
//	}
	
	//마이페이지 - 팔로우 수 조회
	@GetMapping("/followCnt")
	@ResponseBody
	public Map<String, Object> follwCnt(HttpSession session, @RequestParam String memberId) {
//		String memberId = (String) session.getAttribute("memberId");
		MemberFollowCntDto memberFollowCntDto =  memberFollowCntRepo.followCnt(memberId);
		
		Map<String, Object> result = new HashMap<>();
		
		result.put("MemberFollowCnt", memberFollowCntDto.getMemberFollowCnt());
		result.put("MemberFollowerCnt", memberFollowCntDto.getMemberFollowerCnt());
		result.put("MemberPageCnt", memberFollowCntDto.getMemberPageCnt());
		
		System.out.println(result);
		
		return result;
	}
	
	//마이페이지 - 팔로우, 팔로워, 페이지 리스트 조회
	@GetMapping("/followList/{memberId}")
	@ResponseBody
	public Map<String, Object> followList(@PathVariable String memberId) {
	    MemberFollowInfoDto dto = sqlSession.selectOne("follow.selectMemberFollowInfo", memberId);
	    
	    Map<String, Object> result = new HashMap<>();
	    result.put("FollowMemberList", dto.getFollowMemberList());
	    result.put("FollowerMemberList", dto.getFollowerMemberList());
	    result.put("FollowPageList", dto.getFollowPageList());
	    
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
			
				memberRepo.memberExit(memberId);
			
			
			
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
			attr.addAttribute("msg", "잘못된 비밀번호 입니다.");
			return "redirect:password";
		}
		
		memberRepo.updatePw(memberId, changePw);
		
		return "redirect:passwordFinish";
	}
	
	@GetMapping("/passwordFinish")
	public String passwordFinish() {
		return "member/passwordFinish";
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
	
	@GetMapping("/idDuplicatedCheck2")
	@ResponseBody
	public String idDuplicatedCheck2(@RequestParam String memberId) {
		int result = memberRepo.memberExitFind(memberId);
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
	
	//팔로우 리스트 멤버별 프로필 조회
	@GetMapping("/followListProfile")
	@ResponseBody
	public List<FollowDto> followListProfile(@RequestParam String memberId) {
		return memberRepo.followListProfile(memberId);
	}
	
	//팔로워 리스트 멤버별 프로필 조회
	@GetMapping("/followerListProfile")
	@ResponseBody
	public List<FollowDto> followerListProfile(@RequestParam String followTargetPrimaryKey) {
		return memberRepo.followerListProfile(followTargetPrimaryKey);
	}
	
	//페이지 리스트 멤버별 프로필 조회
	@GetMapping("/pageListProfile")
	@ResponseBody
	public List<FollowDto> pageListProfile(@RequestParam String memberId) {
		return memberRepo.pageListProfile(memberId);
	}
	
	//프로필 리스트 팔로우 취소
	@GetMapping("/deleteFollow")
	@ResponseBody
	public String deleteFollow(@RequestParam long followNo) {
		memberRepo.deleteFollow(followNo);
		return null;
	}
}