<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 

<!DOCTYPE html>
<html lang="ko"></html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
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
    
    <!-- toastify -->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

    <script>
    	const contextPath = "${pageContext.request.contextPath}";
    </script>
</head>
<body>
	<div class="container rounded p-3" style="background-color:white">
		<div id="app">
		
			<h1>testuser1/Testuser1!</h1>
			
			<form action="login" method="post" autocomplete="off">
			<div class="row mb-5">
				<h1 style="text-align:center;">로그인</h1>
			</div>
			
			
			<div class="row mb-3">
				<input type="text" name="memberId" placeholder="아이디">
			</div>
			
			<div class="row mb-1">
				<input type="password" name="memberPw" placeholder="비밀번호">
			</div>
			
			<h5 style="color:red; font-size:11px;">${param.msg}</h5>
			<br>
			
			<input style="display: none;" name="prevPage" value="${header.referer}">

			<div class="row mb-3">
				<button type="submit" class="btn btn-info w-100">로그인</button>
			</div>
			</form>
			
			<div class="row mb-3">
				<button type="button" 
					onclick="location.href='${pageContext.request.contextPath}/member/findId'">아이디 찾기</button>
			</div>
			
			<div class="row mb-3">
				<button type="button" onclick="location.href='${pageContext.request.contextPath}/member/findPw'">비밀번호 찾기</button>
			</div>
			
			
		</div>
	</div>
    </script>
</body>    
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>













