<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
   
    <!-- favicon -->
	<link rel="icon" href="/static/image/favicon.ico">
    <title>스타링크</title>
    
    
    <!-- 폰트css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/load.css" />
    
    <!-- pretendard -->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
    
  
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
	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/reset.css">

    <!-- custom 테스트 css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/test.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/component.css">
    <!-- doo-css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/doo.css" />

	
	<!-- full calendar css -->
	<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css' rel='stylesheet'>
	<link href='https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css' rel='stylesheet'>
	
	<!-- 채팅 css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/chat.css" />
    
    <!-- fullcalendar cdn -->
	<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
    <!-- 캘린더 스크립트 -->
	<script src= "${pageContext.request.contextPath}/static/js/calendar.js"></script>
	<!-- 캘린더 css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/calendar.css" />


    <script>
    	const contextPath = "${pageContext.request.contextPath}";
		const memberId = "${sessionScope.memberId}";
        const memberLevel = "${sessionScope.memberLevel}";
    </script>
    
    <style>
    	i {
    		font-family:  "Font Awesome 6 Free"  !important;
    	}
    	
    	nav.navbar {
    		position: fixed;
			width: 100%;
    		top: 0;
    		z-index: 999;
    	}
    	#aside-bar {
			position: fixed; 
			top:90px; 
			width: 25%;
			height: 90%;
		}
    	@media screen and (max-width:992px) {
		  	#calendar {
		  		display: none;
		  	}
			.col-3.calendar-area {
				width: 0%;
			}
			.col-6.article {
				width: 85%;
			}
			.col-3.left-aside {
				width: 15%;
			}
			#aside-bar {
				width: 15%;
			}

			.nav .aside-name-tag {
				/* font-size: 0px; */
				display: none;
		  	}
			.nav img {
				margin-left: 0px !important;
			}
			.nav a {
				text-align: center;
			}
    	}
		@media screen and (max-width:640px){
			#header-area .navbar .container-fluid .col-3 {
				width: 40%;
			}
			#header-area .navbar .container-fluid .col-6 {
				width: 20%;
			}
			
		}
    	/*@media screen and (max-width:767px) {
		  	.hide-part {
		    	display:none; 
		  	}
    	}*/
    	/*@media screen and (max-width:667px) {
		  	.col-6 {
		  		width: 306px;
		  	}
		  	.col-3 {
		  		width: 153px;
		  	}
    	}*/
    
    	.profileDummy,
    	.noti,
    	.weez {
    		border-radius: 100%;
    		width: 40px;
    		border: 0.3px solid #c7cbca;
    	}
    	.user-btn,
    	.weez-btn,
    	.noti-btn,
    	.hide-style {
    		margin: 0;
    		padding: 0;
    		background: none;
    		border: none;
    	}
		.container-fluid {
			padding-left: 0px;
			padding-right: 0px;
		}
		
		/* chat.css에 있는 내용인데 왜인지 안 먹어서 여기다가도 빼둠 */
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
    </style>
</head>



<body style="background-color: #f5f5f5;">
    <main>
    	<!----------------------------------------------- 헤더 시작 ----------------------------------------------->
        <header>
   
        	<div id="header-area" style="position: relative;">
				<nav class="navbar navbar-light back-white px-4" style="box-shadow: 0px 3px 4px rgba(3, 21, 17, 0.1);">
				  	<div class="container-fluid">
				  		<div class="col-3">
					    	<a class="navbar-brand" href="/"><img src="/static/image/logo.png" style="width:130px;"></a>
					    	<!-- <a href="dev/loading">(임시)로딩</a> -->
					    </div>
				    	<div class="col-6 d-flex px-3" id="navbarSupportedContent">
				      		<form action="/search/post" class="d-flex w-100" method="get">
				      			<div class="search-box w-100">
					        		<input name="q" class="search-input me-2 w-100" placeholder="STARLINK 검색" type="text" value="${param.q}">
					        	</div>
				      		</form>
				    	</div>
				    	<div class="col-3 d-flex justify-content-end" id="header-buttons">
				    		<!-- 알림버튼 -->
				    		<button class="noti-btn me-2">
								<img class="noti nav-item hide-part" alt="알림" src="/static/image/notificationIcon.png">
							</button>
							<!-- 위즈버튼 -->
							<button class="weez-btn me-2" @click="showChatMainModal" style="position: relative;">
								<img class="weez nav-item hide-part" alt="위즈" src="/static/image/dmIcon.png">
								<!-- 새 채팅이 있는 경우 새 채팅 알림 마크 -->
								<div v-if="newChatNoti === true" class="notiMark"></div>
							</button>
							<!-- 유저버튼 -->
							<button class="user-btn d-flex align-items-center" @click="goToLoginPage()">
								<img class="weez nav-item hide-part" alt="유저" src="/static/image/profileDummy.png">
							</button>
							<!-- <div class="offset-5 col-3">
					<c:if test="${memberId == null}">
						<a href="${pageContext.request.contextPath}/member/login">로그인</a>
						<a href="${pageContext.request.contextPath}/member/join">회원가입</a>
					</c:if>
					<c:if test="${memberId != null}">
						<a href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
						<a href="${pageContext.request.contextPath}/member/mypage">마이페이지</a>
					</c:if>
					<c:if test="${memberLevel == '관리자'}">
						<a href="${pageContext.request.contextPath}/admin/">관리자 페이지</a>
					</c:if>
				</div> -->
				    	</div>
				  	</div>
				</nav>
				<!---------------------------------------- 채팅 메인 모달 ---------------------------------------->
				<div class="customModal chatMainModal" v-if="chatMainModal == true">
					<div class="customModalHeader d-flex align-items-center justify-content-between">
						<h5>내 위즈</h5>
						<div class="d-flex justify-content-end align-items-center">
							<button v-if="memberId.length > 0" type="button" @click="showCreateRoomModal"
										class="hide-style pe-3 newChatRoomBtn d-flex align-items-center justify-content-center">
								<i class="ti ti-message-circle-plus"></i>
							</button>
							<button type="button" class="btn-close" @click="hideChatMainModal"></button>
						</div>
					</div>
					<div class="customModalBody">
						<div v-if="memberId.length < 1" class="d-flex align-items-center justify-content-center" style="height: 408px;">
							<div>
								<h5 class="text-center mb-2">🙌</h5>
								<h5 class="text-center mb-2">로그인하고</h5>
								<h5 class="text-center">친구들과 대화를 시작해보세요!</h5>
								<button type="button" class="custom-btn btn-purple1 btn-round w-100 mt-3" @click="login">
									로그인하러 가기
								</button>
							</div>
						</div>
						<div v-else>
							<div v-if="chatRoomList.length < 1" class="d-flex align-items-center justify-content-center" style="height: 408px;">
								<div>
									<h5 class="text-center mb-2">🙌</h5>
									<h5 class="text-center mb-2">새 위즈를 만들고</h5>
									<h5 class="text-center">친구들과 대화를 시작해보세요!</h5>
								</div>
							</div>
							<div class="chatRooms mb-2" v-if="chatRoomList.length > 0" v-for="(room, index) in chatRoomList" :key="index">
								<!-- 채팅방 이름(단톡일 때: 지정한 이름 표시) -->
								<div v-if="chatRoomList[index].chatRoomType == 'G'">
									<button @click="showChatRoomModal(index)" class="hide-style w-100 mb-3">
										<div class="d-flex align-items-center w-100">
											<div class="col-3 d-flex justify-content-center align-items-center" 
												style="height: 45px; width: 45px; background-color: #a294f9; border-radius: 100px; color: white; font-size: 1.3em;">
												{{ chatRoomList[index].chatRoomName1[0] }}
											</div>
											<div class="col-9 ms-3">
												<div class="d-flex align-items-center mb-2">
													<div class="text-start" :title="chatRoomList[index].chatRoomName1">
														<h6>{{ chatRoomList[index].chatRoomName1 }}</h6>
													</div>
													<!-- 새 메세지 알림 표시 -->
													<div v-if="chatRoomList[index].newChat === true" class="notiMarkChat ms-2"></div>
												</div>
												<div class="sysMsgContent d-flex justify-content-between">
													<div>마지막 메세지</div>
													<div>·</div>
													<div>{{ getTimeDifference(chatRoomList[index].chatRoomLast) }}</div>
												</div>
											</div>
										</div>
									</button>
								</div>
								<!-- 채팅방 이름(갠톡일 때: 상대방 이름 표시) -->
								<div v-if="chatRoomList[index].chatRoomType == 'P'">
									<!-- 갠톡 채팅방 이름 1 -->
									<button v-if="chatRoomList[index].chatRoomName1 != memberId" 
												@click="showChatRoomModal(index)" class="hide-style w-100 mb-3">
										<div class="d-flex align-items-center mb-2">
											<div class="col-3 d-flex justify-content-center align-items-center" style="height: 45px; width: 45px;">
												<img :src="findMemberByIdInMain(index).profileSrc" class="profileImg" style="height: 45px; width: 45px;">
											</div>
											<div class="col-9 ms-3">
												<div class="d-flex align-items-center mb-2">
													<div class="text-start d-flex align-items-baseline" style="max-width: 180px; overflow: hidden;">
														<div class="me-2 w-100" style="max-width: 120px">
															<h6 class="chatRoomName" style="max-width: 120px" :title="findMemberByIdInMain(index).memberNick">
																{{ findMemberByIdInMain(index).memberNick }}
															</h6>
														</div>
														<div class="sysMsgContent" :title="findMemberByIdInMain(index).memberId">
															@{{ findMemberByIdInMain(index).memberId }}
														</div>
													</div>
													<!-- 새 메세지 알림 표시 -->
													<div v-if="chatRoomList[index].newChat === true" class="notiMarkChat ms-2"></div>
												</div>
												<div class="sysMsgContent d-flex justify-content-between">
													<div>마지막 메세지</div>
													<div>·</div>
													<div>{{ getTimeDifference(chatRoomList[index].chatRoomLast) }}</div>
												</div>
											</div>
										</div>
									</button>
									<!-- 갠톡 채팅방 이름 2 -->
									<button v-if="chatRoomList[index].chatRoomName2 != memberId" 
												@click="showChatRoomModal(index)" class="hide-style w-100 mb-3">
										<div class="d-flex align-items-center mb-2 chatRoomName">
											<div class="col-3 d-flex justify-content-center align-items-center" style="height: 45px; width: 45px;">
												<img :src="findMemberByIdInMain(index).profileSrc" class="profileImg" style="height: 45px; width: 45px;">
											</div>
											<div class="col-9 ms-3">
												<div class="d-flex align-items-center mb-2">
													<div class="text-start d-flex align-items-baseline" style="max-width: 180px; overflow: hidden;">
														<div class="me-2 w-100" style="max-width: 120px">
															<h6 class="chatRoomName" style="max-width: 120px" :title="findMemberByIdInMain(index).memberNick">
																{{ findMemberByIdInMain(index).memberNick }}
															</h6>
														</div>
														<div class="sysMsgContent" :title="findMemberByIdInMain(index).memberId">
															@{{ findMemberByIdInMain(index).memberId }}
														</div>
													</div>
													<!-- 새 메세지 알림 표시 -->
													<div v-if="chatRoomList[index].newChat === true" class="notiMarkChat ms-2"></div>
												</div>
												<div class="sysMsgContent d-flex justify-content-between">
													<div>마지막 메세지</div>
													<div>·</div>
													<div>{{ getTimeDifference(chatRoomList[index].chatRoomLast) }}</div>
												</div>
											</div>
										</div>
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!---------------------------------------- 채팅 메인 모달 ---------------------------------------->
				<!--------------------------------------- 채팅방 생성 모달 ---------------------------------------->
				<div class="customModal createRoomModal" v-if="createRoomModal == true">
					<div class="customModalHeader d-flex align-items-center justify-content-between">
						<h5>새 위즈 만들기</h5>
						<div class="d-flex justify-content-end align-items-center">
							<button type="button" class="hide-style pe-3 confirmNewChatRoomBtn d-flex align-items-center justify-content-center"
								@click="createChatRoom"
								:disabled="(selectedMemberList.length === 0 && nameCount < 1) || 
											(selectedMemberList.length >= 2 && (nameCount < 1 || nameCount > 20)) || 
											selectedMemberList.length > 49">
								<i class="ti ti-message-circle-check"></i>
							</button>
							<button type="button" class="btn-close" @click="hideCreateRoomModal"></button>
						</div>
					</div>
					<div class="customModalBody">
						<div v-if="followList.length < 1" class="d-flex align-items-center justify-content-center" style="height: 408px;">
							<div>
								<h5 class="text-center mb-2">👋<h5>
								<h5 class="text-center mb-2">새 친구를 팔로우하고</h5>
								<h5 class="text-center">대화를 시작해보세요!</h5>
							</div>
						</div>
						<div v-if="followList.length > 0">
							<div class="form-floating mb-3" v-if="memberCount > 1">
		  						<input type="text" class="form-control form-control-sm" id="chatRoomNameInput" placeholder="채팅방이름" 
		  											v-model="chatRoom.chatRoomName1" @input="chatRoom.chatRoomName1 = $event.target.value">
							  	<label for="chatRoomNameInput">채팅방 이름</label>
							</div>
							<!-- 팔로우 목록 -->
							<label v-for="(follow, index) in followProfileList" class="w-100 mb-3">
								<div class="d-flex w-100">
									<div class="d-flex align-items-center col-9">
										<div class="me-3">
											<img :src="follow.profileSrc" class="profileImg" style="height: 45px; width: 45px;">
										</div>
										<div>
											<div style="font-size: 0.95em;">{{ follow.memberNick }}</div>
											<div style="font-size: 0.9em; color: #7f7f7f;">@{{ follow.memberId }}</div>
										</div>
									</div>
									<div class="col-3 d-flex justify-content-end">
				    					<input type="checkbox" v-model="selectedMemberList" :value="follow">
				    				</div>
				    			</div>
							</label>
						</div>
					</div>
				</div>
				<!------------------------------------- 채팅방 생성 모달 -------------------------------------->
				<!--------------------------------------- 채팅방 모달 ---------------------------------------->
				<div class="customModal chatRoomModal" v-if="chatRoomModal == true">
					<!-- 헤더 -->
					<div class="customModalHeader d-flex align-items-center">
						<div class="d-flex justify-content-between w-100">
							<!-- 채팅방 이름(갠톡일 때: 상대방 이름 표시) -->
							<div v-if="roomInfo.chatRoomType == 'P'">
								<h5>{{ findMemberByIdInRoom().memberNick }}</h5>
								<!-- <h5 v-if="roomInfo.chatRoomName2 != memberId">{{ roomInfo.chatRoomName2 }}</h5> -->
							</div>
							<!-- 채팅방 이름(단톡일 때: 지정한 채팅방 이름 표시) -->
							<div v-if="roomInfo.chatRoomType == 'G'">
								<!-- 채팅방 이름 변경 모드 -->
								<div v-if="roomInfo.edit == true" class="d-flex align-items-center justify-content-between w-100">
									<!-- 이름 변경 입력창 -->
									<input v-model="roomInfo.chatRoomName1" @keyup.enter="saveRoomName" 
										class="changeNameInput" @input="roomInfo.chatRoomName1 = $event.target.value" >
									<!-- 이름 변경 버튼 -->
									<div class="d-flex justify-content-end">
										<!-- 이름변경 저장 버튼 -->
										<button type="button" @click="saveRoomName" class="hide-style confirmNameBtn me-2 d-flex align-items-center justify-content-center" 
											:disabled="(roomInfo.chatRoomName1.length < 1 || roomInfo.chatRoomName1.length > 20) || roomInfo.chatRoomName1 == roomInfoCopy.chatRoomName1">
											<i class="ti ti-edit-circle ti-edit-circle-large"></i>
										</button>
										<!-- 이름 변경 취소 버튼 -->
										<button type="button" @click="cancelChange" class="hide-style cancelRenameBtn me-2 d-flex align-items-center justify-content-center">
											<i class="ti ti-edit-circle-off"></i>
										</button>
									</div>
								</div>
								<!-- 채팅방 이름 -->
								<div v-else style="max-width: 200px;">
									<h5 class="chatRoomNameDiv" :title="roomInfo.chatRoomName1">
										{{ roomInfo.chatRoomName1 }}
									</h5>
								</div>
							</div>
							<div class="d-flex justify-content-end align-items-center">
								<!-- 메뉴 열기 버튼 -->
								<button type="button" @click="showChatMenuModal" v-if="chatMenuModal == false && roomInfo.edit == false"
										class="hide-style changeRoomNameBtn d-flex align-items-end pe-2 d-flex align-items-center justify-content-center">
									<i class="ti ti-dots-vertical"></i>
								</button>
								<!-- 메뉴 닫기 버튼 -->
								<button type="button" @click="hideChatMenuModal" v-if="chatMenuModal == true && roomInfo.edit == false"
										class="hide-style changeRoomNameBtn d-flex align-items-end pe-2" style="padding-top: 2px;">
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
									<!-- 프로필 영역 -->
									<a class="d-flex align-items-center link-to-profile" :href="'${pageContext.request.contextPath}/member/mypage/' + findMemberById(index).memberId">
										<img :src="findMemberById(index).profileSrc" v-if="!sameTime(index)" 
											class="profileImg me-2" style="height: 30px; width: 30px;">
										<span style="font-size: 0.8em;" v-if="!sameTime(index)" style="margin: 0;">
											{{ findMemberById(index).memberNick }}
										</span>
									</a>
									<!-- 메세지 영역 -->
									<div class="d-flex align-items-end" style="margin-left: 36.5px;">
										<!-- 텍스트 메세지일 때 -->
										<div v-if="message.attachmentNo === 0" class="messageBox">{{ message.chatMessageContent }}</div>
										<!-- 이미지 메세지일 때 -->
										<img class="photoMessage" v-if="message.attachmentNo != 0" @load="scrollBottom" @click="setModalImgURL(index)"
												data-bs-target="#image-modal-chat" data-bs-toggle="modal"
												:src="'${pageContext.request.contextPath}/download?attachmentNo=' + message.attachmentNo" >
										<div class="messageTime" v-if="displayTime(index)">{{ timeFormat(message.chatMessageTime) }}</div>
									</div>
								</div>
								<!-- 내가 보낸 메세지일 때 -->
								<div v-else>
									<div class="d-flex align-items-end justify-content-end myMessage" 
											@mouseover="showDeleteButton(index)" @mouseleave="hideDeleteButton(index)">
										<!-- 메세지 삭제버튼 -->
										<button v-if="showDeleteButtonIndex === index" @click="showDeleteMsgAlert(index)" 
											class="hide-style d-flex align-items-end deleteMessageBtn" style="padding-bottom: 1px; margin-right: 5px;">
											<i class="ti ti-x"></i>
										</button>
										<div class="messageTime" v-if="displayTime(index)">{{ timeFormat(message.chatMessageTime) }}</div>
										<!-- 텍스트 메세지일 때 -->
										<div v-if="message.attachmentNo === 0" class="messageBox">{{ message.chatMessageContent }}</div>
										<!-- 이미지 메세지일 때 -->
										<img class="photoMessage myMessage" v-if="message.attachmentNo != 0" @load="scrollBottom"  @click="setModalImgURL(index)"
												data-bs-target="#image-modal-chat" data-bs-toggle="modal"
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
								<button type="button" @click="showMemberListModal" class="hide-style memberListBtn d-flex align-items-center mb-3 w-100">
									<i class="ti ti-users-group pe-2"></i>
									참여자
								</button>
								<button type="button" @click="showInviteMemberModal" class="hide-style inviteBtn d-flex align-items-center mb-3 w-100">
									<i class="ti ti-user-plus pe-2"></i>
									초대
								</button>
								<button type="button" @click="changeRoomName" class="hide-style eidtNameBtn d-flex align-items-center mb-3 w-100">
									<i class="ti ti-edit-circle ti-edit-circle-small pe-2"></i>
									이름변경
								</button>
								<button type="button" @click="showLeaveRoomAlert" class="hide-style exitBtn d-flex align-items-center w-100">
									<i class="ti ti-message-circle-off pe-2"></i>
									나가기
								</button>
							</div>
							<!-- 갠톡일 때 -->
							<div v-if="roomInfo.chatRoomType == 'P'" class="customModalSmall2">
								<button type="button" @click="showLeaveRoomAlert" class="hide-style exitBtn d-flex align-items-center w-100">
									<i class="ti ti-message-circle-off pe-2"></i>
									나가기
								</button>
							</div>
						</div>
						<!-- 참여자 리스트 모달 -->
						<div v-if="chatRoomModal == true && memberListModal == true" class="customModal chatRoomModal">
							<div class="customModalHeader d-flex justify-content-between">
								<div class="d-flex align-items-end">
									<h5>참여자</h5>
									<span class="sysMsgContent ms-2">{{ chatMemberList.length }}명</span>
								</div>
								<button type="button" class="btn-close" @click="hideMemberListModal"></button>
							</div>
							<!-- 참여자 목록 -->
							<div class="customModalBody">
								<div v-for="(member, index) in chatMemberList" class="w-100 mb-3 d-flex w-100">
									<a class="d-flex align-items-center col-9 link-to-profile" 
											:href="'http://localhost:8080/member/mypage/' + member.memberId">
										<div class="me-3">
											<img :src="member.profileSrc" class="profileImg" style="height: 45px; width: 45px;">
										</div>
										<div>
											<div style="font-size: 0.95em;">{{ member.memberNick }}</div>
											<div style="font-size: 0.9em; color: #7f7f7f;">@{{ member.memberId }}</div>
										</div>
									</a>
								</div>
							</div>
						</div>
						<!-- 채팅방 나가기 경고 모달 -->
				        <div v-if="chatRoomModal == true && leaveRoomAlert == true" class="custom-modal leaveRoomAlert">
					        <div class="custom-modal-body">
					        	<div class="text-center mb-3">
					        		<i class="ti ti-alert-triangle"></i>
					        	</div>
					        	<div class="text-center">채팅방을 나가면</div>
					        	<div class="text-center">메세지가 모두 삭제됩니다.</div>
					        	<div class="text-center">채팅방을 나가시겠습니까?</div>
					        	<div class="d-flex justify-content-center mt-4">
					        		<button class="custom-btn btn-round btn-purple1-secondary me-2 w-100" @click="leaveRoom">나가기</button>
					        		<button class="custom-btn btn-round btn-purple1 w-100"  @click="hideLeaveRoomAlert">취소</button>
					        	</div>
					        </div>
					    </div>
					    <!-- 메세지 삭제 경고 모달 -->
				        <div v-if="chatRoomModal == true && deleteMsgAlert == true" class="custom-modal deleteMsgAlert">
					        <div class="custom-modal-body">
					        	<div class="text-center mb-3">
					        		<i class="ti ti-alert-triangle"></i>
					        	</div>
					        	<div class="text-center">위즈의 모든 참여자에게</div>
					        	<div class="text-center">메세지가 삭제됩니다.</div>
					        	<div class="d-flex justify-content-center mt-4">
					        		<button class="custom-btn btn-round btn-purple1-secondary me-2 w-100" @click="deleteMessage(index)">삭제</button>
					        		<button class="custom-btn btn-round btn-purple1 w-100" @click="hideDeleteMsgAlert">취소</button>
					        	</div>
					        </div>
					    </div>
					    <!-- 20메가 이상인 이미지 업로드 금지 모달 -->
				        <div v-if="chatRoomModal == true && fileSizeAlert == true" class="custom-modal fileSizeAlert">
					        <div class="custom-modal-body">
					        	<div class="text-center mb-3">
					        		<i class="ti ti-alert-triangle"></i>
					        	</div>
					        	<div class="text-center">20MB 미만의 사진만 전송할 수 있습니다.</div>
					        	<div class="d-flex justify-content-center mt-4">
					        		<button class="custom-btn btn-round btn-purple1 w-100" @click="hideFileSizeAlert">확인</button>
					        	</div>
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
				            		<!-- d-none -->
				            		<input class="form-control picInput d-none" type="file" accept=".png, .jpg, .gif" @change="sendPic" />
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
						<div class="d-flex justify-content-end align-items-center">
							<button type="button" class="hide-style pe-3 confirmNewChatRoomBtn d-flex align-items-center" @click="inviteMember"
										:disabled="selectedMemberList.length === 0 || selectedMemberList.length + chatMemberList.length > 50">
								<i class="ti ti-message-circle-check"></i>
							</button>
							<button type="button" class="btn-close" @click="hideInviteMemberModal"></button>
						</div>
					</div>
					<div class="customModalBody">
						<!-- 더 초대할 수 있는 팔로워가 없을 때 -->
						<div v-if="filteredFollowList.length < 1" class="d-flex align-items-center justify-content-center" style="height: 408px;">
							<div>
								<h5 class="text-center mb-2">👀</h5>
								<h5 class="text-center mb-2">더 초대할 수 있는 친구가 없어요.</h5>
							</div>
						</div>
						<!-- 팔로우 목록 -->
						<label v-if="filteredFollowList.length > 0" v-for="(follow, index) in filteredFollowList" class="w-100 mb-3">
							<div class="d-flex w-100">
								<div class="d-flex align-items-center col-9">
									<div class="me-3">
										<img :src="follow.profileSrc" class="profileImg" style="height: 45px; width: 45px;">
									</div>
									<div>
										<div style="font-size: 0.95em;">{{ follow.memberNick }}</div>
										<div style="font-size: 0.9em; color: #7f7f7f;">@{{ follow.memberId }}</div>
									</div>
								</div>
								<div class="col-3 d-flex justify-content-end">
			    					<input type="checkbox" v-model="selectedMemberList" :value="follow">
			    				</div>
			    			</div>
						</label>
					</div>
				</div>
				<!---------------------------------------- 초대 모달 ---------------------------------------->
				<!-- 이미지 확대 모달 -->
				<div class="modal" tabindex="-1" role="dialog" id="image-modal-chat">
	     			<div class="modal-dialog modal-lg" role="image">
   						<div class="modal-content">
 					 		<img :src="modalImgURL">
	     			 	</div>                           					 	
					</div>
	           	</div>
			</div>
        	<!----------------------------------------------- 헤더 끝 ----------------------------------------------->
            <%-- 
			<div class="row" style="position: fixed !important; top: 80px; z-index: 99999999999;">
				<!-- (개발)로그인 버튼 -->
				<div class="col-4">
					<button><a href="/dev/login?memberId=testuser1">testuser1</a></button>
					<button><a href="/dev/login?memberId=testuser2">testuser2</a></button>
					<button><a href="/dev/login?memberId=testuser3">testuser3</a></button>
					<button><a href="/dev/login?memberId=adminuser1">adminuser3</a></button>
				</div>
				<div class="offset-5 col-3">
					<!--<c:if test="${memberId == null}">
						<a href="${pageContext.request.contextPath}/member/login">로그인</a>
						<a href="${pageContext.request.contextPath}/member/join">회원가입</a>
					</c:if>
					<c:if test="${memberId != null}">
						<a href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
						<a href="${pageContext.request.contextPath}/member/mypage">마이페이지</a>
					</c:if>-->
					<c:if test="${memberLevel == '관리자'}">
						<a href="${pageContext.request.contextPath}/admin/">관리자 페이지</a>
					</c:if>
				</div>
            </div>
			--%>
        </header>
          <!-- <hr> -->

        <section class="container-fluid px-0">
            <div class="row mx-0">
				<!-- aside -->
                <div class="col-3 left-aside px-0">
					<c:choose>
						<%-- 일반페이지 aside --%>
						<c:when test="${!admin}">
							<jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
						</c:when>
						<%-- 관리자페이지 aside --%>
						<c:otherwise>
							<jsp:include page="/WEB-INF/views/admin/adminAside.jsp"></jsp:include>
						</c:otherwise>
					</c:choose>
                </div>
				<!-- 본문 -->
				<c:choose>
					<%-- 일반페이지 본문 --%>
					<c:when test="${!admin}">
						<div class="col-6 article container-fluid mb-4 px-4" style="padding:0px; margin-top: 90px;">
					</c:when>
					<%-- 관리자페이지페이지 본문 --%>
					<c:otherwise>
						<div class="col-9 article container-fluid py-4">
					</c:otherwise>
				</c:choose>
                