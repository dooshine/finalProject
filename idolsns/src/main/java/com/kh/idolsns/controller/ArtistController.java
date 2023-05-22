package com.kh.idolsns.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/artist")
public class ArtistController {
    
    @GetMapping("/{artistName}")
    public String home(@PathVariable String artistName, Model model){
        model.addAttribute("artistName", artistName);
        return "/artist/artistHome";
    }
}
