package com.kh.idolsns.service;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.kh.idolsns.dto.ChatJoinDto;
import com.kh.idolsns.dto.ChatRoomDto;
import com.kh.idolsns.dto.ChatRoomPrivDto;
import com.kh.idolsns.repo.ChatJoinRepo;
import com.kh.idolsns.repo.ChatRoomPrivRepo;
import com.kh.idolsns.repo.ChatRoomRepo;
import com.kh.idolsns.vo.ChatRoomVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ChatRoomServiceImpl implements ChatRoomService {

	@Autowired
	private ChatRoomRepo chatRoomRepo;
	@Autowired
	private ChatJoinRepo chatJoinRepo;
	@Autowired
	private ChatRoomPrivRepo chatRoomPrivRepo;
	
	// 채팅방 만들기
	@Override
	public void createChatRoom(ChatRoomVO vo) {
		
		String memberId = vo.getMemberId();
		ChatRoomDto chatRoomDto = vo.getChatRoomDto();
		List<String> memberList = vo.getMemberList();
		
		// 생성 요청을 받은 채팅방이 1대1 채팅방이면
		if(memberList.size() == 2) {
			// 1대1이면 중복방이 있는지 확인(chatRoomPriv)
			// 중복방이 있으면 생성 중지
			// 1. 나 - 상대방
			ChatRoomPrivDto chatRoomPrivDto1 = new ChatRoomPrivDto();
			chatRoomPrivDto1.setChatRoomPrivI(memberList.get(0));
			chatRoomPrivDto1.setChatRoomPrivU(memberList.get(1));
			ChatRoomPrivDto existRoom1 = chatRoomPrivRepo.findRoom(chatRoomPrivDto1);
			boolean isChatRoomExist1 = existRoom1 != null;
			// 2. 상대방 - 나
			ChatRoomPrivDto chatRoomPrivDto2 = new ChatRoomPrivDto();
			chatRoomPrivDto2.setChatRoomPrivI(memberList.get(1));
			chatRoomPrivDto2.setChatRoomPrivU(memberList.get(0));
			ChatRoomPrivDto existRoom2 = chatRoomPrivRepo.findRoom(chatRoomPrivDto2);
			boolean isChatRoomExist2 = existRoom2 != null;
			// 1, 2 둘 다 있으면 -> 둘 다 참여 중인 갠톡방이 있으므로 방 생성 중지
			if(isChatRoomExist1 && isChatRoomExist2) return;
			
			// 2만 있으면 -> 나는 나갔지만 1대1 채팅 이력이 있으면(상대방에게는 나와의 채팅방이 남아있으면)
			if(isChatRoomExist2) {
				// 참여자 테이블에 저장
				ChatJoinDto joinDto = new ChatJoinDto();
				joinDto.setChatRoomNo(existRoom2.getChatRoomNo());
				joinDto.setMemberId(memberId);
				chatJoinRepo.joinChatRoom(joinDto);
				// 1대1 채팅 테이블에 저장
				ChatRoomPrivDto privDto = new ChatRoomPrivDto();
				privDto.setChatRoomNo(existRoom2.getChatRoomNo());
				privDto.setChatRoomPrivI(memberId);
				privDto.setChatRoomPrivU(existRoom2.getChatRoomPrivI());
				chatRoomPrivRepo.createRoom(privDto);
				return;
			}
			
			// 중복방이 없으면 채팅방 생성
			// 채팅방 테이블에 저장
			int chatRoomNo = chatRoomRepo.sequence();
			chatRoomDto.setChatRoomNo(chatRoomNo);
			chatRoomDto.setChatRoomName(memberId + " 외 " + (memberList.size() - 1) + "명");
			chatRoomRepo.createRoom(chatRoomDto);
			ChatRoomDto roomDto = chatRoomRepo.findRoom(chatRoomNo);
			// 참여자 테이블에 저장
			for(String member : memberList) {
				ChatJoinDto joinDto = new ChatJoinDto();
				joinDto.setMemberId(member);
				joinDto.setChatJoinTime(roomDto.getChatRoomStart());
				joinDto.setChatRoomNo(chatRoomNo);
				chatJoinRepo.joinChatRoom(joinDto);
			}
			// 1대1 채팅 테이블에 저장
			ChatRoomPrivDto privDto1 = new ChatRoomPrivDto();
			privDto1.setChatRoomNo(chatRoomNo);
			privDto1.setChatRoomPrivI(memberList.get(0));
			privDto1.setChatRoomPrivU(memberList.get(1));
			chatRoomPrivRepo.createRoom(privDto1);
			ChatRoomPrivDto privDto2 = new ChatRoomPrivDto();
			privDto2.setChatRoomNo(chatRoomNo);
			privDto2.setChatRoomPrivI(memberList.get(1));
			privDto2.setChatRoomPrivU(memberList.get(0));
			chatRoomPrivRepo.createRoom(privDto2);
		}
		else {
			// 생성 요청 받은 채팅방이 단체 채팅방이면
			// 채팅방 테이블에 저장
			int chatRoomNo = chatRoomRepo.sequence();
			chatRoomDto.setChatRoomNo(chatRoomNo);
			chatRoomDto.setChatRoomName(memberId + " 외 " + (memberList.size() - 1) + "명");
			chatRoomRepo.createRoom(chatRoomDto);
			ChatRoomDto roomDto = chatRoomRepo.findRoom(chatRoomNo);
			// 참여자 테이블에 저장
			for(String member : memberList) {
				ChatJoinDto joinDto = new ChatJoinDto();
				joinDto.setMemberId(member);
				joinDto.setChatJoinTime(roomDto.getChatRoomStart());
				joinDto.setChatRoomNo(chatRoomNo);
				chatJoinRepo.joinChatRoom(joinDto);
			}
		}

	}

	// 채팅방 나가기, 지우기
	@Override
	public void leaveChatRoom(ChatRoomVO vo) {
		
		String memberId = vo.getMemberId();
		int chatRoomNo = vo.getChatRoomNo();
		
		// 갠톡 여부 조회
		ChatRoomPrivDto privDto = new ChatRoomPrivDto();
		privDto.setChatRoomNo(chatRoomNo);
		privDto.setChatRoomPrivI(memberId);
		boolean isPriv = chatRoomPrivRepo.checkPriv(privDto) != null;
		
		// 갠톡인 경우 chat_room_priv에서 내 데이터 삭제
		if(isPriv) {
			chatRoomPrivRepo.leaveRoom(privDto);
		}
		
		// 참여자 테이블에서 내 데이터 삭제
		ChatJoinDto joinDto = new ChatJoinDto();
		joinDto.setChatRoomNo(chatRoomNo);
		joinDto.setMemberId(memberId);
		chatJoinRepo.leaveRoom(joinDto);
		
		// 채팅방에 참여자가 남아있는지 확인
		boolean isEmpty = chatJoinRepo.findMembersByRoomNo(chatRoomNo).isEmpty();
		log.debug("isEmpty: " + isEmpty);
		
		// 채팅방에 참여자가 남아있지 않으면 chat_room에서 방 삭제
		if(isEmpty) {
			ChatRoomDto chatRoomDto = new ChatRoomDto();
			chatRoomDto.setChatRoomNo(chatRoomNo);
			chatRoomRepo.deleteRoom(chatRoomDto);
		}
	}

}
