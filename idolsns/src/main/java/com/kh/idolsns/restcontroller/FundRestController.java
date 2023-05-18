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
@RequestMapping("/fund")
public class FundRestController {

	@Autowired
	private FundRepo fundRepo;
	
	@PostMapping("/")
	public void add(
			@ParameterObject
			@RequestBody FundDto fundDto
			) {
		Long fundNo = fundRepo.sequence();
		fundDto.setFundNo(fundNo);
		fundRepo.insert(fundDto);
		
	}
	
}
