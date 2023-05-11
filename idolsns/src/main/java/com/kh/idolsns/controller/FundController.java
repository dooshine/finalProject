package com.kh.idolsns.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	private PostRepo postRepo;
	
	@Autowired
	private FundPostRepo fundPostRepo;
	
	@Autowired
	private PostImageRepo postImageRepo;
	
	@Autowired
	private CustomFileuploadProperties customFileuploadProperties;
	
	@Autowired
	private AttachmentRepo attachmentRepo;
	
	private File dir;
	   @PostConstruct
	   public void init() {
	      dir = new File(customFileuploadProperties.getPath());
	   }
	
	@GetMapping("/")
	public String base() {
		return "fund/base";
	}
	
	@GetMapping("/write")
	public String write() {
		return "fund/write";
	}
	
	@PostMapping("/write")
	public String write(
							HttpSession session,
							@ModelAttribute FundPostDto fundPostDto,
							@ModelAttribute PostDto postDto,
							@RequestParam MultipartFile attach,
							RedirectAttributes attr
							) throws IllegalStateException, IOException {
		
		// # 통합게시물 등록
		// 1. 통합게시물 시퀀스 발행
        Long postNo = postRepo.sequence();
        postDto.setPostNo(postNo);

        // 2. 통합게시물 작성자
        String memberId = (String)session.getAttribute("memberId");
        postDto.setMemberId(memberId);

        // 3. 통합게시물 게시물종류 설정(Fix!!)
        postDto.setPostType("펀딩");

        // 4. 통합게시물 등록
        postRepo.insert(postDto);

		// # 펀딩게시물 등록
        // 1. 펀딩게시물 시퀀스 설정
        fundPostDto.setPostNo(postNo);
        
        // 2. 펀딩게시물 작성자
        fundPostDto.setMemberId(memberId);
        
        // 3. 펀딩게시물 등록
		fundPostRepo.insert(fundPostDto);
		
		// # 파일 등록
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
		
		// 리디렉트어트리뷰트 추가
        attr.addAttribute("postNo", postNo);
		
		return "redirect:detail/";
	}
	
	@PostMapping("/write2")
	public String write2(
							HttpSession session,
							@ModelAttribute FundPostDto fundPostDto,
							@ModelAttribute PostDto postDto,
							@RequestParam List<MultipartFile> attaches,
							RedirectAttributes attr
							) throws IllegalStateException, IOException {
		
		// # 통합게시물 등록
		// 1. 통합게시물 시퀀스 발행
        Long postNo = postRepo.sequence();
        postDto.setPostNo(postNo);

        // 2. 통합게시물 작성자
        String memberId = (String)session.getAttribute("memberId");
        postDto.setMemberId(memberId);

        // 3. 통합게시물 게시물종류 설정(Fix!!)
        postDto.setPostType("펀딩");

        // 4. 통합게시물 등록
        postRepo.insert(postDto);

		// # 펀딩게시물 등록
        // 1. 펀딩게시물 시퀀스 설정
        fundPostDto.setPostNo(postNo);
        
        // 2. 펀딩게시물 작성자
        fundPostDto.setMemberId(memberId);
        
        // 3. 펀딩게시물 등록
		fundPostRepo.insert(fundPostDto);
		
		// # 파일 등록
		if(!attaches.isEmpty()) {
			for(MultipartFile attach : attaches) {
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
	      }
		
		// 리디렉트어트리뷰트 추가
        attr.addAttribute("postNo", postNo);
		
		return "redirect:detail/";
	}
	
	// 펀딩게시물 목록조회
	@GetMapping("/list")
	public String list(Model model) {
		model.addAttribute("fundList", fundPostRepo.selectList());
		return "fund/list";
	}
	
	// 펀딩게시물 상세조회
	@GetMapping("/detail")
	public String detail(@RequestParam Long postNo, Model model) {
		FundPostDto fundPostDto = fundPostRepo.selectOne(postNo);
		
		List<PostImageDto> list = postImageRepo.selectList(postNo);
//		List<PostImageDto> postImageList = postImageRepo.selectList(postNo);
//		for(PostImageDto dto : postImageList) {
//			
//		}
//		int attachmentNo = postImageDto.getAttachmentNo();
//		postImageDto.setAttachmentNo(attachmentNo);
		
//		if(postImageDto.getAttachmentNo() != null) {
//			
//		}
		model.addAttribute("fundPostDto", fundPostDto);
		model.addAttribute("list", list);
		return "fund/detail";
	}
	
	
	
	

}
