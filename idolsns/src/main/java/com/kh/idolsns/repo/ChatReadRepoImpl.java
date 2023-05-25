package com.kh.idolsns.repo;
import java.util.HashMap;
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
	
}
