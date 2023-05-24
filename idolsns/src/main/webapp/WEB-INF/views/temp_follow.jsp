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
    <!-- # 팔로우 예시 타이틀 -->
    <div class="row">
        <div class="col">
            <h1>팔로우 예시</h1>
        </div>
    </div>
    <hr>

    <!-- 모든 회원 목록 -->
    <div class="row mt-5">
        <div class="col">
            <h1>모든 회원 목록</h1>
        </div>
    </div>
    <!-- 모든 회원 목록  -->
    <div class="row">
        <div class="col">
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">회원아이디</th>
                        <th scope="col">회원닉네임</th>
                        <th scope="col">회원포인트</th>
                        <th scope="col">회원이메일</th>
                        <th scope="col">회원가입날짜</th>
                        <th scope="col">최근로그인날짜</th>
                        <th scope="col">관리도구</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(member, i) in memberList" :key="i">
                        <td>
                            {{member.memberId}}
                        </td>
                        <td>{{member.memberNick}}</td>
                        <td>{{member.memberPoint}}</td>
                        <td>{{member.memberEmail}}</td>
                        <td>{{member.memberJoin}}</td>
                        <td>{{member.memberLogin === null ? "미접속": member.memberLogin }}</td>
                        <td>
                            <!-- <i class="fa-solid fa-user-xmark" data-bs-toggle="modal" data-bs-target="#repotModal1" @click="setReportDto(member.memberId)"></i> -->
                    <!-- <button class="btn btn-primary" @click="followMember(member.memberId)">팔로우하기</button> -->
                            <button class="btn rounded-pill btn-primary text-white">팔로우하기</button>
                            <button class="btn rounded-pill btn-secondary">팔로우취소하기</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- <div class="row" v-for="(followingMember, i) in followingMemberList">
        {{followingMember}}
    </div> -->
    <hr>

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
    <div class="row" v-for="(followingMember, i) in followingMemberList">
        {{followingMember}}
    </div>
    <hr>

    <!-- # 팔로우한 페이지 목록 예시 -->
    
    <!-- 팔로우한 페이지 목록 타이틀 -->
    <div class="row mt-5">
        <div class="col">
            <h1>팔로우한 페이지 목록</h1>
        </div>
    </div>
    <!-- 로그인 안했을 경우 보여줄 메세지 -->
    <c:if test="${sessionScope.memberId == null}">
        <h2>로그인을 하면 팔로우한 페이지 목록을 확인할 수 있습니다.</h2>
    </c:if>
    <!-- 팔로우한 회원 목록  -->
    <div class="row" v-for="(followingPage, i) in followingPageList">
        {{followingPage}}
    </div>
    <hr>
</div>

<!-- 뷰 스크립트 작성 -->
<script>
    Vue.createApp({
      data() {
        return {
            // 팔로우한 회원 목록
            followingMemberList: [],
            // 팔로우한 페이지 목록
            followingPageList: [],

            // 회원 리스트
            memberList: [], 
        };
      },
      computed: {
  
        },
      methods: {
        // [함수] 팔로우한 회원 목록 불러오기
        async loadFollowingMemberList(){
            // 비로그인시 실행X
            if(memberId==="") return;
            // url
            const url = "http://localhost:8080/rest/follow/member";
            // api호출
            const resp = await axios.get(url);
            // data 반영
            this.followingMemberList = resp.data;
        },
        // [함수] 팔로우한 대표페이지 목록 불러오기
        async loadFollowingArtistList(){
            // 비로그인시 실행X
            if(memberId==="") return;
            // url
            const url = "http://localhost:8080/rest/follow/page";
            // api호출
            const resp = await axios.get(url);
            // data 반영
            this.followingPageList = resp.data;
        },
        // [함수] 모든 회원 목록 불러오기
        async loadFollowingArtistList(){
            // url
            const url = "http://localhost:8080/rest/admin/member";
            // api호출
            const resp = await axios.post(url,{});
            // data 반영
            this.memberList = resp.data;
        },
      },
      watch: {
  
      },
      created(){
        // 모든 회원 목록 불러오기

        // 팔로우한 회원 목록 불러오기
        this.loadFollowingMemberList();
        // 팔로우한 페이지 목록 불러오기
        this.loadFollowingArtistList();
      },
    }).mount('#app')
  </script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	
	