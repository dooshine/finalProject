<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<jsp:include page="/WEB-INF/views/template/header_member.jsp"></jsp:include> 

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
