package com.kh.idolsns.repo;
import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.kh.idolsns.dto.ChatJoinDto;

@Repository
public class ChatJoinRepoImpl implements ChatJoinRepo {

	@Autowired
	private SqlSession sql;

	@Override
	public void joinChatRoom(ChatJoinDto dto) {
		sql.insert("chatJoin.joinChatRoom", dto);
	}
	@Override
	public List<ChatJoinDto> findChatRoomById(String memberId) {
		return sql.selectList("chatJoin.findChatRoomById", memberId);
	}
	@Override
	public int findChatRoomNoById(String memberId) {
		return sql.selectOne("chatJoin.findChatRoomNoById", memberId);
	}
	@Override
	public boolean doseAlreadyIn(ChatJoinDto dto) {
		return sql.selectOne("chatJoin.doseAlreadyIn", dto) != null;
	}
	@Override
	public List<ChatJoinDto> findMembersByRoomNo(int chatRoomNo) {
		return sql.selectList("chatJoin.findMembersByRoomNo", chatRoomNo);
	}
	
}
