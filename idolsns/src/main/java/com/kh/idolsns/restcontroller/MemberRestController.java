package com.kh.idolsns.restcontroller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.MemberDto;
import com.kh.idolsns.repo.MemberRepo;

@CrossOrigin
@RestController
@RequestMapping("/rest/member")
public class MemberRestController {

	@Autowired 
	private MemberRepo memberRepo;
	
	 @GetMapping("/{memberId}")
	 public MemberDto getMember(@PathVariable String memberId) {
        // memberId를 사용하여 멤버 정보를 조회하고 MemberDto로 반환하는 로직을 작성해주세요
        // 예시로 임시로 생성한 MemberDto를 반환합니다.
      
		 MemberDto memberDto = memberRepo.selectOne(memberId);
	     memberDto.setMemberPoint(memberDto.getMemberPoint()); 
	        
        return memberDto;
	 }

	
	@GetMapping("/memberId/{memberId}")
	public String memberId(@PathVariable String memberId) {
		return memberRepo.selectOne(memberId) == null ? "Y":"N";
	}
	
	@GetMapping("memberNick/{memberNick}")
	public String memberNick(@PathVariable String memberNick) {
		return memberRepo.joinNick(memberNick) == null? "Y":"N";
	}
	
	@GetMapping("memberEmail/{memberEmail}")
	public String memberEmail(@PathVariable String memberEmail) {
		return memberRepo.joinEmail(memberEmail) == null? "Y":"N";
	}

}
