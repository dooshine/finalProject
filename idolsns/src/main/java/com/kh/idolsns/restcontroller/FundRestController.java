package com.kh.idolsns.restcontroller;

import org.springdoc.api.annotations.ParameterObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.FundDto;
import com.kh.idolsns.repo.FundRepo;

@CrossOrigin
@RestController
@RequestMapping("/rest/fund")
public class FundRestController {

	@Autowired
	private FundRepo fundRepo;
	
	// 후원하기 
	@PostMapping("/")
	public void add(
			@ParameterObject
			@RequestBody FundDto fundDto
			) {
		Long fundNo = fundRepo.sequence();
		fundDto.setFundNo(fundNo);
		// memberId는 header.jsp에서 가져와서 사용
		fundRepo.insert(fundDto);
		
	}
	
	// FundPost 
	
	
	
}
