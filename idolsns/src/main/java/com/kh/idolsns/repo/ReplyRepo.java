package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.ReplyDto;

public interface ReplyRepo {
	void addReply(ReplyDto replyDto);
	Long sequence();
	List<ReplyDto> getRepliesByPostNo(Long postNo);
	ReplyDto selectOne(Long replyNo);
	boolean deleteReplies(Long groupNo);
	boolean deleteRereply(Long replyNo);
	boolean updateReply(Long replyNo, String replyContent);
}
