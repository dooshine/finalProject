package com.kh.idolsns.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
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
@RequestMapping("/rest/post")
public class PostReplyRestController {
	
	@Autowired
	private ReplyRepo replyRepo; 
	
	// 통합게시글 페이지 reply 목록 조회
	@GetMapping("/reply/{postNo}")
	public List<ReplyDto> getReplies(@PathVariable Long postNo) {
		return replyRepo.getRepliesByPostNo(postNo);
	}
	
	// 댓글 등록 
	@PostMapping("/reply")
	public void write(@RequestBody ReplyDto replyDto,
						HttpSession session) {
		
		String memberId = (String)session.getAttribute("memberId");
	    Long sequence = replyRepo.sequence();
	    ReplyDto dto = new ReplyDto();
	    dto.setReplyNo(sequence); 
	    dto.setPostNo(replyDto.getPostNo()); 
	    dto.setReplyId(memberId);
	    dto.setReplyContent(replyDto.getReplyContent());
	    dto.setReplyGroupNo(sequence); 
	   
	    System.out.println("dto is : "+ dto);
	    replyRepo.addReply(dto);
	}
	
	// 대댓글 등록 
	@PostMapping("/rereply")
	public void reWrite(@RequestBody ReplyDto replyDto,
						HttpSession session){
		
		String memberId = (String) session.getAttribute("memberId"); 
		Long sequence = replyRepo.sequence();
		ReplyDto dto = new ReplyDto();		
		dto.setReplyNo(sequence);
		dto.setPostNo(replyDto.getPostNo());
		dto.setReplyId(memberId); 
		dto.setReplyContent(replyDto.getReplyContent());
		dto.setReplyGroupNo(replyDto.getReplyGroupNo());
		
		System.out.println("dto is : "+ dto);
		replyRepo.addReply(dto); 
	}
	
	// 댓글 삭제
	@DeleteMapping("/reply/delete/{replyNo}")
	public void delete(@PathVariable Long replyNo)
	{
		// 그룹이 replyNo인 댓글 모두 삭제, 원 댓글 밑 그 밑의 대댓글 전부 삭제
		replyRepo.deleteReplies(replyNo);
	}
	
	// 대댓글 삭제
	@DeleteMapping("/reply/reDelete/{replyNo}")
	public void reDelete(@PathVariable Long replyNo)
	{
		// 댓글번호가 replyNo인 대댓글만을 삭제
		replyRepo.deleteRereply(replyNo);
	}

}
