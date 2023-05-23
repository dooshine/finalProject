package com.kh.idolsns.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.idolsns.repo.PostImageRepo;
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
	
	public void postShow(Long postNo) 
	{
		PostShowVO postShowVO = postShowRepo.selectOne(postNo);
		postShowVO.setTagList(tagRepo.selectAll(postNo));
		postShowVO.setAttachmentList(postImageRepo.selectAttachNoList(postNo));
		log.debug("postShowVO is {}",postShowVO);
	}
	
	
}
