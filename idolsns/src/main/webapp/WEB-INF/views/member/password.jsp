<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<jsp:include page="/WEB-INF/views/template/header_member.jsp"></jsp:include> 
	<br><br>
	<div class="container" id = app>
	<div class="col-6 custom-container" style="background-color:white; margin-left: 300px;">
		<form action="password" method="post" autocomplete="off" @submit.prevent="submitForm">
			<div class="row center">
				<h1 class="font-purple1">비밀번호 변경</h1>
			</div>
			<div class="custom-hr"></div>
			<div class="row">
				<input class="custom-input-rounded-container width: 100%;"  type="password"  v-model="currentPw" name="currentPw" placeholder="현재 비밀번호"
				:class="{'is-invalid':currentPw !== '' && !pwCheck}" @blur="passwordCheck()">
				<div class="invalid-feedback">{{currentPwMessage}}</div>
			</div>
			<br>
			<div class="row mb-1">
				<input class="custom-input-rounded-container width: 100%;"  type="password"  v-model="memberNewPw" name="changePw" placeholder="새로운 비밀번호"
				:class="{'is-invalid':memberNewPw !== '' && !memberNewPwValid}">
				<div class="invalid-feedback">{{memberNewPwMessage}}</div>
			</div>
			<div class="row mb-3">
				<input class="custom-input-rounded-container width: 100%;"  type="password" v-model="memberNewPwRe" name="changePwRe" placeholder="새로운 비밀번호 확인"
				:class="{'is-invalid' :memberNewPw !== '' && !memberNewPwReValid}">
				<div class="invalid-feedback">{{memberNewPwReMessage}}</div>
			</div>
			<div class="row">
				<button type="submit"  v-bind:disabled="!allValid" class="custom-btn btn-round btn-purple1" >변경</button>
			</div>
		</form>
	</div>
	</div>
	
	<script>
        Vue.createApp({
            data(){
                return{
                    memberNewPw:"",
                    memberNewPwRe:"",
                    currentPw:"",
                    pwCheck:false,
                };
            },
            methods:{
            	submitForm() {
                    if (this.allValid()) {
                        // 폼 제출 허용
                        return true;
                    } else {
                        // 폼 제출 막기
                        event.preventDefault();
                    }
                 },
                 async passwordCheck() {
                	 const response = await axios.get("/member/passwordCheck");
                	 if(this.currentPw == response.data) {
                		 this.pwCheck = true;
                	 }
                	 
                 }
            },
            computed:{
            	currentPwMessage() {
            		if(!this.pwCheck) {
            			return "비밀번호를 다시 입력해주세요."
            		}
            		
            	},
            	
                memberNewPwValid(){
                    const regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
                    return regex.test(this.memberNewPw);
                },
                memberNewPwMessage(){
                    if(this.memberNewPw.length == 0) {
                        return "";
                    }
                    else if(this.memberNewPwValid) {
                        return "올바른 비밀번호 형식입니다.";
                    }
                    else {
                        return "영문 대/소문자, 숫자, 특수문자를 반드시 포함하여 8~16자로 작성하세요.";
                    }
                },
                memberNewPwReValid(){
                	if(this.memberNewPwRe == '')
                	return false;
                    return this.memberNewPw == this.memberNewPwRe;
                },
                memberNewPwReMessage(){
                    if(this.memberNewPwRe.length == 0) {
                        return "";
                    }
                    else if(this.memberNewPw.length == 0) {
                        return "비밀번호를 먼저 입력하세요.";
                    }
                    else if(this.memberNewPwReValid) {
                        return "비밀번호가 일치합니다.";
                    }
                    else {
                        return "비밀번호가 일치하지 않습니다.";
                    }
                },
                allValid(){
                	return (
                		    this.memberNewPwValid &&
                		    this.memberNewPwReValid &&
                		    this.pwCheck
                		  );
                },
                
             
            },
        }).mount("#app");
</script>