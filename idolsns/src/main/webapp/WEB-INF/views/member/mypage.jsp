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
    <!-- tabler 아이콘 -->
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">
	
</head>
<body test>
	<div class="container rounded p-3" style="background-color:white">
	<div id="app">
		
		<div class="container">
			<div class="row">
				<a href="${pageContext.request.contextPath}/member/exit">회원탈퇴</a>
				<a href="${pageContext.request.contextPath}/member/password">비밀번호 변경</a>
				<a href="${pageContext.request.contextPath}/member/nickname">닉네임 변경</a>
			</div>
			
			<div class="row">
				<img src="/static/image/profileDummy.png" style="width: 200px; height: auto; border-radius: 100%;">
			</div>
			
			<div class="row">
				<h3>@{{memberId}}</h3>
				<h3>{{memberNick}}</h3>
			</div>
		</div>
	
	</div>
	</div>	
		
		<script>
			Vue.createApp({
				data(){
					return{
						memberId:"",
						memberNick:"",
					};
				},		
				methods:{
					async profile() {
						const response = await axios.get("/member/profile");
						const {memberId, memberNick} = response.data;
						
						this.memberId = memberId;
						this.memberNick=memberNick;
						
					},
				},
				mounted() {
					this.profile();
				},
			}).mount("#app");
		</script>
		
</body>    

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>