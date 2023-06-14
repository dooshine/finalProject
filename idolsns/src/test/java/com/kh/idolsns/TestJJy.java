package com.kh.idolsns;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.kh.idolsns.service.PostShowService;
import com.kh.idolsns.service.ReplyShowService;
import com.kh.idolsns.vo.PostShowVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest
public class TestJJy {

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private PostShowService postShowService; 

	@Test
	public void test() {
		
		int page = 1; 
				
		List<PostShowVO> list =  postShowService.fixedTagPostShowByPagingReload(page, "아이브");
	
		for(PostShowVO vo : list) {
			//System.out.println(vo);
		}
				
		
		
		
		
	}
	
}
