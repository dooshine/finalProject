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
    		height: 450px;
    		z-index: 999;
    		display: block;
    		
    		/* 스크롤 설정 */
    		overflow-y: initial;
    	}
    	.chatRoomModal {
    		position: fixed;
    		bottom: 10px;
    		right: 313px;
    		background: white;
    		border: 0.5px solid #c8c8c8;
    		border-radius: 5px;
    		width: 300px;
    		height: 450px;
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
    		height: 390px;
    		overflow-y: auto;
    	}
    	.short {
    		padding: 16px;
    		height: 290px;
    		overflow-y: auto;
    	}
    	.customModalFooter {
    		padding-top: 5px;
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
    	.ti-edit-circle {
    		font-size: 22px;
    		color: #7f7f7f;
    	}
    	.ti-message-circle-plus:hover,
    	.ti-message-circle-check:hover,
    	.ti-edit-circle:hover {
    		color: #404040;
    	}
    	.newChatRoomBtn[disabled] .ti-message-circle-plus,
    	.newChatRoomBtn[disabled]:hover .ti-message-circle-plus,
    	.confirmNewChatRoomBtn[disabled] .ti-message-circle-check,
    	.confirmNewChatRoomBtn[disabled]:hover .ti-message-circle-check,
    	.roomNameChangeModeBtn[disabled] .ti-edit-circle,
    	.roomNameChangeModeBtn[disabled]:hover .ti-edit-circle {
    		color: #dee2e6;
    	}
    	.type-box {
    		width: 300px;
    		height: 50px;
    		resize: none;
    		border: none;
    		outline: none;
    	}
    	.type-box::-webkit-scrollbar {
    		display: none;
    	}
    	.length-alert {
    		font-size: 0.8em;
    		color: red;
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
							<button class="hide-style" @click="chatRoomModal">
								{{ room.chatRoomName }}
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
								:disabled="(selectedMemberList.length === 0 && nameCount < 1) || (selectedMemberList.length >= 3 && nameCount === 0)">
								<i class="ti ti-message-circle-check"></i>
							</button>
							<button type="button" class="btn-close" @click="hideCreateRoomModal"></button>
						</div>
					</div>
					<div class="customModalBody">
						<div>
							<div class="form-floating mb-3" v-if="memberCount > 2">
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
				<!--------------------------------------- 채팅방 생성 모달 ---------------------------------------->
				<!--------------------------------------- 채팅방 모달 ---------------------------------------->
				<div class="customModal chatRoomModal">
					<!-- 헤더 -->
					<div class="customModalHeader d-flex align-items-center justify-content-between">
						<h5>채팅방 이름</h5>
						<div class="d-flex justify-content-end">
							<!-- 이름 수정 버튼(chatRoomType이 그룹일때만 보임 roomInfo.chatRoomType == 'G') -->
							<button type="button" class="hide-style pe-3 roomNameChangeModeBtn">
								<i class="ti ti-edit-circle"></i>
							</button>
							<!-- 닫기 버튼 -->
							<button type="button" class="btn-close"></button>
						</div>
					</div>
					<!-- 바디 -->
					<div class="customModalBody short">
						메세지 내용 불러오기
					</div>
					<!-- 푸터 -->
					<div class="customModalFooter">
						<div class="type-area d-flex">
							<textarea class="type-box"></textarea>
						</div>
						<div class="footer-area d-flex align-items-center justify-content-between mt-3">
							<div class="length-alert">
								글자수를 초과했습니다.
							</div>
							<div class="button-area d-flex justify-content-end">
								<button type="button" class="hide-style me-2">이미지</button>
								<button type="button" class="hide-style">전송</button>
							</div>
						</div>
					</div>
				</div>
				<!--------------------------------------- 채팅방 모달 ---------------------------------------->
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
          <hr>

        <section class="container-fluid">
            <div class="row">
                <div class="col-3 d-flex left-aside">
                    <jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
                </div>
                <div class="col-6 article container-fluid py-5" style="padding:0px;">
                