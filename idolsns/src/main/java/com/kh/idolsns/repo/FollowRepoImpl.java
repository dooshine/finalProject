package com.kh.idolsns.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.FollowDto;

@Repository
public class FollowRepoImpl implements FollowRepo{

    @Autowired
    private SqlSession sqlSession;

    // 팔로우 생성
    @Override
    public void createFollow(FollowDto followDto) {
        sqlSession.insert("follow.createFollow", followDto);
    }

    // 팔로우 개별조회(팔로우한 사람, 팔로우 대상 타입, 팔로우 대상 PK)
    @Override
    public FollowDto selectFollowOne(FollowDto followDto) {
        return sqlSession.selectOne("follow.selectFollowOne", followDto);
    }

    // 팔로우 삭제(팔로우한 사람, 팔로우 대상 타입, 팔로우 대상 PK)
    @Override
    public void deleteFollow(FollowDto followDto) {
        sqlSession.delete("follow.deleteFollow", followDto);
    }
    
}
