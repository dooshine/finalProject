<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<jsp:include page="/WEB-INF/views/template/header_member.jsp"></jsp:include> 

	<br><br>
	<div class="container" id = app>
	<div class="col-6 custom-container" style="background-color:white; margin-left: 300px;">
	
		<div class="row mb-5">
			<h1 class="font-purple1">비밀번호 변경 완료</h1>
			<div class="custom-hr"></div>
			<h3>변경이 완료되었습니다.</h3>
		</div>
		<div class="row mb-3">
			<button type="button" class="custom-btn btn-round btn-purple1-secondary"  @click="goToHome()">홈으로</button>
		</div>
			
	</div>
	</div>	

	<script>
		Vue.createApp({
			methods:{
				goToHome() {
	      		  window.location.href = "${pageContext.request.contextPath}/"; 
	      	  },
			},
		}).mount("#app");
	</script>
