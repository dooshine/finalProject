package com.kh.idolsns.vo;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import com.kh.idolsns.dto.PostDto;
import com.kh.idolsns.dto.PostImageDto;
import com.kh.idolsns.dto.PostShowDto;
import com.kh.idolsns.dto.TagDto;

import lombok.Data;

@Data 
public class PostShowVO {
    // 통합게시물 번호
    private Long postNo;
    // 통합게시물 작성자
    private String memberId;
    // 통합게시물 작성자 닉네임
    private String memberNick;
    // 통합게시물 글종류
    private String postType;
    // 통합게시물 작성시간
    private Timestamp postTime;
    // 통합게시물 내용
    private String postContent;
    // -----------------------------------    
    // 행사일정 시작날짜
	private Date scheduleStart;
	// 행사일정 종료날짜
	private Date scheduleEnd;
	// -----------------------------------
	// 같이가요 시작날짜
	private Date togetherStart;
	// 같이가요 종료날짜
	private Date togetherEnd;
	// -----------------------------------
	// 위치 정보
	private String mapPlace;
	private String mapName;
	// ----------------------------------
	// 태그 정보,게시물 이미지는 DTO List형태로 받기
	private List<String> freeTagList;
	private List<String> fixedTagList;
	
	private List<String> attachmentList;
	// ----------------------------------
	// 프로필 사진 번호 
	private Integer attachmentNo; 
	// ----------------------------------
	// 좋아요 수
	private Long likeCount;
	// ----------------------------------
	// 댓글 List형태로 받기
	private List<ReplyShowVO> replyList; 
	//-----------------------------------

	
	
	
	
	//postShow
	private PostShowDto postShowDto;
	private List<PostImageDto> attachmentNos;
	private List<PostDto> postDtos;
	private List<TagDto> tagNames;

}
