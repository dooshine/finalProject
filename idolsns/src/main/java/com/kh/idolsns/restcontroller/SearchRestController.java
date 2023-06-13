package com.kh.idolsns.restcontroller;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.SearchMemberDto;
import com.kh.idolsns.vo.MemberSearchVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/search")
public class SearchRestController {
    
    @Autowired
    private SqlSession sqlSession;

    // 회원검색결과 조회
    @GetMapping("/member")
    public List<SearchMemberDto> selectSearchMember(@ModelAttribute MemberSearchVO memberSearchVO){
    // public List<SearchMemberDto> selectSearchMember(@RequestParam String memberId){
        return sqlSession.selectList("search.selectSearchMember", memberSearchVO);
        // return null;
    }

    // 회원검색결과 조회
    @GetMapping("/memberProfile")
    public SearchMemberDto selectMemberProfile(@RequestParam String memberId){
        return sqlSession.selectOne("search.selectMemberProfile", memberId);
    }
}
