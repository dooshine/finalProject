<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- c태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .btn-primary {
        background-color: #6A53FB;
    }
    .btn-primary:hover {
        background-color: #6A53FB;
    }
</style>

<div class="container-fluid" id="app">
    <div class="row">
        <div class="col">
            <a href="/dev/follow">팔로우 통합</a>
        </div>
        <div class="col">
            <a href="/dev/followMember">팔로우한 회원목록</a>
        </div>
        <div class="col">
            <a href="/dev/memberFollowCnt">팔로우 수</a>
        </div>
    </div>
    <!-- # 팔로우한 회원 목록 예시 -->
    <!-- 팔로우한 회원 목록 타이틀 -->
    <div class="row mt-5">
        <div class="col">
            <h1>팔로우한 회원 목록</h1>
        </div>
    </div>

    <!-- 로그인 안했을 경우 보여줄 메세지 -->
    <c:if test="${sessionScope.memberId == null}">
        <h2>로그인을 하면 팔로우한 회원 목록을 확인할 수 있습니다.</h2>
    </c:if>

    <!-- 팔로우한 회원 목록  -->
    <div class="row" v-for="(followingMember, i) in followMemberList">
        <div class="col">
            {{i+1}}
        </div>
        <div class="col">
            {{followingMember}}
        </div>
    </div>
    <hr>
</div>


<!-- 뷰 스크립트 작성 -->
<script>
    Vue.createApp({
      data() {
        return {
            // 팔로우한 회원 목록
            followMemberList: [],
        };
      },
      computed: {
        
      },
      methods: {
        // [함수] 팔로우한 회원 목록 불러오기
        async loadFollowMemberList(){
            // 비로그인시 실행X
            if(memberId==="") return;
            // url
            const url = "http://localhost:8080/rest/follow/member";
            // api호출
            const resp = await axios.get(url);
            // data 반영
            this.followMemberList = resp.data;
        },
      },
      watch: {
  
      },
      created(){

        // 팔로우한 회원 목록 불러오기
        this.loadFollowMemberList();
        
      },
    }).mount('#app')
  </script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	
	