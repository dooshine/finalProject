package com.kh.idolsns.restcontroller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.idolsns.dto.ArtistDto;
import com.kh.idolsns.dto.ArtistProfileDto;
import com.kh.idolsns.dto.ArtistViewDto;
import com.kh.idolsns.repo.ArtistRepo;
import com.kh.idolsns.repo.AttachmentRepo;
import com.kh.idolsns.service.AttachmentService;

@CrossOrigin
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
                sqlSession.update("artist.updateArtistProfile", ArtistProfileDto.builder().artistNo(artistNo).attachmentNo(attachmentNo).build());
            } else {
                sqlSession.insert("artist.insertArtistProfile", ArtistProfileDto.builder().artistNo(artistNo).attachmentNo(attachmentNo).build());
            }
            
        }
    }

    // 대표페이지 삭제
    @DeleteMapping("/")
    public void deleteArtist(@RequestBody List<Integer> artistNoList){
        for(Integer artistNo : artistNoList){
            artistRepo.deleteArtist(artistNo);
        }
    }


    // (search) 대표페이지 검색조회
    @GetMapping("/search")
    public List<ArtistViewDto> selectArtistViewSearchList(@RequestParam Map<String, Object> artistSearchVO){
        // System.out.println(page);
        return sqlSession.selectList("artist.selectArtistViewSearchList", artistSearchVO);
    }

}
