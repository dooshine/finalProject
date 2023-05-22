package com.kh.idolsns.repo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.kh.idolsns.dto.ChatRoomPrivDto;

@Repository
public class ChatRoomPrivRepoImpl implements ChatRoomPrivRepo {

	@Autowired
	private SqlSession sql;

	@Override
	public void createRoom(ChatRoomPrivDto dto) {
		sql.insert("chatRoomPriv.createRoom", dto);
	}
	@Override
	public ChatRoomPrivDto findRoom(ChatRoomPrivDto dto) {
		return sql.selectOne("chatRoomPriv.findRoom", dto);
	}
	@Override
	public void leaveRoom(ChatRoomPrivDto dto) {
		sql.delete("chatRoomPriv.leaveRoom", dto);
	}
	@Override
	public ChatRoomPrivDto checkPriv(ChatRoomPrivDto dto) {
		return sql.selectOne("chatRoomPriv.checkPriv", dto);
	}
	
}
