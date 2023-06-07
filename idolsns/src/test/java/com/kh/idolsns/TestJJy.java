package com.kh.idolsns;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.kh.idolsns.vo.PostShowVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest
public class TestJJy {

	@Autowired
	private SqlSession sqlSession;
	
	@Test
	public void test() {
		
		Long postNo = 332l;
		
		List<PostShowVO> posts = sqlSession.selectList("postShow.getPostShow",postNo);
		
		for(PostShowVO post : posts)
		{
			System.out.println(post);
		}
		
	}
	
}
