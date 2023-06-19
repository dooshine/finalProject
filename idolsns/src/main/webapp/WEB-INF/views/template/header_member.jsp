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
	<link rel="icon" href="${pageContext.request.contextPath}/static/image/favicon.ico">
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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/component.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/doo.css">
    
    <!-- 폰트css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/load.css" />
    <!-- doo-css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/doo.css" />
     <!-- toastify -->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

	
	


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
			top: 15px;
			right: 20px;
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
<header style="height: 100px;">
   <div id="header-area" style="height: 57.06px;">
      <nav class="navbar navbar-expand-md navbar-light back-white" style="box-shadow: 0px 3px 4px rgba(3, 21, 17, 0.1); height: 100%;">
         <div class="container-fluid d-flex justify-content-center align-items-center" style="height: 100%;">
            <div class="text-center">
               <a class="navbar-brand" href="${pageContext.request.contextPath}/"><img src="/static/image/logo.png" style="width: 130px;"></a>
            </div>
         </div>
      </nav>
   </div>
</header>

                