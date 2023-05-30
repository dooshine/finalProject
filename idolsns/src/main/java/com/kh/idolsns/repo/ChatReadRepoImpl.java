package com.kh.idolsns.repo;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.kh.idolsns.dto.ChatReadDto;

@Repository
public class ChatReadRepoImpl implements ChatReadRepo {

	@Autowired
	private SqlSession sql;

	@Override
	public void saveMessage(ChatReadDto dto) {
		sql.insert("chatRead.saveMessage", dto);
	}
	@Override
	public void readMessage(ChatReadDto dto) {
		sql.delete("chatRead.readMessage", dto);
	}
	@Override
	public int newChatCount(String memberId) {
		return sql.selectOne("chatRead.newChatCount", memberId);
	}
	@Override
	public List<ChatReadDto> newChatByRoom(List<Integer> chatRoomNoList, String memberId) {
		Map<String, Object> param = Map.of("chatRoomNoList", chatRoomNoList, "memberId", memberId);
		return sql.selectList("chatRead.newChatByRoom", param);
	}
	
}
