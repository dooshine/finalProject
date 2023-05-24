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
import com.kh.idolsns.vo.FundDetailVO;
import com.kh.idolsns.vo.FundVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/fund")
public class FundPostListRestController {

	@Autowired
	private FundPostImageRepo fundPostImageRepo;
	
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
	
	// 펀딩상세 
	@GetMapping("/{postNo}")
	public FundPostImageDto detail(@PathVariable Long postNo) {
		FundDetailVO vo = fundPostImageRepo.selectOne(postNo);
		FundPostImageDto fundPostImageDto = vo.getFundPostImageDto();
//		System.out.println(fundPostImageDto);
		return fundPostImageDto;
	}
	
	// 후원한 total금액 
	@GetMapping("/fundtotal/{postNo}")
	public int fundTotal(@PathVariable Long postNo){
		List<FundDto> list = fundPostImageRepo.selectFundList(postNo);
		
		int fundTotal = 0;
		for(FundDto dto : list) {
			fundTotal += dto.getFundPrice();
		}
		
		return fundTotal;
	}
}
