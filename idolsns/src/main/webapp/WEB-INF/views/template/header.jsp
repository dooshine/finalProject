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


	



    <!-- custom 테스트 css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/test.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/component.css">
    
 
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
    	.user-btn,
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
    		box-shadow: 0px 3px 4px rgba(3, 21, 17, 0.08);
    		
    		/* 스크롤 설정 */
    		overflow-y: initial;
    	}
    	.customModalSmall {
    		position: absolute;
    		bottom: 282px;
    		right: 60px;
    		z-index: 9999;
    		background: white;
    		border: 0.5px solid #c8c8c8;
    		border-radius: 5px;
    		display: block;
    		box-shadow: 0px 3px 4px rgba(3, 21, 17, 0.08);
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
    		box-shadow: 0px 3px 4px rgba(3, 21, 17, 0.08);
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
    	.customModalMemberList {
    		position: absolute;
    		width: 250px;
    		max-height: 275px;
    		bottom: 27%;
    		right: 8%;
    		transform: translate(0.5%, -8%);
    		z-index: 9999;
    		background: white;
    		border: 0.5px solid #c8c8c8;
    		border-radius: 5px;
    		display: block;
    		box-shadow: 0px 3px 4px rgba(3, 21, 17, 0.08);
    		padding: 16px;
    		
    		/* 스크롤 설정 */
    		overflow-y: initial;
    	}
    	.customModalMemberListBody {
    		max-height: 250px;
    		overflow-y: auto;
    		
    		/* 파폭 스크롤 커스텀 */
    		scrollbar-width: thin;
    		scrollbar-color: #c8c8c8 rgba(0,0,0,0);
    	}
    	.customModalMemberListHeader {
    		padding-bottom: 16px;
    		margin-bottom: 16px;
    		border-bottom: 0.5px solid #dee2e6;
    	}
    	/* 스크롤바 설정*/
		.customModalBody::-webkit-scrollbar,
		.customModalMemberListBody::-webkit-scrollbar {
		    width: 5px;
		}
		/* 스크롤바 막대 설정*/
		.customModalBody::-webkit-scrollbar-thumb,
		.customModalMemberListBody::-webkit-scrollbar-thumb {
		    background-color: #c8c8c8;
		    border-radius: 10px;    
		}
		/* 스크롤바 뒷 배경 설정*/
		.customModalBody::-webkit-scrollbar-track,
		.customModalMemberListBody::-webkit-scrollbar-track {
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
    		overflow-x: hidden;
    		
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
		.ti-edit-circle-large,
		.ti-users-group {
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
		.exitBtn:hover .ti-message-circle-off,
		.memberListBtn:hover .ti-users-group {
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
    	.confirmNameBtn[disabled]:hover .ti-edit-circle-large,
    	.memberListBtn[disabled] .ti-users-group,
    	.memberListBtn[disabled]:hover .ti-users-group {
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
    		
    		-ms-overflow-style: none; /* 인터넷 익스플로러 */
  			scrollbar-width: none;
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
			word-break: break-all;
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
		
		.notiMark {
			position: absolute;
			top: 5px;
			right: 5px;
			border-radius: 10px;
			width: 12px;
			height: 12px;
			background: #6a53fb;
		}
		
		.notiMarkChat {
			/*position: fixed;*/
			border-radius: 10px;
			width: 8px;
			min-width: 8px;
			height: 8px;
			background: #6a53fb;
			z-index: 9999;
		}
		.chatRoomNameDiv {
			display: block;
			white-space: nowrap;
			overflow: hidden;
			text-overflow: ellipsis;
			word-break: break-all;
		}
		
		.profileImg {
			border-radius: 100px;
		}
		.back-white {
			background-color: white;
		}
		.btn-close {
			box-shadow: none;
		}
		
		.chatRoomName {
			display: block;
			white-space: nowrap;
			overflow: hidden;
			text-overflow: ellipsis;
			word-break: break-all;
		}
    </style>
</head>



<body style="background-color: #f5f5f5;">
    <main>
    	<!----------------------------------------------- 헤더 시작 ----------------------------------------------->
        <header>
   
        	<div id="header-area">
				<nav class="navbar navbar-expand-md navbar-light back-white" style="box-shadow: 0px 3px 4px rgba(3, 21, 17, 0.1);">
				  	<div class="container-fluid">
				  		<div class="col-3 ps-2">
					    	<a class="navbar-brand" href="/"><img src="/static/image/logo.png" style="width:130px;"></a>
					    </div>
				    	<div class="col-6 d-flex collapse navbar-collapse" id="navbarSupportedContent">
				      		<form action="/search" class="d-flex w-100">
				      			<div class="search-box w-100">
					        		<input name="q" class="search-input me-2 w-100" placeholder="STARLINK 검색" type="text" value="${param.q}">
					        	</div>
				      		</form>
				    	</div>
				    	<div class="col-3 d-flex justify-content-end collapse navbar-collapse pe-2">
				    		<!-- 알림버튼 -->
				    		<button class="noti-btn me-2">
								<img class="noti nav-item hide-part" alt="알림" src="/static/image/notificationIcon.png">
							</button>
							<!-- 위즈버튼 -->
							<button class="weez-btn me-2" @click="showChatMainModal" style="position: relative;">
								<img class="weez nav-item hide-part" alt="위즈" src="/static/image/dmIcon.png">
								<!-- 새 채팅이 있는 경우 새 채팅 알림 마크 -->
								<div v-if="newChatNoti === true" class="notiMark collapse navbar-collapse"></div>
							</button>
							<!-- 유저버튼 -->
							<button class="user-btn" @click="goToLoginPage()">
								<img class="me-2 weez nav-item hide-part" alt="유저" src="/static/image/profileDummy.png">
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
						<div class="d-flex justify-content-end">
							<button type="button" class="hide-style pe-3 newChatRoomBtn" @click="showCreateRoomModal">
								<i class="ti ti-message-circle-plus"></i>
							</button>
							<button type="button" class="btn-close" @click="hideChatMainModal"></button>
						</div>
					</div>
					<div class="customModalBody">
						<div class="chatRooms mb-2" v-for="(room, index) in chatRoomList" :key="index">
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
												<div>{{ timeFormatDetailed2(chatRoomList[index].chatRoomLast) }}</div>
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
												<div class="text-start d-flex align-items-baseline">
													<div class="me-2 w-100" style="max-width: 120px">
														<h6 class="chatRoomName" style="max-width: 120px" :title="findMemberByIdInMain(index).memberNick">
															{{ findMemberByIdInMain(index).memberNick }}
														</h6>
													</div>
													<div class="sysMsgContent">
														@{{ findMemberByIdInMain(index).memberId }}
													</div>
												</div>
												<!-- 새 메세지 알림 표시 -->
												<div v-if="chatRoomList[index].newChat === true" class="notiMarkChat ms-2"></div>
											</div>
											<div class="sysMsgContent d-flex justify-content-between">
												<div>마지막 메세지</div>
												<div>·</div>
												<div>{{ timeFormatDetailed2(chatRoomList[index].chatRoomLast) }}</div>
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
												<div class="text-start d-flex align-items-baseline">
													<div class="me-2 w-100" style="max-width: 120px">
														<h6 class="chatRoomName" style="max-width: 120px" :title="findMemberByIdInMain(index).memberNick">
															{{ findMemberByIdInMain(index).memberNick }}
														</h6>
													</div>
													<div class="sysMsgContent">
														@{{ findMemberByIdInMain(index).memberId }}
													</div>
												</div>
												<!-- 새 메세지 알림 표시 -->
												<div v-if="chatRoomList[index].newChat === true" class="notiMarkChat ms-2"></div>
											</div>
											<div class="sysMsgContent d-flex justify-content-between">
												<div>마지막 메세지</div>
												<div>·</div>
												<div>{{ timeFormatDetailed2(chatRoomList[index].chatRoomLast) }}</div>
											</div>
										</div>
									</div>
								</button>
							</div>
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
								:disabled="(selectedMemberList.length === 0 && nameCount < 1) || (selectedMemberList.length >= 2 && (nameCount < 1 || nameCount > 20))">
								<i class="ti ti-message-circle-check"></i>
							</button>
							<button type="button" class="btn-close" @click="hideCreateRoomModal"></button>
						</div>
					</div>
					<div class="customModalBody">
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
				<!--------------------------------------- 채팅방 생성 모달 ---------------------------------------->
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
										<button type="button" @click="saveRoomName" class="hide-style confirmNameBtn me-2" 
											:disabled="(roomInfo.chatRoomName1.length < 1 || roomInfo.chatRoomName1.length > 20) || roomInfo.chatRoomName1 == roomInfoCopy.chatRoomName1">
											<i class="ti ti-edit-circle ti-edit-circle-large"></i>
										</button>
										<!-- 이름 변경 취소 버튼 -->
										<button type="button" @click="cancelChange" class="hide-style cancelRenameBtn me-2">
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
									<div class="d-flex align-items-center">
										<img :src="findMemberById(index).profileSrc" v-if="!sameTime(index)" 
											class="profileImg me-2" style="height: 30px; width: 30px;">
										<span style="font-size: 0.8em;" v-if="!sameTime(index)" style="margin: 0;">{{ findMemberById(index).memberNick }}</span>
									</div>
									<div class="d-flex align-items-end" style="margin-left: 36.5px;">
										<!-- 텍스트 메세지일 때 -->
										<div v-if="message.attachmentNo === 0" class="messageBox">{{ message.chatMessageContent }}</div>
										<!-- 이미지 메세지일 때 -->
										<img class="photoMessage" v-if="message.attachmentNo != 0" @load="scrollBottom"
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
											class="hide-style d-flex align-items-end deleteMessageBtn" style="padding-bottom: 1px; margin-right: 5px;">
											<i class="ti ti-x"></i>
										</button>
										<div class="messageTime" v-if="displayTime(index)">{{ timeFormat(message.chatMessageTime) }}</div>
										<!-- 텍스트 메세지일 때 -->
										<div v-if="message.attachmentNo === 0" class="messageBox">{{ message.chatMessageContent }}</div>
										<!-- 이미지 메세지일 때 -->
										<img class="photoMessage myMessage" v-if="message.attachmentNo != 0" @load="scrollBottom"
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
						<!-- 참여자 리스트 모달 -->
						<div v-if="chatRoomModal == true && memberListModal == true" class="customModal chatRoomModal">
							<div class="customModalHeader d-flex justify-content-between">
								<h5>참여자 목록</h5>
								<button type="button" class="btn-close" @click="hideMemberListModal"></button>
							</div>
							<!-- 참여자 목록 -->
							<div class="customModalBody">
								<div v-for="(member, index) in chatMemberList" class="w-100 mb-3 d-flex w-100">
									<div class="d-flex align-items-center col-9">
										<div class="me-3">
											<img :src="member.profileSrc" class="profileImg" style="height: 45px; width: 45px;">
										</div>
										<div>
											<div style="font-size: 0.95em;">{{ member.memberNick }}</div>
											<div style="font-size: 0.9em; color: #7f7f7f;">@{{ member.memberId }}</div>
										</div>
									</div>
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
						<!-- 팔로우 목록 -->
						<label v-for="(follow, index) in filteredFollowList" class="w-100 mb-3">
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
			</div>
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
						<a href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
						<a href="${pageContext.request.contextPath}/member/mypage">마이페이지</a>
					</c:if>
					<c:if test="${memberLevel == '관리자'}">
						<a href="${pageContext.request.contextPath}/admin/">관리자 페이지</a>
					</c:if>
				</div>
            </div>
        </header>
          <!-- <hr> -->

        <section class="container-fluid">
            <div class="row">
                <div class="col-3 d-flex left-aside">
                    <jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
                </div>
                <div class="col-6 article container-fluid py-4" style="padding:0px;">
                