package com.kh.idolsns.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.TagDto;
import com.kh.idolsns.dto.TogetherPostDto;
import com.kh.idolsns.dto.FreePostDto;
import com.kh.idolsns.dto.PostDto;
import com.kh.idolsns.dto.PostImageDto;
import com.kh.idolsns.dto.SchedulePostDto;
import com.kh.idolsns.repo.TagRepo;
import com.kh.idolsns.repo.TogetherPostRepo;
import com.kh.idolsns.repo.FreePostRepo;
import com.kh.idolsns.repo.PostImageRepo;
import com.kh.idolsns.repo.PostRepo;
import com.kh.idolsns.repo.PostWithNickRepo;
import com.kh.idolsns.repo.SchedulePostRepo;
import com.kh.idolsns.repo.SchedulePostRepoImpl;

@CrossOrigin
@RestController
@RequestMapping("/rest/post")
public class PostRestController {
    
    @Autowired
    private PostRepo postRepo;

    @Autowired
    private PostWithNickRepo postWithNickRepo;

    @Autowired
    private TagRepo tagRepo;
    
    // 자유 게시물
    @Autowired
    private FreePostRepo freePostRepo;
    
    // 행사일정 게시물
    @Autowired
    private SchedulePostRepo schedulePostRepo;
    
    @Autowired
    private TogetherPostRepo togetherPostRepo;    
    
    // 통합게시물 등록
    @PostMapping("/")
    public Long insert(PostDto postDto, HttpSession session){
        // 통합 게시물 시퀀스 발행	
		 Long postNo = postRepo.sequence();
		 
		 System.out.println("postNo는 : "+postNo);
		 // # 통합 게시물 생성 
		 // 1. 통합게시물 번호 설정
		 postDto.setPostNo(postNo); // 세션에 있는거 확인할 때는 이거
		 // postDto.setMemberId((String)session.getAttribute("memberId"));
		 // 2. 통합게시물 작성자 설정 
		 postDto.setMemberId(postDto.getMemberId());
		 // 3. 통합게시물 글 종류 설정(fix!!)
		 postDto.setPostType(postDto.getPostType()); // postDto.setPostTime(new
		 //Date(System.currentTimeMillis())); // 현재 시간으로 설정 
		 // 4. 통합게시물 글 내용 설정
		 postDto.setPostContent(postDto.getPostContent());
		 
		 // 5. 통합게시물 등록 
		 postRepo.insert(postDto);
			 
        
		 // 등록된 게시글 번호를 바탕으로 다른 비동기 통신(ajax, axios)에서 태그, 
		 // 사진 정보를 해당 테이블의 정규화 테이블 추가할 떄 사용한다.
		 return postDto.getPostNo();
    }
    
    // -------------------- 태그정보 등록 
    @PostMapping("/tag")
    public void taging(@RequestParam Long postNo, @RequestBody List<String> tagList) {
  
    	Long tempNo; // controller측 임시 시퀀스 번호 
    	TagDto tempDto = new TagDto();

    	for(String tag : tagList) {
			tempNo = tagRepo.sequence();
			tempDto.setTagNo(tempNo);
			tempDto.setPostNo(postNo);
			tempDto.setTagType("자유"); // 자유, 고정 둘 중 하나
			tempDto.setTagName(tag);
			tagRepo.insert(tempDto);    		
    	}
    }	

    
    @PostMapping("/postType")
    public void postType(@RequestParam Long postNo,@RequestBody PostDto postDto){
    	String postType = postDto.getPostType();
    	System.out.println("ajax로 수신받은 값들은 다음과 같아요 postNo : "+postNo+" postType: "+postType);
    	if(postType.equals("자유"))
    	{
    		TogetherPostDto togetherPostDto = new TogetherPostDto();
        	togetherPostDto.setPostNo(postDto.getPostNo()); 
        	togetherPostDto.setMemberId(postDto.getMemberId());
        	togetherPostDto.setTogetherStart(null);
        	togetherPostDto.setTogetherEnd(null);
        	togetherPostRepo.insert(togetherPostDto);
    	}
    	else if (postType.equals("행사일정"))
    	{
        	SchedulePostDto schedulePostDto = new SchedulePostDto();
        	schedulePostDto.setPostNo(postDto.getPostNo()); 
        	schedulePostDto.setMemberId(postDto.getMemberId()); 
        	schedulePostDto.setScheduleStart(null);
        	schedulePostDto.setScheduleEnd(null); 
        	schedulePostRepo.insert(schedulePostDto); 
    	}
    	else if (postType.equals("같이가요"))
    	{
        	FreePostDto freePostDto = new FreePostDto();
        	freePostDto.setPostNo(postDto.getPostNo());
        	freePostDto.setMemberId(postDto.getMemberId());
        	freePostRepo.insert(freePostDto);
    	}
    }
    
//    @PostMapping("/together")
//    public void together(PostDto postDto)
//    {
//    	System.out.println("게시물 타입은 :  " + postDto.getPostType());
//    	System.out.println("게시물 번호는 :  " + postDto.getPostNo());
//    	TogetherPostDto togetherPostDto = new TogetherPostDto();
//    	togetherPostDto.setPostNo(postDto.getPostNo()); 
//    	togetherPostDto.setMemberId(postDto.getMemberId());
//    	togetherPostDto.setTogetherStart(null);
//    	togetherPostDto.setTogetherEnd(null);
//    	togetherPostRepo.insert(togetherPostDto);
//    }
//    
//    @PostMapping("/schedule")
//    public void schedule(PostDto postDto)
//    {
//    	System.out.println("게시물 타입은 :  " + postDto.getPostType());
//    	System.out.println("게시물 번호는 :  " + postDto.getPostNo());
//    	SchedulePostDto schedulePostDto = new SchedulePostDto();
//    	schedulePostDto.setPostNo(postDto.getPostNo()); 
//    	schedulePostDto.setMemberId(postDto.getMemberId()); 
//    	schedulePostDto.setScheduleStart(null);
//    	schedulePostDto.setScheduleEnd(null); 
//    	schedulePostRepo.insert(schedulePostDto); 
//    }
//    @PostMapping("/free")
//    public void free(PostDto postDto)
//    {
//    	System.out.println("게시물 타입은 :  " + postDto.getPostType());
//    	System.out.println("게시물 번호는 :  " + postDto.getPostNo());
//    	FreePostDto freePostDto = new FreePostDto();
//    	freePostDto.setPostNo(postDto.getPostNo());
//    	freePostDto.setMemberId(postDto.getMemberId());
//    	freePostRepo.insert(freePostDto);
//    }
    
    

//    // 통합게시물 목록조회, 해당 DTO로 전달
//    @GetMapping("/")
//    public List<PostWithNickDto> selectList(@ModelAttribute SearchVO searchVO){
//        return postWithNickRepo.selectList(searchVO);
//    }
//    // 통합게시물 상세조회
//    @GetMapping("/{postNo}")
//    public PostWithNickDto selectOne(@PathVariable Long postNo){
//        return postWithNickRepo.selectOne(postNo);
//    }

    // 통합게시물 수정
    @PutMapping("/")
    public boolean update(@ModelAttribute PostDto postDto){
        return postRepo.update(postDto);
    }

    // 통합게시물 삭제
    @DeleteMapping("/{postNo}")
    public boolean delete(@RequestParam Long postNo){
        return postRepo.delete(postNo);
    }

}