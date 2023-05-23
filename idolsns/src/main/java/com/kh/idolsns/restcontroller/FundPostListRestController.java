package com.kh.idolsns.restcontroller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.FundPostListDto;
import com.kh.idolsns.dto.PostImageDto;
import com.kh.idolsns.repo.FundPostListRepo;

@CrossOrigin
@RestController
@RequestMapping("/rest/fundlist")
public class FundPostListRestController {

	@Autowired
	private FundPostListRepo fundPostListRepo;
	
	// 상세이미지 attachmentNos 불러오기
	@GetMapping("/attaches/{postNo}")
	public List<Integer> list(@PathVariable Long postNo) {
		List<PostImageDto> list = fundPostListRepo.selectAttachList(postNo);
		List<Integer> attachList = new ArrayList<>();
		
		for(PostImageDto dto : list) {
			attachList.add(dto.getAttachmentNo());
		}
		System.out.println("noooooooooooossssssss ====" + attachList);
		
		return attachList;
	}
	
//	// 펀딩 상세조회
	@GetMapping("/{postNo}")
	public FundPostListDto detail(@PathVariable Long postNo) {
		
		return fundPostListRepo.selectOne(postNo);
	}
	
	
}
