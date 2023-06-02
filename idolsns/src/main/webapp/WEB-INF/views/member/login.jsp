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
    <!-- toastify -->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
    <style>
    .container {
        margin-top: 20px;
    }
</style>
</head>
<body>

	<br><br><br><br><br><br>
	<div class="container" id = app>
	
	<!-- 로그인 왼쪽 -->
	<div class="col-6" style="float:left; margin-left: 50px;">
		<img src="/static/image/logo2.jpg" style="width:200px;">
		<br><br>
		<h3 style="font-weight: bold; color: grey;">스타링크에서 당신의 아이돌과 소통하세요</h3>
	</div>
	
	<!-- 로그인 오른쪽 -->
	<div class="col-3" style="background-color:white; float:right; margin-right: 200px;">
		<form action="login" method="post" autocomplete="">
			
			<div class="custom-input-rounded-container mb-3">
            	<input class="custom-input " type="text" name="memberId" placeholder="아이디">
       		 </div>
       		 
       		 <div class="custom-input-rounded-container mb-3">
            	<input class="custom-input" type="password" name="memberPw" placeholder="비밀번호">
       		 </div>
			
			<h5 style="color:red; font-size:11px;">${param.msg}</h5>
			<br>
			

			<div class="row mb-3">
				<button type="submit" class=" btn btn-primary w-50">로그인</button>
			</div>
			
		</form>
			
			<div class="row mb-3">
				<button type="button" onclick="location.href='${pageContext.request.contextPath}/member/findId'">아이디 찾기</button>
			</div>
			
			<div class="row mb-3">
				<button type="button" onclick="location.href='${pageContext.request.contextPath}/member/findPw'">비밀번호 찾기</button>
			</div>
				<button type="button" onclick="location.href='${pageContext.request.contextPath}/member/join'">회원가입</button>
			<div class="row mb-3">
			
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
