<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<jsp:include page="/WEB-INF/views/template/header_member.jsp"></jsp:include> 
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
			<div class="custom-input-rounded-container mb-3 mx-3">
					<input type="email" class="custom-input" placeholder="이메일" v-model="memberEmail"  name="memberEmail"
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
