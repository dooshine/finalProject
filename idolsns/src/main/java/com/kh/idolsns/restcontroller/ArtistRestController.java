package com.kh.idolsns.restcontroller;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.idolsns.dto.ArtistDto;
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

    // 대표페이지 확인(artistEngNameLower)
    @GetMapping("/check")
    public boolean isArtistViewExist(@RequestParam String artistEngNameLower){
        ArtistViewDto dto = sqlSession.selectOne("artist.selectArtistViewByEngName", artistEngNameLower);
        return dto != null;
    }
    // 대표페이지 생성
    @PostMapping("/")
    public void createArtist(@RequestParam("attachment") MultipartFile attachment, @ModelAttribute ArtistDto artistDto){
        System.out.println("대표페이지 생성까지 왔슈");
        System.out.println("대표페이지 생성 로직 구성하슈");
        // 파일저장
        // attachment저장
        // artist 저장
    }


    // (search) 대표페이지 검색조회
    @GetMapping("/search")
    public List<ArtistViewDto> selectArtistViewSearchList(@RequestParam Map<String, Object> artistSearchVO){
        // System.out.println(page);
        return sqlSession.selectList("artist.selectArtistViewSearchList", artistSearchVO);
    }
}
