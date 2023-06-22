package com.kh.idolsns.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.ArtistDto;
import com.kh.idolsns.dto.ArtistViewDto;

@Repository
public class ArtistRepoImpl implements ArtistRepo{

    @Autowired
    private SqlSession sqlSession;

    // 대표페이지 정보가져오기
    @Override
    public ArtistViewDto selectOneByName(String artistName) {
        // TODO Auto-generated method stub
        return null;
    }

    // 대표페이지 확인(영문소문자 이름)
    @Override
    public boolean isArtistExistByArtistEngNameLower(String artistEngNameLower) {
        ArtistViewDto dto = sqlSession.selectOne("artist.selectArtistViewByEngName", artistEngNameLower);
        return dto != null;
    }

    // 대표페이지 시퀀스 생성
    @Override
    public int createSequence() {
        return sqlSession.selectOne("artist.sequence");
    }

    // 대표페이지 생성
    @Override
    public void createArtist(ArtistDto artistDto) {
        sqlSession.insert("artist.insertArtist", artistDto);
    }

    // 대표페이지 삭제(대표페이지 번호)
    @Override
    public void deleteArtist(Integer artistNo) {
        sqlSession.delete("artist.deleteArtistByArtistNo", artistNo);
    }
}
