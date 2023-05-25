package com.kh.idolsns.repo;

import com.kh.idolsns.dto.ReplyDto;

public interface ReplyRepo {
	void addReply(ReplyDto replyDto);
	Long sequence();
}
