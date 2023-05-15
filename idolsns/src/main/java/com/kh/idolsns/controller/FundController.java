package com.kh.idolsns.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/fund")
public class FundController {

	
	 @GetMapping("/list")
	    public String list(){
	        return "fund/list";
	    }
	
	 @GetMapping("/detail")
	    public String detail(){
	        return "fund/detail";
	    }
	
	
}
