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
</style>
    
  <!-- aside -->
  <aside class ="col-12" id="aside-bar">
	<div class= "nav flex-column">
        <a href="${pageContext.request.contextPath}/">
        	<i class="fa-solid fa-house"> 홈</i></a>
        <a href="${pageContext.request.contextPath}/member/follower">
        	<i class="fa-solid fa-user"> 내 친구</i></a>
        <a href="#" @click="toggleMyArtist">
        	<i class="fa-solid fa-star"> 내 아이돌</i></a>
			<div v-if="toggleFollowPageList" >
				<a :href="'/artist/'+followPage.artistEngNameLower" v-for="(followPage, i) in memberFollowObj.followPageList" :key="i">
					<img class="ms-3 rounded-circle" :src="followPage.profileSrc" style="height: 30px; width: 30px;">
					<div class="fa-solid ms-2">{{fullName(followPage.artistName, followPage.artistEngName)}}</div>
				</a>
			</div>
        <a href="${pageContext.request.contextPath}/fund/list">
        	<i class="fa-solid fa-sack-dollar"> 펀딩</i></a>
        <a href="${pageContext.request.contextPath}/point/charge">
        	<i class="fa-sharp fa-solid fa-coins"> 충전</i></a>
       	<button>글쓰기</button>
  	</div>
  </aside>


  <script>
	Vue.createApp({
	  data() {
		return {
		  // 로그인 회원 팔로우 목록 조회
		  memberFollowObj: {},
		  toggleFollowPageList: false,
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
		// 풀네임
		fullName(name, engName){
          return name + "(" + engName + ")";
        },
	  },
	  watch: {
  
	  },
	  created(){
		this.loadMemberFollowInfo();
	  },
	}).mount('#aside-bar')
  </script>