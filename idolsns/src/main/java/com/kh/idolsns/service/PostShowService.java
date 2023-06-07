package com.kh.idolsns.service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.idolsns.repo.PostImageRepo;
import com.kh.idolsns.repo.PostLikeRepo;
import com.kh.idolsns.repo.PostShowRepo;
import com.kh.idolsns.repo.ReplyRepo;
import com.kh.idolsns.repo.TagRepo;
import com.kh.idolsns.vo.PostShowVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PostShowService {

	@Autowired
	private PostShowRepo postShowRepo; 
	
	@Autowired
	private TagRepo tagRepo;
	
	@Autowired
	private PostImageRepo postImageRepo;
	
	@Autowired
	private PostLikeRepo postLikeRepo;
	
	@Autowired
	private ReplyRepo replyRepo;
	
	public void postShowOne(Long postNo) 
	{
		PostShowVO postShowVO = postShowRepo.selectOne(postNo);
		postShowVO.setFreeTagList(tagRepo.selectAll(postNo));
		postShowVO.setAttachmentList(postImageRepo.selectAttachNoList(postNo));
		log.debug("postShowVO is {}",postShowVO);
	}
	
	// 모든 게시물 한번에 전달
	public List<PostShowVO> postShowAll()
	{
		List<PostShowVO> postShowList = postShowRepo.selectAll();
		Long postNo = 0l; 
		
		for(PostShowVO postShowVO : postShowList)
		{	
			
			// 글번호 
			postNo = postShowVO.getPostNo();
			
			// 고정 태그 리스트
			postShowVO.setFixedTagList(tagRepo.selectFixedTagAll(postNo));
			
			// 자유 태그 리스트
			postShowVO.setFreeTagList(tagRepo.selectFreeTagAll(postNo));
			
			// 첨부파일 
			if(postImageRepo.selectAttachNoList(postNo).size()>0) {
				postShowVO.setAttachmentList(postImageRepo.selectAttachNoList(postNo));
			}
			else {
				postShowVO.setAttachmentList(null);
			}
			// 좋아요 
			postShowVO.setLikeCount(postLikeRepo.count(postNo));
			//  log.debug("postImageRepo.selectAttachNoList(postNo) is {}", postImageRepo.selectAttachNoList(postNo));
			//	log.debug("postShowVO is {}", postShowVO); 
			
			// 댓글 가져오기 
			postShowVO.setReplyList(replyRepo.getRepliesByPostNo(postNo));
		
		}
		return postShowList;
	}
	
	// 모든 게시물 한번에 전달 페이징을 구현
	public List<PostShowVO> postShowByPaging(int page){
		List<PostShowVO> postShowList = postShowRepo.selectListByPaging(page);
		Long postNo = 0l;
		
		for(PostShowVO postShowVO : postShowList)
		{
			// 글번호 
			postNo = postShowVO.getPostNo();
			
			// 고정 태그 리스트
			postShowVO.setFixedTagList(tagRepo.selectFixedTagAll(postNo));
			
			// 자유 태그 리스트
			postShowVO.setFreeTagList(tagRepo.selectFreeTagAll(postNo));
			
			// 첨부파일 
			if(postImageRepo.selectAttachNoList(postNo).size()>0) {
				postShowVO.setAttachmentList(postImageRepo.selectAttachNoList(postNo));
			}
			else {
				postShowVO.setAttachmentList(null);
			}
			// 좋아요 
			postShowVO.setLikeCount(postLikeRepo.count(postNo));
			//  log.debug("postImageRepo.selectAttachNoList(postNo) is {}", postImageRepo.selectAttachNoList(postNo));
			//	log.debug("postShowVO is {}", postShowVO); 
			
			// 댓글 가져오기 
			postShowVO.setReplyList(replyRepo.getRepliesByPostNo(postNo));
			
		}
		
		return postShowList;
	}
	
	////  페이징으로 구현 맨처음 부터 지금까지 지금쓰는 것!!
	public List<PostShowVO> postShowByPagingReload(int page){
		List<PostShowVO> postShowList = postShowRepo.selectListByPagingReload(page);
		Long postNo = 0l;
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		for(PostShowVO postShowVO : postShowList)
		{
			// 글번호 
			postNo = postShowVO.getPostNo();
//			Timestamp ts = postShowVO.getPostTime();
			
			// 시간 재설정
//			String formattedTime = dateFormat.format(postShowVO.getPostTime());
//			Date parsedTime = dateFormat.parse(formattedTime)
//			postShowVO.setPostTime();
//			postShowVO.setPostTime((postShowVO.getPostTime()));
			System.out.println((postShowVO.getPostTime()));
			
			// 고정 태그 리스트
			postShowVO.setFixedTagList(tagRepo.selectFixedTagAll(postNo));
			
			// 자유 태그 리스트
			postShowVO.setFreeTagList(tagRepo.selectFreeTagAll(postNo));
						
			// 첨부파일 
			if(postImageRepo.selectAttachNoList(postNo).size()>0) {
				postShowVO.setAttachmentList(postImageRepo.selectAttachNoList(postNo));
			}
			else {
				postShowVO.setAttachmentList(null);
			}
			// 좋아요 
			postShowVO.setLikeCount(postLikeRepo.count(postNo));
			//  log.debug("postImageRepo.selectAttachNoList(postNo) is {}", postImageRepo.selectAttachNoList(postNo));
			//	log.debug("postShowVO is {}", postShowVO); 
			
			// 댓글 가져오기 
			postShowVO.setReplyList(replyRepo.getRepliesByPostNo(postNo));
//			System.out.println("게시글 번호가 "+postNo+"번인 게시글의 답글 리스트는 다음과 같습니다. replyList는 "+replyRepo.getRepliesByPostNo(postNo));
		}
		
		return postShowList;
	}
	
	// 특정 맴버가 좋아요한 글 맨 처음 페이지 부터 지금 페이지까지 
	public List<PostShowVO> likedPostShowByPagingReload(int page,String memberId){
		List<PostShowVO> postShowList = postShowRepo.selectLikedPostListByPagingReload(page, memberId);
		Long postNo = 0l;
		
		for(PostShowVO postShowVO : postShowList)
		{
			// 글번호 
			postNo = postShowVO.getPostNo();
			
			// 고정 태그 리스트
			postShowVO.setFixedTagList(tagRepo.selectFixedTagAll(postNo));
			
			// 자유 태그 리스트
			postShowVO.setFreeTagList(tagRepo.selectFreeTagAll(postNo));
						
			// 첨부파일 
			if(postImageRepo.selectAttachNoList(postNo).size()>0) {
				postShowVO.setAttachmentList(postImageRepo.selectAttachNoList(postNo));
			}
			else {
				postShowVO.setAttachmentList(null);
			}
			// 좋아요 
			postShowVO.setLikeCount(postLikeRepo.count(postNo));
			
			// 댓글 가져오기 
			postShowVO.setReplyList(replyRepo.getRepliesByPostNo(postNo));
		}
		
		return postShowList;
	}
	
	// 특정 맴버가 쓴글 글 맨 처음 페이지 부터 지금 페이지까지
	public List<PostShowVO> writedPostShowByPagingReload(int page, String memberId){
		
		List<PostShowVO> postShowList = postShowRepo.selectWritedPostListByPagingReload(page, memberId);
		
		Long postNo = 0l;
		
		for(PostShowVO postShowVO : postShowList)
		{
			// 글번호 
			postNo = postShowVO.getPostNo();
			
			// 고정 태그 리스트
			postShowVO.setFixedTagList(tagRepo.selectFixedTagAll(postNo));
			
			// 자유 태그 리스트
			postShowVO.setFreeTagList(tagRepo.selectFreeTagAll(postNo));
						
			// 첨부파일 
			if(postImageRepo.selectAttachNoList(postNo).size()>0) {
				postShowVO.setAttachmentList(postImageRepo.selectAttachNoList(postNo));
			}
			else {
				postShowVO.setAttachmentList(null);
			}
			// 좋아요 
			postShowVO.setLikeCount(postLikeRepo.count(postNo));
			
			// 댓글 가져오기 
			postShowVO.setReplyList(replyRepo.getRepliesByPostNo(postNo));
		}
		
		return postShowList;
	}
	
	// 고정 태그 글 맨 처음 페이지 부터 지금 페이지까지
	public List<PostShowVO> fixedTagPostShowByPagingReload(int page,String tagName){
		
		List<PostShowVO> postShowList = postShowRepo.selectFixedTagPostListByPagingReload(page, tagName);

		Long postNo = 0l;
		
		for(PostShowVO postShowVO : postShowList)
		{
			// 글번호 
			postNo = postShowVO.getPostNo();
			
			// 고정 태그 리스트
			postShowVO.setFixedTagList(tagRepo.selectFixedTagAll(postNo));
			
			// 자유 태그 리스트
			postShowVO.setFreeTagList(tagRepo.selectFreeTagAll(postNo));
						
			// 첨부파일 
			if(postImageRepo.selectAttachNoList(postNo).size()>0) {
				postShowVO.setAttachmentList(postImageRepo.selectAttachNoList(postNo));
			}
			else {
				postShowVO.setAttachmentList(null);
			}
			// 좋아요 
			postShowVO.setLikeCount(postLikeRepo.count(postNo));
			
			// 댓글 가져오기 
			postShowVO.setReplyList(replyRepo.getRepliesByPostNo(postNo));
		}
		
		return postShowList;
	}
}
