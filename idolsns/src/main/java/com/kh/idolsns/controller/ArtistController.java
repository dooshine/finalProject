package com.kh.idolsns.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.NoHandlerFoundException;

import com.kh.idolsns.repo.ArtistRepo;

@Controller
@RequestMapping("/artist")
public class ArtistController {
    
    @Autowired
    private ArtistRepo artistRepo;

    @GetMapping("/{artistEngNameLower}")
    public String home(@PathVariable String artistEngNameLower, Model model) throws NoHandlerFoundException{

        boolean isArtistExist = artistRepo.isArtistExistByArtistEngNameLower(artistEngNameLower);
        if(!isArtistExist){
            throw new NoHandlerFoundException(null, null, null);
        }
        model.addAttribute("artistEngNameLower", artistEngNameLower);
        return "/artist/artistHome";
    }
}
