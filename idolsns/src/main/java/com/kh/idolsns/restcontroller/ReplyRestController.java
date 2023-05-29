package com.kh.idolsns.restcontroller;

import java.util.List;

//github.com/dooshine/finalProject.git
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
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
	
	// 펀딩페이지 댓글 조회 
	@GetMapping("/fund/{postNo}")
	public List<ReplyDto> getReplies(@PathVariable Long postNo) {
		return replyRepo.getRepliesByPostNo(postNo);
	}
	
	// 펀딩페이지 댓글 작성 
	@PostMapping("/fund")
	public void addReply(@RequestBody ReplyDto replyDto) {
//	     reply sequence 발행
	    Long sequence = replyRepo.sequence();
	    
	    // 댓글 번호 설정
	    replyDto.setReplyNo(sequence);
	    // 댓글 그룹 설정	    
	    if(replyDto.getReplyGroupNo() == null) { // 새로 작성하는 댓글이면
	    	replyDto.setReplyGroupNo(sequence); // groupNo를 replyNo로 설정
	    }
	    replyRepo.addReply(replyDto);
	}
	
	// 펀딩페이지 댓글 삭제
	@DeleteMapping("/fund/{replyNo}")
	public void deleteReply(@PathVariable Long replyNo) {
		ReplyDto dto = replyRepo.selectOne(replyNo); // 삭제하려는 댓글
		Long replyGroupNo = dto.getReplyGroupNo();
		if(replyNo.equals(replyGroupNo)) { // 최상위 댓글이면
			// 그 밑에있는(groupNo가 같은) 대댓들 다 같이 삭제
			replyRepo.deleteReplies(dto.getReplyGroupNo());
		}
		else { // 대댓글이면 
			replyRepo.deleteRereply(replyNo); // 대댓글만 삭제
		}
	}
	
	// 펀딩페이지 댓글 수정
	@PutMapping("/fund/")
	public void updateReply(@RequestBody ReplyDto replyDto) {
		replyRepo.updateReply(replyDto.getReplyNo(), replyDto.getReplyContent());
	}
	
}

