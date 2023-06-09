package com.kh.idolsns.service;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.kh.idolsns.vo.ReplyShowVO;


@Repository
public interface ReplyShowService {
	// 특정 글의 댓글 리스트를 불러오는 서비스
	List<ReplyShowVO> showReplyList(Long postNo);
	
}
