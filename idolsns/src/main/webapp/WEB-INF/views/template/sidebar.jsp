<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	.nav a {
		display: block;
		padding: 10px;
		margin-bottom: 10px;
		transition: background-color 0.3s ease;
	}
		
	.nav a:hover {
	  	background-color: #eee;
		border-radius: 10px / 10px;
	}
</style>
    
  <!-- aside -->
  <aside class ="col-12">
	<div class= "nav flex-column">
        <a href="${pageContext.request.contextPath}/">
        	<i class="fa-solid fa-house"> 홈</i></a>
        <a href="${pageContext.request.contextPath}/member/follower">
        	<i class="fa-solid fa-user"> 내 친구</i></a>
        <a href="${pageContext.request.contextPath}/member/myidol">
        	<i class="fa-solid fa-star"> 내 아이돌</i></a>
        <a href="${pageContext.request.contextPath}/fund/list">
        	<i class="fa-solid fa-sack-dollar"> 펀딩</i></a>
        <a href="${pageContext.request.contextPath}/point/charge">
        	<i class="fa-sharp fa-solid fa-coins"> 충전</i></a>
       	<button>글쓰기</button>
  	</div>
  </aside>