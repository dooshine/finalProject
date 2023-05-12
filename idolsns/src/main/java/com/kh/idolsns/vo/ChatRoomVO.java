package com.kh.idolsns.vo;
import java.io.IOException;
import java.util.List;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;
import org.springframework.web.socket.TextMessage;
import lombok.Data;

@Data
public class ChatRoomVO {

	/** 사용자 저장소 **/
	private Set<ChatMemberVO> members = new CopyOnWriteArraySet<>();
	private List<String> memberList;
	
	/** 입장 **/
	public void enter(ChatMemberVO member) {
		members.add(member);
	}
	
	/** 퇴장 **/
	public void leave(ChatMemberVO member) {
		members.remove(member);
	}
	
	/** 채팅방 참여 인원 수 **/
	public int size() {
		return members.size();
	}
	
	/** 사용자 유무 확인 **/
	public boolean memberExist(ChatMemberVO member) {
		return members.contains(member);
	}
	
	/** 브로드캐스트 **/
	public void broadcast(TextMessage jsonMessage) throws IOException {
		for(ChatMemberVO member : members) {
			member.sendMessage(jsonMessage);
		}
	}
	
}
