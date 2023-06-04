package com.kh.idolsns.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.TagDto;
import com.kh.idolsns.repo.TagRepo;

@CrossOrigin
@RestController
@RequestMapping("/rest/tag")
public class TagRestController {

	

	@Autowired
	private TagRepo tagRepo;
	
	// 게시물 목록 조회
	@GetMapping("/{tagName}")
	public TagDto find(@PathVariable String tagName) {
		TagDto tagDto = tagRepo.find(tagName);
	    return tagDto;
    }
	 
	
}
