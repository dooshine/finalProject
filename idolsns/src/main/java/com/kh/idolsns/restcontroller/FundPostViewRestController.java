package com.kh.idolsns.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.FundPostViewDto;
import com.kh.idolsns.repo.FundPostViewRepo;

@CrossOrigin
@RestController
@RequestMapping("/fundpostview")
public class FundPostViewRestController {

	@Autowired
	private FundPostViewRepo fundPostViewRepo;
	
	@GetMapping("/")
	public List<FundPostViewDto> list() {
		return fundPostViewRepo.selectList();
	}
}
