package com.kh.idolsns.repo;

import com.kh.idolsns.dto.ArtistViewDto;

public interface ArtistRepo {
    // 대표페이지 View 
    ArtistViewDto selectOneByName(String artistName);
}
