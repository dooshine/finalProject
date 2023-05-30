package com.kh.idolsns.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.PostLikeDto;

@Repository
public class PostLikeRepoImpl implements PostLikeRepo{

	@Autowired
	private SqlSession sqlSession; 
	
	// 특정 맴버의 특정 게시글 좋아요 추가
	@Override
	public void insert(PostLikeDto postLikeDto) {
		sqlSession.insert("postLike.insert",postLikeDto); 		
	}

	// 특정 맴버의 특정 게시글 좋아요 삭제
	@Override
	public void delete(PostLikeDto postLikeDto) {
		sqlSession.delete("postLike.delete",postLikeDto);
	}

	// 특정 게시물 좋아요 수 조회 
	@Override
	public Long count(Long postNo) {
		return sqlSession.selectOne("postLike.count",postNo); 
	}

	// 특정 맴버가 좋아요 했는 지 조회 
	@Override
	public Boolean check(PostLikeDto postLikeDto) {
		return (Integer) sqlSession.selectOne("postLike.check",postLikeDto) > 0 ;
	}

	@Override
	public void deleteByPostNo(Long postNo) {
		sqlSession.delete("postLike.deleteByPostNo",postNo);
		
	}

}
