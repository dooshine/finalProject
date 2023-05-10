package com.kh.idolsns.repo;
import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.kh.idolsns.dto.ChatRoomDto;

@Repository
public class ChatRoomRepoImpl implements ChatRoomRepo {

	@Autowired
	private SqlSession sql;

	@Override
	public void createRoom(ChatRoomDto dto) {
		sql.insert("chatRoom.creatChatRoom", dto);
	}
	@Override
	public ChatRoomDto findRoom(int roomNo) {
		return sql.selectOne("chatRoom.findRoom", roomNo);
	}
	@Override
	public List<ChatRoomDto> listRoom() {
		return sql.selectList("chatRoom.listRoom");
	}
	
}
