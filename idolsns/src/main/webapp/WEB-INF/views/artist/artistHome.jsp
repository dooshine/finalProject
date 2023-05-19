<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- develope-css -->
<style>
    .develope-back-forestgreen {
        background: forestgreen;
        min-height: 300px;
    }
    .develope-back-aqua {
        background: aquamarine;
        min-height: 300px;
    }
    .mh-300{
        min-height: 300px;
    }
    .artist-profile-img {
        width: 200px;
        height: 200px;
    }
</style>

<!-- 제어영역 설정 -->
<div class="container" id="app" >
    <!-- # 대표페이지 프로필 -->
    <div class="row my-5 mx-5">
        <!-- 대표페이지 프로필 사진 -->
        <div class="col">
            <div class="border artist-profile-img rounded-circle overflow-hidden">
                <img src="https://via.placeholder.com/200x200?text=LOGO">
            </div>
        </div>

        <!-- 대표페이지 이름 및 팔로워 -->
        <div class="col container pt-4">
            <!-- 대표페이지 이름 -->
            <div class="row">
                <h1 class="p-0">
                    ${artistName}
                </h1>
            </div>
            <!-- 대표페이지 팔로워 -->
            <div class="row">
                팔로워 10,000명
            </div>
        </div>

        <!-- 버튼(팔로우하기, 글쓰기) -->
        <div class="col pt-4 container">
            <div class="row mb-2">
                <button class="btn btn-primary rounded-pill">팔로우하기</button>
            </div>
            <div class="row">
                <button class="btn btn-secondary rounded-pill">글쓰기</button>
            </div>
        </div>
    </div>

    <hr>

    <!-- # 지도 -->
    <div class="row px-5 pt-5 mb-4">
        <!-- [Component] 지도 -->
        <div class="col border rounded-4 mh-300 me-3">
            <h3>지도</h3>
        </div>
        <!-- [Component] 성지순례 목록글 -->
        <div class="col border rounded-4 mh-300 container p-4">
            <div class="row">
                <div class="col">
                    <h3>✨성지순례✨</h3>
                </div>
            </div>
            <div class="row">
                <div class="col container pt-3 px-4">
                    <div><i class="fa-solid fa-location-dot me-1"></i>카페 디퓨즈</div>
                    <div><i class="fa-solid fa-location-dot me-1"></i>신라 호텔</div>
                    <div><i class="fa-solid fa-location-dot me-1"></i>하니가 자주가는 국밥집</div>
                </div>
            </div>
        </div>
    </div>

    <!-- # 같이가요, 펀딩 -->
    <div class="row px-5">
        <!-- [Component] 같이가요 -->
        <div class="col border rounded-4 mh-300 container me-3 p-4">
            <div class="row">
                <div class="col">
                    <h3>👭같이가요👬</h3>
                </div>
            </div>
            <div class="row">
                <div class="col container pt-3 px-4">
                    <div>같이가용 같이가용</div>
                </div>
            </div>
        </div>
        <!-- [Component] 펀딩 -->
        <div class="col border rounded-4 mh-300 p-4">
            <div class="row">
                <div class="col">
                    <h3>📢후원하기📢</h3>
                    <!-- 🎉📣📣 -->
                </div>
            </div>
            <div class="row">
                <div class="col container pt-3 px-4">
                    <div>후원해요</div>
                </div>
            </div>
        </div>
    </div>
    

    <!-- 팔로우 테스트 -->
    <div>
        <!-- 팔로우 대상설정 -->
        <h2>팔로우 대상설정</h2>
        follow target type: <input type="text" v-model="followObj.followTargetType">
        follow target PK: <input type="text" v-model="followObj.followTargetPrimaryKey">
        
    </div>
    <div>
        <!-- 팔로우 비동기통신 테스트 -->
        <h2>팔로우 버튼</h2>
        <button class="btn-primary" @click="checkFollow">팔로우 확인</button><br>
        <button class="btn-secondary" @click="createFollow">팔로우 생성</button><br>
        <button class="btn-alert" @click="deleteFollow">팔로우 제거</button><br>
        <button class="btn-warning" @click="toggleFollow">팔로우 토글</button><br>
    </div>
</div>

<!-- 뷰 스크립트 작성 -->
<script>
    Vue.createApp({
      data() {
        return {
            followObj: {
                memberId: memberId,
                // followTargetType: "",
                // followTargetPrimaryKey: "",
                followTargetType: "회원",
                followTargetPrimaryKey: "testuser1",
            },
        };
      },
      computed: {
  
      },
      methods: {
        // 팔로우 확인
        async checkFollow(){
            // 팔로우 확인 url
            const url = "http://localhost:8080/rest/follow/check/";
            const resp = await axios.get(url, {
                params: this.followObj,
            });
            return resp.data;
        },
        // 팔로우 생성
        async createFollow(){
            // 팔로우 생성 url
            const url = "http://localhost:8080/rest/follow/";
            await axios.post(url, this.followObj);
            console.log(this.followObj);
            console.log("팔로우 생성");
        },
        // 팔로우 취소
        async deleteFollow(){
            // 팔로우 생성 url
            const url = "http://localhost:8080/rest/follow/";
            await axios.delete(url, {
                data: this.followObj,
            });
        },
        // 팔로우 토글
        async toggleFollow(){
            // 팔로우 확인 url
            console.log(this.checkFollow()); 
        }
      },
      watch: {
  
      },
      created(){
      },
    }).mount('#app')
</script>

<jsp:include page="/WEB-INF/views/artist/artistFooter.jsp"></jsp:include>