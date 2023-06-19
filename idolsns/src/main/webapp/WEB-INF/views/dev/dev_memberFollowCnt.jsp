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
    <!-- # 팔로우 통계 예시 -->
    <!-- 모든회원 팔로우 통계 타이틀 -->
    <div class="row mt-5">
        <div class="col">
            <h1>모든회원 팔로우 통계</h1>
        </div>
    </div>
    <!-- 회원 팔로우 통계  -->
    <div class="row">
        <div class="col">
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">번호</th>
                        <th scope="col">회원아이디</th>
                        <th scope="col">회원팔로우 수</th>
                        <th scope="col">회원팔로워 수</th>
                        <th scope="col">페이지팔로우 수</th>
                        <th scope="col">관리도구</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(memberFollowCnt, i) in allMemberFollowCnt" :key="i">
                        <td>
                            {{i+1}}
                        </td>
                        <td>{{memberFollowCnt.memberId}}</td>
                        <td>{{memberFollowCnt.memberFollowCnt}}</td>
                        <td>{{memberFollowCnt.memberFollowerCnt}}</td>
                        <td>{{memberFollowCnt.memberPageCnt}}</td>
                        <td>
                            <!-- <button class="btn rounded-fill" :class="{'btn-primary':!isFollowMemberList[i], 'btn-secondary': isFollowMemberList[i]}" v-text="isFollowMemberList[i]?'팔로우취소':'팔로우하기'" @click="followMember(member.memberId, i)"></button> -->
                            관리도구
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <hr>




    <!-- 특정회원 팔로우 통계 타이틀 -->
    <div class="row mt-5">
        <div class="col">
            <h1>특정회원 팔로우 통계</h1>
        </div>
    </div>
    <!-- 회원ID 입력 창 통계  -->
    <div class="row mt-3">
        <div class="col">
            <h3>아이디 입력</h3>
        </div>
    </div> 
    <div class="row mt-3">
        <div class="col">
            <input class="me-3" type="text" v-model="targetMemberId">
            <button type="button" class="btn btn-primary" @click="selectTargetMemberFollowCnt">검색</button>
        </div>
    </div> 

    <!-- 특정회원 팔로우 통계  -->
    <div class="row mt-5">
        <div class="col">
            <h3>특정회원 팔로우 통계</h3>
        </div>
    </div> 
    <div class="row">
        <div class="col">
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">회원아이디</th>
                        <th scope="col">회원팔로우 수</th>
                        <th scope="col">회원팔로워 수</th>
                        <th scope="col">페이지팔로우 수</th>
                        <th scope="col">관리도구</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(memberFollowCnt, i) in targetMemberFollowCnt" :key="i">
                        <td>{{memberFollowCnt.memberId}}</td>
                        <td>{{memberFollowCnt.memberFollowCnt}}</td>
                        <td>{{memberFollowCnt.memberFollowerCnt}}</td>
                        <td>{{memberFollowCnt.memberPageCnt}}</td>
                        <td>
                            <!-- <button class="btn rounded-fill" :class="{'btn-primary':!isFollowMemberList[i], 'btn-secondary': isFollowMemberList[i]}" v-text="isFollowMemberList[i]?'팔로우취소':'팔로우하기'" @click="followMember(member.memberId, i)"></button> -->
                            관리도구
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <hr>


    <!-- 팔로우 수 예시 -->
    <h1 v-for="(memberFollowCnt, i) in targetMemberFollowCnt" :key="i">내가 팔로우 한 사람: {{memberFollowCnt.memberFollowCnt}}</h1>
    <h1 v-for="(memberFollowCnt, i) in targetMemberFollowCnt" :key="i">나를 팔로우 한 사람: {{memberFollowCnt.memberFollowerCnt}}</h1>
</div>


<!-- 뷰 스크립트 작성 -->
<script>
    Vue.createApp({
      data() {
        return {
            // 팔로우한 회원 목록
            allMemberFollowCnt: [],

            // 타겟 아이디
            targetMemberId: "",
            targetMemberFollowCnt: [],
        };
      },
      computed: {
        
      },
      methods: {
        // [함수] 모든회원 팔로우 통계 조회
        async loadAllMemberFollowCntList(){
            // url
            const url = "${contextPath}/rest/follow/memberFollowCnt";
            // api호출
            const resp = await axios.get(url);
            // data 반영
            this.allMemberFollowCnt = resp.data;
        },

        // [함수] 특정회원 팔로우 통계 조회
        async selectTargetMemberFollowCnt(){
            // url
            const url = "${contextPath}/rest/follow/memberFollowCnt";
            // api호출
            const resp = await axios.get(url, { params: {memberId: this.targetMemberId} });
            // data 반영
            this.targetMemberFollowCnt = resp.data;
            //console.log("야호");
        },

      },
      watch: {
  
      },
      created(){

        // 팔로우한 회원 목록 불러오기
        this.loadAllMemberFollowCntList();
        
      },
    }).mount('#app')
  </script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	
	