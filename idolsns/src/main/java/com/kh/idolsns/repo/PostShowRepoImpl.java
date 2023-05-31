package com.kh.idolsns.repo;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.vo.PostShowVO;

@Repository
public class PostShowRepoImpl implements PostShowRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public PostShowVO selectOne(Long postNo) {
		return sqlSession.selectOne("postShow.selectOne",postNo); 
	}

	@Override
	public List<PostShowVO> selectAll() {
		return sqlSession.selectList("postShow.selectAll");		
	}

	@Override
	public List<PostShowVO> selectListByPaging(int page) {		
		int end = page * 10;
		int begin = end - 9;
		Map<String, Object> param = Map.of("begin", begin, "end", end);
		return sqlSession.selectList("postShow.infinite",param);
	}
	
	@Override
	public List<PostShowVO> selectListByPagingReload(int page){
		int end = page * 10; 
		int begin = 1;
		
		Map<String, Object> param = Map.of("begin", begin, "end", end);
		return sqlSession.selectList("postShow.infinite",param);
		
	}
}
