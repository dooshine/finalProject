package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.vo.PostShowVO;

public interface PostShowRepo {
	public PostShowVO selectOne(Long postNo);
	public List<PostShowVO> selectAll();
	List<PostShowVO> selectListByPaging(int page);
	List<PostShowVO> selectListByPagingReload(int page);
}
