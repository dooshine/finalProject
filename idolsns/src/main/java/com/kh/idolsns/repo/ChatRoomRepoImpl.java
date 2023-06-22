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
	public int sequence() {
		return sql.selectOne("chatRoom.sequence");
	}
	@Override
	public void createRoom(ChatRoomDto dto) {
		sql.insert("chatRoom.createRoom", dto);
	}
	@Override
	public ChatRoomDto findRoom(int roomNo) {
		return sql.selectOne("chatRoom.findRoom", roomNo);
	}
	@Override
	public void deleteRoom(ChatRoomDto dto) {
		sql.delete("chatRoom.deleteRoom", dto);
	}
	@Override
	public void changeName(ChatRoomDto dto) {
		sql.update("chatRoom.changeName", dto);
	}
	@Override
	public List<ChatRoomDto> findRooms(List<Integer> chatRoomNoList) {
		return sql.selectList("chatRoom.findRooms", chatRoomNoList);
	}
	@Override
	public void updateLast(int roomNo) {
		sql.update("chatRoom.updateLast", roomNo);
	}
	
}
