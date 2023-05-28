package com.kh.idolsns.service;
import java.io.IOException;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

@Service
public class WebSocketServiceImpl implements WebSocketService {

	@Override
	public void connectHandler(WebSocketSession session) {
		
	}
	@Override
	public void disconnectHandler(WebSocketSession session) {
		
	}
	@Override
	public void receiveHandler(WebSocketSession session, TextMessage message) throws IOException {
		
	}

}
