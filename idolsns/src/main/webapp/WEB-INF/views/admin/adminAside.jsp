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
        <a href="${pageContext.request.contextPath}/admin/">
        	<i class="fa-solid fa-house">관리자홈</i></a>
        <a href="${pageContext.request.contextPath}/admin/member">
        	<i class="fa-solid fa-user">회원목록</i></a>
        <a href="${pageContext.request.contextPath}/admin/report">
        	<i class="fa-solid fa-star">신고목록</i></a>
        <a href="${pageContext.request.contextPath}/admin/">
        	<i class="fa-solid fa-sack-dollar">메뉴3</i></a>
        <a href="${pageContext.request.contextPath}/admin/">
        	<i class="fa-sharp fa-solid fa-coins">메뉴4</i></a>
  	</div>
  </aside>