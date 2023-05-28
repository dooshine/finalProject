package com.kh.idolsns.restcontroller;

import java.util.List;

//github.com/dooshine/finalProject.git
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.ReplyDto;
import com.kh.idolsns.repo.ReplyRepo;

@CrossOrigin
@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {

	@Autowired
	private ReplyRepo replyRepo;
	
	// 펀딩페이지 reply 조회 
	@GetMapping("/fund/{postNo}")
	public List<ReplyDto> getReplies(@PathVariable Long postNo) {
//		System.out.println(postNo);
		return replyRepo.getRepliesByPostNo(postNo);
	}
	
	// 펀딩페이지 reply 작성 
	@PostMapping("/fund")
	public void write(@RequestBody ReplyDto replyDto) {
//		System.out.println(replyDto);
//	     reply sequence 발행
	    Long sequence = replyRepo.sequence();
	    
	    // 댓글 번호 설정
	    replyDto.setReplyNo(sequence);
	    // 댓글 그룹 설정	    
	    if(replyDto.getReplyGroupNo() == null) {
	    	replyDto.setReplyGroupNo(sequence);
	    }
	    replyRepo.addReply(replyDto);
	}
}

