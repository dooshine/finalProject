package com.kh.idolsns.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.kh.idolsns.repo.ChatRoomRepo;

@Controller
@RequestMapping("/chat")
public class ChatTestController {
	
	@Autowired
	private ChatRoomRepo chatRoomRepo;

	@GetMapping("/")
	public String main(Model model) {
		model.addAttribute("chatRoomList", chatRoomRepo.listRoom());
		return "chat/main";
	}
	
	@GetMapping("/chatRoomNo")
	public String chatRooms() {
		return "chat/chatRoomNo";
	}
	
}
