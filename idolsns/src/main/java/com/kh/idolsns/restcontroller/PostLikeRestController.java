package com.kh.idolsns.restcontroller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.PostLikeDto;
import com.kh.idolsns.repo.PostLikeRepo;


@CrossOrigin
@RestController
@RequestMapping("/rest/post/")
public class PostLikeRestController {

	@Autowired
	private PostLikeRepo postLikeRepo;
	
	@GetMapping("/like/{postNo}")
	public String like(HttpSession session, // 좋아요 아이디 체크 
					@PathVariable Long postNo) { // 좋아요 확인
		String memberId = (String)session.getAttribute("memberId");
		PostLikeDto postLikeDto = new PostLikeDto(); 
		postLikeDto.setMemberId(memberId);
		postLikeDto.setPostNo(postNo); 
		
//		System.out.println("아이디 : " +memberId);
//		System.out.println("게시물번호 : " +postNo);
//		System.out.println("체크결과 "+ postLikeRepo.check(postLikeDto));
		// 좋아요가 되어 있으면
		if(memberId != null) {
			if(postLikeRepo.check(postLikeDto)){
				postLikeRepo.delete(postLikeDto);
				return "disLike";
			}
			else{ //안되어 있으면 
				postLikeRepo.insert(postLikeDto);
				return "Like";
			}		
		}
		return null;
	}
	
	@GetMapping("/like/update/{postNo}")
	public Long update(@PathVariable Long postNo) { // 좋아요 확인
		return postLikeRepo.count(postNo);
	}

	
}
