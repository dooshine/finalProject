package com.kh.idolsns.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.FundPostDto;
import com.kh.idolsns.dto.PostImageDto;

@Repository
public class FundPostRepoImpl implements FundPostRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(FundPostDto dto) {
		sqlSession.insert("fundPost.add", dto);
	}

	@Override
	public List<FundPostDto> selectList() {
		return sqlSession.selectList("fundPost.selectList");
	}

	@Override
	public FundPostDto selectOne(Long postNo) {
		return sqlSession.selectOne("fundPost.selectOne", postNo);
	}

	@Override
	public boolean update(FundPostDto dto) {
		return sqlSession.update("fundPost.edit", dto) > 0;
	}

	@Override
	public void connect(PostImageDto postImageDto) {
		sqlSession.insert("fundPost.connect", postImageDto);
	}

	@Override
	public boolean sponsorCount(FundPostDto fundPostDto) {
		return sqlSession.update("fundPost.sponsorCount", fundPostDto) > 0;
	}
	
//	@Override
//	public void connect(Long postNo, int attachmentNo) {
//		Map<String, Object> parameters = new HashMap<>();
//		parameters.put("param1", postNo);
//		parameters.put("param2", attachmentNo);
//		sqlSession.insert("fundPost.connect", parameters);
//	}



}
