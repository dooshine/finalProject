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
    <title>비밀번호 변경</title>
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

</head>
<body>
	<br><br>
	<div class="container" id = app>
	<div class="col-6 custom-container" style="background-color:white; margin-left: 300px;">
		<form action="password" method="post" autocomplete="off">
			<div class="row center">
				<h1 class="font-purple1">비밀번호 변경</h1>
			</div>
			<div class="custom-hr"></div>
			<div class="row">
				<input class="custom-input-rounded-container width: 100%;"  type="password" name="currentPw" placeholder="현재 비밀번호">
			</div>
			   <h6 class="font-purple1 text-center">잘못된 비밀번호입니다. 다시 입력하세요.</h6>
			<br>
			<div class="row mb-1">
				<input class="custom-input-rounded-container width: 100%;"  type="password"  v-model="memberNewPw" name="changePw" placeholder="새로운 비밀번호"
				:class="{'is-invalid':memberNewPw !== '' && !memberNewPwValid}">
				<div class="invalid-feedback">{{memberNewPwMessage}}</div>
			</div>
			<div class="row mb-3">
				<input class="custom-input-rounded-container width: 100%;"  type="password" v-model="memberNewPwRe" name="changePw" placeholder="새로운 비밀번호 확인"
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
                };
            },
            methods:{

            },
            computed:{
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
                    return 
                                this.memberNewPwValid
                                && this.memberNewPwReValid;
                },
                
             
            },
        }).mount("#app");
        </script>
</body>