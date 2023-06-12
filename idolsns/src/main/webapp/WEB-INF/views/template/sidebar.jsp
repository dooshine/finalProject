<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	.nav a {
		display: block;
		padding: 10px;
		margin-bottom: 10px;
		transition: background-color 0.3s ease;
	}
		
	.nav a:hover {
	  	background-color: #eee;
		border-radius: 10px / 10px;
	}
	
	#aside-bar i {
		font-weight: bold;
	}
	#aside-bar a {
		text-decoration: none;
		color: #333;
		font-weight: bold;
		font-size: 20px;
	}
	.selected {
		color: #6A53FB !important;
	}
	.nav a {
		padding-top: 10px;
		padding-bottom: 10px;
	}
	@media screen and (max-width:992px) {
		  	.nav .aside-name-tag {
				display: none;
		  	}
			.nav img {
				margin-left: 0px !important;
			}
			.nav a {
				justify-content: center;
			}
			#aside-footer {
				display: none;
			}
    	}
</style>
    
  <!-- aside -->
  <aside id="aside-bar" class="d-flex flex-column">
	<div class= "nav flex-column ps-3">
        <a href="${pageContext.request.contextPath}/">
        	<i class="fa-solid fa-house" :class="{selected: asideTab === '홈'}"><span class="ps-2 aside-name-tag"> 홈</span></i></a>
		<%-- 내 아이돌(비로그인-로그인모달 at footer) --%>
		<a href="#" v-if="memberId===''" data-bs-toggle="modal" data-bs-target="#loginModal">
        	<i class="ti ti-star-filled" :class="{selected: asideTab === '대표페이지'}"><span class="ps-2 aside-name-tag"> 내 아이돌</span></i></a>
		<%-- 내 아이돌(로그인-펼치기) --%>
		<a href="#" v-else @click="toggleMyArtist">
			<i class="ti ti-star-filled" :class="{selected: asideTab === '대표페이지'}"><span class="ps-2 aside-name-tag"> 내 아이돌</span></i></a>
		<div v-if="toggleFollowPageList">
			<a class="d-flex" :href="'/artist/'+followPage.artistEngNameLower + '/feed'" v-for="(followPage, i) in memberFollowObj.followPageList" :key="i">
				<img class="ms-3 rounded-circle" :src="followPage.profileSrc" style="height: 30px; width: 30px;">
				<div class="ms-2 aside-name-tag" :class="{selected: isPage(followPage.artistEngNameLower) }">{{fullName(followPage.artistName, followPage.artistEngName)}}</div>
			</a>
			<div v-if="memberFollowObj.followPageList===undefined">
				팔로우 한 대표페이지가 없습니다
			</div>
		</div>
        <a href="${pageContext.request.contextPath}/fund/list">
        	<!-- <i class="fa-solid fa-comments-dollar" :class="{selected: asideTab === '펀딩'}"> 펀딩</i></a> -->
			<i class="fa-solid fa-piggy-bank" :class="{selected: asideTab === '펀딩'}"><span class="ps-2 aside-name-tag"> 펀딩</span></i></a>
        <a href="${pageContext.request.contextPath}/point/charge">
        	<i class="fa-solid fa-wallet" :class="{selected: asideTab === '포인트'}"><span class="ps-2 aside-name-tag"> 충전</span></i></a>
		<c:if test="${'관리자'.equals(sessionScope.memberLevel)}">
			<a href="${pageContext.request.contextPath}/admin/">
				<i class="fa-solid fa-hammer" :class="{selected: asideTab === '관리자페이지'}"><span class="ps-2 aside-name-tag"> 관리자페이지</span></i></a>
		</c:if>
  	</div>
	<!-- 어사이드 푸터 -->
	<div id="aside-footer" class="mt-auto ps-4 pb-4">
		<span style="color: #7f7f7f" class="font-small2">
		<!-- <span style="background-color: forestgreen;"> -->
			개인정보처리방침 · 약관 · STARLINK © 2023
		</span>
	</div>
  </aside>
  

  <script>
	Vue.createApp({
	  data() {
		return {
		  // 로그인 회원 팔로우 목록 조회
		  memberFollowObj: {},
		  toggleFollowPageList: false,
		  asideTab: "",

		  // 로그인 회원 아이디
		  memberId: memberId,
		};
	  },
	  computed: {
  
	  },
	  methods: {

		// 로그인 회원 팔로우 정보 로드
		async loadMemberFollowInfo(){
			// 로그인X → 실행 X
			if(memberId==="") return;
			// url
			const url = "http://localhost:8080/rest/follow/memberFollowProfileInfo/"
			// 팔로우 목록 load
			const resp = await axios.get(url, {params:{memberId: memberId}});

			// 로그인 팔로우 정보 로드
			this.memberFollowObj = resp.data;
		},

		// 내 아이돌 
		toggleMyArtist(){
			if(memberId===""){
				if(!confirm("로그인이 필요한 페이지 입니다. 로그인하시겠습니까?")){
					return;
				}
				window.location.href="http://localhost:8080/member/login";
			} else {
				this.toggleFollowPageList = !this.toggleFollowPageList
			}
		},

		loadAsideTab(){
			// 경로
			const pathName = window.location.pathname;

			// 정규표현식(포인트, 펀딩, 홈, 대표페이지)
			const pointRegex = /^(\/point\/).*$/;
			const fundRegex = /^(\/fund\/).*$/;
			const homeRegex = /^\/$/;
			const artistRegex = /^(\/artist\/).*$/;
			const adminRegex = /^(\/admin\/).*$/;


			// 경로에 따른 asideTab 지정
			if(pointRegex.test(pathName)){
				this.asideTab = "포인트";
			} else if(fundRegex.test(pathName)){
				this.asideTab = "펀딩";
			} else if(homeRegex.test(pathName)){
				this.asideTab = "홈";
			} else if(artistRegex.test(pathName)){
				this.asideTab = "대표페이지";
				// 로그인 상태일 때만 펼치기
				if(memberId !== '') {
					this.toggleFollowPageList = true;
				}
			} else if(adminRegex.test(pathName)){
				this.asideTab = "관리자페이지";
			}
		},

		// 풀네임
		fullName(name, engName){
          return name + "(" + engName + ")";
        },

		isPage(artistEngNameLower){
			return window.location.pathname.includes(artistEngNameLower);
		}
		,
	  },
	  watch: {
  
	  },
	  created(){
		this.loadMemberFollowInfo();
		this.loadAsideTab();
	  },
	}).mount('#aside-bar')
  </script>