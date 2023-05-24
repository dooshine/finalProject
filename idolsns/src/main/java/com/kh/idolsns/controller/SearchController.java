package com.kh.idolsns.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/search")
public class SearchController {
    
    @GetMapping("")
    public String search(@RequestParam String q, Model model){
        model.addAttribute("query", q);
        System.out.println(q);
        return "search/search";
    }
}
