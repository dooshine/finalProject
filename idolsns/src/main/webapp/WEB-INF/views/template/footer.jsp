<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

            </div>

	<style>
		
	</style>
	<!-- 일반페이지 일때 -->
	<c:if test="${!admin}">
		<div class="col-3 py-4 calendar-area px-0">
			<!-- 캘린더 영역 -->
		 	<jsp:include page="/WEB-INF/views/template/calendar.jsp"></jsp:include>
		</div>
	</c:if>
	





        
        </section>
		<%-- <div class="custom-hr"></div> --%>
        <footer>
            <%-- <h1>푸터</h1>
            <h2>세션 memberId: ${sessionScope.memberId}</h2>
            <h2>세션 memberLevel: ${sessionScope.memberLevel}</h2> --%>
        </footer>
    </main>
 
	

	

	<!-- 부트스트랩 js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>



<!-- 채팅방 -->
 
 	<script>
		Vue.createApp({
			data() {
				return {
					socket: null,
					memberId: "${sessionScope.memberId}",
					chatMainModal: false,
					createRoomModal: false,
					chatRoomModal: false,
					chatMenuModal: false,
					inviteMemberModal: false,
					memberListModal: false,
					leaveRoomAlert: false,
					deleteMsgAlert: false,
					fileSizeAlert: false,
					
					// main에서 가져옴
					chatRoom: {
						chatRoomNo: "",
						chatRoomName1: "",
						chatRoomName2: "",
						chatRoomStart: "",
						chatRoomType: ""
					},
					chatRoomList: [],
					followList: [],
					followProfileList: [],
					selectedMemberList: [],
					selectedMemberIdList: [],
					selectedMemberNickList: [],
					chatRoomIdList: [],
					chatRoomProfileList: [],
					
					// chatRoomNo에서 가져옴
					text: "",
					chatRoomNo: "",
					roomInfo: {
						chatRoomNo: "",
						chatRoomName1: "",
						chatRoomName2: "",
						chatRoomStart: "",
						chatRoomType: "",
						edit: false
					},
					roomInfoCopy: {
						chatRoomName1:"",
					},
					chatMemberList: [],
					messageList: [],
					//chatJoin: "",
					// 입력창 초기화
					clear() {
						this.text = ""
					},
					modalImgURL: "",
					
					// 활성화 여부 저장
					isVisible: true,
					isFocused: true,
					
					joinRoomList: [],
					
					// 메세지 삭제 버튼 관련
					showDeleteButtonIndex: -1,
					
					// 새 메세지 알림 여부
					newChatNoti: false,
					chatRoomNoList: [],


				};
			},
			methods: {
				// 로그인 안한 경우 로그인으로 이동
				login() {
					window.location.href = contextPath + "/member/login";
				},
				connect() {
					if(this.memberId === "") return;
					const url = contextPath + "/ws/server";
					this.socket = new SockJS(url);
					// this: 뷰 객체
					const app = this;
					this.socket.onopen = function() {
						app.openHandler();
					};
					this.socket.onclose = function() {
						app.closeHandler();
					};
					this.socket.onerror = function() {
						app.closeHandler();
					};
					this.socket.onmessage = function(e) {
						app.messageHandler(e);
					};
				},
				async openHandler() {
					this.loadRoomList();
					this.loadChatNoti();
				},
				closeHandler() {
				},
				errorHandler() {
				},
				messageHandler(e) {
					const parsedData = JSON.parse(e.data);
					//console.log(parsedData);
					// 방 생성 메세지인 경우 chatRoomNo 변수에 저장
					if(parsedData.type == 11) {
						//console.log("newRoomNo: " + parsedData.chatRoomDto.chatRoomNo);
						//this.chatRoomNo = parsedData.chatRoomDto.chatRoomNo;
						//console.log("newRoomNo: " + parsedData.chatRoomNo);
						this.chatRoomNo = parsedData.chatRoomNo;
						this.showNewChatRoomModal();
					}
					// 타입이 3인(삭제인) 메세지는 리스트에 추가하지 않음
					if(parsedData.type == 3) {
						this.messageList.splice(0);
						this.loadMessage(); return;
					}
					if(parsedData.chatMessageType == 5 && parsedData.chatRoomType == 'P') {
						this.messageList.splice(0);
						this.loadMessage(); return;
					}
					// 이름 변경인 경우 방 정보 reload
					if(parsedData.type == 8) {
						this.roomInfo.chatRoomNo = "";
						this.roomInfo.chatRoomName1 = "";
						this.roomInfo.chatRoomName2 = "";
						this.roomInfo.chatRoomStart = "";
						this.roomInfo.chatRoomType = "";
						this.roomInfoCopy.chatRoomName1 = "";
						this.loadRoomInfo();
						this.chatRoomList.splice(0);
						this.loadRoomList(); return;
					}
					// 현재 방에 해당하는 메세지만 불러오기
					if(parsedData.chatRoomNo === this.chatRoomNo) {						
						this.messageList.push(parsedData);
					}
					// 사용자가 페이지를 보고있는 경우 메세지 읽음 처리
					if(this.isVisible && this.isFocused && parsedData.memberId != this.memberId &&
							this.chatRoomNo == parsedData.chatRoomNo && this.chatRoomModal === true) {
						this.readMessage();
					}
					this.loadRoomList();
					this.loadChatNoti();
					if((parsedData.chatMessageType === 1) || parsedData.chatMessageType === 4 || 
						parsedData.chatMessageType === 5 || parsedData.chatMessageType === 6) {						
						this.scrollBottom();
					}
					if(parsedData.chatMessageType === 5 || parsedData.chatMessageType === 13) {
						this.chatMemberList.splice(0);
						this.loadChatMember();
					}
				},
				// 참여중인 방 정보 가져오기
				loadJoinRooms() {
					this.joinRoomList = [];
					for(let i=0; i<this.chatRoomList.length; i++) {
						this.joinRoomList[i] = this.chatRoomList[i];
					}
				},
				// 새 채팅 알림 있는지 확인
				async loadChatNoti() {
					//console.log("memberId: " + this.memberId);
					if(this.memberId.length > 0 && this.chatRoomList.length > 0) {
						const url = contextPath + "/chat/message/noti/" + this.memberId;
						const resp = await axios.get(url);
						//console.log(resp.data);
						if(resp.data === true) this.newChatNoti = true;
						else this.newChatNoti = false;
					}
				},
				// 방별로 새 알림 있는지 확인
				async loadChatRoomNoti() {
					if(this.chatRoomList.length > 0) {
						this.chatRoomNoList = [];
						//console.log("chatRoomNo: " + this.chatRoomList[0].chatRoomNo);
						for(let i=0; i<this.chatRoomList.length; i++) {
							this.chatRoomNoList[i] = this.chatRoomList[i].chatRoomNo;
						}
						//console.log("chatRoomNoList: " + this.chatRoomNoList);
						const url = contextPath + "/chat/message/noti";
						const data = {
								chatRoomNoList: this.chatRoomNoList,
								memberId: this.memberId
						};
						const resp = await axios.post(url, data);
						const numbers = resp.data.map(obj=>obj.chatRoomNo);
						//console.log(numbers);
						const filterArray = this.chatRoomList.filter(
							room=>numbers.some(number=>number == room.chatRoomNo)
						);
						//console.log(filterArray);
						if(filterArray.length > 0) {
							filterArray.forEach(room=>{room.newChat=true});
						}
						this.loadChatNoti();
					}
				},
				// 메세지 읽음
				async readMessage() {
					const url = contextPath + "/chat/message";
					const data = {
							chatReceiver: this.memberId,
							chatRoomNo: this.chatRoomNo
					};
					const resp = await axios.put(url, data);
				},
				// 채팅 메인 모달 열기
				showChatMainModal() {
					this.followList.splice(0);
					this.loadRoomList();
					this.loadFollowList();
					this.loadJoinRooms();
					this.chatMainModal = true;
				},
				// 채팅 메인 모달 닫기
				hideChatMainModal() {
					if(this.chatRoomModal = true) this.hideChatRoomModal();
					this.chatMainModal = false;
				},
				// 채팅방 만들기 모달 열기
				showCreateRoomModal() {
					this.hideChatMainModal();
					this.createRoomModal = true;
				},
				// 채팅방 만들기 모달 닫기
				hideCreateRoomModal() {
					this.chatRoom.chatRoomName1 = "";
					this.selectedMemberList.splice(0);
					this.createRoomModal = false;
					this.showChatMainModal();
				},
				// 채팅방 모달 열기
				showChatRoomModal(index) {
					if(this.chatRoomNo == this.chatRoomList[index].chatRoomNo) return;
					if(this.chatRoomModal == true) this.hideChatRoomModal();
					if(this.roomInfo.edit == true) this.cancelChange();
					const chatRoomNo = this.chatRoomList[index].chatRoomNo;
					const data = {
							type: 2,
							chatRoomNo: chatRoomNo
					};
					this.socket.send(JSON.stringify(data));
					/*this.roomInfo.chatRoomNo = "";
					this.roomInfo.chatRoomName1 = "";
					this.roomInfo.chatRoomName2 = "";
					this.roomInfo.chatRoomStart = "";
					this.roomInfo.chatRoomType = "";
					this.roomInfoCopy.chatRoomName1 = "";
					this.chatMemberList.splice(0);
					this.messageList.splice(0);
					this.chatJoin = "";*/
					this.chatRoomNo = chatRoomNo;
					this.loadRoomInfo();
					this.loadChatMember();
					//this.getChatJoin();
					// 메세지 읽기
					this.readMessage();
					this.loadRoomList();
					this.chatRoomModal = true;
					this.loadMessage();
					this.$nextTick(() => {
					    this.text = "";
					    this.$refs.messageInput.focus();
					});
					this.memberListModal = false;
					this.inviteMemberModal = false;
					this.fileSizeAlert = false;
				},
				// 채팅방 모달 닫기
				hideChatRoomModal() {
					this.chatRoomNo = "";
					this.roomInfo.chatRoomNo = "";
					this.roomInfo.chatRoomName1 = "";
					this.roomInfo.chatRoomName2 = "";
					this.roomInfo.chatRoomStart = "";
					this.roomInfo.chatRoomType = "";
					this.roomInfoCopy.chatRoomName1 = "";
					this.chatMemberList.splice(0);
					this.messageList.splice(0);
					//this.chatJoin = "";
					this.memberListModal = false;
					this.chatMenuModal = false;
					this.chatRoomModal = false;
					this.hideLeaveRoomAlert();
					this.hideDeleteMsgAlert();
					this.fileSizeAlert = false;
				},
				// 새 채팅방 모달 열기
				showNewChatRoomModal() {
					const chatRoomNo = this.chatRoomNo;
					//console.log("showNewChatRoomModal: " + chatRoomNo);
					const data = {
							type: 2,
							chatRoomNo: chatRoomNo
					};
					this.socket.send(JSON.stringify(data));
					this.roomInfo.chatRoomNo = "";
					this.roomInfo.chatRoomName1 = "";
					this.roomInfo.chatRoomName2 = "";
					this.roomInfo.chatRoomStart = "";
					this.roomInfo.chatRoomType = "";
					this.roomInfoCopy.chatRoomName1 = "";
					this.chatMemberList.splice(0);
					this.messageList.splice(0);
					//this.chatJoin = "";
					this.loadRoomInfo();
					this.loadChatMember();
					//this.getChatJoin();
					// 메세지 읽기
					//this.readMessage();
					this.loadRoomList();
					this.chatRoomModal = true;
					this.loadMessage();
					this.$nextTick(() => {
					    this.text = "";
					    this.$refs.messageInput.focus();
					});
					//this.memberListModal = false;
					//this.inviteMemberModal = false;
				},
				// 채팅방 메뉴 모달 열기
				showChatMenuModal() {
					if(this.chatRoomModal == false) return;
					this.chatMenuModal = true;
				},
				// 채팅방 메뉴 모달 닫기
				hideChatMenuModal() {
					this.chatMenuModal = false;
				},
				// 단체채팅방 참여자 모달 열기
				showMemberListModal() {
					if(this.chatRoomModal == false) return;
					this.hideChatMenuModal();
					this.memberListModal = true;
				},
				// 단체채팅방 참여자 모달 닫기
				hideMemberListModal() {
					this.memberListModal = false;
				},
				// 초대 모달 열기
				showInviteMemberModal() {
					this.chatMenuModal = false;
					this.inviteMemberModal = true;
				},
				// 초대 모달 닫기
				hideInviteMemberModal() {
					this.selectedMemberList = [];
					this.selectedMemberIdList = [];
					this.inviteMemberModal = false;
				},
				// 채팅방 나가기 경고 모달 열기
				showLeaveRoomAlert() {
					this.leaveRoomAlert = true;
					this.hideChatMenuModal();
				},
				// 채팅방 나가기 경고 모달 닫기
				hideLeaveRoomAlert() {
					this.leaveRoomAlert = false;
				},
				// 메세지 삭제 경고 모달 열기
				showDeleteMsgAlert(index) {
					this.deleteMsgAlert = true;
					this.msgIndex = index;
				},
				// 메세지 삭제 경고 모달 닫기
				hideDeleteMsgAlert() {
					this.msgIndex = "";
					this.deleteMsgAlert = false;
				},
				// 파일 사이즈 경고 모달 닫기(열기는 20메가 이상인 파일 올릴 때 자동으로 열림)
				hideFileSizeAlert() {
					const fileInput = document.querySelector('.picInput');
					fileInput.value = '';
					this.fileSizeAlert = false;
				},
				
				// 로그인한 회원이 속해있는 채팅방 목록
				async loadRoomList() {
					const memberId = this.memberId;
					if(memberId.length > 0) {
						const url = contextPath + "/chat/chatRoom/" + memberId;
						const resp = await axios.get(url);
						this.chatRoomList.splice(0);
						this.chatRoomList.push(...resp.data);
						this.loadChatRoomNoti();
						
						//console.log("resp.data.length: " + resp.data.length);
						// 갠톡인 경우 상대방 아이디 따로 빼두기
						for (let i = 0; i < resp.data.length; i++) {
							if (resp.data[i].chatRoomType === 'P') {
							    if (resp.data[i].chatRoomName1 !== this.memberId && !this.chatRoomIdList.includes(resp.data[i].chatRoomName1)) {
							      	this.chatRoomIdList.push(resp.data[i].chatRoomName1);
							    }
							    if (resp.data[i].chatRoomName2 !== this.memberId && !this.chatRoomIdList.includes(resp.data[i].chatRoomName2)) {
							      this.chatRoomIdList.push(resp.data[i].chatRoomName2);
							    }
							}
						}
						const url2 = contextPath + "/rest/member/getMemberProfile";
						const resp2 = await axios.get(url2, {
							params: {
								memberIdList: this.chatRoomIdList
							},
							paramsSerializer: params => {
								return new URLSearchParams(params).toString();
							}
						})
						this.chatRoomProfileList = resp2.data;
					}
				},
				// 팔로우 목록 불러오기
				async loadFollowList() {
					if(this.memberId === "") return;
					const url = contextPath + "/rest/follow/member";
					const resp = await axios.get(url);
					//console.log("data: " + resp.data);
					this.followList.push(...resp.data);
					//console.log("followList: " + this.followList);
					if(this.followList.length > 0) {
						const url2 = contextPath + "/rest/member/getMemberProfile";
						const resp2 = await axios.get(url2, {
							params: {
								memberIdList: this.followList
							},
							paramsSerializer: params => {
								return new URLSearchParams(params).toString();
							}
						})
						this.followProfileList = resp2.data;
					}
				},
				// 채팅방 만들기
				createChatRoom() {
					if(this.memberId === "") return;
					if(this.selectedMemberList.length > 1) {
						this.chatRoom.chatRoomType = 'G';
					}
					else {
						this.chatRoom.chatRoomType = 'P';
					}
					for(let i=0; i<this.selectedMemberList.length; i++) {
						this.selectedMemberIdList[i] = this.selectedMemberList[i].memberId;
					}
					//console.log("selectedMemberIdList: " + this.selectedMemberIdList);
					const data = {
							type: 11,
							memberId: this.memberId,
							chatRoomDto: this.chatRoom,
							memberList: this.selectedMemberIdList
					}
					const app = this;
					this.socket.onmessage = (e) => {
						app.messageHandler(e);
						app.chatRoom.chatRoomName1 = "";
					}
					this.socket.send(JSON.stringify(data));
					this.selectedMemberList.splice(0);
					this.selectedMemberIdList.splice(0);
					this.createRoomModal = false;
					this.chatMainModal = true;
					setTimeout(() => {
						this.chatRoomList.splice(0);
						this.loadRoomList();
					}, 30);
					setTimeout(() => {
						this.chatRoomList.splice(0);
						this.loadRoomList();
					}, 30);
				},
				
				// 채팅방 정보 불러오기
				async loadRoomInfo() {
					if(this.memberId === "") return;
					const chatRoomNo = this.chatRoomNo;
					const url = contextPath + "/chat/chatRoom/chatRoomNo/" + chatRoomNo;
					const resp = await axios.get(url);
					this.roomInfo.chatRoomNo = resp.data.chatRoomNo;
					this.roomInfo.chatRoomName1 = resp.data.chatRoomName1;
					this.roomInfo.chatRoomName2 = resp.data.chatRoomName2;
					this.roomInfo.chatRoomStart = resp.data.chatRoomStart;
					this.roomInfo.chatRoomType = resp.data.chatRoomType;
					this.roomInfoCopy.chatRoomName1 = _.cloneDeep(resp.data.chatRoomName1);
				},
				// 참여자 정보 불러오기
				async loadChatMember() {
					if(this.memberId === "") return;
					const chatRoomNo = this.chatRoomNo;
					//console.log("chatRoomNo: " + chatRoomNo);
					const url = contextPath + "/chat/chatRoom/chatMember/" + chatRoomNo;
					const resp = await axios.get(url);
					this.chatMemberList.push(...resp.data);
				},
				// 참여자 정보로 닉네임 가져오기
				findMemberById(index) {
					//console.log("실행");
					const memberId = this.messageList[index].memberId;
					if (this.chatMemberList.some(member => member.memberId === memberId)) {
						member = this.chatMemberList.find(member => member.memberId === memberId);
					}
					else {
					    member = this.followProfileList.find(member => member.memberId === memberId);
					}
					//console.log("member: " + member.memberId);
					if(member) {						
						return {
							memberNick: member.memberNick,
							memberId: member.memberId,
							profileSrc: member.profileSrc
						}
					}
					else return {
						memberNick: '(알수없음)',
						memberId: '(알수없음)',
						profileSrc: contextPath + '/static/image/profileDummy.png'
					}
				},
				findMemberByIdInInvite(index) {
					const memberId = this.filteredFollowList[index].memberId;
					const member = this.chatMemberList.find(function(member) {
						return member.memberId === memberId;
					})
					if(member) {						
						return {
							memberNick: member.memberNick,
							memberId: member.memberId,
							profileSrc: member.profileSrc
						}
					}
					else return {
						memberNick: '(알수없음)',
						memberId: '(알수없음)',
						profileSrc: contextPath + '/static/image/profileDummy.png'
					}
				},
				findMemberByIdInRoom() {
					let findId = "";
					let member = "";
					//console.log("this.roomInfo.chatRoomName1: " + this.roomInfo.chatRoomName1);
					if(this.roomInfo.chatRoomName1 != this.memberId) {
						findId = this.roomInfo.chatRoomName1;
					}
					else if(this.roomInfo.chatRoomName2 != this.memberId) {
						findId = this.roomInfo.chatRoomName2;
					}
					if (this.chatMemberList.some(member => member.memberId === memberId)) {
						member = this.chatMemberList.find(member => member.memberId === findId);
					}
					else {
					    member = this.followProfileList.find(member => member.memberId === findId);
					}
					
					//console.log("findId: " + findId);
					if(member) {						
						return {
							memberNick: member.memberNick,
							memberId: member.memberId,
							profileSrc: member.profileSrc
						}
					}
					else return {
						memberNick: '(알수없음)',
						memberId: '(알수없음)',
						profileSrc: contextPath + '/static/image/profileDummy.png'
					}
				},
				findMemberByIdInMain(index) {
					//const findId = this.chatRoomList[index].chatRoomName1;
					let findId;
					if(this.chatRoomList[index].chatRoomType == 'P') {
						if(this.chatRoomList[index].chatRoomName1 != this.memberId) {
							findId = this.chatRoomList[index].chatRoomName1;
						}
						else if(this.chatRoomList[index].chatRoomName2 != this.memberId) {
							findId = this.chatRoomList[index].chatRoomName2;
						}
					}
					//console.log("findId: " + findId);
					const member = this.chatRoomProfileList.find(function(member) {
						return member.memberId === findId;
					})
					if(member) {
						return {
							memberNick: member.memberNick,
							memberId: member.memberId,
							profileSrc: member.profileSrc
						}
					}
					else return {
						memberNick: '(알수없음)',
						memberId: '(알수없음)',
						profileSrc: contextPath + '/static/image/profileDummy.png'
					}
				},
				// 메세지 불러오기
				async loadMessage() {
					if(this.memberId === "") return;
					const chatRoomNo = this.chatRoomNo;
					this.messageList.splice(0);
					//this.getChatJoin();
					const url = contextPath + "/chat/message";
					const data = {
							memberId: this.memberId,
							chatRoomNo: chatRoomNo
					}
					const resp = await axios.post(url, data);
					//console.log("chatMessageTime: " + resp.data[0].chatMessageTime)
					//console.log("chatJoin: " + this.chatJoin)
					/*for(let i=0; i<resp.data.length; i++) {
						if(resp.data[i].chatMessageTime >= this.chatJoin)
							//console.log(resp.data[i].chatRoomNo)
							this.messageList.push(resp.data[i]);
					}*/
					this.messageList.push(...resp.data);
					this.scrollBottom();
				},
				// 보내는 메세지가 오늘의 첫 메세지인지 확인
				firstMsg() {
					const today = new Date().toLocaleDateString();
					if(this.messageList.length < 1) {
						const data = {
								type: 10,
								chatRoomNo: this.chatRoomNo,
								chatMessageContent: today
						};
						this.socket.send(JSON.stringify(data));
					}
					else {
						const lastMessage = this.messageList[this.messageList.length - 1];
						const lastDate = new Date(lastMessage.chatMessageTime).toLocaleDateString();
						if(lastDate === today) return;
						const data = {
								type: 10,
								chatRoomNo: this.chatRoomNo,
								chatMessageContent: today
						};
						this.socket.send(JSON.stringify(data));
					}
				},
				// 메세지 보내기(실시간 알림 전송 포함)
				async sendMessage() {
					if(this.textCount < 1) return;
					if(this.textCount > 300) return;
					this.firstMsg();
					const text = this.text.trim();
					// 상대방이 나간 갠톡인 경우
					//console.log("chatRoomType: " + this.roomInfo.chatRoomType);
					//console.log("memberList: " + this.chatMemberList.length);
					if(this.roomInfo.chatRoomType === 'P' && this.chatMemberList.length === 1) {
						let targetId = "";
						//console.log("memberId: " + this.memberId);
						//console.log("chatRoomName1: " + this.roomInfo.chatRoomName1);
						if(this.roomInfo.chatRoomName1 !== this.memberId) {
							targetId = this.roomInfo.chatRoomName1;
						}
						else {
							targetId = this.roomInfo.chatRoomName2;
						}
						//console.log("targetId: " + targetId);
						const url = contextPath + "/chat/chatRoom/reinvite";
						const data2 = {
							chatRoomNo: this.chatRoomNo,
							memberId: this.memberId,
							targetId: targetId
						};
						const resp = await axios.post(url, data2);
						this.chatMemberList.splice(0);
						this.loadChatMember();
					}
					const data = {
						type: 1,
						chatRoomNo: this.chatRoomNo,
						chatMessageContent: text
					};
					this.socket.send(JSON.stringify(data));
					this.clear();
					this.loadRoomList();
				},
				// 사진 보내기(실시간 알림 전송 포함)
				async sendPic() {
					if(this.memberId === "") return;
					const fileInput = document.querySelector('.picInput');
					const file = fileInput.files[0];
					let reader = new FileReader();
					const isValid = await new Promise((resolve, reject) => {
						reader.onload = function(e) {
							const fileSize = e.target.result.length;
							const isValidSize = fileSize <= 20961034;
							resolve(isValidSize);
						};
						reader.onerror = function(error) {
							reject(error);
						};
						reader.readAsDataURL(file);
					})
					if(!isValid) {
						this.fileSizeAlert = true;
						return;
					}
					//console.log("전송")
					// 갠톡방에서 상대방 나가있을 경우 다시 초대
					if(this.roomInfo.chatRoomType === 'P' && this.chatMemberList.length === 1) {
						let targetId = "";
						//console.log("memberId: " + this.memberId);
						//console.log("chatRoomName1: " + this.roomInfo.chatRoomName1);
						if(this.roomInfo.chatRoomName1 !== this.memberId) {
							targetId = this.roomInfo.chatRoomName1;
						}
						else {
							targetId = this.roomInfo.chatRoomName2;
						}
						//console.log("targetId: " + targetId);
						const url = contextPath + "/chat/chatRoom/reinvite";
						const data2 = {
							chatRoomNo: this.chatRoomNo,
							memberId: this.memberId,
							targetId: targetId
						};
						const resp = await axios.post(url, data2);
						this.chatMemberList.splice(0);
						this.loadChatMember();
					}
					const formData = new FormData();
					formData.append("attach", file);
					const url = contextPath + "/rest/attachment/upload";
					const resp = await axios.post(url, formData);
					if(resp.data) {
						const data = {
							type: 4,
							chatRoomNo: this.chatRoomNo,
							attachmentNo: resp.data.attachmentNo,
							chatMessageContent: "사진 " + resp.data.attachmentNo
						}
						this.socket.send(JSON.stringify(data));
						fileInput.value = '';
						this.loadRoomList();
					}
				},
				// 시간 포멧 설정
				timeFormat(chatMessageTime) {
					return moment(chatMessageTime).format("HH:mm");
				},
				timeFormatDetailed(chatMessageTime) {
					return moment(chatMessageTime).format("YYYY년 M월 D일 dddd");
				},
	            // 채팅방 목록 마지막 메세지 시간 (n시간 전 형식)
                getTimeDifference(time) {
                    const writeTime = new Date(time);
                    const currentTime = new Date();
                    const timeDifference = currentTime.getTime() - writeTime.getTime();
                    if (timeDifference < 20000) { // 20초 내                       
                         return '방금 전';
                    }
                    else if (timeDifference < 60000){ // 1분 내 
                        const seconds = Math.floor(timeDifference / 1000);
                        return seconds+'초 전';
                    }
                    else if (timeDifference < 3600000) { // 1시간 내
                         const minutes = Math.floor(timeDifference / 60000);
                         return minutes+'분 전';
                    }
                    else if (timeDifference < 86400000) { // 24시간 내
                         const hours = Math.floor(timeDifference / 3600000);
                         return hours+'시간 전';
                    }
                    else if (timeDifference < 604800000) { // 1주일 내
                         const days = Math.floor(timeDifference / 86400000);
                         return days+'일 전';
                    }
                    else { // 1주일 이상
                        var dateOptions; 
                        // 년도 비교
                        if(writeTime.getFullYear() === currentTime.getFullYear()) { // 년도가 같으면
                           dateOptions = {month: 'short', day: 'numeric' };
                        } 
                        else {
                           dateOptions = { year: 'numeric', month: 'short', day: 'numeric' }; // 년도가 다르면 
                        }
                        return writeTime.toLocaleDateString('ko-KO', dateOptions);
                    }
                },
				// 메세지 삭제버튼 보이기
				showDeleteButton(index) {
				    this.showDeleteButtonIndex = index;
				},
				// 메세지 삭제버튼 숨기기
				hideDeleteButton(index) {
				    this.showDeleteButtonIndex = -1;
				},
				// 보낸 메세지 삭제
				deleteMessage(index) {
					if(this.memberId === "") return;
					const chatRoomNo = this.chatRoomNo;
					const data = {
						type: 3, 
						chatMessageNo: this.messageList[this.msgIndex].chatMessageNo, 
						chatRoomNo: chatRoomNo,
						attachmentNo: this.messageList[this.msgIndex].attachmentNo
					};
					this.socket.send(JSON.stringify(data));
					this.messageList.splice(index, -1);
					this.hideDeleteMsgAlert();
				},
				// 해당 채팅방에 참여한 날짜와 시간 가져오기
				/*async getChatJoin() {
					const chatRoomNo = this.chatRoomNo;
					const memberId = this.memberId;
					const url = "${pageContext.request.contextPath}/chat/chatRoom/join/";
					const data = {
							chatRoomNo: chatRoomNo,
							memberId: memberId
					};
					const resp = await axios.post(url, data);
					this.chatJoin = resp.data;
				},*/
				// 채팅방 나가기
				async leaveRoom() {
					if(this.memberId === "") return;
					const memberId = this.memberId;
					const chatRoomNo = this.chatRoomNo;
					const chatRoomType = this.roomInfo.chatRoomType;
					const member = this.chatMemberList.find(function(member) {
						return member.memberId === memberId;
					})
					if(this.roomInfo.chatRoomType != 'P') {
						const data1 = {
							type: 5,
							memberId: memberId,
							chatRoomNo: chatRoomNo,
							chatMessageContent: member.memberNick + " 님이 위즈를 떠났습니다."
						};
						this.socket.send(JSON.stringify(data1));
					}
					else {
						const data1 = {
							type: 13,
							memberId: memberId,
							chatRoomNo: chatRoomNo,
						};
						this.socket.send(JSON.stringify(data1));
					}
					const data2 = {
							memberId: memberId,
							chatRoomNo: chatRoomNo
					};
					const url = contextPath + "/chat/chatRoom/leave/";
					const resp = await axios.post(url, data2);
					this.chatRoomList.splice(0);
					this.loadRoomList();
					this.hideChatRoomModal();
				},
				// 채팅방 이름 변경 모드
				changeRoomName() {
					this.hideChatMenuModal();
					this.roomInfo.edit = true;
				},
				// 이름 변경 취소
				cancelChange() {
					this.roomInfo.chatRoomName1 = this.roomInfoCopy.chatRoomName1;
					this.roomInfo.edit = false;
				},
				// 채팅방 이름 변경
				async saveRoomName() {
					if(this.memberId === "") return;
					if(this.roomInfo.chatRoomName1.length < 1) return;
					if(this.roomInfo.chatRoomName1.length > 20) return;
					const chatRoomNo = this.chatRoomNo;
					const url = contextPath + "/chat/chatRoom/changeName";
					const data = this.roomInfo;
					const resp = await axios.put(url, data);
					this.loadRoomInfo();
					const data2 = {
							type: 8,
							chatRoomNo: chatRoomNo
					};
					this.socket.send(JSON.stringify(data2));
					this.roomInfo.edit = false;
				},
				// 사용자 초대
				async inviteMember() {
					if(this.memberId === "") return;
					const chatRoomNo = this.chatRoomNo;
					for(let i=0; i<this.selectedMemberList.length; i++) {
						this.selectedMemberIdList[i] = this.selectedMemberList[i].memberId;
					}
					for(let j=0; j<this.selectedMemberList.length; j++) {
						this.selectedMemberNickList[j] = this.selectedMemberList[j].memberNick;
					}
					const url = contextPath + "/chat/chatRoom/invite";
					//console.log("roomInfo: " + this.roomInfo);
					const data1 = {
							chatRoomNo: chatRoomNo,
							memberList: this.selectedMemberIdList
					};
					const resp = await axios.post(url, data1);
					const memberNicks = this.selectedMemberNickList.join(", ");
					const data2 = {
							type: 6,
							chatRoomNo: chatRoomNo,
							chatMessageContent: memberNicks + " 님에게 인사해주세요🖐"
					};
					this.socket.send(JSON.stringify(data2));
					this.chatMemberList.splice(0);
					this.selectedMemberList.splice(0);
					this.selectedMemberIdList.splice(0);
					this.selectedMemberNickList.splice(0);
					this.loadChatMember();
					this.hideInviteMemberModal();
				},
				// 스크롤 맨 아래로
				scrollBottom() {
					this.$nextTick(() => {
					    const messageWrapper = this.$refs.messageWrapper;
					    if(messageWrapper) {
					    	messageWrapper.scrollTop = messageWrapper.scrollHeight;
					    }
					});
				},
				// 보낸 시간 확인
				sameTime(index) {
					if(index == 0) return false;
					const prevMsg = this.messageList[index-1];
					const thisMsg = this.messageList[index];
					if(prevMsg.chatMessageType != 1 && prevMsg.chatMessageType != 4) return false;
					if(prevMsg.memberId != thisMsg.memberId) return false;
					if(this.timeFormat(prevMsg.chatMessageTime) != this.timeFormat(thisMsg.chatMessageTime)) return false;
					return true;
				},
				displayTime(index) {
					if(index + 1 == this.messageList.length) return true;
					const thisMsg = this.messageList[index]
					const nextMsg = this.messageList[index+1];
					if(thisMsg.memberId != nextMsg.memberId) return true;
					if(this.timeFormat(thisMsg.chatMessageTime) != this.timeFormat(nextMsg.chatMessageTime)) return true;
					return false;
				},
				//유저버튼 - 로그인 or 마이페이지로 이동
				async goToLoginPage() {
				  const response = await axios.get(contextPath + "/member/goToLoginPage");
				  if (memberId === "") {
				    window.location.href = contextPath + "/member/login";
				  } else {
					  window.location.href = contextPath + "/member/mypage2/" + response.data;
				  }
				},
				// 이미지 메세지 모달로 크게 보기위한 url 셋팅
				setModalImgURL(index) {
					this.modalImgURL = contextPath + "/download?attachmentNo=" + this.messageList[index].attachmentNo;
				},
				// 채팅방에서 상대방 프사나 닉넴 클릭하면 그 사람 프로필 페이지로 이동
				/*moveToProfile(index) {
					this.targetId = this.messageList[index].memberId;
					window.location.href = `${pageContext.request.contextPath}/member/mypage/${targetId}`;
				}*/

				
			},
			computed: {
				memberCount() {
					return this.selectedMemberList.length;
				},
				nameCount() {
					return this.chatRoom.chatRoomName1.length;
				},
				filteredFollowList() {
					return this.followProfileList.filter(follow => 
								!this.chatMemberList.some(member => 
									member.memberId === follow.memberId));
				},
				textCount() {
					return this.text.trim().length;
				}
			},
			created() {
				if(this.memberId != "" && memberId != ""){
					this.connect();
				}

				
			},
			mounted() {
				// 사용자가 이 탭을 보고있는지 확인
				document.addEventListener("visibilitychange", () => {
					if(document.hidden) {
						//console.log("hidden");
						this.isVisible = false;
					}
					else {
						//console.log("visible");
						this.isVisible = true;
					}
				});
				// 사용자가 다른 프로그램을 보는 경우
				window.addEventListener("blur", () => {
					//console.log("out of focus");
					this.isFocused = false;
				});
				// 사용자가 브라우저를 보고 있는 경우
				window.addEventListener("focus", () => {
					//console.log("in focus");
					this.isFocused = true;
				});

				

				function getWindowWidth() {
					return window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
				};


				// ######################## 헤더 조정 ########################
				var inputCompoEle = document.getElementById('navbarSupportedContent');
				var inputEle = $(inputCompoEle).find("input[name=q]");
					// 헤더버튼 요소 선택
				var headerButtons = document.getElementById('header-buttons');
				function focusInput() {
					$(this).css('width', '60%');
					$(headerButtons).find("img").hide();
				}
				function rollbackView() {
					$(inputCompoEle).css('width', '20%');
					$(headerButtons).find("img").show();
				}

				function registerEvent() {
					var windowWidth = getWindowWidth();

					if (windowWidth <= 640) {
						// 헤더검색창 요소 선택
						
						// 헤더검색창 클릭 이벤트 처리
						$(inputCompoEle).css('width', '20%');
						inputCompoEle.addEventListener('click', focusInput);

						inputEle.blur(rollbackView);
					} else {
						$(inputCompoEle).css('width', '50%');
						inputCompoEle.removeEventListener('click', focusInput);
						inputEle.off('blur', rollbackView);
						$(headerButtons).find("img").show();
					}
				}


				// 페이지 로드 시 등록 이벤트
				window.addEventListener('load', registerEvent);
				// 또는 윈도우 크기 변경 시마다 이벤트 등록
				window.addEventListener('resize', registerEvent);


				// ######################## 헤더 조정 끝 ########################
			},
			watch: {
				// 채팅방 모달 켜질 때 메세지 입력창으로 커서 이동되게
				chatRoomModal(value) {
					if(value) {
						this.$nextTick(() => {
							//this.text = "";
							this.$refs.messageInput.focus();
						})
					}
				},
				// 사용자가 페이지를 벗어났다가 다시 들어왔을 때 메세지 읽음 처리
				isVisible: {
					handler: function(newValue) {
						if(newValue && this.isFocused) {
							this.readMessage();
							this.loadRoomList();
						}
					},
					immediate: true
				},
				isFocused: {
					handler: function(newValue) {
						if(this.isVisible && newValue) {
							this.readMessage();
							this.loadRoomList();
						}
					},
					immediate: true
				},
				newChatNoti(newValue) {
					function getWindowWidth() {
						return window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
					};

					if(newValue){
						// ######################## 헤더 조정 ########################
						var inputCompoEle = document.getElementById('navbarSupportedContent');
						var inputEle = $(inputCompoEle).find("input[name=q]");
						
							// 헤더버튼 요소 선택
						function focusInputNoti() {
							var notiMarkEle = $(".notiMark");
							notiMarkEle.hide();
						}
						function rollbackViewNoti() {
							var notiMarkEle = $(".notiMark");
							notiMarkEle.show();
						}

						function registerEvent() {
							var windowWidth = getWindowWidth();

							if (windowWidth <= 640) {
								// 헤더검색창 요소 선택
								
								// 헤더검색창 클릭 이벤트 처리
								inputCompoEle.addEventListener('click', focusInputNoti);
								inputEle.blur(rollbackViewNoti);
							} else {
								inputCompoEle.removeEventListener('click', focusInputNoti);
								inputEle.off('blur', rollbackViewNoti);
								$(".notiMark").show();
							}
						}


						// 페이지 로드 시 등록 이벤트
						window.addEventListener('load', registerEvent);
						// 또는 윈도우 크기 변경 시마다 이벤트 등록
						window.addEventListener('resize', registerEvent);


						// ######################## 헤더 조정 끝 ########################
					}
				}
			},
		}).mount("#header-area");
	</script>
	<script>
		$(function(){
			$(".loading-screen").remove();
		})
	</script>

		<!-- 로그인모달 -->
		<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" >
				<div class="modal-content custom-container" style="border: 1px solid white">
					<div class="modal-header justify-content-center" style="padding-top: 0px">
						<h1 class="modal-title fs-5 font-bold" id="loginModalLabel">
							<img class="me-2" src="${pageContext.request.contextPath}/static/image/loading.png" style="width: 1.5em;">
							스타링크 로그인
						</h1>
					</div>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="position: absolute; right: 20px;"></button>
				<div class="modal-body">
					<div>
						<form class="w-100" action="${pageContext.request.contextPath}/member/login" method="post" autocomplete="off">
							
							<div class="row mb-3 mt-4 mx-0">
								<input class="custom-input-rounded-container width: 100%;" type="text" name="memberId" placeholder="아이디">
								</div>
								
								<div class="row mx-0 mb-1">
								<input class="custom-input-rounded-container" type="password" name="memberPw" placeholder="비밀번호">
								</div>
							
							<h6 class="font-purple1 text-center" >${param.msg}</h6>
							
							
							<div class="custom-hr"></div>
				
							<div class="row my-3 mx-0 ">
								<button type="submit" class="custom-btn btn-round btn-purple1" >로그인</button>
							</div>
							
						</form>
							
							
							<div class="row mb-3  mx-0">
								<button type="button" onclick="location.href='${pageContext.request.contextPath}/member/join'" class="custom-btn btn-round btn-purple1-secondary" >회원가입</button>
							</div>
							
							<div class="text-center">
							<a href="${pageContext.request.contextPath}/member/findId" style="text-decoration: none; color:gray;">아이디 /</a>
							<a href="${pageContext.request.contextPath}/member/findPw" style="text-decoration: none; color:gray;">비밀번호 찾기</a>
							</div>
							
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

</html>
