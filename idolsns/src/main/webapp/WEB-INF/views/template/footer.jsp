<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- clndr -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/clndr/1.1.0/clndr.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.13.6/underscore-min.js"></script>
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
					
					// main에서 가져옴
					chatRoom: {
						chatRoomNo: "",
						chatRoomName: "",
						chatRoomStart: "",
						chatRoomType: ""
					},
					memberId: memberId,
					chatRoomList: [],
					followList: [],
					selectedMemberList: [memberId]
					
					// chatRoomNo에서 가져옴
					/*text: "",
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
					//followList: [],
					//selectedMemberList: [],
					messageList: [],
					chatJoin: "",
					
					// 입력창 초기화
					clear() {
						this.text = ""
					},*/
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
					const data = { type: 2, chatRoomNo: -2 };
					this.socket.send(JSON.stringify(data));
				},
				closeHandler() {
				},
				errorHandler() {
				},
				messageHandler(e) {
					
				},
				// 채팅 메인 모달 표시
				showChatMainModal() {
					this.chatRoomList.splice(0);
					this.loadRoomList();
					this.followList.splice(0);
					this.loadFollowList();
					this.chatMainModal = true;
				},
				// 채팅 메인 모달 숨김
				hideChatMainModal() {
					this.chatMainModal = false;
				},
				// 채팅방 만들기 모달 표시
				showCreateRoomModal() {
					this.hideChatMainModal();
					this.createRoomModal = true;
				},
				// 채팅방 만들기 모달 숨김
				hideCreateRoomModal() {
					this.createRoomModal = false;
					this.showChatMainModal();
				},
				// 채팅방 모달 표시
				showChatRoomModal() {
					
				},
				hideChatRoomModal() {
					
				},
				
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
					this.chatRoom.chatRoomName = "";
					this.selectedMemberList.splice(0);
					this.selectedMemberList.push(memberId);
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
				this.hideCreateRoomModal();
				this.hideChatMainModal();
				if(this.memberId != ""){
					this.connect();
					this.loadRoomList();
					this.loadFollowList();
				}
			},
			mounted() {

			}
		}).mount("#header-area");
	</script>

 
    
</body>
</html>

