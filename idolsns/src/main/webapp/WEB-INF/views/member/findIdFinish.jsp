<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 

	<div class="container">
		<div class="row">
			<div class="col-3"></div>
			<div class="col-6">
				찾으시는 아이디는 ${memberId}입니다.
			</div>
			<div class="col-3"></div>
		</div>
		<div class="row">
			<div class=col>
				<a href="${pageContext.request.contextPath}/member/login">로그인</a>
			</div>
			<div class="row">
				<div class="col">
					<a href="${pageContext.request.contextPath}/member/findPw">비밀번호 찾기</a>
				</div>
			</div>			
		</div>
	</div>
