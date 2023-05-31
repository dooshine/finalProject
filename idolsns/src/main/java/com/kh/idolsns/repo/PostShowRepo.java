package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.vo.PostShowVO;

public interface PostShowRepo {
	public PostShowVO selectOne(Long postNo);
	public List<PostShowVO> selectAll();
	List<PostShowVO> selectListByPaging(int page);
	List<PostShowVO> selectListByPagingReload(int page);
	// 특정 맴버가 좋아요한 글 맨 처음 페이지 부터 지금 페이지까지 
	List<PostShowVO> selectLikedPostListByPagingReload(int page,String memberId);
	// 특정 맴버가 쓴글 글 맨 처음 페이지 부터 지금 페이지까지
	List<PostShowVO> selectWritedPostListByPagingReload(int page, String memberId);
	// 특정 고정태그 글
	List<PostShowVO> selectFixedTagPostListByPagingReload(int page,String fixedTag);
}
