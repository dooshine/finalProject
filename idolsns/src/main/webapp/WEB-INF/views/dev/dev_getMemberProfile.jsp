<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- c태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    
</style>

<div class="container-fluid" id="app">
    <div class="row">
        <div class="col">
            <a href="${pageContext.request.contextPath}/dev/follow">팔로우 통합</a>
        </div>
        <div class="col">
            <a href="${pageContext.request.contextPath}/dev/followMember">모두 팔로우한 회원목록</a>
        </div>
        <div class="col">
            <a href="${pageContext.request.contextPath}/dev/memberFollowCnt">팔로우 수</a>
        </div>
        <div class="col">
            <a href="${pageContext.request.contextPath}/dev/memberProfile">회원프로필</a>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <h1>회원 아이디 목록</h1>
        </div>
    </div>
    <div class="row" v-for="(memberId, i) in memberIdList" :key="i">
        <div class="col">
            {{i+1}} 번째 회원아이디: {{memberId}}
        </div>
    </div>

    <div class="row" v-for="(memberProfile, i) in memberProfileList" :key="i">
        <div class="col">
            {{i+1}} 번째 회원아이디: {{memberProfile.memberId}}
        </div>
        <div class="col ms-3">
            회원 닉네임: {{memberProfile.memberNick}}
        </div>
        <div class="col ms-3">
            attachmentNo: {{memberProfile.attachmentNo}}
        </div>
        <div class="col ms-3">
            <img :src="memberProfile.profileSrc" style="height: 50px; width: 50px;">
        </div>
    </div>
</div>


<!-- 뷰 스크립트 작성 -->
<script>
    Vue.createApp({
      data() {
        return {
            // 팔로우한 회원 목록
            memberIdList: ["testuser1", "testuser2", "testuser3"],
            memberProfileList: [],
        };
      },
      computed: {
        
      },
      methods: {
        // 테스트
        async test(){
            const url = "${contextPath}/rest/member/getMemberProfile";
            
            const resp = await axios.get(url, {
                params: {
                    memberIdList: this.memberIdList
                },
                paramsSerializer: params => {
		            return new URLSearchParams(params).toString();
                }
            })

            //console.log(resp.data);

            this.memberProfileList = resp.data;
        }
      },
      watch: {
  
      },
      created(){
        this.test();
      },
      updated(){
      }
    }).mount('#app')
  </script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	
	