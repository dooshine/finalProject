<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>스타링크</title>
    <!-- 폰트어썸 cdn -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
    <!-- tabler 아이콘 -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">
    <!-- jquery cdn -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <!-- 뷰 cdn -->
    <script src="https://unpkg.com/vue@3.2.26"></script>
    <!-- axios -->
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <!-- lodash -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
    <!-- moment -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
    <!-- moment 한국어팩 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/locale/ko.min.js"></script>
    <!-- 부트스트랩 css(공식) -->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
	<!-- sock.js cdn -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>





    <!-- custom 테스트 css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/test.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/custom.css">
    
    <!-- 폰트css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/load.css" />
    <!-- doo-css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/doo.css" />

	
	


    <script>
    	const contextPath = "${pageContext.request.contextPath}";
		const memberId = "${sessionScope.memberId}";
        const memberLevel = "${sessionScope.memberLevel}";
    </script>
    
    <style>
    	@media screen and (max-width:767px) {
		  	.hide-part {
		    	display:none; 
		  	}
    	}
    
    	.profileDummy,
    	.noti,
    	.weez {
    		border-radius: 100%;
    		width: 40px;
    		border: 0.3px solid #c7cbca;
    	}
    	.weez-btn,
    	.noti-btn,
    	.hide-style {
    		margin: 0;
    		padding: 0;
    		background: none;
    		border: none;
    	}
    	.customModal {
    		position: fixed;
    		bottom: 10px;
    		right: 10px;
    		background: white;
    		border: 0.5px solid #c8c8c8;
    		border-radius: 5px;
    		width: 300px;
    		height: 500px;
    		z-index: 999;
    		display: block;
    		
    		/* 스크롤 설정 */
    		overflow-y: initial;
    	}
    	.customModalSmall {
    		position: absolute;
    		bottom: 320px;
    		right: 60px;
    		z-index: 9999;
    		background: white;
    		border: 0.5px solid #c8c8c8;
    		border-radius: 5px;
    		display: block;
    		box-shadow: 0px 0px 5px 2px #e6e8e7;
    		padding: 16px;
    	}
    	.customModalSmall2 {
    		position: absolute;
    		bottom: 395px;
    		right: 60px;
    		z-index: 9999;
    		background: white;
    		border: 0.5px solid #c8c8c8;
    		border-radius: 5px;
    		display: block;
    		box-shadow: 0px 0px 5px 2px #e6e8e7;
    		padding: 16px;
    	}
    	.chatRoomModal,
    	.inviteMemberModal {
    		position: fixed;
    		bottom: 10px;
    		right: 313px;
    		background: white;
    		border: 0.5px solid #c8c8c8;
    		border-radius: 5px;
    		width: 300px;
    		height: 500px;
    		z-index: 999;
    		display: block;
    		
    		/* 스크롤 설정 */
    		overflow-y: initial;
    	}
    	/* 스크롤바 설정*/
		.customModalBody::-webkit-scrollbar {
		    width: 5px;
		}
		/* 스크롤바 막대 설정*/
		.customModalBody::-webkit-scrollbar-thumb {
		    background-color: #c8c8c8;
		    border-radius: 10px;    
		}
		/* 스크롤바 뒷 배경 설정*/
		.customModalBody::-webkit-scrollbar-track {
		    background-color: rgba(0,0,0,0);
		}
    	h2, h3, h4, h5, h6 {
    		margin: 0;
    	}
    	.customModalHeader {
    		padding: 16px;
    		border-bottom: 0.5px solid #dee2e6;
    	}
    	.btn-plus {
    		transform: rotate(45deg);
    	}
    	.customModalBody {
    		padding: 16px;
    		height: 440px;
    		overflow-y: auto;
    		
    		/* 파폭 스크롤 커스텀 */
    		scrollbar-width: thin;
    		scrollbar-color: #c8c8c8 rgba(0,0,0,0);
    	}
    	.short {
    		padding: 16px;
    		height: 330px;
    		overflow-y: auto;
    	}
    	.customModalFooter {
    		padding-top: 8px;
    		padding-left: 16px;
    		padding-right: 16px;
    		padding-bottom: 16px;
    		border-top: 0.5px solid #dee2e6;
    	}
    	.hide-style {
    		font-size: 0.9em;
    	}
    	.ti-message-circle-plus,
    	.ti-message-circle-check,
    	.ti-dots-vertical,
    	.ti-dots {
    		font-size: 22px;
    		color: #7f7f7f;
    	}
    	
    	.ti-user-plus,
		.ti-edit-circle-small,
		.ti-message-circle-off,
		.ti-edit-circle-off, 
		.ti-edit-circle-large {
			font-size: 18px;
			color: #7f7f7f;
		}
		
    	.ti-message-circle-plus:hover,
    	.ti-message-circle-check:hover,
    	.ti-dots-vertical:hover,
    	.ti-dots:hover {
    		color: #404040;
    	}
    	
    	.inviteBtn:hover .ti-user-plus,
		.eidtNameBtn:hover .ti-edit-circle,
		.exitBtn:hover .ti-message-circle-off {
			color: #404040;
		}
    	
    	.newChatRoomBtn[disabled] .ti-message-circle-plus,
    	.newChatRoomBtn[disabled]:hover .ti-message-circle-plus,
    	.confirmNewChatRoomBtn[disabled] .ti-message-circle-check,
    	.confirmNewChatRoomBtn[disabled]:hover .ti-message-circle-check,
    	.roomNameChangeModeBtn[disabled] .ti-edit-circle,
    	.roomNameChangeModeBtn[disabled]:hover .ti-edit-circle,
    	.changeRoomNameBtn[disabled] .ti-dots-vertical .ti-dots,
    	.changeRoomNameBtn[disabled]:hover .ti-dots-vertical .ti-dots,
    	.cancelRenameBtn[disabled] .ti-edit-circle-off,
    	.cancelRenameBtn[disabled]:hover .ti-edit-circle-off,
    	.confirmNameBtn[disabled] .ti-edit-circle-large,
    	.confirmNameBtn[disabled]:hover .ti-edit-circle-large {
    		color: #dee2e6;
    	}
    	.type-box {
    		width: 100%;
    		height: 55px;
    		resize: none;
    		border: none;
    		outline: none;
    		font-size: 0.9em;
    		padding: 0;
    	}
    	.type-box::-webkit-scrollbar {
    		display: none;
    	}
    	.length-alert {
    		font-size: 0.7em;
    		color: #6A53FB;
    	}
    	
    	.changeNameInput {
    		padding: 0;
    		border: none;
    		outline: none;
    		width: 100%;
    		margin-right: 5px;
    	}
		
		.fakeBtn {
			width: 30px;
			height: 30px;
			background: #a698fd;
			border-radius: 100px;
			cursor: pointer;
		}
		
		.fakeBtn:hover {
			background: #6A53FB;
		}
		
		.fakeBtn[disabled] ,
    	.fakeBtn[disabled]:hover {
    		background: #a698fd;
    		cursor: default;
    	}
		
		.ti-photo-up,
		.ti-send {
			color: white;
			font-size: 18px;
		}
		
		.messageBox {
			border: 1.3px solid #6A53FB;
			border-radius: 10px;
			padding-top: 3px;
			padding-bottom: 3px;
			padding-right: 10px;
			padding-left: 10px;
			margin-right:5px;
			font-size: 0.9em;
			max-width: 200px;
		}
		
		.myMessage > .messageBox  {
			border: 1.3px solid #f0eeff;
			background: #f0eeff;
			margin-right: 0;
			margin-left: 5px;
		}
		
		.messageTime {
			font-size: 0.7em;
			color: #7f7f7f;
		}
		
		.ti-x {
			color: #a698fd;
		}
		.deleteMessageBtn:hover .ti-x {
			color: #6A53FB;
		}
		
		.photoMessage {
			width: 200px;
			border-radius: 10px;
			margin-right:5px;
		}
		
		.myMessage > .photoMessage  {
			margin-right: 0;
			margin-left: 5px;
		}
		
		.sysMessage {
			background: #f8f7fc;
			padding-top: 3px;
			padding-bottom: 3px;
			padding-right: 10px;
			padding-left: 10px;
			width: 100%;
			border-radius: 10px;
		}
		
		.sysMsgTime {
			font-size: 0.7em;
			color: #7f7f7f;
		}
		
		.sysMsgContent {
			font-size: 0.8em;
			color: #7f7f7f;
		}
		
		.sysMessageDate {
			display: flex;
			flex-basis: 100%;
			align-items: center;
			color: #7f7f7f;
			font-size: 0.7em;
			margin-bottom: 18px;
			margin-top: 20px;
		}
		.sysMessageDate::before {
			content: "";
			flex-grow: 1;
			background: #dee2e6;
			height: 0.3px;
			font-size: 0;
			line-height: 0px;
			margin-right: 8px;
		}
		.sysMessageDate::after {
			content: "";
			flex-grow: 1;
			background: #dee2e6;
			height: 0.3px;
			font-size: 0;
			line-height: 0px;
			margin-left: 8px;
		}
    </style>
</head>



<body style="background-color: #f5f5f5;">
    <main>
    	<!----------------------------------------------- 헤더 시작 ----------------------------------------------->
        <header>
        	<div id="header-area">
				<nav class="navbar navbar-expand-md navbar-light bg-light">
				  	<div class="container-fluid">
				  		<div class="col-3">
				  			<span>isFocused = {{isFocused}}</span>
					    	<a class="navbar-brand" href="/">STARLINK</a>
					    </div>
				    	<div class="col-6 d-flex collapse navbar-collapse" id="navbarSupportedContent">
				      		<form action="/search" class="d-flex w-100">
				      			<div class="search-box w-100">
					        		<input name="q" class="search-input me-2 w-100" placeholder="STARLINK 검색" type="text">
					        	</div>
				      		</form>
				    	</div>
				    	<div class="col-3 d-flex justify-content-end collapse navbar-collapse">
				    		<!-- 알림버튼 -->
				    		<button class="noti-btn">
								<img class="noti me-2 nav-item hide-part" alt="알림" src="/static/image/notificationIcon.png">
							</button>
							<!-- 위즈버튼 -->
							<button class="weez-btn" @click="showChatMainModal">
								<img class="weez nav-item hide-part" alt="위즈" src="/static/image/dmIcon.png">
							</button>
				    	</div>
				  	</div>
				</nav>
				<!---------------------------------------- 채팅 메인 모달 ---------------------------------------->
				<div class="customModal chatMainModal" v-if="chatMainModal == true">
					<div class="customModalHeader d-flex align-items-center justify-content-between">
						<h5>내 위즈</h5>
						<div class="d-flex justify-content-end">
							<button type="button" class="hide-style pe-3 newChatRoomBtn" @click="showCreateRoomModal">
								<i class="ti ti-message-circle-plus"></i>
							</button>
							<button type="button" class="btn-close" @click="hideChatMainModal"></button>
						</div>
					</div>
					<div class="customModalBody">
						<div class="chatRooms mb-2" v-for="(room, index) in chatRoomList" :key="index">
							<button class="hide-style" @click="showChatRoomModal(index)">
								{{ chatRoomList[index].chatRoomName }}
							</button>
						</div>
					</div>
				</div>
				<!---------------------------------------- 채팅 메인 모달 ---------------------------------------->
				<!--------------------------------------- 채팅방 생성 모달 ---------------------------------------->
				<div class="customModal createRoomModal" v-if="createRoomModal == true">
					<div class="customModalHeader d-flex align-items-center justify-content-between">
						<h5>새 위즈 만들기</h5>
						<div class="d-flex justify-content-end">
							<button type="button" class="hide-style pe-3 confirmNewChatRoomBtn" @click="createChatRoom"
								:disabled="(selectedMemberList.length === 0 && nameCount < 1) || (selectedMemberList.length >= 3 && (nameCount === 0 || nameCount > 10))">
								<i class="ti ti-message-circle-check"></i>
							</button>
							<button type="button" class="btn-close" @click="hideCreateRoomModal"></button>
						</div>
					</div>
					<div class="customModalBody">
						<div>
							<div class="form-floating mb-3" v-if="memberCount > 2">
		  						<input type="text" class="form-control form-control-sm" id="chatRoomNameInput" placeholder="채팅방이름" 
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
				<!--------------------------------------- 채팅방 생성 모달 ---------------------------------------->
				<!--------------------------------------- 채팅방 모달 ---------------------------------------->
				<div class="customModal chatRoomModal" v-if="chatRoomModal == true">
					<!-- 헤더 -->
					<div class="customModalHeader d-flex align-items-center">
						<div class="d-flex justify-content-between w-100">
							<!-- 채팅방 이름(갠톡일 때) -->
							<h5 v-if="roomInfo.chatRoomType == 'P'">상대방 아이디</h5>
							<!-- 채팅방 이름(단톡일 때) -->
							<div v-if="roomInfo.chatRoomType == 'G'">
								<div v-if="roomInfo.edit == true" class="d-flex align-items-center justify-content-between w-100">
									<!-- 이름 변경 입력창 -->
									<input v-model="roomInfo.chatRoomName" @input="roomInfo.chatRoomName = $event.target.value" @keyup.enter="saveRoomName" class="changeNameInput">
									<!-- 이름 변경 버튼 -->
									<div class="d-flex justify-content-end">
										<!-- 이름변경 저장 버튼 -->
										<button type="button" @click="saveRoomName" class="hide-style confirmNameBtn me-2" 
											:disabled="(roomInfo.chatRoomName.length < 1 || roomInfo.chatRoomName.length > 10) || roomInfo.chatRoomName == roomInfoCopy.chatRoomName">
											<i class="ti ti-edit-circle ti-edit-circle-large"></i>
										</button>
										<!-- 이름 변경 취소 버튼 -->
										<button type="button" @click="cancelChange" class="hide-style cancelRenameBtn me-2">
											<i class="ti ti-edit-circle-off"></i>
										</button>
									</div>
								</div>
								<div v-else>
									<h5>{{ roomInfo.chatRoomName }}</h5>
								</div>
							</div>
							<div class="d-flex justify-content-end">
								<!-- 메뉴 열기 버튼 -->
								<button type="button" @click="showChatMenuModal" v-if="chatMenuModal == false && roomInfo.edit == false"
										class="hide-style changeRoomNameBtn d-flex align-items-end pe-2">
									<i class="ti ti-dots-vertical"></i>
								</button>
								<!-- 메뉴 닫기 버튼 -->
								<button type="button" @click="hideChatMenuModal" v-if="chatMenuModal == true && roomInfo.edit == false"
										class="hide-style changeRoomNameBtn d-flex align-items-end pe-2">
									<i class="ti ti-dots"></i>
								</button>
								<!-- 닫기 버튼 -->
								<button type="button" class="btn-close" @click="hideChatRoomModal"></button>
							</div>
						</div>
					</div>
					<!-- 바디 -->
					<div class="customModalBody short message-wrapper" ref="messageWrapper">
						<div class="message" style="margin-top: 10px;" v-for="(message, index) in messageList" :key="index">
							<!-- 사용자가 보내는 메세지일 때 -->
							<div v-if="message.chatMessageType === 1 || message.chatMessageType === 4">
								<!-- 상대방이 보낸 메세지일 때 -->
								<div v-if="message.memberId != memberId">
									<span style="font-size: 0.9em;" v-if="!sameTime(index)">{{ message.memberId }}</span>
									<div class="d-flex align-items-end">
										<!-- 텍스트 메세지일 때 -->
										<div v-if="message.attachmentNo === 0" class="messageBox">{{ message.chatMessageContent }}</div>
										<!-- 이미지 메세지일 때 -->
										<img class="photoMessage" v-if="message.attachmentNo != 0" 
												:src="'${pageContext.request.contextPath}/download?attachmentNo=' + message.attachmentNo">
										<div class="messageTime" v-if="displayTime(index)">{{ timeFormat(message.chatMessageTime) }}</div>
									</div>
								</div>
								<!-- 내가 보낸 메세지일 때 -->
								<div v-else>
									<div class="d-flex align-items-end justify-content-end myMessage" 
											@mouseover="showDeleteButton(index)" @mouseleave="hideDeleteButton(index)">
										<!-- 메세지 삭제버튼 -->
										<button v-if="showDeleteButtonIndex === index" @click="deleteMessage(index)" 
											class="hide-style d-flex align-items-end deleteMessageBtn" style="padding-bottom: 0.5px; margin-right: 5px;">
											<i class="ti ti-x"></i>
										</button>
										<div class="messageTime" v-if="displayTime(index)">{{ timeFormat(message.chatMessageTime) }}</div>
										<!-- 텍스트 메세지일 때 -->
										<div v-if="message.attachmentNo === 0" class="messageBox">{{ message.chatMessageContent }}</div>
										<!-- 이미지 메세지일 때 -->
										<img class="photoMessage myMessage" v-if="message.attachmentNo != 0" 
												:src="'${pageContext.request.contextPath}/download?attachmentNo=' + message.attachmentNo">
									</div>
								</div>
							</div>
							<!-- 시스템 메세지일 때 -->
							<div v-if="message.chatMessageType === 5 || message.chatMessageType === 6" class="sysMessage">
								<div class="sysMsgTime text-center">{{ timeFormatDetailed(message.chatMessageTime) }}</div>
								<div class="sysMsgContent text-center">{{ message.chatMessageContent }}</div>
							</div>
							<!-- 날짜 구분 메세지일 때 -->
							<div v-if="message.chatMessageType === 10" class="sysMessageDate text-center">{{ timeFormatDetailed(message.chatMessageTime) }}</div>
						</div>
						
						<!-- 메뉴 모달 -->
						<div v-if="chatRoomModal == true && chatMenuModal == true">
							<!-- 단톡일 때 -->
							<div v-if="roomInfo.chatRoomType == 'G'" class="customModalSmall">
								<button type="button" @click="showInviteMemberModal" class="hide-style inviteBtn d-flex align-items-center mb-3 w-100">
									<i class="ti ti-user-plus pe-2"></i>
									초대
								</button>
								<button type="button" @click="changeRoomName" class="hide-style eidtNameBtn d-flex align-items-center mb-3 w-100">
									<i class="ti ti-edit-circle ti-edit-circle-small pe-2"></i>
									이름변경
								</button>
								<button type="button" @click="leaveRoom" class="hide-style exitBtn d-flex align-items-center w-100">
									<i class="ti ti-message-circle-off pe-2"></i>
									나가기
								</button>
							</div>
							<!-- 갠톡일 때 -->
							<div v-if="roomInfo.chatRoomType == 'P'" class="customModalSmall2">
								<button type="button" @click="leaveRoom" class="hide-style exitBtn d-flex align-items-center w-100">
									<i class="ti ti-message-circle-off pe-2"></i>
									나가기
								</button>
							</div>
						</div>
					</div>
					<!-- 푸터 -->
					<div class="customModalFooter">
						<div class="type-area d-flex">
							<textarea v-model="text" ref="messageInput" @input="text = $event.target.value" @keyup.enter="sendMessage" class="type-box"></textarea>
						</div>
						<div class="footer-area d-flex align-items-center justify-content-between mt-1">
							<div style="width: 150px;">
								<div class="length-alert" v-show="text.length > 300">
									300자 이하로 입력하세요.
								</div>
							</div>
							<div class="button-area d-flex justify-content-end">
								<label class="fakeBtn d-flex align-items-center justify-content-center me-2">
				            		<i class="ti ti-photo-up"></i>
				            		<input class="form-control d-none picInput" type="file" accept=".png, .jpg, .gif" @change="sendPic" />
				            	</label>
				            	<button type="button" @click="sendMessage" :disabled="text.length < 1 || text.length > 300" 
				            				class="hide-style fakeBtn d-flex align-items-center justify-content-center">
				            		<i class="ti ti-send" style="margin-right: 2px; margin-top: 1px;"></i>
				            	</button>
							</div>
						</div>
					</div>
				</div>
				<!--------------------------------------- 채팅방 모달 ---------------------------------------->
				<!---------------------------------------- 초대 모달 ---------------------------------------->
				<div class="customModal inviteMemberModal" v-if="inviteMemberModal == true">
					<div class="customModalHeader d-flex align-items-center justify-content-between">
						<h5>새 친구 추가</h5>
						<div class="d-flex justify-content-end">
							<button type="button" class="hide-style pe-3 confirmNewChatRoomBtn" @click="inviteMember"
								:disabled="selectedMemberList.length === 0">
								<i class="ti ti-message-circle-check"></i>
							</button>
							<button type="button" class="btn-close" @click="hideInviteMemberModal"></button>
						</div>
					</div>
					<div class="customModalBody">
						<div>
							<label class="d-flex justify-content-between" v-for="(follow, index) in filteredFollowList">
						    	{{ follow.memberId }}
						    	<input type="checkbox" v-model="selectedMemberList" :value="follow.memberId">
							</label>
						</div>
					</div>
				</div>
				<!---------------------------------------- 초대 모달 ---------------------------------------->
			
        	<!----------------------------------------------- 헤더 끝 ----------------------------------------------->
            
				<div class="row">
					<!-- (개발)로그인 버튼 -->
					<div class="col-4">
						<button><a href="/dev/login?memberId=testuser1">testuser1</a></button>
						<button><a href="/dev/login?memberId=testuser2">testuser2</a></button>
						<button><a href="/dev/login?memberId=testuser3">testuser3</a></button>
						<button><a href="/dev/login?memberId=adminuser1">adminuser3</a></button>
					</div>
					<div class="offset-5 col-3">
						<c:if test="${memberId == null}">
							<a href="${pageContext.request.contextPath}/member/login">로그인</a>
							<a href="${pageContext.request.contextPath}/member/join">회원가입</a>
						</c:if>
						<c:if test="${memberId != null}">
							<a href="#" @click="logout">로그아웃</a>
							<a href="${pageContext.request.contextPath}/member/mypage">마이페이지</a>
						</c:if>
						<c:if test="${memberLevel == '관리자'}">
							<a href="${pageContext.request.contextPath}/admin/">관리자 페이지</a>
						</c:if>
					</div>
	            </div>
            </div>
        </header>
          <hr>

        <section class="container-fluid">
            <div class="row">
                <div class="col-3 d-flex left-aside">
                    <jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
                </div>
                <div class="col-6 article container-fluid py-5" style="padding:0px;">
                