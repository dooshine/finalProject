<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div id="app">
	<h1 v-if="roomInfo.chatRoomType == 'P'">상대방 이름</h1>
	<div v-if="roomInfo.chatRoomType == 'G'">
		<div v-if="roomInfo.edit == true">
			<input v-model="roomInfo.chatRoomName" @input="roomInfo.chatRoomName = $event.target.value">
			<button type="button" @click="cancelChange">취소</button>
			<button type="button" @click="saveRoomName">변경 완료</button>
		</div>
		<div v-else>
			<h1>{{ roomInfo.chatRoomName }}</h1>
			<button type="button" @click="changeRoomName">채팅방 이름 변경</button>
		</div>
	</div>
	
	<p>${sessionScope.memberId}</p>
	
	<button type="button" @click="leaveRoom">나가기</button>
	<button type="button" data-bs-target="#inviteMemberModal" data-bs-toggle="modal">초대</button>
	
	<hr>
	
	<!-- 메세지 입력창 + 전송버튼 -->
	<input type="text" class="user-input" v-model="text" @input="text = $event.target.value">
	<button class="btn-send" @click="sendMessage">전송</button>
	<input class="form-control d-none" type="file" accept=".png, .jpg, .gif" @change="sendPic">
	
	<hr>
	
	<!-- 메세지가 표시될 공간 -->
	<div class="message-wrapper">
		<div class="message" v-for="(message, index) in messageList" :key="index">
			<!-- 사용자가 보내는 메세지일 때 -->
			<div v-if="message.chatMessageType === 1 || message.chatMessageType === 4">
				<h4>{{ message.memberId }}</h4>
				<button v-if="message.memberId == memberId" @click="deleteMessage(index)">x</button>
				<!-- 텍스트 메세지일 때 -->
				<div v-if="message.attachmentNo === 0">{{ message.chatMessageContent }}</div>
				<!-- 이미지 메세지일 때 -->
				<img class="photo" v-if="message.attachmentNo != 0" 
						:src="'${pageContext.request.contextPath}/download?attachmentNo=' + message.attachmentNo">
				<div>{{ timeFormat(message.chatMessageTime) }}</div>
			</div>
			<!-- 시스템 메세지일 때 -->
			<div v-if="message.chatMessageType === 5 || message.chatMessageType === 6">
				<div>{{ timeFormat(message.chatMessageTime) }}</div>
				<div>{{ message.chatMessageContent }}</div>
			</div>
		</div>
	</div>
	
	<!----------------------------------------------------- 사용자 초대 모달 ----------------------------------------------------->
	<div class="modal"  tabindex="-1" role="dialog" data-bs-backdrop="static" ref="createRoomModal" id="inviteMemberModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
				    <h3 class="modal-title">회원 추가</h3>
				    <div class="d-flex justify-content-end">
				    	<button type="button" class="btn btn-primary" @click="inviteMember" data-bs-dismiss="modal" 
				    		:disabled="selectedMemberList.length === 0">
	           				초대
	        			</button>
					    <button type="button" class="btn bt-secondary" data-bs-dismiss="modal">
	           				닫기
	        			</button>
				    </div>
				</div>
				<div class="modal-body">
					<label class="d-flex justify-content-between" v-for="(follow, index) in followList">
				    	{{ follow.memberId }}
				    	<input type="checkbox" v-model="selectedMemberList" :value="follow.memberId">
					</label>
				</div>
			</div>
		</div>
	</div>
<!----------------------------------------------------- 사용자 초대 모달 ----------------------------------------------------->
	
</div>

<!-- Vue cdn -->
<script src="https://unpkg.com/vue@3.2.36"></script>
<!-- sockjs cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<!-- moment cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<!-- moment cdn 한국어 팩 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/locale/ko.min.js"></script>
<!-- axios cdn -->
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<!-- lodash cdn -->
<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"></script>
<script>
	Vue.createApp({
		data() {
			return {
				text: "",
				roomInfo: {
					chatRoomNo: "",
					chatRoomName: "",
					chatRoomStart: "",
					chatRoomType: ""
				},
				roomInfoCopy: {
					chatRoomName:"",
				},
				chatMemberList: [],
				followList: [],
				selectedMemberList: [],
				messageList: [],
				memberId: "${sessionScope.memberId}",
				chatJoin: "",
				socket: null,
				
				// 입력창 초기화
				clear() {
					this.text = ""
				},
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
				// 방 접속 코드 필요
				const chatRoomNo = new URLSearchParams(location.search).get("chatRoomNo");
				const data = { type: 2, chatRoomNo: chatRoomNo };
				this.socket.send(JSON.stringify(data));
				this.chatRoomNo = chatRoomNo;
			},
			closeHandler() {
				this.connected = false;
			},
			errorHandler() {
				this.connected = false;
			},
			messageHandler(e) {
				const parsedData = JSON.parse(e.data);
				// 타입이 3인(삭제인) 메세지는 리스트에 추가하지 않음
				if(parsedData.type == 3) {
					this.clearMessageList();
					this.loadMessage(); return;
				}
				this.messageList.push(parsedData);
			},
			// 채팅방 정보 불러오기
			async loadRoomInfo() {
				const chatRoomNo = new URLSearchParams(location.search).get("chatRoomNo");
				const url = "${pageContext.request.contextPath}/chat/chatRoom/chatRoomNo/" + chatRoomNo;
				const resp = await axios.get(url);
				//console.log("data: " + resp.data.chatRoomName);
				//this.roomInfo.push(resp.data);
				this.roomInfo.chatRoomNo = resp.data.chatRoomNo;
				this.roomInfo.chatRoomName = resp.data.chatRoomName;
				this.roomInfo.chatRoomStart = resp.data.chatRoomStart;
				this.roomInfo.chatRoomType = resp.data.chatRoomType;
				this.roomInfoCopy.chatRoomName = _.cloneDeep(resp.data.chatRoomName);
			},
			// 참여자 정보 불러오기
			async loadChatMember() {
				const chatRoomNo = new URLSearchParams(location.search).get("chatRoomNo");
				const url = "${pageContext.request.contextPath}/chat/chatRoom/chatMember/" + chatRoomNo;
				const resp = await axios.get(url);
				this.chatMemberList.push(...resp.data);
			},
			// 메세지 목록 지우기
			clearMessageList() {
				this.messageList.splice(0);
			},
			// 메세지 불러오기
			async loadMessage() {
				const chatRoomNo = new URLSearchParams(location.search).get("chatRoomNo");
				const url = "${pageContext.request.contextPath}/chat/message/" + chatRoomNo;
				const resp = await axios.get(url);
				for(let i=0; i<resp.data.length; i++) {
					if(resp.data[i].chatMessageTime >= this.chatJoin)
						this.messageList.push(resp.data[i]);
				}
			},
			// 메세지 보내기
			sendMessage() {
				if(this.text.length == 0) return;
				const data = { 
						type: 1, 
						chatMessageContent: this.text 
				};
				this.socket.send(JSON.stringify(data));
				// 입력창 초기화
				this.clear();
			},
			// 사진 보내기
			async sendPic() {
				// 비동기로 파일 정보 저장
				const fileInput = document.querySelector('input[type=file]');
			    const file = fileInput.files[0];
				const formData = new FormData();
				formData.append("attach", file);
				const url = "${pageContext.request.contextPath}/rest/attachment/upload";
				const resp = await axios.post(url, formData);
				// 소켓 샌드로 메세지 보내기
				//console.log("attachmentNo: " + resp.data.attachmentNo);
				if(resp.data) {
					const data = {
							type: 4, 
							attachmentNo: resp.data.attachmentNo,
							chatMessageContent: "사진 " + resp.data.attachmentNo
					}
					this.socket.send(JSON.stringify(data));
					this.clear();
					this.fileInput = [];
				}
			},
			// 시간 포맷 설정
			timeFormat(chatMessageTime) {
				//return moment(chatMessageTime).format("A h:mm");
				return moment(chatMessageTime).format("YYYY-M-D A h:mm");
			},
			// 보낸 메세지 삭제
			deleteMessage(index) {
				const chatRoomNo = new URLSearchParams(location.search).get("chatRoomNo");
				const data = {
						type: 3, 
						chatMessageNo: this.messageList[index].chatMessageNo, 
						chatRoomNo: chatRoomNo,
						attachmentNo: this.messageList[index].attachmentNo
				};
				this.socket.send(JSON.stringify(data));
				this.messageList.splice(index, 1);
			},
			// 해당 채팅방에 참여한 날짜와 시간 가져오기
			async getChatJoin() {
				const chatRoomNo = new URLSearchParams(location.search).get("chatRoomNo");
				const memberId = this.memberId;
				const url = "${pageContext.request.contextPath}/chat/chatRoom/join/";
				const data = {
						chatRoomNo: chatRoomNo,
						memberId: memberId
				}
				const resp = await axios.post(url, data);
				this.chatJoin = resp.data;
			},
			// 채팅방 나가기
			async leaveRoom() {
				const memberId = this.memberId;
				const chatRoomNo = new URLSearchParams(location.search).get("chatRoomNo");
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
				window.location.href = "${pageContext.request.contextPath}/chat/";
			},
			// 채팅방 이름 변경 모드
			changeRoomName() {
				this.roomInfo.edit = true;
			},
			// 이름 변경 취소
			cancelChange() {
				this.roomInfo.chatRoomName = this.roomInfoCopy.chatRoomName;
				this.roomInfo.edit = false;
			},
			// 채팅방 이름 변경
			async saveRoomName() {
				const url = "${pageContext.request.contextPath}/chat/chatRoom/changeName";
				const data = this.roomInfo;
				const resp = await axios.put(url, data);
				this.roomInfo.edit = false;
			},
			// 팔로우 목록 불러오기
			async loadFollowList() {
				const url = "${pageContext.request.contextPath}/chat/chatRoom/follow/";
				const resp = await axios.get(url);
				//console.log("data: " + resp.data);
				this.followList.push(...resp.data);
			},
			// 사용자 초대
			async inviteMember() {
				const chatRoomNo = new URLSearchParams(location.search).get("chatRoomNo");
				const url = "${pageContext.request.contextPath}/chat/chatRoom/invite";
				console.log("roomInfo: " + this.roomInfo);
				const data1 = {
						chatRoomNo: chatRoomNo,
						memberList: this.selectedMemberList
				}
				const resp = await axios.post(url, data1);
				const data2 = {
						type: 6,
						chatRoomNo: chatRoomNo,
						chatMessageContent: this.selectedMemberList[0] + " 님이 입장했습니다."
				};
				this.socket.send(JSON.stringify(data2));
				this.selectedMemberList = "";
			}
		},
		computed: {

		},
		created() {
			this.connect();
			this.loadRoomInfo();
			this.loadChatMember();
			this.loadMessage();
			this.getChatJoin();
			this.loadFollowList();
		},
		mounted() {
			
		}
	}).mount("#app");
</script>

<style>
	.message {
		border-bottom: 1px solid gray;
		padding: 10px;
	}
</style>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
