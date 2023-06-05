<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header_member.jsp"></jsp:include>
<%@ page import="javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/commons mye.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/component.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/doo.css">
    <!-- toastify -->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
    <style>
    .container {
        margin-top: 20px;
    }
     .container-rounded {
        display: flex;
        flex-direction: column;
        align-items: center;
    }
</style>
</head>
<body>

	<br><br><br><br><br><br>
	<div class="container" id = app>
	
	<!-- 로그인 왼쪽 -->
	<div class="col-6" style="float:left; margin-left: 40px;">
		<img src="/static/image/logo2.jpg" style="width:200px;">
		<br><br>
		<h3 class="font-gray2 font-bold">스타링크에 오신것을 환영합니다.</h3>
		<h3 class="font-gray2 font-bold">회원가입이 완료되었습니다.</h3>
	</div>
	
	<!-- 로그인 오른쪽 -->
	<div class="col-4 custom-container" style="background-color:white; float:right; margin-right: 100px;">
		<form class="w-100" action="login" method="post" autocomplete="off">
			
			<div class="row mb-3 mt-4 mx-0">
            	<input class="custom-input-rounded-container width: 100%;" type="text" name="memberId" placeholder="아이디">
       		 </div>
       		 
       		 <div class="row mx-0 mb-1">
            	<input class="custom-input-rounded-container" type="password" name="memberPw" placeholder="비밀번호">
       		 </div>
			
			<h6 class="font-purple1 text-center" >${param.msg}</h6>
			
			
			<div class="custom-hr"></div>

			<div class="row my-3 mx-0 ">
				<button type="submit" class="custom-btn btn-round btn-purple1" >로그인</button>
			</div>
			
		</form>
			<div class="text-center">
			<a href="${pageContext.request.contextPath}/member/findId" style="text-decoration: none; color:gray;">아이디 /</a>
			<a href="${pageContext.request.contextPath}/member/findPw" style="text-decoration: none; color:gray;">비밀번호 찾기</a>
			</div>
			
	</div>
		
	</div>
			<script>
		        document.addEventListener('DOMContentLoaded', function() {
		            var mode = '${param.mode}';
		            var message = '${param.mmssgg}';
		
		            function showAlert() {
		                if (mode === 'cancel' && message) {
		                    alert(message);
		                }
		            }
		
		            showAlert();
		        });
		    </script>

</body>
