package com.kh.idolsns.controller;

import java.io.File;

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
import com.kh.idolsns.repo.AttachmentRepo;
import com.kh.idolsns.repo.FundPostRepo;

@Controller
@RequestMapping("fund")
public class FundController {
	
	@Autowired
	FundPostRepo repo;
	
	@Autowired
	PostRepo postRepo;
	
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
	public String write(@ModelAttribute FundPostDto dto,
							@RequestParam MultipartFile attach) {
		dto.setPostNo(postRepo.sequence());
		repo.insert(dto);
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

//	         productImageDao.insert(ProductImageDto.builder()
//                     .productNo(productDto.getProductNo())
//                     .attachmentNo(attachmentNo)
//                     .build()
//	        		 );
	      }
		
		return "redirect:writeFinish";
	}
	
	@GetMapping("/writeFinish")
	public String writeFinish() {
		return "fund/writeFinish";
	}
	
	@GetMapping("/list")
	public String list(Model model) {
		model.addAttribute("fundList", repo.selectList());
		return "list";
	}
	
	

}
