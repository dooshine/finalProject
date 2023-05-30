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


    .btn-primary {
        background-color: #6A53FB;
    }
    .btn-primary:hover {
        background-color: #6A53FB;
    }
</style>

<!-- 제어영역 설정 -->
<div class="container" id="app" >
    <!-- # 대표페이지 프로필 -->
    <div class="row my-5 mx-5">
        <!-- 대표페이지 프로필 사진 -->
        <div class="col">
            <div class="border artist-profile-img rounded-circle overflow-hidden">
                <!-- <img src="https://via.placeholder.com/200x200?text=LOGO"> -->
                <img :src="artistObj.attachmentNo==null?'https://via.placeholder.com/200x200?text=LOGO':'/download?attachmentNo='+artistObj.attachmentNo">
            </div>
        </div>

        <!-- 대표페이지 이름 및 팔로워 -->
        <div class="col container pt-4">
            <!-- 대표페이지 이름 -->
            <div class="row">
                <h1 class="p-0">
                    {{fullName}}
                </h1>
            </div>
            <!-- 대표페이지 팔로워 -->
            <div class="row">
                팔로워 {{artistObj.followCnt ?? 0}}명
            </div>
        </div>

        <!-- 버튼(팔로우하기, 글쓰기) -->
        <div class="col pt-4 container">
            <div class="row mb-2">
                <button class="btn rounded-pill" :class="{'btn-primary':!isFollowingArtist, 'btn-secondary': isFollowingArtist}"  v-text="isFollowingArtist?'팔로우취소':'팔로우하기'" @click="followPage">팔로우하기</button>
                <!-- <button  :class="{'btn-primary':!isFollowMemberList[i], 'btn-secondary': isFollowMemberList[i]}" v-text="isFollowMemberList[i]?'팔로우취소':'팔로우하기'" @click="followMember(member.memberId, i)"></button> -->
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
</div>


<!-- 뷰 스크립트 작성 -->
<script>
    Vue.createApp({
      data() {
        return {
            artistObj: {},
            followPageObj: {
                memberId: memberId,
                followTargetType: "",
                followTargetPrimaryKey: "",
            },


            memberFollowObj: {},
            isFollowingArtist: false,
        };
      },
      computed: {
        fullName(){
            return this.artistObj.artistName + "(" + this.artistObj.artistEngName + ")";
        },
      },
      methods: {

        // # 사전 로드(대표페이지 정보, 로그인회원 팔로우 정보)
        // 1. 대표페이지(아티스트) 정보 조회
        async loadArtist(){
            // 대표페이지 이름
            const artistEngNameLower = window.location.pathname.split("/").at(-1);

            const url = "http://localhost:8080/rest/artist/";

            const resp = await axios.get(url, { params: { artistEngNameLower: artistEngNameLower } });
            console.table(resp.data)
            this.artistObj = resp.data;
        },
        // 2.로그인 회원 팔로우 정보 로드
        async loadMemberFollowInfo(){
            // 로그인X → 실행 X
            if(memberId==="") return;

            const url = "http://localhost:8080/rest/follow/memberFollowInfo/"

            const resp = await axios.get(url, {params:{memberId: memberId}});

            // 로그인 팔로우 정보 로드
            this.memberFollowObj = resp.data;
            // 팔로우 버튼 동기화
            this.isFollowingArtist = this.checkFollow();
        },


        // 대표페이지 팔로우확인
        checkFollow(){
            // 로그인 안했으면 return false
            if(memberId === "") return false;
            
            // 팔로우 대표페이지 목록
            const followPageList = this.memberFollowObj.followPageList;

            if(this.memberFollowObj.followPageList!==undefined){
                if(followPageList===null) {
                    return false;
                } else {
                    const isFollowing = followPageList.includes(this.artistObj.artistEngNameLower);
                    return isFollowing;
                }
            }
        },




        // 페이지 팔로우 버튼
        async followPage(){
            // 1. 회원 로그인 확인
            if(memberId === ""){
                if(confirm("로그인 한 회원만 사용할 수 있는 기능입니다. 로그인 하시겠습니까?")) {
                    window.location.href = contextPath + "/member/login";
                }
            }

            // 2. toggle 팔로우 삭제, 팔로우 생성
            if(this.isFollowingArtist){
                if(!confirm(this.fullName + "님 팔로우를 취소하시겠습니까?")) return;
                this.setFollowPageObj();
                await this.deleteFollow();
            } else {
                this.setFollowPageObj();
                await this.createFollowPage();
            }

            this.loadArtist();
            this.loadMemberFollowInfo();
        },




        // 대표페이지 팔로우 생성
        async createFollowPage(){
            // 팔로우 생성 url
            const url = "http://localhost:8080/rest/follow/";
            await axios.post(url, this.followPageObj);
            // [develope] 
            console.log(this.followPageObj.memberId + "님의 " + this.followPageObj.followTargetPrimaryKey + "님 팔로우 생성");
        },
        // 대표페이지 팔로우 취소
        async deleteFollow(){
            // 팔로우 생성 url
            const url = "http://localhost:8080/rest/follow/";
            await axios.delete(url, {
                data: this.followPageObj,
            });
            // [develope]
            console.log(this.followPageObj.memberId + "님의 " + this.followPageObj.followTargetPrimaryKey + "님 팔로우 제거");
        },
        // 팔로우 토글
        async toggleFollow(){
            // 1. 회원 로그인 확인
            if(memberId === ""){
                if(confirm("로그인 한 회원만 사용할 수 있는 기능입니다. 로그인 하시겠습니까?")) {
                    window.location.href = contextPath + "/member/login";
                }
            }
            // 팔로우 확인 url
            console.log(this.checkFollow()); 
        },
        


        // 대표페이지 팔로우 대상 설정
        setFollowPageObj (){
            // 아티스트 이름
            const artistName = window.location.pathname.split("/").at(-1);
            // 팔로우 대상 유형
            this.followPageObj.followTargetType = "대표페이지";
            // 팔로우 대상 PK
            this.followPageObj.followTargetPrimaryKey = artistName;
        },



        
      },
      watch: {
  
      },
      created(){
        // 페이지 로드
        // 1. 아티스트 정보 로드
        this.loadArtist();
        // 2. 로그인 한 사람 팔로우 정보 로드
        this.loadMemberFollowInfo();




        // this.followBtn();

        



      },
    }).mount('#app')
</script>

<%-- <jsp:include page="/WEB-INF/views/artist/artistFooter.jsp"></jsp:include> --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>