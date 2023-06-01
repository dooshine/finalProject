package com.kh.idolsns.repo;
import java.util.List;
import com.kh.idolsns.dto.ChatNotiDto;

public interface ChatNotiRepo {

	void insert(ChatNotiDto dto);
	int myNotiList(String memberId);
	List<ChatNotiDto> roomNotiList(List<Integer> chatRoomNoList, String memberId);
	List<Integer> roomNotiNo(int chatRoomNo, String memberId);
	
}
