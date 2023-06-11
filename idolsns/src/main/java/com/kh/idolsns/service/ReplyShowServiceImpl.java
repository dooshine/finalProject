package com.kh.idolsns.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.kh.idolsns.vo.ReplyShowVO;

@Service
public class ReplyShowServiceImpl implements ReplyShowService{

	@Autowired
	private SqlSession sqlSession; 
	
	// 특정 글의 댓글 리스트를 불러오는 서비스
	public List<ReplyShowVO> showReplyList(Long postNo){
		List<ReplyShowVO> replyShowList = sqlSession.selectList("replyShow.list",postNo);
		String memberNick = null;
		Integer attachmentNo = null; 
		for(ReplyShowVO replyShowVO : replyShowList)
		{
			memberNick = sqlSession.selectOne("replyShow.selectReplyNick",replyShowVO.getReplyId());
			attachmentNo = sqlSession.selectOne("replyShow.selectReplyProfileImageNo",replyShowVO.getReplyId());
			// 댓글 닉네임 설정
			replyShowVO.setMemberNick(memberNick);
			
			// 댓글 프로필 이미지 설정
			replyShowVO.setAttachmentNo(attachmentNo);
			
			
		}
		
		return replyShowList;
		
	}
	
}
