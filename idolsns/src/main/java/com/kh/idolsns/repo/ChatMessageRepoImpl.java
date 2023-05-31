package com.kh.idolsns.repo;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.kh.idolsns.dto.ChatMessageDto;
import com.kh.idolsns.vo.ChatMessageVO;

@Repository
public class ChatMessageRepoImpl implements ChatMessageRepo {

	@Autowired
	private SqlSession sql;

	@Override
	public int sequence() {
		return sql.selectOne("chatMessage.sequence");
	}
	@Override
	public void sendMessage(ChatMessageDto dto) {
		sql.insert("chatMessage.sendMessage", dto);
	}
	@Override
	public List<ChatMessageDto> messageList(ChatMessageVO vo) {
		int end = vo.getPage() * 10;
		int begin = end - 9;
		Map<String, Object> param = Map.of("begin", begin, "end", end, "chatRoomNo", vo.getChatRoomNo());
		return sql.selectList("chatMessage.listMessage", param);
	}
	@Override
	public void deleteMessage(long chatMessageNo) {
		sql.delete("chatMessage.deleteMessage", chatMessageNo);
	}
	@Override
	public void sendPic(ChatMessageDto dto) {
		sql.insert("chatMessage.sendPic", dto);
	}
	
}
