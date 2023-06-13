<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- c태그 라이브러리 -->
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
</style>
  
<!-- aside -->
<c:if test="${admin}">
	<aside id="aside-bar">
		<div class= "nav flex-column ps-3">
			<a href="${pageContext.request.contextPath}/admin/">
				<i class="fa-solid fa-house" :class="{selected: asideTab === '관리자홈'}">
					<span class="ps-2"> 관리자 홈</span>
				</i>
			</a>
			<a href="${pageContext.request.contextPath}/admin/member">
				<i class="fa-solid fa-user" :class="{selected: asideTab === '회원관리'}">
					<span class="ps-2"> 회원 관리</span>
				</i>
			</a>
			<a href="${pageContext.request.contextPath}/admin/report">
				<i class="fa-solid fa-list" :class="{selected: asideTab === '신고관리'}">
					<span class="ps-2"> 신고 관리</span>
				</i>
			</a>
			<a href="${pageContext.request.contextPath}/admin/sanction">
				<i class="fa-solid fa-list" :class="{selected: asideTab === '제재관리'}">
					<span class="ps-2"> 제재 관리</span>
				</i>
			</a>
			<a href="${pageContext.request.contextPath}/admin/tag">
				<i class="fa-sharp fa-solid fa-tags" :class="{selected: asideTab === '태그관리'}">
					<span class="ps-2"> 태그 관리</span>
				</i>
			</a>
			<a href="${pageContext.request.contextPath}/admin/tagCnt">
				<i class="fa-sharp fa-solid fa-tags" :class="{selected: asideTab === '태그별사용량조회'}">
					<span class="ps-2"> 태그별 사용량 조회</span>
				</i>
			</a>
			<a href="${pageContext.request.contextPath}/admin/fixedTag">
				<i class="fa-sharp fa-solid fa-tags" :class="{selected: asideTab === '고정태그관리'}">
					<span class="ps-2"> 고정태그 관리</span>
				</i>
			</a>
			<a href="${pageContext.request.contextPath}/admin/artist">
				<i class="fa-sharp fa-solid fa-star" :class="{selected: asideTab === '아티스트관리'}">
					<span class="ps-2"> 아티스트 관리</span>
				</i>
			</a>
	</aside>
</c:if>

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
		  const url = "${contextPath}/rest/follow/memberFollowProfileInfo/"
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
			  window.location.href="${contextPath}/member/login";
		  } else {
			  this.toggleFollowPageList = !this.toggleFollowPageList
		  }
	  },

	  loadAsideTab(){
		console.log(window.location.pathname);
		const pathName = window.location.pathname;
		if(pathName === "/admin/"){
			this.asideTab = "관리자홈";
		} else if(pathName.includes("member")){
			this.asideTab = "회원관리";
		} else if(pathName.includes("report")){
			this.asideTab = "신고관리";
		} else if(pathName.includes("sanction")){
			this.asideTab = "제재관리";
		} else if(pathName.includes("tagCnt")){
			this.asideTab = "태그별사용량조회";
		} else if(pathName.includes("fixedTag")){
			this.asideTab = "고정태그관리";
		} else if(pathName.includes("tag")){
			this.asideTab = "태그관리";
		} else if(pathName.includes("artist")){
			this.asideTab = "아티스트관리";
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