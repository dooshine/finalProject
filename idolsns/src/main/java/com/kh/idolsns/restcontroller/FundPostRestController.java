package com.kh.idolsns.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.FundDto;
import com.kh.idolsns.dto.FundPostDto;
import com.kh.idolsns.dto.FundPostImageDto;
import com.kh.idolsns.repo.FundPostRepo;
import com.kh.idolsns.vo.FundDetailVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/fundpost")
public class FundPostRestController {

	@Autowired
	private FundPostRepo fundPostRepo;
	
	@GetMapping("/")
	public List<FundPostDto> list() {
		return fundPostRepo.selectList();
	}

 
	   
   @GetMapping("/order/{postNo}")
   public FundPostDto getFund(@PathVariable long postNo) {
	   FundPostDto fundPostDto = fundPostRepo.find(postNo);
	   return fundPostDto;
   }



}
