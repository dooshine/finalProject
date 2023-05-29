package com.kh.idolsns.repo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.kh.idolsns.dto.NotiDto;

@Repository
public class NotiRepoImpl implements NotiRepo {

	@Autowired
	private SqlSession sql;
	
	@Override
	public void insert(NotiDto dto) {
		sql.insert("noti.save", dto);
	}
	@Override
	public int sequence() {
		return sql.selectOne("noti.sequence");
	}
	@Override
	public void delete(int notiNo) {
		sql.delete("noti.delete", notiNo);
	}

}
