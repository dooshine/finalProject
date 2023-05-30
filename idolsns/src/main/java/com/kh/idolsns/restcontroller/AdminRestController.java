package com.kh.idolsns.restcontroller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.ArtistDto;
import com.kh.idolsns.dto.ArtistViewDto;
import com.kh.idolsns.dto.MemberDto;
import com.kh.idolsns.dto.TagCntDto;
import com.kh.idolsns.dto.TagDto;
import com.kh.idolsns.service.AdminService;
import com.kh.idolsns.vo.AdminMemberSearchVO;
import com.kh.idolsns.vo.TagCntSearchVO;

// 관리자 Rest Controller
@RestController
@RequestMapping("/rest/admin/")
public class AdminRestController {

    @Autowired
    private AdminService adminService;

    @Autowired
    private SqlSession sqlSession;

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
        System.out.println(tagNameList);
        // adminService.deleteTagByName(tagNameList);
    }


	// 멤버 목록 불러오기
    @PostMapping("/member")
    public List<MemberDto> selectMemberList(@RequestBody AdminMemberSearchVO adminMemberSearchVO){
        return adminService.adminSelectMemberList(adminMemberSearchVO);
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
}

