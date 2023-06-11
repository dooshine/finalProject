package com.kh.idolsns.restcontroller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.FundDto;
import com.kh.idolsns.dto.FundListWithTagDto;
import com.kh.idolsns.dto.FundPostImageDto;
import com.kh.idolsns.dto.PostImageDto;
import com.kh.idolsns.dto.PostLikeDto;
import com.kh.idolsns.dto.TagDto;
import com.kh.idolsns.repo.FundPostImageRepo;
import com.kh.idolsns.repo.FundPostRepo;
import com.kh.idolsns.repo.FundRepo;
import com.kh.idolsns.repo.PostLikeRepo;
import com.kh.idolsns.vo.FundDetailVO;
import com.kh.idolsns.vo.FundSearchVO;
import com.kh.idolsns.vo.FundVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/fund")
public class FundRestController {

	@Autowired
	private FundRepo fundRepo;
	
	@Autowired
	private FundPostRepo fundPostRepo;
	
	@Autowired
	private FundPostImageRepo fundPostImageRepo;
	
	@Autowired
	private PostLikeRepo postLikeRepo;
	
	// 펀딩게시물 목록 조회
	@GetMapping("/")
	public List<FundPostImageDto> fundPostList(){
		return fundPostImageRepo.selectList();
	}
	
	// 무한스크롤을 위한 백엔드 페이징 목록 구현
	// - 페이지번호를 알려준다면 10개를 기준으로 해당 페이지 번호의 데이터를 반환
	@GetMapping("/page/{page}")
	public List<FundListWithTagDto> paging(@PathVariable int page,
		@ModelAttribute FundSearchVO vo) {
		List<FundListWithTagDto> list = fundPostImageRepo.selectListWithTag(page, vo);
		
		System.out.println("----------------------vo----------------------"+vo);
		System.out.println("----------------------list----------------------"+list);
		return list;
		}
		
	
	// 펀딩상세 
	@GetMapping("/{postNo}")
	public FundPostImageDto detail(@PathVariable Long postNo) {
		FundDetailVO vo = fundPostImageRepo.selectOne(postNo);
		FundPostImageDto fundPostImageDto = vo.getFundPostImageDto();
//		System.out.println(fundPostImageDto);
		return fundPostImageDto;
	}
	
	// 상세이미지 attachmentNos 
	@GetMapping("/attaches/{postNo}")
	public List<Integer> list(@PathVariable Long postNo) {
		List<PostImageDto> list = fundPostImageRepo.selectAttachList(postNo);
		List<Integer> attachList = new ArrayList<>();
		
		for(PostImageDto dto : list) {
			attachList.add(dto.getAttachmentNo());
		}
		
		return attachList;
	}
	
	
	// 후원한 total금액 & 후원자 
	@GetMapping("/fundlist/{postNo}")
	public FundVO fundList(@PathVariable Long postNo){
		
		// total 금액
		List<FundDto> fundList = fundPostImageRepo.selectFundList(postNo);
		int fundTotal = 0;
		for(FundDto dto : fundList) {
			fundTotal += dto.getFundPrice();
		}
		
		// 후원자 수
		int sponsorCount = fundRepo.count(postNo);
		
		FundVO vo = new FundVO();
		vo.setFundTotal(fundTotal);
		vo.setFundSponsorCount(sponsorCount);
		
	    return vo;
	}
	
	
	@GetMapping("/order/{fundNo}")
	public FundDto getFund(@PathVariable long fundNo) {
		FundDto fundDto = fundRepo.find(fundNo);
		return fundDto;
	}
	
	// 펀딩 상세페이지 태그 조회
	@GetMapping("/tag/{postNo}")
	public List<String> getTagList(@PathVariable Long postNo) {
		List<String> list = new ArrayList<>();
		for(TagDto dto : fundPostImageRepo.selectTagList(postNo)) {
			list.add(dto.getTagName());
		}
		return list;
	}
	
	
	// 펀딩 종료일이 지난 펀딩들 확인 & 펀딩 상태 업데이트
	@PostMapping("/update")
	public void updateFundState() {
		// 목록 조회
		List<FundPostImageDto> list = fundPostImageRepo.selectList();
		List<FundPostImageDto> templist = new ArrayList<>();
		LocalDate currentDate = LocalDate.now();
		for(FundPostImageDto dto : list) {
			LocalDate postEnd = dto.getPostEnd().toLocalDate();
			if(currentDate.isAfter(postEnd)) { // 현재날짜가 마감날짜를 지났으면
				templist.add(dto);
			}
		}
	}

	
	// 펀딩 좋아요 수
	@GetMapping("/likeCount/{postNo}")
	public int count(@PathVariable Long postNo){
		System.out.println("likecount--------"+fundRepo.likeCount(postNo));
		return fundRepo.likeCount(postNo);
	}
	
	// 펀딩 목록 좋아요 체크
	@GetMapping("/like/index/{postNoList}")
	public List<Integer> index(@PathVariable List<Long> postNoList,
							HttpSession session){
		List<Integer> response = new ArrayList<Integer>();
		
		PostLikeDto temp = new PostLikeDto();
		String memberId = (String)session.getAttribute("memberId");		
		temp.setMemberId(memberId); 
		
		if(memberId == "" || memberId == null) { // 세션 아이디 없을 때, 
			return null; 
		}
		
		
		for(int i=0; i<postNoList.size();i++){
			temp.setPostNo(postNoList.get(i));
			// 좋아요 돼있으면
			if(postLikeRepo.check(temp)){
				response.add(i); // 반환할 좋아요 배열에 해당 인덱스 추가 
			}		
		}
		
		return response; 
	}
}

	

