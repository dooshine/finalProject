<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- clndr -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/clndr/1.1.0/clndr.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.13.6/underscore-min.js"></script>
<!-- lodash -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
<!-- <link rel="stylesheet" type="text/css" href="/static/css/clndr.css"> -->
            </div>
       
		

	<div class="col-3">
		<!-- 캘린더 영역 -->
	  	<div id="calendar">
	  		<div class="clndr-grid">
				<div class="days-of-the-week clearfix">
					<c:forEach items="${daysOfTheWeek}" var="day">
						<div class="header-day">${day}</div>
					</c:forEach>
				</div>
				<div class="days clearfix">
					<c:forEach items="${days}" var="day">
						<div class="${day.classes}" id="${day.id}">
							<span class="day-number">${day.day}</span>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="event-listing">
				<div class="event-listing-title">EVENTS THIS MONTH</div>
				<c:forEach items="${eventsThisMonth}" var="event">
					<div class="event-item">
						<div class="event-item-name">${event.name}</div>
						<div class="event-item-location">${event.location}</div>
					</div>
				</c:forEach>
			</div>
	  	</div>
	</div>
	





        
        </section>
        <hr>
        <footer>
            <h1>푸터</h1>
            <h2>세션 memberId: ${sessionScope.memberId}</h2>
            <h2>세션 memberLevel: ${sessionScope.memberLevel}</h2>
        </footer>
    </main>
 
 
 
	<!-- 부트스트랩 js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    

	<!-- cnldr 스크립트 -->
 	<script>
 		$(function() {
 			$("#calendar").clndr({
 				daysOfTheWeek: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
 			numberOfRows: 5,
 			days: [
 			  {
 			    day: '1',
 			    classes: 'day today event',
 			    id: 'calendar-day-2013-09-01',
 			    events: [ ],
 			    date: moment('2013-09-01')
 			  },
 			],
 			month: 'September',
 			year: '2013',
 			eventsThisMonth: [ ],
 			extras: { }
 			});
 		});
	</script>
 
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
					selectedMemberList: [],
					
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
					chatJoin: "",
					// 입력창 초기화
					clear() {
						this.text = ""
					},
					
					// 활성화 여부 저장
					isVisible: true,
					isFocused: true,
					
					joinRoomList: [],
					
					// 메세지 삭제 버튼 관련
					showDeleteButtonIndex: -1,
					
					// 새 메세지 알림 여부
					newChatNoti: false,
					//newChatRoomNoti: false,
					chatRoomNoList: []
				};
			},
			methods: {
				connect() {
					const url = "${pageContext.request.contextPath}/ws/server";
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
				openHandler() {
					this.loadJoinRooms();
					this.loadChatNoti();
				},
				closeHandler() {
				},
				errorHandler() {
				},
				messageHandler(e) {
					const parsedData = JSON.parse(e.data);
					// 타입이 3인(삭제인) 메세지는 리스트에 추가하지 않음
					if(parsedData.type == 3) {
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
					this.messageList.push(parsedData);
					// 사용자가 페이지를 보고있는 경우 메세지 읽음 처리
					if(this.isVisible && this.isFocused && parsedData.memberId != this.memberId &&
							this.chatRoomNo == parsedData.chatRoomNo && this.chatRoomModal === true) {
						this.readMessage();
					}
					this.loadRoomList();
					this.scrollBottom();
				},
				// 참여중인 방 정보 가져오기
				loadJoinRooms() {
					this.joinRoomList = [];
					this.loadRoomList();
					for(let i=0; i<this.chatRoomList.length; i++) {
						this.joinRoomList.push(this.chatRoomList[i].chatRoomNo);
					}
					const data = {
							type: 7,
							joinRooms: this.joinRoomList,
							memberId: this.memberId
					}
					this.socket.send(JSON.stringify(data));
				},
				// 새 채팅 알림 있는지 확인
				async loadChatNoti() {
					const memberId = this.memberId;
					const url = "${pageContext.request.contextPath}/chat/message/noti/" + memberId;
					const resp = await axios.get(url);
					console.log(resp.data);
					if(resp.data === true) this.newChatNoti = true;
					else this.newChatNoti = false;
				},
				// 방별로 새 알림 있는지 확인
				/*async loadChatRoomNoti() {
					for(let i=0; i<this.chatRoomList.length; i++) {
						this.chatRoomNoList.push(this.chatRoomList[i].chatRoomNo);
					}
					const memberId = this.memberId;
					const url = "${pageContext.request.contextPath}/chat/message/noti";
					const data = {
							chatRoomNoList: this.chatRoomNoList,
							memberId: memberId
					};
					console.log("chatRoomNoList: " + this.chatRoomNoList);
					const resp = await axios.post(url, data);
					console.log(resp.data);
					//if(!resp.data.isEmpty) this.newChatRoomNoti = true;
					//else this.newChatRoomNoti = false;
				},*/
				async readMessage() {
					const url = "${pageContext.request.contextPath}/chat/message";
					const data = {
							chatReceiver: this.memberId,
							chatRoomNo: this.chatRoomNo
					};
					const resp = await axios.put(url, data);
				},
				// 채팅 메인 모달 열기
				showChatMainModal() {
					this.chatRoomList.splice(0);
					this.followList.splice(0);
					this.loadRoomList();
					this.loadFollowList();
					//this.loadChatRoomNoti();
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
					//this.selectedMemberList.push(this.memberId);
					this.createRoomModal = false;
					this.showChatMainModal();
				},
				// 채팅방 모달 열기
				showChatRoomModal(index) {
					if(this.chatRoomNo == this.chatRoomList[index].chatRoomNo) return;
					const chatRoomNo = this.chatRoomList[index].chatRoomNo;
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
					this.chatJoin = "";
					this.chatRoomNo = chatRoomNo;
					this.loadRoomInfo();
					this.loadChatMember();
					this.getChatJoin();
					// 메세지 읽기
					this.readMessage();
					this.chatRoomModal = true;
					this.loadMessage();
					//this.scrollBottom();
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
					this.chatJoin = "";
					this.chatMenuModal = false;
					this.chatRoomModal = false;
					this.text = "";
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
				// 초대 모달 열기
				showInviteMemberModal() {
					this.chatMenuModal = false;
					this.inviteMemberModal = true;
				},
				// 초대 모달 닫기
				hideInviteMemberModal() {
					this.selectedMemberList = [];
					this.inviteMemberModal = false;
				},
				// 로그인한 회원이 속해있는 채팅방 목록
				async loadRoomList() {
					const memberId = this.memberId;
					const url = "${pageContext.request.contextPath}/chat/chatRoom/" + memberId;
					const resp = await axios.get(url);
					this.chatRoomList.splice(0);
					this.chatRoomList.push(...resp.data);
				},
				// 팔로우 목록 불러오기
				async loadFollowList() {
					const url = "${pageContext.request.contextPath}/rest/follow/member";
					const resp = await axios.get(url);
					//console.log("data: " + resp.data);
					this.followList.push(...resp.data);
					console.log("followList: " + this.followList);
				},
				// 채팅방 만들기 - 모달 안 닫힘 이유를 모르겠음
				createChatRoom() {
					if(this.selectedMemberList.length > 1) {
						this.chatRoom.chatRoomType = 'G';
					}
					else {
						this.chatRoom.chatRoomType = 'P';
					}
					const data = {
							type: 11,
							memberId: this.memberId,
							chatRoomDto: this.chatRoom,
							memberList: this.selectedMemberList
					}
					const app = this;
					this.socket.onmessage = (e) => {
						app.messageHandler(e);
						app.chatRoomList.splice(0);
						app.loadRoomList();
						app.chatRoom.chatRoomName1 = "";
						//app.selectedMemberList.push(this.memberId);
						//app.hideCreateRoomModal();
						//app.createRoomModal = false;
						//app.chatMainModal = true;
					}
					this.socket.send(JSON.stringify(data));
					this.selectedMemberList.splice(0);
					//this.hideCreateRoomModal();
					this.createRoomModal = false;
					this.chatMainModal = true;
					setTimeout(() => {
						this.chatRoomList.splice(0);
						this.loadRoomList();
					}, 30);
				},
				
				// 채팅방 정보 불러오기
				async loadRoomInfo() {
					const chatRoomNo = this.chatRoomNo;
					const url = "${pageContext.request.contextPath}/chat/chatRoom/chatRoomNo/" + chatRoomNo;
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
					const chatRoomNo = this.chatRoomNo;
					//console.log("chatRoomNo: " + chatRoomNo);
					const url = "${pageContext.request.contextPath}/chat/chatRoom/chatMember/" + chatRoomNo;
					const resp = await axios.get(url);
					this.chatMemberList.push(...resp.data);
				},
				// 참여자 정보로 닉네임 가져오기
				findMemberById(index) {
					const memberId = this.messageList[index].memberId;
					const member = this.chatMemberList.find(function(member) {
						return member.memberId === memberId;
					})
					if(member) {						
						return {
							memberNick: member.memberNick,
							memberId: member.memberId
						}
					}
					else return null;
				},
				// 메세지 불러오기
				async loadMessage() {
					const chatRoomNo = this.chatRoomNo;
					this.messageList.splice(0);
					const url = "${pageContext.request.contextPath}/chat/message/" + chatRoomNo;
					const resp = await axios.get(url);
					for(let i=0; i<resp.data.length; i++) {
						if(resp.data[i].chatMessageTime >= this.chatJoin)
							this.messageList.push(resp.data[i]);
					}
					this.scrollBottom();
				},
				// 메세지 보내기
				sendMessage() {
					if(this.textCount() < 1) return;
					if(this.textCount() > 300) return;
					this.firstMsg();
					const data = {
							type: 1,
							chatRoomNo: this.chatRoomNo,
							chatMessageContent: this.text
					};
					this.socket.send(JSON.stringify(data));
					const noti = {
							type: 12,
							memberId: this.memberId,
							chatRoomNo: this.chatRoomNo,
							receiverList: this.chatMemberList
					};
					this.socket.send(JSON.stringify(noti));
					this.clear();
					this.scrollBottom();
					//this.loadRoomList();
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
						//console.log("lastDate: " + lastDate)
						console.log("lastDate: " + typeof lastDate);
						console.log("lastDate: " + lastDate);
						console.log("today: " + typeof today);
						console.log("today: " + today);
						console.log(lastDate === today);
						if(lastDate === today) return;
						const data = {
								type: 10,
								chatRoomNo: this.chatRoomNo,
								chatMessageContent: today
						};
						this.socket.send(JSON.stringify(data));
					}
				},
				// 사진 보내기
				async sendPic() {
					const fileInput = document.querySelector('.picInput');
					const file = fileInput.files[0];
					const formData = new FormData();
					formData.append("attach", file);
					const url = "${pageContext.request.contextPath}/rest/attachment/upload";
					const resp = await axios.post(url, formData);
					if(resp.data) {
						const data = {
								type: 4, 
								chatRoomNo: this.chatRoomNo,
								attachmentNo: resp.data.attachmentNo,
								chatMessageContent: "사진 " + resp.data.attachmentNo
						}
						this.socket.send(JSON.stringify(data));
						const noti = {
								type: 12,
								memberId: this.memberId,
								chatRoomNo: this.chatRoomNo,
								receiverList: this.chatMemberList
						};
						this.socket.send(JSON.stringify(noti));
						/*this.clear();*/
						/*fileInput = [];*/
						this.scrollBottom();
					}
				},
				// 시간 포멧 설정
				timeFormat(chatMessageTime) {
					return moment(chatMessageTime).format("HH:mm");
				},
				timeFormatDetailed(chatMessageTime) {
					return moment(chatMessageTime).format("YYYY년 M월 D일 dddd");
				},
				timeFormatDetailed2(chatRoomLast) {
					return moment(chatRoomLast).format("YYYY년 M월 D일 dddd");
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
					const chatRoomNo = this.chatRoomNo;
					const data = {
						type: 3, 
						chatMessageNo: this.messageList[index].chatMessageNo, 
						chatRoomNo: chatRoomNo,
						attachmentNo: this.messageList[index].attachmentNo
					};
					this.socket.send(JSON.stringify(data));
					this.messageList.splice(index, -1);
				},
				// 해당 채팅방에 참여한 날짜와 시간 가져오기
				async getChatJoin() {
					const chatRoomNo = this.chatRoomNo;
					const memberId = this.memberId;
					const url = "${pageContext.request.contextPath}/chat/chatRoom/join/";
					const data = {
							chatRoomNo: chatRoomNo,
							memberId: memberId
					};
					const resp = await axios.post(url, data);
					this.chatJoin = resp.data;
				},
				// 채팅방 나가기
				async leaveRoom() {
					const memberId = this.memberId;
					const chatRoomNo = this.chatRoomNo;
					const data1 = {
						type: 5,
						memberId: memberId,
						chatRoomNo: chatRoomNo,
						chatMessageContent: this.memberId + " 님이 위즈를 떠났습니다."
					};
					this.socket.send(JSON.stringify(data1));
					const data2 = {
							memberId: memberId,
							chatRoomNo: chatRoomNo
					};
					const url = "${pageContext.request.contextPath}/chat/chatRoom/leave/";
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
					if(this.roomInfo.chatRoomName1.length > 10) return;
					const chatRoomNo = this.chatRoomNo;
					const url = "${pageContext.request.contextPath}/chat/chatRoom/changeName";
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
					const chatRoomNo = this.chatRoomNo;
					const url = "${pageContext.request.contextPath}/chat/chatRoom/invite";
					//console.log("roomInfo: " + this.roomInfo);
					const data1 = {
							chatRoomNo: chatRoomNo,
							memberList: this.selectedMemberList
					};
					const resp = await axios.post(url, data1);
					const memberIds = this.selectedMemberList.join(", ");
					const data2 = {
							type: 6,
							chatRoomNo: chatRoomNo,
							chatMessageContent: memberIds + " 님에게 인사해주세요🖐"
					};
					this.socket.send(JSON.stringify(data2));
					this.chatMemberList.splice(0);
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
				}
			},
			computed: {
				memberCount() {
					return this.selectedMemberList.length;
				},
				nameCount() {
					return this.chatRoom.chatRoomName1.length;
				},
				filteredFollowList() {
					return this.followList.filter(follow => 
								!this.chatMemberList.some(member => 
									member.memberId === follow));
				},
				textCount() {
					return this.text.trim().length;
				}
			},
			created() {
				if(this.memberId != "" && memberId != ""){
					this.connect();
					/*this.chatRoomList.splice(0);
					this.loadRoomList();
					this.followList.splice(0);
					this.loadFollowList();*/
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
			},
			watch: {
				// 채팅방 모달 켜질 때 메세지 입력창으로 커서 이동되게
				chatRoomModal(value) {
					if(value) {
						this.$nextTick(() => {
							this.$refs.messageInput.focus();
						})
					}
				},
				// 사용자가 페이지를 벗어났다가 다시 들어왔을 때 메세지 읽음 처리
				isVisible: {
					handler: function(newValue) {
						if(newValue && this.isFocused) {
							this.readMessage();
						}
					},
					immediate: true
				},
				isFocused: {
					handler: function(newValue) {
						if(this.isVisible && newValue) {
							this.readMessage();
						}
					},
					immediate: true
				}
			}
		}).mount("#header-area");
	</script>

 
    
</body>
</html>

