<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 

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

	<script src="/static/js/member-join.js"></script>
    <script>
    	const contextPath = "${pageContext.request.contextPath}";
    </script>
</head>
<body>

	<form action="join" method="post" enctype="multipart/form-data" autocomplete="off">
	
		<div class="container ">
			<div class="row">
				<div class="col-3"></div>
				<div class="col-6 text-center">				
					<h1>회원가입</h1>
				</div>
				<div class="col-3"></div>
			</div>
			
			<div class="row mb-3">
				<div class="col-3"></div>
				<div class="col-6 text-center">
					<input type="text" name="memberId" placeholder="아이디" class="form-control">
					<div class="valid-message">사용 가능한 아이디입니다.</div>
					<div class="invalid-message">영소문자로 시작하여 숫자를 포함한 8~20자로 작성하세요.</div>
					<div class="invalid-message2">이미 사용중인 아이디입니다.</div>
				</div>
				<div class="col-3"></div>
			</div>
			
			<div class="row mb-3">
				<div class="col-3"></div>
				<div class="col-6 text-center">
					<input type="password" name="memberPw" placeholder="비밀번호" class="form-control">
					<div class="valid-message">올바른 비밀번호 형식입니다</div>
					<div class="invalid-message">영문 대/소문자, 숫자, 특수문자를 반드시 포함하여 8~16자로 작성하세요.</div>
				</div>
				<div class="col-3"></div>
			</div>
			
			<div class="row mb-3">
				<div class="col-3"></div>
				<div class="col-6">
					<input type="password" name="passwordRe" placeholder="비밀번호 확인" class="form-control">
					<div class="valid-message">비밀번호가 일치합니다.</div>
					<div class="invalid-message">비밀번호가 일치하지 않습니다.</div>
					<div class="invalid-message2">비밀번호를 먼저 입력하세요.</div>
				</div>
				<div class="col-3"></div>
			</div>
			
			<div class="row mb-3">
				<div class=col-3></div>
				<div class=col-6>
					<input type="text" name="memberNick" placeholder="닉네임" class="form-control">
					<div class="valid-message">올바른 닉네임 형식입니다.</div>
					<div class="invalid-message">한글, 영문, 숫자, 특수문자 등을 사용하여 1~16자로 작성하세요.</div>
					<div class="invalid-message2">이미 존재하는 닉네임입니다.</div>
				</div>
				<div class=col-3></div>
			</div>
			
			<div class="row mb-3">
				<input type="email" name="memberEmail" placeholder="이메일" class="form-control">
			</div>
			<div class="row mb-3">
				<button type="submit" class="btn btn-info">회원가입</button>
			</div>
			
		</div>
	
	</form>

</body>    