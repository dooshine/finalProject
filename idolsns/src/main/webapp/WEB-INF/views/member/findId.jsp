<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<jsp:include page="/WEB-INF/views/template/header_member.jsp"></jsp:include> 

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기</title>
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
	<br><br>
	<div class="container" id = app>
	<div class="col-6 custom-container" style="background-color:white; margin-left: 300px;">
	<div class="row page">
		
		<div v-show ="page==1">
			<div class="row justify-content-center mb-1">
				<h2 class="font-purple1">아이디 찾기</h2>
			</div>
			<div class="row">
				<h5 class="font-gray2" >아이디를 찾고자하는 이메일를 입력해주세요.</h5>
			</div>
			<div class="custom-hr"></div>
			<br>
			<div class="row mb-3 mx-3">
					<input type="email" class="custom-input-rounded-container" placeholder="이메일" v-model="memberEmail"  name="memberEmail"
					   :class="{'is-invalid':!emailDuplicated && memberEmail !== ''}" 
					  @keyup="emailDuplicatedCheck(memberEmail)">
					<div class="invalid-feedback">{{memberEmailMessage}}</div>
			</div>
			<div class="row mb-3 mx-3">
				<button type="button" class="custom-btn btn-round btn-purple1"   v-bind:disabled="!emailDuplicated" @click="pagePlus(), findId(memberEmail)" >아이디 조회</button>
			</div>
		</div>	
		
		<div v-show="page==2" >
			<div class="row mb-3">
				<h2 class="font-purple1">아이디 조회 결과</h2>
				<div class="custom-hr"></div>
				<h5 style="text-align:center;">조회하신 아이디는 {{memberId}}입니다.</h5>
			</div>
			<div class="row mb-1 mx-0">
			    <button type="button" onclick="location.href='${pageContext.request.contextPath}/member/login'" class="custom-btn btn-round btn-purple1">로그인</button>
			</div>
			<div class="row ">
			    <a href="${pageContext.request.contextPath}/member/findPw" style="text-align: center; text-decoration: none; color:gray; ">비밀번호 찾기</a>
			</div>

		</div>
		
	</div>	
	</div>
	</div>
    <script>
    	Vue.createApp({
    		data(){
    			return{
    				memberEmail:"",
    				emailDuplicated:false,
    				page:1,
    				memberId:"",
    			};
    		},
    		methods:{
    			async emailDuplicatedCheck(memberEmail) {
    				const response = await axios.get("/member/emailDuplicatedCheck", {
    					params:{
    						memberEmail : this.memberEmail
    					}
    				});
    				if(response.data=="N") {
    					this.emailDuplicated=true;
    				}
    				else {
    					this.emailDuplicated=false;
    				}
    			},
    			async findId(memberEmail) {
    				const response = await axios.get("/member/findIdFinish", {
    					params:{
    						memberEmail : this.memberEmail
    					}
    				
    				
    				});
    			
    			
    				
    				this.memberId=response.data;
    				
    			},
    			pagePlus(){
    				this.page++;
    			},
    		},
    		computed:{
    			memberEmailMessage(){
    				if(!this.emailDuplicated) {
    					return "존재하지 않는 이메일입니다.";
    				}
    				else if(this.memberEmail.length == 0) {
    					return " ";
    				}
    			},
    		},
    	}).mount("#app");
    </script>
    
</body>    
