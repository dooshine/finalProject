package com.kh.idolsns.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.repo.MemberRepo;

@CrossOrigin(origins = {"http://127.0.0.1:5500"})
@RestController
@RequestMapping("/rest/member")
public class MemberRestController {

	@Autowired
	private MemberRepo memberRepo;
	
	@GetMapping("/memberId/{memberId}")
	public char memberId(@PathVariable String memberId) {
		return memberRepo.selectOne(memberId) == null ? 'Y':'N';
	}
	
	@GetMapping("memberNick/{memberNick}")
	public char memberNick(@PathVariable String memberNick) {
		return memberRepo.joinNick(memberNick) == null? 'Y':'N';
	}
	
	@GetMapping("memberEmail/{memberEmail}")
	public char memberEmail(@PathVariable String memberEmail) {
		return memberRepo.joinEmail(memberEmail) == null? 'Y':'N';
	}
	
}
