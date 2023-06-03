package com.kh.idolsns.repo;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.MemberSimpleProfileDto;

@Repository
public class MemberSimpleProfileRepoImpl implements MemberSimpleProfileRepo {

	@Autowired
	private SqlSession sql;

	@Override
	public List<MemberSimpleProfileDto> profile(List<String> memberIdList) {
		System.out.println(memberIdList.toString());
		return sql.selectList("simpleProfile.profile", Map.of("memberIdList", memberIdList));
	}

	@Override
	public MemberSimpleProfileDto selectProfileById(String memberId) {
		return sql.selectOne(memberId);
	}
}
