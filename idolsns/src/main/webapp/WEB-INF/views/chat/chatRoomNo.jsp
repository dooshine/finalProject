<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="app">
	<h1>채팅 테스트</h1>
	<p>${sessionScope.memberId}</p>
	
	<a @click="leaveRoom" href="#">나가기</a>
	
	<hr>
	
	<!-- 메세지 입력창 + 전송버튼 -->
	<input type="text" class="user-input" v-model="text" @input="text = $event.target.value">
	<button class="btn-send" @click="sendMessage">전송</button>
	
	<hr>
	
	<!-- 메세지가 표시될 공간 -->
	<div class="message-wrapper">
		<div class="message" v-for="(message, index) in messageList" :key="index">
			<div>
				<h4>{{ message.memberId }}</h4>
				<button v-if="message.memberId == memberId" @click="deleteMessage(index)">x</button>
			</div>
			<div>{{ message.chatMessageContent }}</div>
			<div>{{ timeFormat(message.time) }}</div>
		</div>
	</div>
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
					this.loadMessage();
					return;
				}
				this.messageList.push(parsedData);
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
					if(resp.data[i].chatMessageTime >= this.chatJoin) {
						this.messageList.push(resp.data[i]);
					}
				}
			},
			// 메세지 보내기
			sendMessage() {
				if(this.text.length == 0) return;
				const data = { type: 1, chatMessageContent: this.text };
				this.socket.send(JSON.stringify(data));
				// 입력창 초기화
				this.clear();
			},
			// 사진 보내기
			async sendPic() {
				if(this.text.length == 0) return;
				// 비동기로 파일 정보 저장
				// 소켓 샌드로 메세지 보내기
				// constant에 사진메세지 번호 등록(4)
			},
			// 시간 포맷 설정
			timeFormat(chatMessageTime) {
				return moment(chatMessageTime).format("A h:mm");
			},
			// 보낸 메세지 삭제
			deleteMessage(index) {
				const chatRoomNo = new URLSearchParams(location.search).get("chatRoomNo");
				const data = { type: 3, chatMessageNo: this.messageList[index].chatMessageNo, chatRoomNo: chatRoomNo };
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
				const data = {
						memberId: memberId,
						chatRoomNo: chatRoomNo
				}
				const url = "${pageContext.request.contextPath}/chat/chatRoom/leave/";
				const resp = await axios.post(url, data);
				window.location.href = "${pageContext.request.contextPath}/chat/";
			}
		},
		computed: {

		},
		created() {
			// 웹소켓 연결
			this.connect();
			this.loadMessage();
			this.getChatJoin();
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