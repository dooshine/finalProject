package com.kh.idolsns.restcontroller;


import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.idolsns.configuration.CustomFileuploadProperties;
import com.kh.idolsns.dto.AttachmentDto;
import com.kh.idolsns.dto.MemberDto;
import com.kh.idolsns.dto.MemberProfileImageDto;
import com.kh.idolsns.dto.MemberSimpleProfileDto;
import com.kh.idolsns.repo.AttachmentRepo;
import com.kh.idolsns.repo.MemberRepo;
import com.kh.idolsns.repo.MemberSimpleProfileRepo;

@CrossOrigin
@RestController
@RequestMapping("/rest/member")
public class MemberRestController {

	@Autowired 
	private MemberRepo memberRepo;
	@Autowired
	private MemberSimpleProfileRepo memberSimpleProfileRepo;
	@Autowired
	private AttachmentRepo attachmentRepo;
	@Autowired
	private SqlSession sqlSession;
	@Autowired
	private CustomFileuploadProperties fileUploadProperties;
	
	 private File dir;

	    @PostConstruct
		public void init() {
			dir = new File(fileUploadProperties.getPath());
			dir.mkdirs();
		}
	
	 @GetMapping("/{memberId}")
	 public MemberDto getMember(@PathVariable String memberId) {
        // memberId를 사용하여 멤버 정보를 조회하고 MemberDto로 반환하는 로직을 작성해주세요
        // 예시로 임시로 생성한 MemberDto를 반환합니다.
      
		 MemberDto memberDto = memberRepo.selectOne(memberId);
	     memberDto.setMemberPoint(memberDto.getMemberPoint()); 
	        
        return memberDto;
	 }

	
	@GetMapping("/memberId/{memberId}")
	public String memberId(@PathVariable String memberId) {
		return memberRepo.selectOne(memberId) == null ? "Y":"N";
	}
	
	@GetMapping("memberNick/{memberNick}")
	public String memberNick(@PathVariable String memberNick) {
		return memberRepo.joinNick(memberNick) == null? "Y":"N";
	}
	
	@GetMapping("memberEmail/{memberEmail}")
	public String memberEmail(@PathVariable String memberEmail) {
		return memberRepo.joinEmail(memberEmail) == null? "Y":"N";
	}



	// 회원 아이디 목록 받아서 회원프로필정보 반환
	@GetMapping("/getMemberProfile")
	public List<MemberSimpleProfileDto> getMemberProfile(@RequestParam List<String> memberIdList){
		return memberSimpleProfileRepo.profile(memberIdList);
	}
	
	// 회원 아이디 받아서 회원 프로필정보 반환
	@GetMapping("/getMemberProfileById/{memberId}")
	public MemberSimpleProfileDto selectMemberProfileById(@PathVariable String memberId) {
		return memberSimpleProfileRepo.selectProfileById(memberId);
	}
	
    // CREATE & UPDATE 프로필사진 설정
    @PostMapping("/memberProfile")
    public void memberProfile(@RequestParam("attachment") MultipartFile attachment,
    		@RequestParam("memberId") String memberId) throws IllegalStateException, IOException{

        if(!attachment.isEmpty()) {//파일이 있을 경우

            // # 1. attachment 저장
            //번호 생성
            int attachmentNo = attachmentRepo.sequence();
            
            //파일 저장(저장 위치는 임시로 생성)
            File target = new File(dir, String.valueOf(attachmentNo));//파일명=시퀀스
            attachment.transferTo(target);
            
            //DB 저장
            attachmentRepo.insert(AttachmentDto.builder()
                            .attachmentNo(attachmentNo)
                            .attachmentName(attachment.getOriginalFilename())
                            .attachmentType(attachment.getContentType())
                            .attachmentSize(attachment.getSize())
                        .build());


            // # 2. pageProfile 저장
            // 조회 후 insert | update
            if(sqlSession.selectOne("member.selectOneProfile", memberId)==null){
                sqlSession.insert("member.insertProfile", MemberProfileImageDto.builder().memberId(memberId).attachmentNo(attachmentNo).build());
            } else {
                sqlSession.update("member.updateProfile", MemberProfileImageDto.builder().memberId(memberId).attachmentNo(attachmentNo).build());
            }
            
        }

    }

}
