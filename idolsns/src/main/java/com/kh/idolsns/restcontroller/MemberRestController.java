package com.kh.idolsns.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.MemberDto;
import com.kh.idolsns.repo.MemberRepo;
import com.kh.idolsns.vo.AdminMemberSearchVO;

import io.swagger.v3.oas.annotations.parameters.RequestBody;

@CrossOrigin
@RestController
@RequestMapping("/rest/member")
public class MemberRestController {
    @Autowired
    private MemberRepo memberRepo;

    @PostMapping("/")
    public List<MemberDto> adminSelectList(@RequestBody AdminMemberSearchVO adminMemberSearchVO){
        return memberRepo.adminSelectList(adminMemberSearchVO);
    }
}
