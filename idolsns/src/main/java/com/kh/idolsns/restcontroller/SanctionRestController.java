package com.kh.idolsns.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.SanctionDto;
import com.kh.idolsns.repo.SanctionRepo;
import com.kh.idolsns.vo.SanctionSearchVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/sanction")

public class SanctionRestController {

    @Autowired
    private SanctionRepo sanctionRepo;
    
    @PostMapping("/list")
    public List<SanctionDto> select(@RequestBody SanctionSearchVO sanctionSearchVO){
        return sanctionRepo.selectListComplex(sanctionSearchVO);
    }
}
