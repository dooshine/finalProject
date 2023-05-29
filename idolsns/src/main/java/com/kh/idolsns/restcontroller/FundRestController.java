package com.kh.idolsns.restcontroller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.FundDto;
import com.kh.idolsns.dto.FundPostImageDto;
import com.kh.idolsns.dto.PostImageDto;
import com.kh.idolsns.repo.FundPostImageRepo;
import com.kh.idolsns.repo.FundRepo;
import com.kh.idolsns.vo.FundDetailVO;
import com.kh.idolsns.vo.FundVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/fund")
public class FundRestController {

	@Autowired
	private FundRepo fundRepo;
	
	@Autowired
	private FundPostImageRepo fundPostImageRepo;
	
	// 펀딩게시물 목록 조회
	@GetMapping("/")
	public List<FundPostImageDto> fundPostList(){
		return fundPostImageRepo.selectList();
	}
	
	// 무한스크롤을 위한 백엔드 페이징 목록 구현
	// - 페이지번호를 알려준다면 10개를 기준으로 해당 페이지 번호의 데이터를 반환
	@GetMapping("/page/{page}")
	public List<FundPostImageDto> paging(@PathVariable int page) {
		return fundPostImageRepo.selectListByPaging(page);
	}
		
	
	// 펀딩상세 
	@GetMapping("/{postNo}")
	public FundPostImageDto detail(@PathVariable Long postNo) {
		FundDetailVO vo = fundPostImageRepo.selectOne(postNo);
		FundPostImageDto fundPostImageDto = vo.getFundPostImageDto();
//		System.out.println(fundPostImageDto);
		return fundPostImageDto;
	}
	
	// 상세이미지 attachmentNos 
	@GetMapping("/attaches/{postNo}")
	public List<Integer> list(@PathVariable Long postNo) {
		List<PostImageDto> list = fundPostImageRepo.selectAttachList(postNo);
		List<Integer> attachList = new ArrayList<>();
		
		for(PostImageDto dto : list) {
			attachList.add(dto.getAttachmentNo());
		}
		
		return attachList;
	}
	
	
	// 후원한 total금액 & 후원자 
	@GetMapping("/fundlist/{postNo}")
	public FundVO fundList(@PathVariable Long postNo){
		
		// total 금액
		List<FundDto> fundList = fundPostImageRepo.selectFundList(postNo);
		int fundTotal = 0;
		for(FundDto dto : fundList) {
			fundTotal += dto.getFundPrice();
		}
		
		// 후원자 수
		int sponsorCount = fundRepo.count(postNo);
		
		FundVO vo = new FundVO();
		vo.setFundTotal(fundTotal);
		vo.setFundSponsorCount(sponsorCount);
		
	    return vo;
	}
	
	
	@GetMapping("/order/{fundNo}")
	public FundDto getFund(@PathVariable long fundNo) {
		FundDto fundDto = fundRepo.find(fundNo);
		return fundDto;
	}
	
	
	  
	  
	
	
}
