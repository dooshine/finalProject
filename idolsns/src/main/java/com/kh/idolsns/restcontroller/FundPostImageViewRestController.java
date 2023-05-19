package com.kh.idolsns.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.FundPostImageViewDto;
import com.kh.idolsns.repo.FundPostImageViewRepo;

@CrossOrigin
@RestController
@RequestMapping("/rest/fundpostimageview")
public class FundPostImageViewRestController {

	@Autowired
	private FundPostImageViewRepo fundPostImageViewRepo;
	
	@GetMapping("/{no}")
	FundPostImageViewDto detail(@PathVariable Long postNo) {
		return fundPostImageViewRepo.selectOne(postNo);
	}
}
