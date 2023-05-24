package com.kh.idolsns;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.kh.idolsns.dto.FundDto;
import com.kh.idolsns.dto.PostImageDto;
import com.kh.idolsns.repo.FundPostImageRepo;
import com.kh.idolsns.vo.FundDetailVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest
public class TestFundList {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private FundPostImageRepo fundPostImageRepo;
	
	@Test
	public void test() {
		Long postNo = (long)30;
		FundDetailVO vo = sqlSession.selectOne("fundpostlist.fundByPostNo", postNo);
//			log.debug("vo={}", vo);
//			log.debug("dto = {}", vo.getFundPostImageDto());
		
		List<PostImageDto> nos = sqlSession.selectList("fundpostlist.attachByPostNo", postNo);
			for(PostImageDto no : nos) {
//				log.debug("attachmentNos = {}", no.getAttachmentNo());
			}
			
			
	}
	
	@Test
	public void testFundTotal() {
		List<FundDto> list = fundPostImageRepo.selectFundList((long) 54);
		String total = "";
		for(FundDto dto : list) {
			total += dto.getFundPrice();
		}
		log.debug(total);
	}
}
