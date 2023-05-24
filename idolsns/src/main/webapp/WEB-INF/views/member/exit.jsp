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
     <!-- toastify -->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

</head>
<body>
	 <div class="container rounded p-3" style="background-color:white">
     <div id="app">
		<form action="exit" method="post" autocomplete="off">
		
			<div class="container">
				<div class="row center">
					<h1>회원탈퇴</h1>
				</div>
				
				<div class="row">
				    <label for="agreement">
				        <input type="checkbox" id="agreement"  v-model="agreementChecked" >
				        회원탈퇴동의
				    </label>
				</div>
				<div class="row">
					<input type="password" name="memberPw"  placeholder="비밀번호" >
				</div>
				<c:if test="${param.mode == 'error' }">
					<div class="row">
						<p style='color: red;'>잘못된 비밀번호 입니다. 다시 입력하세요.</p>
					</div>
				</c:if>
				<div class="row">
					<button type="submit"  :disabled="!agreementChecked">탈퇴</button>
				</div>
			</div>
		
		</form>
	</div>
	</div>	

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/vue@3.2.36"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"></script>
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

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>