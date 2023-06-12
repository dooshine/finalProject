<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<!-- 카카오 api 키 등록 -->
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=047888df39ba653ff171c5d03dc23d6a&libraries=services"></script>
	<!-- 맵 관련 css -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/map.css">
	<!------- 카카오 지도 관련-------->



<!-- develope-css -->
<style>
   @media screen and (max-width:992px) {
		  	.col-6 {
		    width: 100%; 
		  }
    	}
    .mh-300{
        min-height: 300px;
    }
    .artist-profile-img {
        width: 130px;
        height: 130px;
    }
	.arti_name {
		font-weight: bold;
		font-size: 30px;
	}

	.arti_title {
		font-weight: bold;
		font-size: 20px;
	}
	
  .active-icon {
    color: #6A53FB;
  }
  #artist-header {
	width: 100%;
	height: 40px; 
  }
  #artist-header a {
	color: #7f7f7f;
    text-decoration: none;
  }
  #artist-header a.artist-header-tab-active {
  	color: black;
  }
  #artist-header a.artist-header-tab:not(.artist-header-tab-active):hover {
	cursor: pointer;
  	color: #404040
  }
</style>

<!-- 제어영역 설정 -->
<div id="artist-body">
	
	<%-- ######################## 본문 ######################## --%>
	<div class="custom-container pb-0">
	    <!-- # 대표페이지 프로필 -->
	    <div class="my-5 mx-5 d-flex">
	        <!-- 대표페이지 프로필 사진 -->
	        <div class="my-auto" >
	            <div class="border artist-profile-img rounded-circle overflow-hidden">
	                <img class="artist-profile-img " :src="artistObj.profileSrc">
	            </div>
	        </div>
	
	        <!-- 대표페이지 이름 및 팔로워 -->
	        <div class="col container my-auto" style="text-align:left; padding-left:2em;" >
	            <!-- 대표페이지 이름 -->
	            <div class="row arti_name">
					{{fullName(artistObj.artistName, artistObj.artistEngName)}}
	            </div>
	           
	            <!-- 대표페이지 팔로워 -->
	            <div class="row">
					팔로워 {{artistObj.followCnt ?? 0}}명
	            </div>
	        </div>
	
	        <!-- 버튼(팔로우하기, 글쓰기) -->
	        <div class="col container my-auto">
	            <div class="row mb-2 justify-content-end" >
	                <button class="custom-btn btn-round" style="width:150px;" 
	                :class="{'btn-purple1':!isFollowingArtist, 'btn-purple1-secondary': isFollowingArtist}"  v-text="isFollowingArtist?'팔로우취소':'팔로우하기'" @click="followPage">팔로우하기</button>
	            </div>
	            <div class="row justify-content-end">
	                <button class="custom-btn btn-round btn-gray" style="width:150px;">글쓰기</button>
	            </div>
	        </div>
	    </div>
	
	
	    <div class="custom-hr"></div>
	
		<%-- ######################## 대표페이지 헤더 ######################## --%>
		<div class="w-100" id="artist-header">
			<div class="d-flex justify-content-center">
				<a class="font-bold px-4 artist-header-tab" :href="makeHref('feed')">
					게시물
				</a>
				<a class="font-bold px-4 artist-header-tab" :href="makeHref('map')">
					지도
				</a>
				<a class="font-bold px-4 artist-header-tab artist-header-tab-active" :href="makeHref('fund')">
					후원
                </a>
			</div>
		</div>
		<%-- ######################## 대표페이지 헤더 끝######################## --%>
	</div>




	<%-- ######################## 펀딩 ######################## --%>
	<div class="custom-container mt-3">

		<h1>여기에 작성해주면되</h1>

	</div>
	<%-- ######################## 펀딩 끝 ######################## --%>
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




			// ######################## 후원 (lsh) ########################




			// ######################## 후원 (lsh) 끝 ########################
			
        };
      },
      computed: {
      },
	  watch: {
	  },
      methods: {
		// ######################## 대표페이지 method ########################
		// 풀네임 생성
        fullName(name, engName){
          return name + "(" + engName + ")";
        },
		    	// # 사전 로드(대표페이지 정보, 로그인회원 팔로우 정보)
        // 1. 대표페이지(아티스트) 정보 조회
        async loadArtist(){
            // 대표페이지 이름
            const artistEngNameLower = window.location.pathname.split("/").at(-2);
			// url
            const url = "http://localhost:8080/rest/artist/";
			// 조회
            const resp = await axios.get(url, { params: { artistEngNameLower: artistEngNameLower } });
			// 조회 결과 없을 시 
			if(resp.data)
			this.artistObj = resp.data;
			
			this.tagName = this.artistObj.artistName; // 태그명 설정
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
                if(!confirm(this.fullName(this.artistObj.artistName, this.artistObj.artistEngName) + "님 팔로우를 취소하시겠습니까?")) return;
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
        },
        // 대표페이지 팔로우 취소
        async deleteFollow(){
            // 팔로우 생성 url
            const url = "http://localhost:8080/rest/follow/";
            await axios.delete(url, {
                data: this.followPageObj,
            });
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
        makeHref(target){
            const pathName = window.location.pathname;
			const pathArr = pathName.split('/').slice();
			return pathArr.slice(0, pathArr.length-1).join('/') + '/' + target;
        }
		// ######################## 대표페이지 method 끝 ########################




		// ######################## 후원(lsh) method ########################




		// ######################## 후원(lsh) method(끝) ########################
      },
      async mounted(){
		// 1. 아티스트 정보 로드
        this.loadArtist();
        // 2. 로그인 한 사람 팔로우 정보 로드
        this.loadMemberFollowInfo();
      },

	  created(){
		
	  }
    }).mount('#artist-body')
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>