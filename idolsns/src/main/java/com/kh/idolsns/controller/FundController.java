package com.kh.idolsns.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.idolsns.repo.FundPostRepo;

@Controller
@RequestMapping("fund")
public class FundController {
	
	@Autowired
	FundPostRepo repo;
	
	@GetMapping("/write")
	public String write() {
		return "fund/write";
	}
	
//	@PostMapping("/write")
	
	
	

}
