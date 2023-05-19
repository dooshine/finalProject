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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.idolsns.configuration.CustomFileuploadProperties;
import com.kh.idolsns.dto.AttachmentDto;
import com.kh.idolsns.dto.FundDto;
import com.kh.idolsns.dto.FundPostDto;
import com.kh.idolsns.dto.PostDto;
import com.kh.idolsns.dto.PostImageDto;
import com.kh.idolsns.repo.AttachmentRepo;
import com.kh.idolsns.repo.FundPostRepo;
import com.kh.idolsns.repo.FundPostViewRepo;
import com.kh.idolsns.repo.FundRepo;
import com.kh.idolsns.repo.PostImageRepo;
import com.kh.idolsns.repo.PostRepo;
import com.kh.idolsns.vo.SearchVO;

@Controller
@RequestMapping("/fund")
public class FundController {
	
	@Autowired
	private PostRepo postRepo;
	
	//@Autowired
	//private FundRepo fundRepo; 
	
	@Autowired
	private FundPostRepo fundPostRepo;
	
	@Autowired
	private PostImageRepo postImageRepo;
	
	@Autowired
	private FundPostViewRepo fundPostViewRepo;
	
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
	public String write(@ModelAttribute PostImageDto postImageDto,
								Model model) {
		
		return "fund/write";
	}
	
//	@PostMapping("/write")
//	public String write(
//							HttpSession session,
//							@ModelAttribute FundPostDto fundPostDto,
//							@ModelAttribute PostDto postDto,
//							@RequestParam MultipartFile attach,
//							RedirectAttributes attr
//							) throws IllegalStateException, IOException {
//		
//		// # 통합게시물 등록
//		// 1. 통합게시물 시퀀스 발행
//        Long postNo = postRepo.sequence();
//        postDto.setPostNo(postNo);
//
//        // 2. 통합게시물 작성자
//        String memberId = (String)session.getAttribute("memberId");
//        postDto.setMemberId(memberId);
//
//        // 3. 통합게시물 게시물종류 설정(Fix!!)
//        postDto.setPostType("펀딩");
//
//        // 4. 통합게시물 등록
//        postRepo.insert(postDto);
//
//		// # 펀딩게시물 등록
//        // 1. 펀딩게시물 시퀀스 설정
//        fundPostDto.setPostNo(postNo);
//        
//        // 2. 펀딩게시물 작성자
//        fundPostDto.setMemberId(memberId);
//        
//        // 3. 펀딩게시물 등록
//		fundPostRepo.insert(fundPostDto);
//		
//		// # 파일 등록
//		if(!attach.isEmpty()) {
//	         int attachmentNo = attachmentRepo.sequence();   
//	         File target = new File(dir, String.valueOf(attachmentNo));
//	         attach.transferTo(target);
//	         
//	         attachmentRepo.insert(AttachmentDto.builder()
//	                                 .attachmentNo(attachmentNo)
//	                                 .attachmentName(attach.getOriginalFilename())
//	                                 .attachmentType(attach.getContentType())
//	                                 .attachmentSize(attach.getSize())
//	                                 .build()
//	               );
//
//	         postImageRepo.insert(PostImageDto.builder()
//	        		 				.attachmentNo(attachmentNo)
//	        		 				.postNo(postDto.getPostNo())
//	         						.build()
//	        		 );
//	      }
//		
//		// 리디렉트어트리뷰트 추가
//        attr.addAttribute("postNo", postNo);
//		
//		return "redirect:fund/detail";
//	}
	
	@PostMapping("/write2")
	public String write2(
							HttpSession session,
							@ModelAttribute FundPostDto fundPostDto,
							@ModelAttribute PostDto postDto,
							@ModelAttribute PostImageDto postImageDto,
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
		
		// # DB 저장
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
						.postNo(postNo)
						.build()
						);
			}
	      }
		
				
		// 리디렉트어트리뷰트 추가
        attr.addAttribute("postNo", postNo);
		
		return "redirect:detail";
	}
	
	
	@PostMapping("/write3")
	public String write3(
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
		
		// # DB 저장
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
        attr.addAttribute("fundPostDto", fundPostDto);
		
		return "redirect:detail/";
	}
	
	
	// 펀딩게시물 목록조회
	@GetMapping("/list")
	public String list(
						Model model,
						@ModelAttribute SearchVO searchVO
						) {
		model.addAttribute("fundList", fundPostViewRepo.selectList());
		return "fund/list";
	}
	
	// 펀딩게시물 상세조회
	@GetMapping("/detail")
	public String detail(@RequestParam Long postNo, Model model) {
		FundPostDto fundPostDto = fundPostRepo.selectOne(postNo);
		
		List<PostImageDto> list = postImageRepo.selectList(postNo);
		
		model.addAttribute("fundPostDto", fundPostDto);
		model.addAttribute("postImageList", list);
		return "fund/detail";
	}

	// 펀딩게시물 수정
    @GetMapping("/update")
    public String update(
				@RequestParam Long postNo,
										Model model
    						){
        FundPostDto fundPostDto = fundPostRepo.selectOne(postNo);
        model.addAttribute("fundPostDto", fundPostDto);
        return "fund/update";
    }

    // 펀딩게시물 수정
    @PostMapping("/update")
    public String updateProcess(
    		@ModelAttribute PostDto postDto, 
    		RedirectAttributes attr){
        postRepo.update(postDto);

        attr.addAttribute("postNo", postDto.getPostNo());
        return "redirect:fund/detail";
    }
    

	 // 펀딩 주문 페이지
	 @GetMapping("/order")
	 public String fundOrder(@RequestParam Long postNo, Model model) {
	     FundPostDto fundPostDto = fundPostRepo.selectOne(postNo);
	     
	     model.addAttribute("fundPostDto", fundPostDto);
	     
	     
	     return "fund/order";
	 }
	
	 // 펀딩 주문 처리
	 @PostMapping("/order")
	 public String processFundOrder(@RequestParam Long postNo, @RequestParam Integer fundPrice, Model model) {
	     // 후원 정보 처리 및 필요한 동작 수행
	     FundPostDto fundPostDto = fundPostRepo.selectOne(postNo);
	     
	     // 후원금액 처리 등 추가 동작 수행
	     
	     model.addAttribute("fundPostDto", fundPostDto);
	     model.addAttribute("fundPrice", fundPrice);
	     
	     return "fund/clear";
	 }
	
	 // 펀딩 주문 완료 페이지
	 @GetMapping("/order/clear")
	 public String fundOrderClear(@RequestParam Long postNo, @RequestParam Integer fundPrice, Model model) {
	     FundPostDto fundPostDto = fundPostRepo.selectOne(postNo);
	     
	     model.addAttribute("fundPostDto", fundPostDto);
	     model.addAttribute("fundPrice", fundPrice);
	     
	     return "fund/clear";
	     
	 }
    
    

}
