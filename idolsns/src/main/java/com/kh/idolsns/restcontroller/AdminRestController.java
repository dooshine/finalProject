package com.kh.idolsns.restcontroller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.idolsns.configuration.CustomFileuploadProperties;
import com.kh.idolsns.dto.ArtistDto;
import com.kh.idolsns.dto.ArtistProfileDto;
import com.kh.idolsns.dto.ArtistViewDto;
import com.kh.idolsns.dto.AttachmentDto;
import com.kh.idolsns.dto.MemberProfileFollowDto;
import com.kh.idolsns.dto.TagCntDto;
import com.kh.idolsns.dto.TagDto;
import com.kh.idolsns.repo.AttachmentRepo;
import com.kh.idolsns.service.AdminService;
import com.kh.idolsns.vo.AdminMemberSearchVO;
import com.kh.idolsns.vo.TagCntSearchVO;

// 관리자 Rest Controller
@CrossOrigin
@RestController
@RequestMapping("/rest/admin/")
public class AdminRestController {

    @Autowired
    private AdminService adminService;

    @Autowired
    private AttachmentRepo attachmentRepo;
    

    @Autowired
	private CustomFileuploadProperties fileUploadProperties;

    @Autowired
    private SqlSession sqlSession;

    private File dir;

    @PostConstruct
	public void init() {
		dir = new File(fileUploadProperties.getPath());
		dir.mkdirs();
	}


    // SELECT 태그 리스트 목록
    @GetMapping("/tag")
    public List<TagDto> tagList(){
        return adminService.adminTagSelectList();
    }
    // SELECT 태그 사용량 목록
    @GetMapping("/tagName")
    public List<TagCntDto> tagCntList(@ModelAttribute TagCntSearchVO tagCntSearchVO){
        return adminService.adminTagCntSelectList(tagCntSearchVO);
    }
    // UPDATE 태그 타입 수정
    @PutMapping("/tagName")
    public void updateTag(@RequestBody Map<String, Object> data){
        String tagType = (String)data.get("tagType");
        List<String> tagNameList = (ArrayList<String>)data.get("tagNameList");

        adminService.updateTagTypeByName(tagType, tagNameList);
    }
    // DELETE 태그 삭제(이름으로)
    @DeleteMapping("/tagName")
    public void deleteTag(@RequestBody List<String> tagNameList){
        //System.out.println(tagNameList);
        // adminService.deleteTagByName(tagNameList);
    }


	// 멤버 목록 불러오기
    @PostMapping("/member")
    public List<MemberProfileFollowDto> selectMemberList(@RequestBody AdminMemberSearchVO adminMemberSearchVO){
        return adminService.adminSelectMemberList(adminMemberSearchVO);
        // System.out.println(adminMemberSearchVO.toString());
        // return null;
    }




    // CREATE 대표페이지 생성
    @PostMapping("/artist")
    public void createArtist(@RequestBody ArtistDto artistDto){
        sqlSession.insert("admin.insertArtist", artistDto);
    }
    // READ 대표페이지 목록 조회
    @GetMapping("/artistView")
    public List<ArtistViewDto> selectArtistList(){
        return sqlSession.selectList("admin.selectArtistView");
    }

    // CREATE & UPDATE 대표페이지 프로필사진 설정
    @PostMapping("/artistProfile")
    public void setArtistProfile(@RequestParam("attachment") MultipartFile attachment, @RequestParam("artistNo") Integer artistNo) throws IllegalStateException, IOException{

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
            if(sqlSession.selectOne("artist.selectOneArtistProfile", artistNo)==null){
                sqlSession.insert("artist.insertArtistProfile", ArtistProfileDto.builder().artistNo(artistNo).attachmentNo(attachmentNo).build());
            } else {
                sqlSession.update("artist.updateArtistProfile", ArtistProfileDto.builder().artistNo(artistNo).attachmentNo(attachmentNo).build());
            }
            
        }

    }
}

