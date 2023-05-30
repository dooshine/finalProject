package com.kh.idolsns.repo;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.kh.idolsns.dto.ChatNotiDto;

@Repository
public class ChatNotiRepoImpl implements ChatNotiRepo {

	@Autowired
	private SqlSession sql;

	@Override
	public void insert(ChatNotiDto dto) {
		sql.insert("chatNoti.save", dto);
	}
	@Override
	public int myNotiList(String memberId) {
		return sql.selectOne("chatNoti.myNoti", memberId);
	}
	@Override
	public List<ChatNotiDto> roomNotiList(List<Integer> chatRoomNoList, String memberId) {
		Map<String, Object> param = Map.of("chatRoomNoList", chatRoomNoList, "memberId", memberId);
		return sql.selectList("chatNoti.notiList", param);
	}
	@Override
	public List<Integer> roomNotiNo(int chatRoomNo, String memberId) {
		Map<String, Object> param = Map.of("chatRoomNo", chatRoomNo, "memberId", memberId);
		return sql.selectList("chatNoti.roomNoti", param);
	}
	
}
