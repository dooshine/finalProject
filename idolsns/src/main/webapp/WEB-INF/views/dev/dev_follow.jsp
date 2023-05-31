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
        <div class="col">
            <a href="/dev/memberProfile">회원프로필</a>
        </div>
    </div>
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
                            <button class="btn rounded-fill" :class="{'btn-primary':!isFollowMemberList[i], 'btn-secondary': isFollowMemberList[i]}" v-text="isFollowMemberList[i]?'팔로우취소':'팔로우하기'" @click="followMember(member.memberId, i)"></button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
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
    <div class="row" v-for="(followingMember, i) in followMemberList">
        <div class="col">
            {{i+1}}
        </div>
        <div class="col">
            {{followingMember}}
        </div>
    </div>
    <hr>




    <!-- # 팔로우한 페이지 목록 예시 -->
    <!-- 모든 페이지 목록 -->
    <div class="row mt-5">
        <div class="col">
            <h1>모든 페이지 목록</h1>
        </div>
    </div>
    <!-- 모든 대표페이지 목록  -->
    <div class="row">
        <div class="col">
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">대표페이지 이름</th>
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
                            <button class="btn rounded-fill" :class="{'btn-primary':!isFollowMemberList[i], 'btn-secondary': isFollowMemberList[i]}" v-text="isFollowMemberList[i]?'팔로우취소':'팔로우하기'" @click="followMember(member.memberId, i)"></button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
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
    <!-- 팔로우한 페이지 목록  -->
    <div class="row" v-for="(followPage, i) in followPageList">
        <div class="col">
            {{i+1}}
        </div>
        <div class="col">
            {{followPage}}
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

            // 팔로우한 페이지 목록
            followPageList: [],

            // 회원 리스트
            memberList: [],

            // 회원 팔로우 여부 리스트
            isFollowMemberList: [],
        };
      },
      computed: {
        
      },
      methods: {
        // [함수] 모든 회원 목록 불러오기
        async loadMemberList(){
            // url
            const url = "http://localhost:8080/rest/admin/member";
            // api호출
            const resp = await axios.post(url,{});
            // data 반영
            this.memberList = resp.data;

            // 회원 팔로우 여부 조회
            for(let i = 0; i<resp.data.length; i++){
                this.isFollowMemberList[i] = await this.checkFollowMember(resp.data[i].memberId);
            }
        },
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
        // [함수] 팔로우한 대표페이지 목록 불러오기
        async loadFollowingArtistList(){
            // 비로그인시 실행X
            if(memberId==="") return;
            // url
            const url = "http://localhost:8080/rest/follow/page";
            // api호출
            const resp = await axios.get(url);
            // data 반영
            this.followPageList = resp.data;
        },
        




        // [함수] 페이지 팔로우 여부 확인
        async checkFollowPage(artistName){
            // 팔로우 확인 url
            const url = "http://localhost:8080/rest/follow/checkFollowPage/";
            const resp = await axios.get(url, {
                params: {followTargetPrimaryKey: artistName},
            });
            return resp.data;
        },
        // [함수] 회원 팔로우 여부 확인
        async checkFollowMember(memberId){
            // 팔로우 확인 url
            const url = "http://localhost:8080/rest/follow/checkFollowMember";
            const resp = await axios.get(url, {
                params: {followTargetPrimaryKey: memberId},
            });
            return resp.data;
        },
        // [함수] 회원 팔로우 반영
        async setIsFollowMemberList(){
            for(let i = 0; i<this.memberList.length; i++){
                this.isFollowMemberList[i] = this.checkFollowMember(this.memberList[i].memberId);
            }
        },



        // 회원 팔로우 생성
        async createFollowMember(followTargetId){
            // url
            const url = "http://localhost:8080/rest/follow/member";
            const resp = await axios.post(url, { followTargetPrimaryKey: followTargetId });
        },

        // 회원 팔로우 취소
        async deleteFollowMember(followTargetId){
            // url
            const url = "http://localhost:8080/rest/follow/member";
            await axios.delete(url, { data: {followTargetPrimaryKey: followTargetId} });
        },

        // 팔로우 버튼
        async followMember(targetId, i){
            console.log(this.isFollowMemberList[i]);
            const isFollowing = this.isFollowMemberList[i];
            if(isFollowing) {
                // 팔로우 삭제
                await this.deleteFollowMember(targetId);
            } else {
                // 팔로우 생성
                await this.createFollowMember(targetId);
            }
            this.loadMemberList();
            this.loadFollowMemberList();
        },
      },
      watch: {
  
      },
      created(){
        // 모든 회원 목록 불러오기
        this.loadMemberList();
        // 팔로우한 회원 목록 불러오기
        this.loadFollowMemberList();
        // 팔로우한 페이지 목록 불러오기
        this.loadFollowingArtistList();
        
      },
      updated(){
      }
    }).mount('#app')
  </script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	
	