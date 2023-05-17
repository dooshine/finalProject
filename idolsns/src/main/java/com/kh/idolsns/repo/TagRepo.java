package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.TagDto;

//import com.kh.idolsns.dto.freeTagDto;

public interface TagRepo {
	// 자유태그 시퀀스 발행
	Long sequence();
	// 자유태그 등록
	void insert(TagDto tagDto);
	// 업데이트는 필요 x 
	// 하나의 태그명 조회( 번호가 있는 지를 알려줌)
	Long selectOne(String tagName); 
	// 자유태그 삭제
	boolean delete(Long tagNo); 
	// 특정글 태그 전체 불러오기 
	List<String> selectAll(Long postNo);
}
