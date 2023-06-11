package com.kh.idolsns.restcontroller;


import java.sql.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
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

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.idolsns.dto.FreePostDto;
import com.kh.idolsns.dto.FundDto;
import com.kh.idolsns.dto.MapDto;
import com.kh.idolsns.dto.PostDto;
import com.kh.idolsns.dto.PostImageDto;
import com.kh.idolsns.dto.PostShowDto;
import com.kh.idolsns.dto.SchedulePostDto;
import com.kh.idolsns.dto.TagDto;
import com.kh.idolsns.dto.TogetherPostDto;
import com.kh.idolsns.repo.AttachmentRepo;
import com.kh.idolsns.repo.FreePostRepo;
import com.kh.idolsns.repo.MapRepo;
import com.kh.idolsns.repo.PostImageRepo;
import com.kh.idolsns.repo.PostLikeRepo;
import com.kh.idolsns.repo.PostRepo;
import com.kh.idolsns.repo.PostShowRepo;
import com.kh.idolsns.repo.PostWithNickRepo;
import com.kh.idolsns.repo.ReplyRepo;
import com.kh.idolsns.repo.SchedulePostRepo;
import com.kh.idolsns.repo.TagRepo;
import com.kh.idolsns.repo.TogetherPostRepo;
import com.kh.idolsns.service.PostShowService;
import com.kh.idolsns.vo.PostShowVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/post")
public class PostRestController {
    
	// 고정 태그는 repo가 없어서 sqlsession으로 대체 
	@Autowired
	private SqlSession sqlSession;
	
	// 게시글 
    @Autowired
    private PostRepo postRepo;

    @Autowired
    private PostWithNickRepo postWithNickRepo;

    // 태그
    @Autowired
    private TagRepo tagRepo;
    
    //지도 정보
    @Autowired
    private MapRepo mapRepo;
    
    // 답글
    @Autowired
    private ReplyRepo replyRepo;
    
    // 게시물 좋아요
    @Autowired
    private PostLikeRepo postLikeRepo;
    
    // 게시글 이미지
    @Autowired
    private PostImageRepo postImageRepo;
    
    @Autowired
    private PostShowRepo postShowRepo; 
    
    
    // 게시글 게시 service
    @Autowired
    private PostShowService postShowService;
    
    // 이미지
    @Autowired
    private AttachmentRepo attachmentRepo;
    
    // 자유 게시물
    @Autowired
    private FreePostRepo freePostRepo;
    
    // 행사일정 게시물
    @Autowired
    private SchedulePostRepo schedulePostRepo;
    
    // 같기아요
    @Autowired
    private TogetherPostRepo togetherPostRepo;    
    
    
    
    //아티스트페이지 상세조회
    @GetMapping("/{tagName}")
    public List<PostShowDto> selectList(@PathVariable String tagName){
   	      return postShowRepo.selectList(tagName);
  }

    
    
    
    
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
    // -------------------- 고정태그정보 등록
    @PostMapping("/fixed")
    public void fixedTaging(@RequestBody Map<String,Object> fixedTagData) {
    	List<String> fixedTagList = (List<String>) fixedTagData.get("fixedTag");
    	Integer postNoI = (Integer) fixedTagData.get("postNo");
    	Long postNo = (Long) postNoI.longValue();
    	
    	Long tempNo;
    	TagDto tempDto = new TagDto();
    	
    	for(String fixedTag: fixedTagList)
    	{
    		tempNo = tagRepo.sequence();
    		tempDto.setTagNo(tempNo);
    		tempDto.setPostNo(postNo);
    		tempDto.setTagType("고정");
    		tempDto.setTagName(fixedTag);
    		tagRepo.insert(tempDto);
    	}
    	
    }
    
    
    // -------------------- 태그정보 등록 
    @PostMapping("/tag")
    public void taging(@RequestBody Map<String,Object> tagData) {
    	List<String> tagList = (List<String>) tagData.get("tag");
    	Integer postNoI = (Integer) tagData.get("postNo"); 
    	Long postNo = (Long) postNoI.longValue();
    	
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
    //--------------------- 태그정보 불러오기
    @GetMapping("/tag/{postNo}")
    public List<String> getTag(@PathVariable("postNo") Long postNo){
    	System.out.println("postNo는 : "+postNo);
    	return tagRepo.selectAll(postNo);
    }
    
    // ---------------------- 지도정보 등록
    @PostMapping("/map")
    public void maping(MapDto mapDto) {
    	if(mapDto!=null) {
    		System.out.println(mapDto+"는 mapDto입니다.");
    		mapRepo.insert(mapDto);
    	}
    	
    }
    
    
    // 애연 추가 -- 성지순례
    @GetMapping("/map/{postNo}")
    public List<String> getMapList(@PathVariable Long postNo) {
    	return mapRepo.selectAll(postNo);
    	
    }
    
    
 	
    
    
    
    
    // -------------------- 태그정보 등록 
//    @PostMapping("/tag")
//    public void taging(@RequestParam Long postNo, @RequestBody List<String> tagList) {
//  
//    	Long tempNo; // controller측 임시 시퀀스 번호 
//    	TagDto tempDto = new TagDto();
//    	
//    	for(String tag : tagList) {
//			tempNo = tagRepo.sequence();
//			tempDto.setTagNo(tempNo);
//			tempDto.setPostNo(postNo);
//			tempDto.setTagType("자유"); // 자유, 고정 둘 중 하나
//			tempDto.setTagName(tag);
//			tagRepo.insert(tempDto);    		
//    	}
//    }	

    // --------------------- 게시글 타입 정보 등록 
    @PostMapping("/postType")
    public void postType(@RequestBody Map<String,Object> postTypeData){
    	Integer postNoI = (Integer) postTypeData.get("postNo"); 
    	Long postNo = (Long) postNoI.longValue();
    	
    	ObjectMapper objectMapper = new ObjectMapper();
    	
    	PostDto postDto = objectMapper.convertValue(postTypeData.get("postDto"),PostDto.class); 
    	
    	
    	String postType = postDto.getPostType();
    	if(postType.equals("자유"))
    	{
    		FreePostDto freePostDto = new FreePostDto();
        	freePostDto.setPostNo(postNo);
        	freePostDto.setMemberId(postDto.getMemberId());        	
        	freePostRepo.insert(freePostDto);
    		
    	}
    	else if (postType.equals("행사일정"))
    	{
    		Date scheduleStart = objectMapper.convertValue(postTypeData.get("scheduleStart"),Date.class);
    		Date scheduleEnd = objectMapper.convertValue(postTypeData.get("scheduleEnd"),Date.class);
    		
        	SchedulePostDto schedulePostDto = new SchedulePostDto();
        	schedulePostDto.setPostNo(postNo); 
        	schedulePostDto.setMemberId(postDto.getMemberId());
        	schedulePostDto.setScheduleStart(scheduleStart);
        	schedulePostDto.setScheduleEnd(scheduleEnd);
        	schedulePostRepo.insert(schedulePostDto); 
    	}
    	else if (postType.equals("같이가요"))
    	{
    		Date togetherStart = objectMapper.convertValue(postTypeData.get("togetherStart"),Date.class);
    		Date togetherEnd = objectMapper.convertValue(postTypeData.get("togetherEnd"),Date.class);
    		
    		TogetherPostDto togetherPostDto = new TogetherPostDto();
        	togetherPostDto.setPostNo(postNo); 
        	togetherPostDto.setMemberId(postDto.getMemberId());
        	togetherPostDto.setTogetherStart(togetherStart);
        	togetherPostDto.setTogetherEnd(togetherEnd);
        	togetherPostRepo.insert(togetherPostDto);
    	}
    }
        

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
//    @GetMapping()
//    public String sessionMemberAttachmentNo{
//    	
//    	return null;
//    }
    @GetMapping("/sessionAttachmentNo")
    public Integer sessionMemberAttachmentNo(HttpSession session) {
    	String memberId = (String) session.getAttribute("memberId");
    	return postShowRepo.selectSessionMemberAttachmentNo(memberId);    	
    }
    // 게시물 전체 목록 조회 
    @GetMapping("/all")
    public List<PostShowVO> allList(){
    	List<PostShowVO> posts = postShowService.postShowAll();
    	return posts;
    }
    
    // 게시물 페이징 목록 조회
    @GetMapping("/page/{page}")
    public List<PostShowVO> infiniteList(@PathVariable int page){    	
    	List<PostShowVO> posts = postShowService.postShowByPaging(page);    	
    	return posts;
    }
    
    // 게시물 페이징 목록 처음 부터 현재 페이지까지 조회 <-- 지금 쓰는거 
    @GetMapping("/pageReload/{page}")
    public List<PostShowVO> infiniteListReload(@PathVariable int page){
    	List<PostShowVO> posts = postShowService.postShowByPagingReload(page);
    	return posts;
    }
    
    // 특정맴버가 좋아요한 게시물
    @PostMapping("/pageReload/memberLikePost")
    public List<PostShowVO> likedPostListReload(@RequestBody Map<String,Object> likedPostData)
    {	
    	Integer page = (Integer) likedPostData.get("page"); 
    	String likedMemberId = (String) likedPostData.get("likedMemberId");
    	List<PostShowVO> posts = postShowService.likedPostShowByPagingReload(page, likedMemberId);
    	return posts; 
    }
    
    // 특정맴버가 작성한 게시물
    @PostMapping("/pageReload/memberWritePost")
    public List<PostShowVO> writePostListReload(@RequestBody Map<String,Object> writePostData){
    	Integer page = (Integer) writePostData.get("page"); 
    	String writeMemberId = (String) writePostData.get("writeMemberId");
    	List<PostShowVO> posts = postShowService.writedPostShowByPagingReload(page, writeMemberId);
    	return posts;
    }
    
    // 특정 고정태그 게시물
    @PostMapping("/pageReload/fixedTagPost")
    public List<PostShowVO> fixedTagPostListReload(@RequestBody Map<String,Object> fixedTagPostData){
    	Integer page = (Integer) fixedTagPostData.get("page"); 
    	String tagName = (String) fixedTagPostData.get("fixedTagName");
    	List<PostShowVO> posts = postShowService.fixedTagPostShowByPagingReload(page, tagName);
    	System.out.println(posts);
    	return posts;
    }
    
    // 통합게시물 수정
    @PutMapping("/")
    public boolean update(@RequestBody PostDto postDto){
        return postRepo.update(postDto);
    }

    // 통합게시물 삭제
    @DeleteMapping("/{postNo}")
    public boolean delete(@PathVariable Long postNo){
    	// 지도 설정 삭제,
    	mapRepo.delete(postNo); 

    	// 댓글 모두 삭제,
    	replyRepo.deleteByPostNo(postNo);
    	
    	// 태그 모두 삭제, 
    	tagRepo.deleteByPostNo(postNo);
    	
    	// 첨부파일 모두 삭제
    	Integer tempAttachmentNo;
    	List<PostImageDto> postImageList = postImageRepo.selectList(postNo);
    	for(PostImageDto postImage : postImageList) {
    		
    		// 첨부파일 게시글 연결 테이블 삭제 
    		tempAttachmentNo = postImage.getAttachmentNo();
    		postImageRepo.delete(tempAttachmentNo);
    		
    		// 첨부파일 삭제
    		attachmentRepo.delete(tempAttachmentNo);
    	}
    	
    	// 게시물 좋아요 모두 삭제
    	postLikeRepo.deleteByPostNo(postNo);
    	// 타입 게시물 삭제
    	String postType = postRepo.selectOne(postNo).getPostType(); 
    	if(postType.equals("자유"))
    	{
    		freePostRepo.delete(postNo);
    	}
    	else if (postType.equals("행사일정"))
    	{
    		schedulePostRepo.delete(postNo);
    	}
    	else if (postType.equals("같이가요"))
    	{
    		togetherPostRepo.delete(postNo);
    	}
    	
    	// 게시글 삭제, 
    	return postRepo.delete(postNo);
        
    }
    
    

}