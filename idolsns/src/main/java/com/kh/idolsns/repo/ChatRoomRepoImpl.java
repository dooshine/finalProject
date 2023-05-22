package com.kh.idolsns.repo;
import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.kh.idolsns.dto.ChatRoomDto;
import com.kh.idolsns.vo.ChatRoomVO;

@Repository
public class ChatRoomRepoImpl implements ChatRoomRepo {

	@Autowired
	private SqlSession sql;

	@Override
	public int sequence() {
		return sql.selectOne("chatRoom.sequence");
	}
	@Override
	public boolean isRoomExist(List<ChatRoomVO> memberList) {
		return sql.selectList("chatRoom.isRoomExist").size() > 0;
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
	public List<ChatRoomDto> listRoom() {
		return sql.selectList("chatRoom.listRoom");
	}
	@Override
	public void deleteRoom(ChatRoomDto dto) {
		sql.delete("chatRoom.deleteRoom", dto);
	}
	
}
