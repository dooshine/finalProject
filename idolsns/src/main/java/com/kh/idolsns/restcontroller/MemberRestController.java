package com.kh.idolsns.restcontroller;

import java.util.List;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.kh.idolsns.dto.MemberDto;
import com.kh.idolsns.repo.MemberRepo;
import io.swagger.v3.oas.annotations.parameters.RequestBody;
import com.kh.idolsns.vo.AdminMemberSearchVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/member")
public class MemberRestController {

	@Autowired
	private MemberRepo memberRepo;
	
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

    @PostMapping("/")
    public List<MemberDto> adminSelectList(@RequestBody AdminMemberSearchVO adminMemberSearchVO){
        return memberRepo.adminSelectList(adminMemberSearchVO);
    }
}
