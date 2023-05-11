package com.kh.idolsns.repo;
import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.kh.idolsns.dto.ChatRoomPrivateDto;

@Repository
public class ChatRoomPrivateRepoImpl implements ChatRoomPrivateRepo {

	@Autowired
	private SqlSession sql;

	@Override
	public void createPrivateRoom(ChatRoomPrivateDto dto) {
		sql.insert("privateChatRoom.createPrivateRoom", dto);
	}
	@Override
	public ChatRoomPrivateDto findRoom(int privateRoomNo) {
		return sql.selectOne("privateChatRoom.findPrivateChat", privateRoomNo);
	}
	@Override
	public List<ChatRoomPrivateDto> listPrivateRoom() {
		return sql.selectList("privateChatRoom.listPrivateRoom");
	}
	
}
