<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header_member.jsp"></jsp:include>
<%@ page import="javax.servlet.http.*" %>

<br><br><br><br><br><br>
<div class="container" id="app">

    <!-- 로그인 왼쪽 -->
    <div class="col-6" style="float:left; margin-left: 40px;">
        <img src="/static/image/logo.png" style="width:200px;">
        <br><br>
        <h3 class="font-gray2 font-bold">스타링크에서 당신의 아이돌과 소통하세요</h3>
    </div>

    <!-- 로그인 오른쪽 -->
    <div class="col-4 custom-container" style="background-color:white; float:right; margin-right: 100px;">
        <form class="w-100" action="login" method="post" autocomplete="off">

            <div class="custom-input-rounded-container mb-3 mt-4 mx-0">
                <input class="custom-input width: 100%;" type="text" name="memberId" placeholder="아이디">
            </div>

            <div class="custom-input-rounded-container mx-0 mb-1">
                <input class="custom-input " type="password" name="memberPw" placeholder="비밀번호">
            </div>

            <h6 class="font-purple1 text-center">${param.msg}</h6>


            <div class="custom-hr"></div>

            <div class="row my-3 mx-0 ">
                <button type="submit" class="custom-btn btn-round btn-purple1">로그인</button>
            </div>

        </form>

        <div class="modal" tabindex = "-1" role="dialog" id="exitCancleModal" data-bs-backdrop="static" ref="exitCancleModal" v-if="exitCancle">
            <div class="modal-dialog" role="document">
               <div class="modal-content   ">
                  <div class="modal-header">
                     <i class="fa-solid fa-xmark" style="color: #bcc0c8;" data-bs-dismiss="modal" aria-label="Close"></i>
                  </div>
                  <div class="modal-body ">
                  	<div class="row">
	                     <i class="fa-solid fa-lock" @click="goToPassword()">비밀번호 변경</i>
                  	</div>
                  	<div class="row">
	                     <i class="fa-solid fa-pen-to-square" @click="goToLogout()">로그아웃</i>
                  	</div>
                  	<div class="row">
	                     <i class="fa-sharp fa-solid fa-circle-minus " @click="goToExit()">회원탈퇴</i>
                  	</div>
                  </div>
               </div>
            </div>
         </div>	

        <div class="row mb-3  mx-0">
            <button type="button" @click="goToJoinPage" class="custom-btn btn-round btn-purple1-secondary">회원가입</button>
        </div>

        <div class="text-center">
            <a href="${pageContext.request.contextPath}/member/findId" style="text-decoration: none; color:gray;">아이디 /</a>
            <a href="${pageContext.request.contextPath}/member/findPw" style="text-decoration: none; color:gray;">비밀번호 찾기</a>
        </div>

    </div>

</div>

<script>
    const app = Vue.createApp({
        data() {
            return {
                exitCancleModal: null,
                exitCancle : true,
            };
        },
        methods: {
            goToJoinPage() {
                location.href = '${pageContext.request.contextPath}/member/join';
            }
        },
        mounted(){
        	this.exitCancleModal = new bootstrap.Modal(this.$refs.exitCancleModal);
        }
    });

    app.mount("#app");
</script>