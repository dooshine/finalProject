package com.kh.idolsns.restcontroller;

import java.util.HashSet;
import java.util.Set;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@Controller
@RequestMapping("/sse")
public class PostNotiController {
	
	private static final Set<SseEmitter> emitters = new HashSet<>();
	
	@GetMapping("/register")
	public SseEmitter registerClient() {
		SseEmitter emitter = new SseEmitter();
		emitters.add(emitter);
		emitter.onCompletion(() -> emitters.remove(emitter));
		return emitter;
	}
	
//	@GetMapping("/sendNofi")
//	public String sendNoti() {
//		for(SseEmiiter)
//	}
	
}
