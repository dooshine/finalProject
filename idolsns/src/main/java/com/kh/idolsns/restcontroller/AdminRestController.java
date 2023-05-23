package com.kh.idolsns.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.TagCntDto;
import com.kh.idolsns.dto.TagDto;
import com.kh.idolsns.service.AdminService;

// 관리자 Rest Controller
@RestController
@RequestMapping("/rest/admin/")
public class AdminRestController {

    @Autowired
    private AdminService adminService;

    // 태그 리스트 목록
    @GetMapping("/tag")
    public List<TagDto> tagList(){
        return adminService.adminTagSelectList();
    }
    // 태그 사용량 목록
    @GetMapping("/tagCnt")
    public List<TagCntDto> tagCntList(){
        return adminService.adminTagCntSelectList();
    }
    // 태그 삭제
    @DeleteMapping("/tag")
    public void deleteTag(@RequestBody List<Long> tagNoList){
        adminService.deleteTag(tagNoList);
    }
}
