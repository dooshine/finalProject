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
import com.kh.idolsns.vo.ChatMessageReceiveVO;
import com.kh.idolsns.vo.ChatRoomProcessVO;
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
	/*@Autowired
	private ChatService chatService;*/
	
	// 채팅방 만들기 - 채팅방 번호 반환하도록 수정했는데 확인 필요
	@Override
	public int createChatRoom(ChatRoomProcessVO vo) {
		
		String memberId = vo.getMemberId();
		ChatRoomDto chatRoomDto = vo.getChatRoomDto();
		List<String> memberList = vo.getMemberList();
		//log.debug("memberList[0] : " + memberList.get(0));
		// 생성 요청을 받은 채팅방이 1대1 채팅방이면
		if(memberList.size() == 1) {
			// 1대1이면 중복방이 있는지 확인(chatRoomPriv)
			// 중복방이 있으면 생성 중지
			// 1. 나 - 상대방
			ChatRoomPrivDto chatRoomPrivDto1 = new ChatRoomPrivDto();
			chatRoomPrivDto1.setChatRoomPrivI(memberId);
			chatRoomPrivDto1.setChatRoomPrivU(memberList.get(0));
			ChatRoomPrivDto existRoom1 = chatRoomPrivRepo.findRoom(chatRoomPrivDto1);
			boolean isChatRoomExist1 = existRoom1 != null;
			// 2. 상대방 - 나
			ChatRoomPrivDto chatRoomPrivDto2 = new ChatRoomPrivDto();
			chatRoomPrivDto2.setChatRoomPrivI(memberList.get(0));
			chatRoomPrivDto2.setChatRoomPrivU(memberId);
			ChatRoomPrivDto existRoom2 = chatRoomPrivRepo.findRoom(chatRoomPrivDto2);
			boolean isChatRoomExist2 = existRoom2 != null;
			// 1, 2 둘 다 있으면 -> 둘 다 참여 중인 갠톡방이 있으므로 방 생성 중지
			if(isChatRoomExist1 && isChatRoomExist2) return 0;
			
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
				return existRoom2.getChatRoomNo();
			}
			
			// 중복방이 없으면 채팅방 생성
			// 채팅방 테이블에 저장
			int chatRoomNo = chatRoomRepo.sequence();
			chatRoomDto.setChatRoomNo(chatRoomNo);
			chatRoomDto.setChatRoomName(memberId + " 외 " + (memberList.size()) + "명");
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
			ChatJoinDto joinDto = new ChatJoinDto();
			joinDto.setMemberId(memberId);
			joinDto.setChatJoinTime(roomDto.getChatRoomStart());
			joinDto.setChatRoomNo(chatRoomNo);
			chatJoinRepo.joinChatRoom(joinDto);
			// 1대1 채팅 테이블에 저장
			ChatRoomPrivDto privDto1 = new ChatRoomPrivDto();
			privDto1.setChatRoomNo(chatRoomNo);
			privDto1.setChatRoomPrivI(memberId);
			privDto1.setChatRoomPrivU(memberList.get(0));
			chatRoomPrivRepo.createRoom(privDto1);
			ChatRoomPrivDto privDto2 = new ChatRoomPrivDto();
			privDto2.setChatRoomNo(chatRoomNo);
			privDto2.setChatRoomPrivI(memberList.get(0));
			privDto2.setChatRoomPrivU(memberId);
			chatRoomPrivRepo.createRoom(privDto2);
			return chatRoomNo;
		}
		else {
			// 생성 요청 받은 채팅방이 단체 채팅방이면
			// 채팅방 테이블에 저장
			int chatRoomNo = chatRoomRepo.sequence();
			chatRoomDto.setChatRoomNo(chatRoomNo);
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
			ChatJoinDto joinDto = new ChatJoinDto();
			joinDto.setMemberId(memberId);
			joinDto.setChatJoinTime(roomDto.getChatRoomStart());
			joinDto.setChatRoomNo(chatRoomNo);
			chatJoinRepo.joinChatRoom(joinDto);
			return chatRoomNo;
		}
	}
	
	// 채팅방 나가기, 지우기
	@Override
	public void leaveChatRoom(ChatRoomProcessVO vo) {
		
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
	
	// (이미 있는) 채팅방에 사용자 초대
	@Override
	public void inviteMember(ChatRoomProcessVO vo) {
		int chatRoomNo = vo.getChatRoomNo();
		//log.debug("chatRoomNo: " + chatRoomNo);
		List<String> memberList = vo.getMemberList();
		// 참여자 테이블에 저장
		for(String member : memberList) {
			ChatJoinDto joinDto = new ChatJoinDto();
			joinDto.setMemberId(member);
			joinDto.setChatRoomNo(chatRoomNo);
			chatJoinRepo.joinChatRoom(joinDto);
		}
	}

}
