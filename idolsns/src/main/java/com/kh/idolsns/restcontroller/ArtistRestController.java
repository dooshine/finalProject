package com.kh.idolsns.restcontroller;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.ArtistViewDto;

@RestController
@RequestMapping("/rest/artist")
public class ArtistRestController {
    
    @Autowired
    private SqlSession sqlSession;

    // 대표페이지 View 조회
    @GetMapping("/")
    public ArtistViewDto selectArtistView(@RequestParam String artistEngNameLower){
        return sqlSession.selectOne("artist.selectArtistViewByEngName", artistEngNameLower);
    }

    // (search) 대표페이지 검색조회
    @GetMapping("/search")
    public List<ArtistViewDto> selectArtistViewSearchList(@RequestParam Map<String, Object> artistSearchVO){
        // System.out.println(page);
        return sqlSession.selectList("artist.selectArtistViewSearchList", artistSearchVO);
    }
}
