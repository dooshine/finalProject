package com.kh.idolsns.restcontroller;

import javax.servlet.http.HttpSession;

import org.springdoc.api.annotations.ParameterObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.FundDto;
import com.kh.idolsns.repo.FundRepo;

@CrossOrigin
@RestController
@RequestMapping("/rest/fund")
public class FundRestController {

	@Autowired
	private FundRepo fundRepo;
	
	@PostMapping("/")
	public void add(
			@ParameterObject
			@RequestBody FundDto fundDto,
			@RequestParam Long postNo,
			HttpSession session) {
		String memberId = (String) session.getAttribute("memberId");
		Long fundNo = fundRepo.sequence();
		fundDto.setFundId(memberId);
		fundDto.setPostNo(postNo);
		fundDto.setFundNo(fundNo);
		
		fundRepo.insert(fundDto);
		
	}
	
}
