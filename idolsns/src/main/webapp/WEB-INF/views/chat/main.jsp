<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div id="app">
	<h1>채팅 테스트 메인</h1>
	
	<p>아이디: {{ memberId }}</p>
	
	<button data-bs-target="#createRoomModal" data-bs-toggle="modal">채팅방 만들기</button>
	
	<h3>채팅방 목록</h3>
	<div class="chatRooms" v-for="(room, index) in chatRoomList" :key="index">
		<button @click="chatRoomModal">{{ room.chatRoomName }}</button>
	</div>
	
<!----------------------------------------------------- 채팅방 생성 모달 ----------------------------------------------------->
	<div class="modal"  tabindex="-1" role="dialog" data-bs-backdrop="static" ref="createRoomModal" id="createRoomModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
				    <h3 class="modal-title">채팅방 만들기</h3>
				    <div class="d-flex justify-content-end">
				    	<button type="button" class="btn btn-primary" @click="createChatRoom" data-bs-dismiss="modal" 
				    		:disabled="(selectedMemberList.length === 0 && nameCount < 1) || (selectedMemberList.length >= 3 && nameCount === 0)">
	           				생성
	        			</button>
					    <button type="button" class="btn bt-secondary" data-bs-dismiss="modal">
	           				닫기
	        			</button>
				    </div>
				</div>
				<div class="modal-body">
					<div class="form-floating" v-if="memberCount > 2">
  						<input type="text" class="form-control" id="chatRoomNameInput" placeholder="채팅방이름" 
  											v-model="chatRoom.chatRoomName" @input="chatRoom.chatRoomName = $event.target.value">
					  	<label for="chatRoomNameInput">채팅방 이름</label>
					</div>
					<label class="d-flex justify-content-between" v-for="(follow, index) in followList">
				    	{{ follow.memberId }}
				    	<input type="checkbox" v-model="selectedMemberList" :value="follow.memberId">
					</label>
				</div>
			</div>
		</div>
	</div>
<!----------------------------------------------------- 채팅방 생성 모달 ----------------------------------------------------->
	
<!------------------------------------------------------- 채팅방 모달 ------------------------------------------------------->
<!------------------------------------------------------- 채팅방 모달 ------------------------------------------------------->
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
				chatRoom: {
					chatRoomNo: "",
					chatRoomName: "",
					chatRoomStart: "",
					chatRoomType: ""
				},
				memberId: memberId,
				chatRoomList: [],
				followList: [],
				selectedMemberList: [memberId],
				createRoomModal: null
			};
		},
		methods: {
			// 로그인한 회원이 속해있는 채팅방 목록
			async loadRoomList() {
				const memberId = this.memberId;
				const url = "${pageContext.request.contextPath}/chat/chatRoom/" + memberId;
				const resp = await axios.get(url);
				this.chatRoomList.push(...resp.data);
			},
			// 팔로우 목록 불러오기
			async loadFollowList() {
				const url = "${pageContext.request.contextPath}/chat/chatRoom/follow/";
				const resp = await axios.get(url);
				//console.log("data: " + resp.data);
				this.followList.push(...resp.data);
			},
			// 채팅방 모달 (구현 예정)
			chatRoomModal() {
				
			},
			// 채팅방 생성 모달 열기
			openCreateRoomModal() {
				if(this.createRoomModal == null) return;
				this.createRoomModal.show();
			},
			// 채팅방 생성 모달 닫기
			hideCreateRoomModal() {
				if(this.createRoomModal == null) return;
				this.createRoomModal.hide();
			},
			// 채팅방 만들기
			async createChatRoom() {
				this.chatRoom.memberList = this.selectedMemberList;
				if(this.selectedMemberList.length > 2) {
					this.chatRoom.chatRoomType = 'G';
				}
				else {
					this.chatRoom.chatRoomType = 'P';
				}
				const url = "${pageContext.request.contextPath}/chat/chatRoom/";
				const data = {
						memberId: this.memberId,
						chatRoomDto: this.chatRoom,
						memberList: this.selectedMemberList
				}
				const resp = await axios.post(url, data);
			},
		},
		computed: {
			memberCount() {
				return this.selectedMemberList.length;
			},
			nameCount() {
				return this.chatRoom.chatRoomName.length;
			}
		},
		created() {
			// 접속하면 바로 채팅방, 팔로잉 리스트 가져오기
			this.loadRoomList();
			this.loadFollowList();
		},
		mounted() {

		}
	}).mount("#app");
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
