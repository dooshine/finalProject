package com.kh.idolsns.repo;
import java.util.List;
import com.kh.idolsns.dto.ChatNotiDto;

public interface ChatNotiRepo {

	void insert(ChatNotiDto dto);
	int myNotiList(String memberId);
	List<Integer> notiList(List<Integer> chatRoomNoList, String memberId);
	
}
