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
    <title>비밀번호 찾기</title>
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
	<div class="row-page">
	
		<div v-show="page==1"  class="row justify-content-center" style="text-align:center;">
				<div class="row justify-content-center mb-1">
					<img src="/static/image/logo.png" style="width:200px;">
				</div>
				<div class="row ">
					<h3 class="font-gray2" style="text-align:center;">비밀번호를 찾고자하는 아이디를 입력해주세요.</h3>
				</div>
				<div class="custom-hr"></div>
				<br>
				<div class="row mb-3 ">
						<input type="text" class="custom-input-rounded-container" placeholder="아이디" v-model="memberId"  name="memberName" @keyup="idDuplicatedCheck(memberId)">
						<h6 class="font-purple1 text-center" >{{message}}</h6>
				</div>
				<div class="row">
						<button type="button"  class="custom-btn btn-round btn-purple1"  :disabled="!idCheck" @click="pagePlus()">다음 단계</button>					
				</div>
				<div class="row">
					<a href="${pageContext.request.contextPath}/member/findId" style="text-decoration: none; color:gray;">아이디 찾기</a>			
				</div>
		</div>
		
		<div v-show="page==2"  class="row justify-content-center" style="text-align:center;">
				<div class="row justify-content-center mb-1">
					<img src="/static/image/logo.png" style="width:200px;">
				</div>
				<div class="row">
					<h3 class="font-gray2" style="text-align:center;">회원가입 시 사용했던 이메일을 입력하세요.</h3>
				</div>
				<div class="custom-hr"></div>
				<br>
				<div class="row mb-3">
					<input type="email" class="custom-input-rounded-container" placeholder="이메일" v-model="memberEmail" name="memberEmail" @keyup="emailExist(memberId)">
				</div>
				<div class="row mb-3">
					<button type="button" class="custom-btn btn-round btn-purple1"  :disabled="!emailCheck" @click="goToLogin(), sendEmailPassword(memberEmail)">임시 비밀번호 발급</button>
				</div>
		</div>
		
	</div>
	</div>
	</div>	
	
    <script>
        Vue.createApp({
            data(){
                return{
                    memberId:"",
                    memberEmail:"",
                    page:1,
                    idCheck:false,
                    emailCheck:false,
                    message:"",
                };
            },
            methods:{
            	  pagePlus(){
            		  this.page++;
            	  },
            	  
            	  async  idDuplicatedCheck(memberId){
            		  const resp = await axios.get("/member/idDuplicatedCheck",{
            			  params:{
            				  memberId : this.memberId
            			  }
            		  });
 						if(resp.data === "N"){
 							this.idCheck = true; //아이디가 있다.
 						}  
 						else{
 							this.idCheck = false; //존재하는 아이디가 없다.
 							this.message = "아이디가 존재하지 않습니다."
 						}
            	  },
            	  
            	  async emailExist(memberId){
            		  const resp = await axios.get("/member/emailExist", {
            			  params : {
            				  memberId : this.memberId
            			  }
            		  });
            		  if(resp.data === this.memberEmail) {
            			  this.emailCheck = true;
            		  }
            		  else {
            			  this.emailCheck = false;
            		  }
            		  
            	  },
            	  
            	  async sendEmailPassword(memberEmail) {
            		  const response = await axios.get("/member/sendEmailPassword", {
            			  params : {
            				  memberEmail : this.memberEmail
            			  }
            		  });
            		  this.key = response.data;
            	  },
            	  
            	  goToLogin() {
            		  window.location.href = "${pageContext.request.contextPath}/member/login"; 
            		  Toastify({
                			 text:"이메일 전송 완료",
                			 duration:1000,
                			 newWindow:false,
                			 close:true,
                			 gravity:"bottom",
                			 position:"right",
                			 style:{
                				 background:"linear-gradient(to right, #84FAB0, #8FD3F4)"
                			 },
                		 }).showToast();
            	  },
            },
            computed:{
               
            },
        }).mount("#app");
    </script>
</body>   
</html> 

