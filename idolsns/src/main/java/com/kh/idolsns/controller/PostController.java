package com.kh.idolsns.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.idolsns.dto.PostDto;
import com.kh.idolsns.dto.PostWithNickDto;
import com.kh.idolsns.repo.PostRepo;
import com.kh.idolsns.repo.PostWithNickRepo;
import com.kh.idolsns.vo.SearchVO;

// 통합게시물 컨트롤러
@Controller
@RequestMapping("/post")
public class PostController {

    @Autowired
    private PostRepo postRepo;

    @Autowired
    private PostWithNickRepo postWithNickRepo;

    // 통합게시물 기본페이지
    @GetMapping("/")
    public String base(){
        return "/post/base";
    }

    // 통합게시물 등록페이지
    @GetMapping("/insert")
    public String insert(){
        return "/post/insert";
    }
    // 통합게시물 등록
    @PostMapping("/insert")
    public String insert(HttpSession session, Model model, @ModelAttribute PostDto postDto, RedirectAttributes attr){

        // 1. 통합게시물 시퀀스 발행
        Long postNo = postRepo.sequence();
        postDto.setPostNo(postNo);

        // 2. 통합게시물 작성자
        String memberId = (String)session.getAttribute("memberId");
        postDto.setMemberId(memberId);

        // 3. 통합게시물 게시물종류 설정(Fix!!)
        postDto.setPostType("자유");

        // 4. 통합게시물 등록
        postRepo.insert(postDto);

        // 5. 개별테이블 추가(Fix!!)

        // 리디렉트어트리뷰트 추가
        attr.addAttribute("postNo", postNo);

        return "redirect:detail/";
    }

    // 통합게시물 목록조회
    @GetMapping("/selectList")
    public String selectList(Model model, @ModelAttribute SearchVO searchVO){
        List<PostWithNickDto> list = postWithNickRepo.selectList(searchVO);
        model.addAttribute("list", list);
        return "/post/list";
    }

    // 통합게시물 상세조회
    @GetMapping("/detail")
    public String base(@RequestParam Long postNo, Model model){
        PostWithNickDto postWithNickDto = postWithNickRepo.selectOne(postNo);
        model.addAttribute("postWithNickDto", postWithNickDto);
        return "/post/detail";
    }

    // 통합게시물 수정
    @GetMapping("/update")
    public String update(@RequestParam Long postNo, Model model){
        
        PostWithNickDto postWithNickDto = postWithNickRepo.selectOne(postNo);
        model.addAttribute("postWithNickDto", postWithNickDto);
        return "/post/update";
    }

    // 통합게시물 수정
    @PostMapping("/update")
    public String updateProcess(@ModelAttribute PostDto postDto, RedirectAttributes attr){
        postRepo.update(postDto);

        attr.addAttribute("postNo", postDto.getPostNo());
        return "redirect:/post/detail";
    }
    // 통합게시물 삭제
    @GetMapping("/delete")
    public String delete(@RequestParam Long postNo){
        postRepo.delete(postNo);
        return "redirect:selectList";
    }

    // 통합게시물 비동기
    @GetMapping("/rest")
    public String rest(){
        return "/post/rest";
    }
    
    // 특정맴버가 좋아요한 게시물
    @GetMapping("/likedpost/{likedMemberId}")
    public String likedpost(@PathVariable String likedMemberId,
    						Model model) {
    	model.addAttribute("likedMemberId",likedMemberId);
    	return "/post/memberLikePost";
    }
    
    // 특정맴버가 작성한 게시물
    @GetMapping("/writepost/{writeMemberId}")
    public String writepost(@PathVariable String writeMemberId,
    						Model model){
    	model.addAttribute("writeMemberId",writeMemberId);
    	return "/post/memberWritePost";
    }
    
    // 특정 고정태그 게시물
    @GetMapping("/fixedtagpost/{fixedTagName}")
    public String fixedTagPost(@PathVariable String fixedTagName,
    							Model model){
    	model.addAttribute("fixedTagName", fixedTagName);
    	return "/post/fixedTagPost";
    }
    								
    @GetMapping("/linkPost/{postNo}")
    public String linkPost(@PathVariable Long postNo, Model model)
    {	
    	model.addAttribute("postNo",postNo);
    	return "/post/linkPost";
    }
}
