package com.kh.idolsns.repo;

import com.kh.idolsns.dto.ArtistDto;
import com.kh.idolsns.dto.ArtistViewDto;

public interface ArtistRepo {
    // 대표페이지 View 
    ArtistViewDto selectOneByName(String artistName);

    // 대표페이지 확인(영문소문자 이름)
    boolean isArtistExistByArtistEngNameLower(String artistEngNameLower);

    // 대표페이지 시퀀스 생성
    int createSequence();
    
    // 대표페이지 생성
    void createArtist(ArtistDto artistDto);
    
}
