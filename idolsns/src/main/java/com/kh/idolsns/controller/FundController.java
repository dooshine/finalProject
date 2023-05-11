package com.kh.idolsns.controller;

import java.io.File;
import java.io.IOException;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.idolsns.configuration.CustomFileuploadProperties;
import com.kh.idolsns.dto.AttachmentDto;
import com.kh.idolsns.dto.FundPostDto;
import com.kh.idolsns.dto.PostDto;
import com.kh.idolsns.dto.PostImageDto;
import com.kh.idolsns.repo.AttachmentRepo;
import com.kh.idolsns.repo.FundPostRepo;
import com.kh.idolsns.repo.PostImageRepo;
import com.kh.idolsns.repo.PostRepo;

@Controller
@RequestMapping("fund")
public class FundController {
	
	@Autowired
	FundPostRepo fundPostRepo;
	
	@Autowired
	PostRepo postRepo;
	
	@Autowired
	PostDto postDto;
	
	@Autowired
	PostImageRepo postImageRepo;
	
	@Autowired
	CustomFileuploadProperties customFileuploadProperties;
	
	@Autowired
	AttachmentRepo attachmentRepo;
	
	private File dir;
	   @PostConstruct
	   public void init() {
	      dir = new File(customFileuploadProperties.getPath());
	   }
	
	@GetMapping("/write")
	public String write() {
		return "fund/write";
	}
	
	@PostMapping("/writeProcess")
	public String write(
							@ModelAttribute FundPostDto fundPostDto,
							@ModelAttribute PostDto postDto,
							@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		fundPostDto.setPostNo(postRepo.sequence());
		fundPostRepo.insert(fundPostDto);
		if(!attach.isEmpty()) {
	         int attachmentNo = attachmentRepo.sequence();   
	         File target = new File(dir, String.valueOf(attachmentNo));
	         attach.transferTo(target);
	         
	         attachmentRepo.insert(AttachmentDto.builder()
	                                 .attachmentNo(attachmentNo)
	                                 .attachmentName(attach.getOriginalFilename())
	                                 .attachmentType(attach.getContentType())
	                                 .attachmentSize(attach.getSize())
	                                 .build()
	               );

	         postImageRepo.insert(PostImageDto.builder()
	        		 				.attachmentNo(attachmentNo)
	        		 				.postNo(postDto.getPostNo())
	         						.build()
	        		 );
	      }
		
		return "redirect:writeFinish";
	}
	
	@GetMapping("/writeFinish")
	public String writeFinish() {
		return "fund/writeFinish";
	}
	
	@GetMapping("/list")
	public String list(Model model) {
		model.addAttribute("fundList", fundPostRepo.selectList());
		return "list";
	}
	
	

}
