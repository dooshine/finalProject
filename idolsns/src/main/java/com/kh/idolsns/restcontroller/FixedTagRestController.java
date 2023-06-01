package com.kh.idolsns.restcontroller;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.FixedTagDto;
import com.kh.idolsns.service.FixedTagService;

@CrossOrigin
@RestController
@RequestMapping("/rest/fixedTag")
public class FixedTagRestController {
    
    @Autowired
    private SqlSession sqlSession;

    @Autowired
    private FixedTagService fixedTagService;

    // CREATE 고정태그 생성
    @PostMapping("/")
    public void createFixedTag(@RequestBody FixedTagDto fixedTagDto){
        sqlSession.insert("fixedTag.insertFixedTag", fixedTagDto);
    }

    // READ 고정태그 목록 조회
    @GetMapping("/")
    public List<FixedTagDto> selectFixedTagList(){
        return sqlSession.selectList("fixedTag.selectFixedTagList");
    }

    // READ 고정태그 사용량 목록 조회
    @GetMapping("/{fixedTagName}")
    public List<String> selectFixedTagCntList(@PathVariable String fixedTagName){
        // List<String> list = sqlSession.selectList("fixedTag.selectFixedTagCntList", fixedTagName);
        // System.out.println(list.toString());
        return sqlSession.selectList("fixedTag.selectFixedTagCntList", fixedTagName);
    }

    // DELETE 고정태그 삭제
    @DeleteMapping("/")
    public void deleteFixedTag(@RequestBody List<Integer> deleteFixedTagNoList){
        for(Integer fixedTagNo : deleteFixedTagNoList){
            sqlSession.delete("fixedTag.deleteFixedTagByNo", fixedTagNo);
        }
    }

    // READ 고정태그 여부 확인
    @GetMapping("/check")
    public boolean isFixedTag(@RequestParam String fixedTagName){
        return fixedTagService.isFixedTag(fixedTagName);
    }
}
