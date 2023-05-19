<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>홈페이지 레이아웃</title>
    <!-- 폰트어썸 cdn -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
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
    <!-- 부트스트랩 css(공식) -->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">

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
    	.notification,
    	.weez {
    		border-radius: 100%;
    		width: 40px;
    		border: 0.3px solid #c7cbca;
    	}
    </style>
</head>



<body style="background-color: #f5f5f5;">
    <main>
    	<!----------------------------------------------- 헤더 시작 ----------------------------------------------->
        <header>
			<nav class="navbar navbar-expand-md navbar-light bg-light">
			  	<div class="container-fluid">
			  		<div class="col-3">
				    	<a class="navbar-brand" href="/">STARLINK</a>
				    </div>
			    	<div class="col-6 d-flex collapse navbar-collapse" id="navbarSupportedContent">
			      		<form class="d-flex w-100">
			      			<div class="search-box w-100">
				        		<input class="search-input me-2 w-100" placeholder="STARLINK 검색" type="text">
				        	</div>
			      		</form>
			    	</div>
			    	<div class="col-3 d-flex justify-content-end collapse navbar-collapse">
						<img class="notification me-2 nav-item hide-part" alt="알림" src="/static/image/notificationIcon.png">
						<img class="weez nav-item hide-part" alt="위즈" src="/static/image/dmIcon.png">
			    	</div>
			  	</div>
			</nav>
        	<!----------------------------------------------- 헤더 끝 ----------------------------------------------->

            <div class="row">
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
        </header>
          <hr>

        <section class="container-fluid">
            <div class="row">
                <div class="col-3 d-flex left-aside">
                    <jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
                </div>
                <div class="col-6 article container-fluid" style="padding:0px;">

                