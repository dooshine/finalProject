package com.kh.idolsns.vo;
import java.io.IOException;
import java.util.Map;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import lombok.Data;
import lombok.EqualsAndHashCode;

//한 명의 웹소켓 사용자 정보를 가지는 클래스
@Data
@EqualsAndHashCode(of = {"session"})
public class ChatMemberVO {

	private WebSocketSession session;
	private String memberId, memberLevel;
	
	public boolean isMember() {
		return this.memberId != null && this.memberLevel != null;
	}
	
	public void sendMessage(TextMessage jsonMessage) throws IOException {
		session.sendMessage(jsonMessage);
	}
	
	public ChatMemberVO(WebSocketSession session) {
		this.session = session;
		Map<String, Object> attr = session.getAttributes();
		this.memberId = (String)attr.get("memberId");
		this.memberLevel = (String)attr.get("memberLevel");
	}
	
}
