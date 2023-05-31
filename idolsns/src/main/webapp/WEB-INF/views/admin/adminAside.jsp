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
        	<i class="fa-solid fa-list">신고목록</i></a>
        <a href="${pageContext.request.contextPath}/admin/sanction">
        	<i class="fa-solid fa-list">제재목록</i></a>
        <a href="${pageContext.request.contextPath}/admin/tag">
        	<i class="fa-sharp fa-solid fa-tags">태그 목록조회</i></a>
        <a href="${pageContext.request.contextPath}/admin/tagCnt">
        	<i class="fa-sharp fa-solid fa-tags">태그별 사용량 조회</i></a>
        <a href="${pageContext.request.contextPath}/admin/fixedTag">
        	<i class="fa-sharp fa-solid fa-tags">고정태그</i></a>
		<a href="${pageContext.request.contextPath}/admin/artist">
			<i class="fa-sharp fa-solid fa-star">아티스트 조회</i></a>
  	</div>
  </aside>