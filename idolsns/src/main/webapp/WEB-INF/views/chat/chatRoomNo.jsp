<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="app">
	<h1>채팅 테스트</h1>
	<p>${sessionScope.memberId}</p>
	
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
<!-- lodash cdn (throttle) -->
<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"></script>
<script>
	Vue.createApp({
		data() {
			return {
				text: "",
				messageList: [],
				memberId: "${sessionScope.memberId}",
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
				console.log(JSON.parse(e.data));
				this.messageList.push(JSON.parse(e.data));
// 				console.log(JSON.parse(e.data).chatMessageContent);
// 				this.messageList.push(JSON.parse(e.data));
			},
			// 메세지 목록 지우기
			clearMessageList() {
				this.messageList.splice(0);
			},
			// 메세지 불러오기
			async loadMessage() {
				const chatRoomNo = new URLSearchParams(location.search).get("chatRoomNo");
				// console.log("chatRoomNo: " + chatRoomNo);
				const url = "${pageContext.request.contextPath}/chat/message/" + chatRoomNo;
				let resp = await axios.get(url);
				this.messageList.push(...resp.data);
				/*let temp = resp.data.map(item => {
					item.chatMessageTime = this.timeFormat(new Date(item.chatMessageTime));
					// console.log(item.chatMessageContent);
					this.messageList.push(JSON.parse(item.chatMessageContent));
					return item;
				})
				this.clearMessageList();
				for(let i=0; i<temp.length; i++){
					this.messageList.push(JSON.parse(temp[i].chatMessageContent));
				}*/
// 				this.messageList.push(...temp);
			},
			// 메세지 보내기
			sendMessage() {
				//console.log(this.text)
				if(this.text.length == 0) return;
				const data = { type: 1, chatMessageContent: this.text };
				this.socket.send(JSON.stringify(data));
				// 입력창 초기화
				this.clear();
				// 목록 불러오기 - 하면 안됨
// 				this.loadMessage();
			},
			// 시간 포맷 설정
			timeFormat(chatMessageTime) {
				return moment(chatMessageTime).format("A h:mm");
			},
			// 보낸 메세지 삭제
			async deleteMessage(index) {
				const chatMessageNo = this.messageList[index].chatMessageNo;
				console.log("chatMessageNo: " + chatMessageNo);
				const url = "${pageContext.request.contextPath}/chat/message/" + chatMessageNo;
				const resp = await axios.delete(url);
			}
		},
		computed: {
			
		},
		created() {
			// 웹소켓 연결
			this.connect();
			this.loadMessage();
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