<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<jsp:include page="/WEB-INF/views/template/header_member.jsp"></jsp:include> 

<style>
	.member-container {
		position: fixed;
		left: 50%;
		transform: translate(-50%, 0%);  
		width: 600px;    
	}
</style>

	<div class="d-flex" id ="app">
	<div class="custom-container justify-content-center member-container">
	<div class="row-page">
	
		<div v-show="page==1"  class="row justify-content-center" style="text-align:center;">
				<div class="row mb-1">
					<h2 class="font-purple1 text-start">비밀번호 찾기</h2>
				</div>
				<div class="row ">
					<h5 class="font-gray2 text-start" >비밀번호를 찾고자하는 아이디를 입력해주세요.</h5>
				</div>
				<div class="custom-hr mb-3"></div>
				
				<div class="row">
				<div class="custom-input-rounded-container mb-3">
						<input type="text" class="custom-input" placeholder="아이디" v-model="memberId"  name="memberName" @keyup="idDuplicatedCheck(memberId)">
				</div>
				</div>
				
				<div class="row">
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
					<h2 class="font-purple1 text-start">비밀번호 찾기</h2>
				</div>
				<div class="row">
					<h3 class="font-gray2 text-start" style="text-align:center;">회원가입 시 사용했던 이메일을 입력하세요.</h3>
				</div>
				<div class="custom-hr"></div>
				<br>
				<div class="row">
				<div class="custom-input-rounded-container mb-3">
					<input type="email" class="custom-input" placeholder="이메일" v-model="memberEmail" name="memberEmail" @keyup="emailExist(memberId)">
				</div>
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
 							this.message = "	"
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

