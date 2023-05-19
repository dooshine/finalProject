package com.kh.idolsns.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/artist")
public class ArtistController {
    
    @GetMapping("/{artistName}")
    public String home(@PathVariable String artistName){
        System.out.println("artistName: " + artistName);
        return "/artist/home";
    }
}
