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

    <script>
    	const contextPath = "${pageContext.request.contextPath}";
    </script>
</head>
 <body>
      <div id="app" class="container">
        

        <div class="row page">
            <form action="join" method="post" autocomplete="off">

            <div class="row mb-5">
                <div class="col-3"></div>
                <div class="col-6 text-center">
                    <h1>회원가입</h1>
                </div>
                <div class="col-3"></div>
            </div>

            <div class="row mb-3">
                <div class="col-3"></div>
                <div class="col-6">
                    <input type="text" v-model="memberId" class="form-control" 
                    	:class="{ 'is-valid': memberIdValid && !idDuplicated, 'is-invalid': memberId !== '' && (!memberIdValid || idDuplicated)}" placeholder="아이디" 
                    	@blur="idDuplicatedCheck(memberId)" name="memberId" id="memberId">
                    <div class="valid-feedback">{{memberIdMessage}}</div>
  					<div class="invalid-feedback">{{memberIdMessage}}</div>
                </div>
                <div class="col-3"></div>
            </div>

            <div class="row mb-3">
                <div class="col-3"></div>
                <div class="col-6">
                    <input type="password" v-model="memberPw" class="form-control" 
                    	:class="{'is-valid' : memberPwValid, 'is-invalid' : memberPw !== '' && !memberPwValid}" placeholder="비밀번호" name="memberPw">
                    <div class="valid-feedback">{{memberPwMessage}}</div>
                    <div class="invalid-feedback">{{memberPwMessage}}</div>
                </div> 
                <div class="col-3"></div>
            </div>

            <div class="row mb-3">
                <div class="col-3"></div>
                <div class="col-6">
                    <input type="password" v-model="memberPwRe" class="form-control" 
                    	:class="{'is-valid':memberPwReValid, 'is-invalid':memberPwRe !== '' && (!memberPwReValid || memberPw.length==0)}" placeholder="비밀번호 확인" name="memberPwRe">
                    <div class="valid-feedback">{{memberPwReMessage}}</div>
                    <div class="invalid-feedback">{{memberPwReMessage}}</div>
                </div>
                <div class="col-3"></div>
            </div>

            <div class="row mb-3">
                <div class="col-3"></div>
                <div class="col-6">
                    <input type="text" v-model="memberNick" class="form-control" placeholder="닉네임" 
                    	:class="{'is-valid':memberNickValid && !nickDuplicated, 'is-invalid':memberNick !== '' && (!memberNickValid || nickDuplicated)}" 
                    	@blur="nickDuplicatedCheck(memberNick)" name="memberNick">
                    <div class="valid-feedback">{{memberNickMessage}}</div>
                    <div class="invalid-feedback">{{memberNickMessage}}</div>
                </div>
                <div class="col-3"></div>
            </div>

            <div class="row mb-3">
                <div class="col-3"></div>
                <div class="col-6">
                    <input type="email" v-model="memberEmail" class="form-control" placeholder="이메일" 
                    	:class="{'is-valid':memberEmailValid && !emailDuplicated, 'is-invalid':memberEmail !== '' && (!memberEmailValid || emailDuplicated)}" 
                    	@blur="emailDuplicatedCheck(memberEmail)" name="memberEmail">
                    <div class="valid-feedback">{{memberEmailMessage}}</div>
                    <div class="invalid-feedback">{{memberEmailMessage}}</div>
                </div>
                <div class="col-3"></div>
            </div>

            <div class="row mb-3">
                <div class="col-3"></div>
                <div class="col-6">
                    <button type="submit" class="btn btn-info w-100" v-bind:disabled="!allValid">다음단계</button>
                </div>
                <div class="col-3"></div>
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
                    memberId:"",
                    memberPw:"",
                    memberPwRe:"",
                    memberNick:"",
                    memberEmail:"",
                    page:1,
                    agree:false,
                    idDuplicated:false,
                    nickDuplicated:false,
                    emailDuplicated:false,
                };
            },
            methods:{
            	  async idDuplicatedCheck(memberId){

                      const resp = await axios.get("/member/idDuplicatedCheck",{
                          params :{
                           memberId : this.memberId
                          }
                      });
                      if(resp.data === "N"){
                          this.idDuplicated = true;
                      }else{
                          this.idDuplicated = false; 
                      }
                      // this.idDuplicated= resp.data ==="Y";
                  },

                  async nickDuplicatedCheck(memberNick) {

                    const resp = await axios.get("/member/nickDuplicatedCheck", {
                        params : {
                            memberNick : this.memberNick
                        }
                    });
                    if(resp.data === "N") {
                        this.nickDuplicated = true;
                    }
                    else {
                        this.nickDuplicated = false;
                    }
                  },

                  async emailDuplicatedCheck(memberEmail) {

                    const resp = await axios.get("/member/emailDuplicatedCheck", {
                        params : {
                            memberEmail : this.memberEmail
                        }
                    });

                    if(resp.data === "N") {
                        this.emailDuplicated = true;
                    }
                    else {
                        this.emailDuplicated = false;
                    }
                  },

            },
            computed:{
                memberIdValid(){
                    const regex = /^[a-z][a-z0-9]{8,20}$/;
                    return regex.test(this.memberId);
                },
                memberIdMessage(){
                    if(this.memberId.length == 0) {
                        return "";
                    }
                    if(this.memberIdValid && !this.idDuplicated) {
                        return "사용 가능한 아이디입니다.";
                    }else if(this.idDuplicated) {
                        return "이미 사용중인 아이디입니다.";
                    }
                    else {
                        return "영소문자로 시작하여 숫자를 포함한 8~20자로 작성하세요.";
                    }
                },

              
                memberPwValid(){
                    const regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
                    return regex.test(this.memberPw);
                },
                memberPwMessage(){
                    if(this.memberPw.length == 0) {
                        return "";
                    }
                    else if(this.memberPwValid) {
                        return "올바른 비밀번호 형식입니다.";
                    }
                    else {
                        return "영문 대/소문자, 숫자, 특수문자를 반드시 포함하여 8~16자로 작성하세요.";
                    }
                },
                memberPwReValid(){
                	if(this.memberPwRe == '')
                	return false;
                    return this.memberPw == this.memberPwRe;
                },
                memberPwReMessage(){
                    if(this.memberPwRe.length == 0) {
                        return "";
                    }
                    else if(this.memberPw.length == 0) {
                        return "비밀번호를 먼저 입력하세요.";
                    }
                    else if(this.memberPwReValid) {
                        return "비밀번호가 일치합니다.";
                    }
                    else {
                        return "비밀번호가 일치하지 않습니다.";
                    }
                },
                memberNickValid(){
                    const regex = /^[가-힣0-9a-z!@#$.-_]{1,10}$/;
                    return regex.test(this.memberNick);
                },
                memberNickMessage(){
                    if(this.memberNick.length == 0) {
                        return "";
                    }
                    else if(this.memberNickValid && !this.nickDuplicated) {
                        return "사용 가능한 닉네임입니다.";
                    }
                    else if(this.nickDuplicated) {
                        return "이미 사용중인 닉네임입니다.";
                    }
                    else{
                        return "한글, 영문, 숫자, 특수문자 등을 사용하여 1~16자로 작성하세요.";
                    }
                },
                memberEmailValid(){
                    const regex = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
                    return regex.test(this.memberEmail);
                },
                memberEmailMessage(){
                    if(this.memberEmail.length == 0) {
                        return "";
                    }
                    else if(this.memberEmailValid && !this.emailDuplicated) {
                        return "사용 가능한 이메일입니다.";
                    }
                    else if(this.emailDuplicated) {
                        return "이미 사용중인 이메일입니다.";
                    }
                    else{
                        return "올바른 이메일 형식이 아닙니다.";
                    }
                },
                allValid(){
                    return this.memberIdValid
                                && this.memberPwValid
                                && this.memberPwReValid
                                && this.memberNickValid
                                && this.memberEmailValid
                                && !this.idDuplicated
                                && !this.nickDuplicated
                                && !this.emailDuplicated;
                },
            },
        }).mount("#app");
    </script>
  </body>
</html>


