package com.kh.idolsns.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.idolsns.dto.MemberDto;
import com.kh.idolsns.repo.MemberRepo;
import com.kh.idolsns.vo.AdminMemberSearchVO;

@Controller
@RequestMapping("/report")
public class ReportController {
    @Autowired
    private MemberRepo memberRepo;

    @GetMapping("/board")
    private String board(){
        return "/report/reportBoard";
    }
    // @GetMapping("/member")
    // private String member(@ModelAttribute AdminMemberSearchVO adminMemberSearchVO, Model model){
    //     List<MemberDto> list = memberRepo.selectList(adminMemberSearchVO);
    //     model.addAttribute("list", list);
    //     return "/report/reportMember";
    // }
    @GetMapping("/memberVue")
    private String member(HttpSession session, Model model){
        String memberId = (String)session.getAttribute("memberId");
        model.addAttribute("memberId", memberId);
        return "/report/reportMemberVue";
    }
    @GetMapping("/reply")
    private String reply(){
        return "/report/reportReply";
    }
}
