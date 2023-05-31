<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>




<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>



<!-- lodash -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
<!-- <link rel="stylesheet" type="text/css" href="/static/css/clndr.css"> -->
            </div>
      
    
	<div class="col-3">
		<!-- 캘린더 영역 -->
	

	
	
	 
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


<script src="
https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js
"></script>



 	<script>
		Vue.createApp({
			  data() {
				    return {
				      maintenance: {
				        title: null,
				        description: null,
				        color: null,
				        startedAt: moment().format('YYYY-MM-DD HH:mm:ss'),
				        endedAt: moment().format('YYYY-MM-DD HH:mm:ss'),
				      },
				    };
				  },
				  mounted() {
				    this.initCalendar();
				    this.setDate(new Date(), new Date());
				  },
				  methods: {
				    save() {
				      // API Post
				    },

				    setDate(date1, date2) {
				      this.maintenance.startedAt = moment(date1).format('YYYY-MM-DD 09:00:00');
				      this.maintenance.endedAt = moment(date2).format('YYYY-MM-DD 18:00:00');

				      $('#reservationtime').daterangepicker({
				        timePicker: true,
				        startDate: moment(date1).format('YYYY-MM-DD 09:00:00'),
				        endDate: moment(date2).format('YYYY-MM-DD 18:00:00'),
				        timePickerIncrement: 30,
				        locale: {
				          format: 'YYYY-MM-DD HH:mm:ss',
				        },
				      });
				    },
				    initCalendar() {
				      $(document).ready(() => {
				        const date = new Date();
				        const d = date.getDate(),
				          m = date.getMonth(),
				          y = date.getFullYear();

				        const { Calendar } = FullCalendar;
				        const calendarEl = document.getElementById('calendar');
				        const containerEl = document.getElementById('external-events');
				        let numClicks = 0;
				        let timeOut;
				        const draggable = new FullCalendar.Draggable(containerEl, {
				          itemSelector: '.external-event',
				          eventData(eventEl) {
				            return {
				              title: eventEl.innerText,
				              backgroundColor: window.getComputedStyle(eventEl, null).getPropertyValue('background-color'),
				              borderColor: window.getComputedStyle(eventEl, null).getPropertyValue('background-color'),
				              textColor: window.getComputedStyle(eventEl, null).getPropertyValue('color'),
				            };
				          },
				        });

				        const calendar = new Calendar(calendarEl, {
				          headerToolbar: {
				            left: 'prev,next today',
				            center: 'title',
				            right: 'dayGridMonth,timeGridWeek,timeGridDay',
				          },
				          themeSystem: 'bootstrap',
				          editable: true,
				          droppable: true,
				          drop: (info) => {
				            $('#maintenance').modal('show');
				            this.setDate(new Date(info.dateStr), new Date(info.dateStr));
				          },
				          dateClick: (info) => {
				            numClicks++;
				            switch (numClicks) {
				              case 2:
				                numClicks = 0;
				                $('#maintenance').modal('show');
				                this.setDate(new Date(info.dateStr), new Date(info.dateStr));
				                break;
				              case 1:
				                timeOut = setTimeout(() => {
				                  numClicks = 0;
				                }, 400);
				                break;
				              default:
				                break;
				            }
				          },
				          eventClick: (info) => {
				            info.el.addEventListener('click', () => {
				              $('#maintenance').modal('show');
				            });
				          },
				        });
				        calendar.render();
				      });
				    },
				  },
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
						chatRoomName: "",
						chatRoomStart: "",
						chatRoomType: ""
					},
					memberId: memberId,
					chatRoomList: [],
					followList: [],
					selectedMemberList: [],
					
					// chatRoomNo에서 가져옴
					text: "",
					chatRoomNo: "",
					roomInfo: {
						chatRoomNo: "",
						chatRoomName: "",
						chatRoomStart: "",
						chatRoomType: "",
						edit: false
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
					const data = { type: 2, chatRoomNo: -2 };
					this.socket.send(JSON.stringify(data));
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
					this.messageList.push(parsedData);
				},
				// 채팅 메인 모달 열기
				showChatMainModal() {
					this.chatRoomList.splice(0);
					this.loadRoomList();
					this.followList.splice(0);
					this.loadFollowList();
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
					this.roomInfo.chatRoomName = "";
					this.roomInfo.chatRoomStart = "";
					this.roomInfo.chatRoomType = "";
					this.roomInfoCopy.chatRoomName = "";
					this.chatMemberList.splice(0);
					this.messageList.splice(0);
					this.chatJoin = "";
					this.chatRoomNo = chatRoomNo;
					this.loadRoomInfo();
					this.loadChatMember();
					this.loadMessage();
					this.getChatJoin();
					this.chatRoomModal = true;
				},
				// 채팅방 모달 닫기
				hideChatRoomModal() {
					this.chatRoomNo = "";
					this.roomInfo.chatRoomNo = "";
					this.roomInfo.chatRoomName = "";
					this.roomInfo.chatRoomStart = "";
					this.roomInfo.chatRoomType = "";
					this.roomInfoCopy.chatRoomName = "";
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
					this.hideCreateRoomModal();
				},
				
				// 채팅방 정보 불러오기
				async loadRoomInfo() {
					const chatRoomNo = this.chatRoomNo;
					const url = "${pageContext.request.contextPath}/chat/chatRoom/chatRoomNo/" + chatRoomNo;
					const resp = await axios.get(url);
					this.roomInfo.chatRoomNo = resp.data.chatRoomNo;
					this.roomInfo.chatRoomName = resp.data.chatRoomName;
					this.roomInfo.chatRoomStart = resp.data.chatRoomStart;
					this.roomInfo.chatRoomType = resp.data.chatRoomType;
					this.roomInfoCopy.chatRoomName = _.cloneDeep(resp.data.chatRoomName);
				},
				// 참여자 정보 불러오기
				async loadChatMember() {
					const chatRoomNo = this.chatRoomNo;
					const url = "${pageContext.request.contextPath}/chat/chatRoom/chatMember/" + chatRoomNo;
					const resp = await axios.get(url);
					this.chatMemberList.push(...resp.data);
				},
				// 메세지 불러오기
				async loadMessage() {
					const chatRoomNo = this.chatRoomNo;
					const url = "${pageContext.request.contextPath}/chat/message/" + chatRoomNo;
					const resp = await axios.get(url);
					for(let i=0; i<resp.data.length; i++) {
						if(resp.data[i].chatMessageTime >= this.chatJoin)
							this.messageList.push(resp.data[i]);
					}
				},
				// 메세지 보내기
				sendMessage() {
					if(this.text.length < 1) return;
					const data = {
							type: 1,
							chatMessageContent: this.text
					};
					this.socket.send(JSON.stringify(data));
					this.clear();
				},
				// 사진 보내기
				async sendPic() {
					const fileInput = document.querySelector('input[type=file]');
					const file = fileInput.files[0];
					const formData = new FormData();
					formData.append("attach", file);
					const url = "${pageContext.request.contextPath}/rest/attachment/upload";
					const resp = await axios.post(url, formData);
					if(resp.data) {
						const data = {
								type: 4, 
								attachmentNo: resp.data.attachmentNo,
								chatMessageContent: "사진 " + resp.data.attachmentNo
						}
						this.socket.send(JSON.stringify(data));
						/*this.clear();*/
						this.fileInput = [];
					}
				},
				// 시간 포멧 설정
				timeFormat(chatMessageTime) {
					return moment(chatMessageTime).format("YYYY-M-D A h:mm");
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
					this.roomInfo.chatRoomName = this.roomInfoCopy.chatRoomName;
					this.roomInfo.edit = false;
				},
				// 채팅방 이름 변경
				async saveRoomName() {
					const url = "${pageContext.request.contextPath}/chat/chatRoom/changeName";
					const data = this.roomInfo;
					const resp = await axios.put(url, data);
					this.loadRoomInfo();
					this.roomInfo.edit = false;
				},
				// 팔로우 목록 불러오기
				async loadFollowList() {
					const url = "${pageContext.request.contextPath}/chat/chatRoom/follow/";
					const resp = await axios.get(url);
					this.followList.push(...resp.data);
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
				}
			},
			computed: {
				memberCount() {
					return this.selectedMemberList.length;
				},
				nameCount() {
					return this.chatRoom.chatRoomName.length;
				},
				filteredFollowList() {
					return this.followList.filter(follow => 
								!this.chatMemberList.some(member => 
									member.memberId === follow.memberId));
				}
			},
			created() {
				if(this.memberId != "" && memberId != ""){
					this.connect();
					this.loadRoomList();
					this.loadFollowList();
				}
			},
			mounted() {
				
			},
			watch: {
				// 채팅방 모달 켜질 때 메세지 입력창으로 커서 이동되게
				chatRoomModal(value) {
					if(value) {
						this.$nextTick(() => {
							this.$refs.messageInput.focus();
						})
					}
				}
			}
		}).mount("#header-area");
	</script>

 
    
</body>
</html>

