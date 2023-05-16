package com.kh.idolsns.service;
import java.io.IOException;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

public interface ChatService {

	void connectHandler(WebSocketSession session);
	void disconnectHandler(WebSocketSession session);
	void receiveHandler(WebSocketSession session, TextMessage message) throws IOException;
	
}
