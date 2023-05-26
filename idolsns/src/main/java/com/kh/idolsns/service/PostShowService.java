package com.kh.idolsns.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.idolsns.repo.PostImageRepo;
import com.kh.idolsns.repo.PostLikeRepo;
import com.kh.idolsns.repo.PostShowRepo;
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
	
	public void postShowOne(Long postNo) 
	{
		PostShowVO postShowVO = postShowRepo.selectOne(postNo);
		postShowVO.setTagList(tagRepo.selectAll(postNo));
		postShowVO.setAttachmentList(postImageRepo.selectAttachNoList(postNo));
		log.debug("postShowVO is {}",postShowVO);
	}
	
	public List<PostShowVO> postShowAll()
	{
		List<PostShowVO> postShowList = postShowRepo.selectAll();
		Long postNo = 0l; 
		
		for(PostShowVO postShowVO : postShowList)
		{	
			// 글번호 
			postNo = postShowVO.getPostNo();
			
			// 태그 리스트
			postShowVO.setTagList(tagRepo.selectAll(postNo));
			
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
		}
		return postShowList;
	}
	
}
