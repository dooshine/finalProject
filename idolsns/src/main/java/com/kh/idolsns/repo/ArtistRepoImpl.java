package com.kh.idolsns.repo;

import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.ArtistViewDto;

@Repository
public class ArtistRepoImpl implements ArtistRepo{

    // 대표페이지 정보가져오기
    @Override
    public ArtistViewDto selectOneByName(String artistName) {
        // TODO Auto-generated method stub
        return null;
    }
    
}
