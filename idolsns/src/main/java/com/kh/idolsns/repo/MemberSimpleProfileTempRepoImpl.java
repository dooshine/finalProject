package com.kh.idolsns.repo;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.MemberSimpleProfileTempDto;

@Repository
public class MemberSimpleProfileTempRepoImpl implements MemberSimpleProfileTempRepo {

	@Autowired
	private SqlSession sql;

	@Override
	public List<MemberSimpleProfileTempDto> profile(List<String> memberIdList) {
		return sql.selectList("simpleProfile.profile", memberIdList);
	}

}
