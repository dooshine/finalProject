package com.kh.idolsns.repo;
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
	
}
