package com.kh.idolsns;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.kh.idolsns.repo.MemberRepo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest
public class Test02 {

	@Autowired
	private MemberRepo memberRepo;
	
	@Test
	public void test() {
		//log.debug("아이디 삭제 작업 ; {}", memberRepo.deleteMemberProc("testuser7"));
	}
}
