package com.kh.idolsns.repo;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.FundDto;
import com.kh.idolsns.dto.FundListWithTagDto;
import com.kh.idolsns.dto.FundPostImageDto;
import com.kh.idolsns.dto.PostImageDto;
import com.kh.idolsns.dto.TagDto;
import com.kh.idolsns.vo.FundDetailVO;

@Repository
public class FundPostImageRepoImpl implements FundPostImageRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<PostImageDto> selectAttachList(Long postNo) {
		return sqlSession.selectList("fundpostinte.attachByPostNo", postNo);
	}

	@Override
	public FundDetailVO selectOne(Long postNo) {
		return sqlSession.selectOne("fundpostinte.fundPostByPostNo", postNo);
	}

	@Override
	public List<FundPostImageDto> selectList() {
		return sqlSession.selectList("fundpostinte.list");
	}

	@Override
	public List<FundDto> selectFundList(Long postNo) {
		return sqlSession.selectList("fundpostinte.fundByPostNo", postNo);
	}

	@Override
	public List<FundPostImageDto> selectListByPaging(int page, String searchKeyword) {
		int end = page * 10;
		int begin = end - 9;
		Map<String, Object> param = Map.of("begin", begin, "end", end,
													"searchKeyword", searchKeyword);
		return sqlSession.selectList("fundpostinte.infiniteWithKeyword", param);
	}

	@Override
	public List<FundPostImageDto> selectListByPaging(int page) {
		int end = page * 10;
		int begin = end - 9;
		Map<String, Object> param = Map.of("begin", begin, "end", end);
		return sqlSession.selectList("fundpostinte.infinite", param);
	}

	@Override
	public List<TagDto> selectTagList(Long postNo) {
		return sqlSession.selectList("fundpostinte.tagByPostNo", postNo);
	}

	@Override
	public List<FundListWithTagDto> selectListWithTag(int page, String searchKeyword) {
		int end = page * 10;
		int begin = end - 9;
		Map<String, Object> param = Map.of("begin", begin, "end", end,
													"searchKeyword", searchKeyword);
		return sqlSession.selectList("fundpostinte.selectListWithTag", param);
	}

	
	
	
	

}
