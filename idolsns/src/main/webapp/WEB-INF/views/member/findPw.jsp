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
		
		<div class="row page">
			
			<div v-show="page==1" style="text-align:center;">
				<div class="row">
					<h1>STARLINK</h1>
					<h3>비밀번호를 찾고자하는 아이디를 입력해주세요.</h3>
				</div>
				<br><br>
				<div class="row mb-3">
					<div class="col"></div>
						<input type="text" class="form-control' w-50 " placeholder="아이디" v-model="memberId"  name="memberName" @keyup="idDuplicatedCheck(memberId)">
					<div class="col"></div>
				</div>
				<div class="row">
					<div class="col"></div>
						<button type="button"  class="btn btn-info w-50"  :disabled="!idCheck" @click="pagePlus()">다음 단계</button>					
					<div class="col"></div>
				</div>
				<div class="row">
					<div class="col"></div>
					<a href="${pageContext.request.contextPath}/member/findId">아이디 찾기</a>				
					<div class="col"></div>
				</div>
			</div>
			
			<div v-show="page==2" style="text-align:center;">
				<div class="row">
					<h1>STARLINK</h1>
					<h3>회원정보에 등록한 이메일주소로 인증하기</h3>
				</div>
				<br><br>
				<div class="row mb-3">
					<div class="col"></div>
					<input type="email" class="form-control w-50" placeholder="이메일" v-model="memberEmail" name="memberEmail" @keyup="emailExist(memberId)">
					<div class="col"></div>
				</div>
				<div class="row mb-3">
					<input type="text" class="form-control" placeholder="인증번호"  v-model.number="code" @blur="isKeyValid">
					<button type="button" class="btn btn-secondary"  :disabled="!emailCheck" @click="sendEmail(memberEmail)">전송</button>
				</div>
				<div class="row"> 
					<div class="col"></div>
					<button type="button" class="btn btn-info w-50"  :disabled="!keyValid"  @click="pagePlus()">임시 비밀번호 발급</button>
					<div class="col"></div>
				</div>
			</div>
			
			<div v-show="page==3" style="text-align:center;">
				<div class="row mb-4">
					<h1>비밀번호 재설정</h1>
					<h3>새로운 비밀번호로 재설정 하세요.</h3>
					<br><br>
				</div>
				<div class="row mb-1">
					<input type="password" class="form-control" placeholder="새 비밀번호">
				</div>
				<div class="row">
					<input type="password" class="form-control" placeholder="비밀번호 확인">
				</div>
				<div class="row">
					<button type="button">비밀번호 변경</button>
				</div>
			</div>
			
		</div>
		
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
                    memberId:"",
                    memberEmail:"",
                    code:"",
                    page:1,
                    idCheck:false,
                    emailCheck:false,
                    key :"",
                    keyValid:false,
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
            	  
            	  async sendEmail(memberEmail) {
            		  Toastify({
              			 text:"이메일 전송 완료",
              			 duratioin:1000,
              			 newWindow:false,
              			 close:true,
              			 gravity:"bottom",
              			 position:"right",
              			 style:{
              				 background:"linear-gradient(to right, #84FAB0, #8FD3F4)"
              			 },
              		 }).showToast();
            		 const response = await axios.get("/member/emailSend", {
            			 params : {
            				 memberEmail : this.memberEmail
            			 }
            		 }); 
            		 console.log(this.key);
            		 this.key = response.data;
            	  },
            	  
            	  isKeyValid(){
            		  
            		  if(this.code == this.key) {
            			  this.keyValid = true;
            		  }
            		  else{
            			  this.keyValid=false;
            		  }
            		  
            	  },
            },
            computed:{
               
            },
    
      
        }).mount("#app");
    </script>
</body>   
</html> 

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>