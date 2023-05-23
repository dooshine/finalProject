package com.kh.idolsns.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.PostImageDto;

@Repository
public class PostImageRepoImpl implements PostImageRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(PostImageDto postImageDto) {
		sqlSession.insert("postImage.add", postImageDto);
	}

	@Override
	public List<PostImageDto> selectList(Long postNo) {
		return sqlSession.selectList("postImage.list", postNo);
	}

	@Override
	public List<Long> selectAttachNoList(Long postNo) {
		return sqlSession.selectList("postImage.selectAttachNoList",postNo);
	}

}
