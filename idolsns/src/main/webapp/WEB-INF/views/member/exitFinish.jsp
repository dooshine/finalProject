<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<jsp:include page="/WEB-INF/views/template/header_member.jsp"></jsp:include> 

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

</head>
<body>

	<br><br>
	<div class="container" id = app>
	<div class="col-6 custom-container" style="background-color:white; margin-left: 300px;">
	
		<div class="row mb-5">
			<h1 class="font-purple1">회원탈퇴 완료</h1>
			<div class="custom-hr"></div>
			<h3>2주 후 회원정보가 삭제됩니다.</h3>
			<h3>그 전에 로그인하시면 회원탈퇴가 취소됩니다.</h3>
		</div>
		<div class="row mb-3">
			<button type="button" class="custom-btn btn-round btn-purple1-secondary"  @click="goToLogin()">로그인</button>
		</div>
		<div class="row mb-3">
			<button type="button" class="custom-btn btn-round btn-purple1-secondary"  @click="goToJoin()">회원가입</button>
		</div>
			
	</div>
	</div>	

	<script>
		Vue.createApp({
			methods:{
				goToLogin() {
	      		  window.location.href = "${pageContext.request.contextPath}/member/login"; 
	      	  },
				goToJoin() {
	      		  window.location.href = "${pageContext.request.contextPath}/member/join"; 
	      	  },
			},
		}).mount("#app");
	</script>
</body>    

