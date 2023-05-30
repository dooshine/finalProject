package com.kh.idolsns.restcontroller;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.SearchMemberDto;

@RestController
@RequestMapping("/rest/search")
public class SearchRestController {
    
    @Autowired
    private SqlSession sqlSession;

    // 회원검색결과 조회
    @GetMapping("/member")
    public List<SearchMemberDto> selectSearchMember(@RequestParam String memberId){
        return sqlSession.selectList("search.selectSearchMember", memberId);
    }

    // 회원검색결과 조회
    @GetMapping("/memberProfile")
    public SearchMemberDto selectMemberProfile(@RequestParam String memberId){
        return sqlSession.selectOne("search.selectMemberProfile", memberId);
    }
}
