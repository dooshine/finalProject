package com.kh.idolsns.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/search")
public class SearchController {
    
    @GetMapping("/post")
    public String searchPost(@RequestParam String q, Model model){
        model.addAttribute("query", q);
        return "search/searchPost";
    }

    @GetMapping("/artist")
    public String searchArtist(@RequestParam String q, Model model){
        model.addAttribute("query", q);
        return "search/searchArtist";
    }

    @GetMapping("/member")
    public String searchMember(@RequestParam String q, Model model){
        model.addAttribute("query", q);
        return "search/searchMember";
    }
}
