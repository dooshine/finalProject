package com.kh.idolsns;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.kh.idolsns.dto.FundPostImageDto;
import com.kh.idolsns.repo.FundPostImageRepo;
import com.kh.idolsns.vo.FundDetailVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
// @SpringBootTest
public class TestFundList {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private FundPostImageRepo fundPostImageRepo;
	
//	@Test
//	public void test() {
//		Long postNo = (long)30;
//		FundDetailVO vo = sqlSession.selectOne("fundpostlist.fundByPostNo", postNo);
//			log.debug("vo={}", vo);
//			log.debug("dto = {}", vo.getFundPostImageDto());
//		
//		List<PostImageDto> nos = sqlSession.selectList("fundpostlist.attachByPostNo", postNo);
//			for(PostImageDto no : nos) {
//				log.debug("attachmentNos = {}", no.getAttachmentNo());
//			}
//	}
	
//	@Test
//	public void testFundTotal() {
//		List<FundDto> list = fundPostImageRepo.selectFundList((long) 54);
//		String total = "";
//		for(FundDto dto : list) {
//			total += dto.getFundPrice();
//		}
//		log.debug(total);
//	}
	
//	@Test
//	public void test02() {
//		FundDetailVO vo = fundPostImageRepo.selectOne(285L);
//		FundPostImageDto dto = vo.getFundPostImageDto();
//		LocalDate postEnd = dto.getPostEnd().toLocalDate();
//		LocalDate currentDate = LocalDate.now();
//		log.debug(postEnd.toString());
//		log.debug(currentDate.toString());
//		log.debug("boolean = {}", postEnd.isAfter(currentDate));
//	}
	
	// @Test
	// public void test() {
	// 	// 목록 조회 ( 마감날짜가 지난 펀딩게시글들 )
	// 	List<FundPostImageDto> list = fundPostImageRepo.selectList();
	// 	List<FundPostImageDto> templist = new ArrayList<>();
	// 	LocalDate currentDate = LocalDate.now();
	// 	for(FundPostImageDto dto : list) {
	// 		LocalDate postEnd = dto.getPostEnd().toLocalDate();
	// 		if(currentDate.isAfter(postEnd)) { // 현재날짜가 마감날짜를 지났으면
	// 			templist.add(dto);
	// 		}
	// 	}
	// 	for(FundPostImageDto dto : templist) {
	// 		//log.debug("no = {}" , dto.getPostNo());
			
	// 	}
	// }
}
