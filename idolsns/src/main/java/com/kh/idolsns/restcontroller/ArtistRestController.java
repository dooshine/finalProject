package com.kh.idolsns.restcontroller;

import java.io.File;
import java.io.IOException;
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
import com.kh.idolsns.dto.ArtistProfileDto;
import com.kh.idolsns.dto.ArtistViewDto;
import com.kh.idolsns.dto.AttachmentDto;
import com.kh.idolsns.repo.ArtistRepo;
import com.kh.idolsns.repo.AttachmentRepo;
import com.kh.idolsns.service.AttachmentService;

@RestController
@RequestMapping("/rest/artist")
public class ArtistRestController {
    
    @Autowired
    private AttachmentRepo attachmentRepo;

    @Autowired
    private AttachmentService attachmentService;

    @Autowired
    private ArtistRepo artistRepo;
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
        return artistRepo.isArtistExistByArtistEngNameLower(artistEngNameLower);
    }
    // 대표페이지 생성
    @PostMapping("/")
    public void createArtist(@RequestParam("attachment") MultipartFile attachment, @ModelAttribute ArtistDto artistDto) throws IllegalStateException, IOException{
        System.out.println("대표페이지 생성까지 왔슈");
        System.out.println("대표페이지 생성 로직 구성하슈");
        // 파일저장
        // attachment저장
        // artist 저장

        if(!attachment.isEmpty()) {//파일이 있을 경우

            // # 1. attachment 저장
            // 번호 생성
            int attachmentNo = attachmentRepo.sequence();
            
            // 파일 저장 & attachment 테이블 저장
            attachmentService.handleAttachment(attachmentNo, attachment);

            // # 2. artist 생성
            // 시퀀스 발행
            int artistNo = artistRepo.createSequence();
            artistDto.setArtistNo(artistNo);

            if(!artistRepo.isArtistExistByArtistEngNameLower(artistDto.getArtistEngNameLower())){
                artistRepo.createArtist(artistDto);
            }

            // # 3. pageProfile 저장
            // 조회 후 insert | update
            if(!artistRepo.isArtistExistByArtistEngNameLower(artistDto.getArtistEngNameLower())){
                sqlSession.insert("artist.insertArtistProfile", ArtistProfileDto.builder().artistNo(artistNo).attachmentNo(attachmentNo).build());
            } else {
                sqlSession.update("artist.updateArtistProfile", ArtistProfileDto.builder().artistNo(artistNo).attachmentNo(attachmentNo).build());
            }
            
        }
    }


    // (search) 대표페이지 검색조회
    @GetMapping("/search")
    public List<ArtistViewDto> selectArtistViewSearchList(@RequestParam Map<String, Object> artistSearchVO){
        // System.out.println(page);
        return sqlSession.selectList("artist.selectArtistViewSearchList", artistSearchVO);
    }

}
