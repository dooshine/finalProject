<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
</style>
    
  <!-- aside -->
  <aside class ="col-12 py-4" id="aside-bar">
	<div class= "nav flex-column">
        <a href="${pageContext.request.contextPath}/">
        	<i class="fa-solid fa-house" :class="{selected: asideTab === '홈'}"></i><span class="ps-2"> 홈</span></a>
        <a href="#" @click="toggleMyArtist">
        	<i class="ti ti-star-filled" :class="{selected: asideTab === '대표페이지'}"><span class="ps-2"> 내 아이돌</span></i></a>
		<div v-if="toggleFollowPageList">
			<a class="d-flex" :href="'/artist/'+followPage.artistEngNameLower" v-for="(followPage, i) in memberFollowObj.followPageList" :key="i">
				<img class="ms-3 rounded-circle" :src="followPage.profileSrc" style="height: 30px; width: 30px;">
				<div class="ms-2" :class="{selected: isPage(followPage.artistEngNameLower) }">{{fullName(followPage.artistName, followPage.artistEngName)}}</div>
			</a>
		</div>
        <a href="${pageContext.request.contextPath}/fund/list">
        	<!-- <i class="fa-solid fa-comments-dollar" :class="{selected: asideTab === '펀딩'}"> 펀딩</i></a> -->
			<i class="fa-solid fa-piggy-bank" :class="{selected: asideTab === '펀딩'}"><span class="ps-2"> 펀딩</span></i></a>
        <a href="${pageContext.request.contextPath}/point/charge">
        	<i class="fa-solid fa-wallet" :class="{selected: asideTab === '충전'}"><span class="ps-2"> 충전</span></i></a>
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
			console.log(window.location.pathname);
			if(window.location.pathname.includes("point")){
				this.asideTab = "충전";
			} else if(window.location.pathname.includes("fund")){
				this.asideTab = "펀딩";
			} else if(window.location.pathname==="/"){
				this.asideTab = "홈";
			} else if(window.location.pathname.includes("artist")){
				this.asideTab = "대표페이지";
				this.toggleFollowPageList = true;
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