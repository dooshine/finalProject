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
    <title>회원탈퇴</title>
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

</head>
<body>
	<!-- 회원탈퇴 -->
     <div class="container"  id="app">
     <br>
	<div class="row mt-5">
		<div class="col-2"></div>
		<div class="custom-container col-8" style="background-color:white ;">
			<form class="w-80" action="exit" method="post" autocomplete="off">
				
				<!-- 제목 -->
				<br>
				<div class="text-center">
					 <img src="/static/image/logo2.jpg" style="width:180px;">
					<br><br>
					<h3 class="font-gray2 font-bold">탈퇴하실 아이디의 비밀번호를 입력하세요.</h3>
				</div>
				<br>
				
				<!-- 비밀번호입력 -->
				<div class="row mx-5 mb-1">
					<input type="password"  class="custom-input-rounded-container" name="memberPw" placeholder="비밀번호"  >
				</div>
				
				<!-- 비밀번호 불일치시 메세지 -->
				<c:if test="${param.mode == 'error' }">
					<div class="row">
						<h6 class="font-purple1 text-center" >잘못된 비밀번호 입니다. 다시 입력하세요.</h6>
					</div>
				</c:if>
				<br>
				
				<!-- 약관동의 -->
				<div class="row mx-5 ">
					<label for="agreement">
						<input type="checkbox" id="agreement" v-model="agreementChecked">
						회원탈퇴동의
						<i class="ti ti-chevron-down"></i>
						<input type="text">숨김
					</label>
				</div>
				
				
				<div class="custom-hr"></div>
				
				<!-- 탈퇴 버튼 -->
				<div class="row my-3 mx-5">
					<button type="submit" :disabled="!agreementChecked" class="custom-btn btn-round btn-purple1" >탈퇴</button>
				</div>
				
			</form>
		</div>
		<div class="col-2"></div>
	</div>
</div>

	<script>
		Vue.createApp({
			data(){
				return{
					agreementChecked:false,
				};
			},
		}).mount("#app");
	</script>

</body>    

