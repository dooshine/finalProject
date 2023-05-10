package com.kh.idolsns.repo;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.kh.idolsns.dto.ChatMessageDto;

@Repository
public class ChatMessageRepoImpl implements ChatMessageRepo {

	@Autowired
	private SqlSession sql;

	@Override
	public void sendMessage(ChatMessageDto dto) {
		sql.insert("chatMessage.sendMessage", dto);
	}
	@Override
	public List<ChatMessageDto> messageList(int chatRoomNo) {
		return sql.selectList("chatMessage.listMessage", chatRoomNo);
	}
	@Override
	public void deleteMessage(int chatMessageNo, String memberId) {
		Map<String, Object> param = new HashMap<>();
		param.put("chatMessageNo", chatMessageNo);
		param.put("memberId", memberId);
		sql.delete("chatMessage.deleteMessage", param);
	}
	
}
