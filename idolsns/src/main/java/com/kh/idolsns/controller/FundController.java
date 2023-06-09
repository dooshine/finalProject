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
import com.kh.idolsns.dto.FundDto;
import com.kh.idolsns.dto.FundMainImageDto;
import com.kh.idolsns.dto.FundPostDto;
import com.kh.idolsns.dto.PostDto;
import com.kh.idolsns.dto.PostImageDto;
import com.kh.idolsns.dto.TagDto;
import com.kh.idolsns.repo.AttachmentRepo;
import com.kh.idolsns.repo.FundMainImageRepo;
import com.kh.idolsns.repo.FundPostImageRepo;
import com.kh.idolsns.repo.FundPostRepo;
import com.kh.idolsns.repo.FundRepo;
import com.kh.idolsns.repo.MemberRepo;
import com.kh.idolsns.repo.PostImageRepo;
import com.kh.idolsns.repo.PostRepo;
import com.kh.idolsns.repo.TagRepo;
import com.kh.idolsns.vo.SearchVO;

@Controller
@RequestMapping("/fund")
public class FundController {
   
   
   @Autowired
   private MemberRepo memberRepo;
   
   @Autowired
   private TagRepo tagRepo;
   
   @Autowired
   private PostRepo postRepo;
   
   @Autowired
   private FundRepo fundRepo; 
   
   @Autowired
   private FundPostRepo fundPostRepo;
   
   @Autowired
   private PostImageRepo postImageRepo;
   
   @Autowired
   private FundPostImageRepo fundPostListRepo;
   
   @Autowired
   private FundMainImageRepo fundMainImageRepo;
   
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
   
   
   // 펀딩게시물 등록
   @PostMapping("/write3")
   public String write3(
                     HttpSession session,
                     @ModelAttribute FundPostDto fundPostDto,
                     @ModelAttribute PostDto postDto,
                     @RequestParam MultipartFile attach,
                     @RequestParam(required=false) List<Integer> attachmentNo,
                     RedirectAttributes attr,
                      @RequestParam List<String> newFixedTagList
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
      if(!attach.isEmpty()) {
            int attachmentNo1 = attachmentRepo.sequence();   
            File target = new File(dir, String.valueOf(attachmentNo1));
            attach.transferTo(target);   
            
            attachmentRepo.insert(AttachmentDto.builder()
                  .attachmentNo(attachmentNo1)
                  .attachmentName(attach.getOriginalFilename())
                  .attachmentType(attach.getContentType())
                  .attachmentSize(attach.getSize())
                  .build()
                  );
            
            fundMainImageRepo.insert(FundMainImageDto.builder()
                  .attachmentNo(attachmentNo1)
                  .postNo(postNo)
                  .build()
                  );
         }
      if(attachmentNo != null) {
         for(int no : attachmentNo) {
            PostImageDto postImageDto = new PostImageDto();
            postImageDto.setPostNo(postNo);
            postImageDto.setAttachmentNo(no);
            postImageRepo.insert(postImageDto);
         }
      }
      System.out.println("newFixedTagList--------------------"+newFixedTagList);
      // 태그 등록
      if(newFixedTagList != null) { // 태그 선택을 했으면 실행
    	  System.out.println("이거 나오면 안됨!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    	  for(String tagName: newFixedTagList) {
    		  tagRepo.insert(TagDto.builder()
    				  .postNo(postNo)
    				  .tagNo(tagRepo.sequence())
    				  .tagName(tagName)
    				  .tagType("고정")
    				  .build());
    	  }
      }
      
            
      // 리디렉트어트리뷰트 추가
        attr.addAttribute("postNo", postNo);
      
        
//      return "redirect:detail";
        return null;
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
    
   
   // 펀딩게시물 목록조회
   @GetMapping("/list")
   public String list(
                  Model model,
                  @ModelAttribute SearchVO searchVO
                  ) {
      model.addAttribute("fundList", fundPostListRepo.selectList());
      return "fund/list";
   }
   
   // 펀딩게시물 상세조회
   @GetMapping("/detail")
   public String detail(@RequestParam Long postNo, Model model) {
      FundPostDto fundPostDto = fundPostRepo.selectOne(postNo);
      List<PostImageDto> list = postImageRepo.selectList(postNo);
      FundMainImageDto fundMainImageDto = fundMainImageRepo.selectOne(postNo);
      
      model.addAttribute("fundPostDto", fundPostDto);
      model.addAttribute("postImageList", list);
      model.addAttribute("fundMainImageDto", fundMainImageDto);
      return "fund/detail";
   }


   
   
   
   // 펀딩게시물 주문폼으로 넘기기
    @PostMapping("/detail")
    public String orderTo(
          @RequestParam Long postNo, Model model){
       FundPostDto fundPostDto = fundPostRepo.selectOne(postNo);
      List<PostImageDto> list = postImageRepo.selectList(postNo);
      
      model.addAttribute("fundPostDto", fundPostDto);
      model.addAttribute("postImageList", list);
        return "fund/order";
    }
    

 // 펀딩 주문폼 페이지
    @GetMapping("/order")
    public String order(@RequestParam Long postNo, Model model) {
        FundPostDto fundPostDto = fundPostRepo.selectOne(postNo);
        FundMainImageDto fundMainImageDto = fundMainImageRepo.selectOne(postNo);
        
        model.addAttribute("fundMainImageDto", fundMainImageDto);
        model.addAttribute("fundPostDto", fundPostDto);
//        System.out.println(fundPostDto);
        return "fund/order";
    }

    // 펀딩 주문 처리
    @PostMapping("/order")
    public String processOrder(
          HttpSession session, 
          @RequestParam Long postNo, 
          @ModelAttribute FundDto fundDto, 
          @ModelAttribute FundPostDto fundPostDto,
          RedirectAttributes attr) {
       
        String memberId = (String) session.getAttribute("memberId");
        String fundTitle = (fundPostRepo.selectOne(postNo)).getFundTitle();
        
        fundDto.setMemberId(memberId);
        fundDto.setPostNo(postNo);
        fundDto.setFundNo(fundRepo.sequence());
        fundDto.setFundTitle(fundTitle);
        
        fundRepo.insert(fundDto);
       

        // 포인트 차감
        int fundPrice = fundDto.getFundPrice();
        memberRepo.minusPoint(memberId, fundPrice);
        
        attr.addAttribute("fundNo", fundDto.getFundNo());
        
        return "redirect:clear";
    }

    // 펀딩 주문 완료 페이지
    @GetMapping("/clear")
    public String orderClear(@RequestParam Long fundNo, Model model) {
        FundDto fundDto = fundRepo.find(fundNo);
        model.addAttribute("fundDto", fundDto);
        return "fund/clear";
    }
    
}