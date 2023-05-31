<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <!-- 폰트어썸 cdn -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
    <!-- jquery cdn -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <!-- 뷰 cdn -->
    <script src="https://unpkg.com/vue@3.2.26"></script>
    <!-- axios -->
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <!-- lodash -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
    <!-- moment -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
    <!-- 부트스트랩 css(공식) -->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">

    <!-- custom 테스트 css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/test.css">
    <!-- tabler 아이콘 -->
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">
    <!-- toastify -->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
	<style>
		.profile-image-wrapper {
		    position: relative;
		    display: inline-block;
		}
		
		.profile-image {
		    width: 200px;
		    height: 200px;
		    border-radius: 100%;
		    transition: filter 0.3s;
		}
		
		.profile-image:hover {
		    filter: brightness(50%);
}
	</style>
</head>
<body>
	<div class="container rounded p-3" style="background-color:white">
	<div id="app">
		
		<div class="container">
			<div class="row">
				<a href="${pageContext.request.contextPath}/member/exit">회원탈퇴</a>
				<a href="${pageContext.request.contextPath}/member/password">비밀번호 변경</a>
			</div>
			
			<div class="row">
				<div>
					<img :src="memberProfileImageObj !== ''  && memberProfileImageObj.attachmentNo !== undefined ? '/download/?attachmentNo='+memberProfileImageObj.attachmentNo :  ' /static/image/profileDummy.png' "
						style="width: 200px; height: 200px; border-radius: 100%;">
				</div>
			</div>
			
			<div class="row">
				<div class="col-8">
					<h3>{{memberNick}}</h3>
					<h5>@{{memberId}}</h5>
				</div>
				<div class="col-4 text-right">
					<button type = "button" class="btn btn-primary mt-4" v-on:click = "showModal">프로필 수정</button>
				</div>
			</div>
			<div class="row">
				<div class="col-4 " style="display: flex; justify-content: space-between; flex-direction: column; align-items: center;" 
					v-on:click="showFollowModal">
					<span >팔로우</span>
					<span>{{ MemberFollowCnt }}명</span>
				</div>
				<div class="col-4 " style="display: flex; justify-content: space-between; flex-direction: column; align-items: center;"
					v-on:click="showFollowerModal">
					<span>팔로워</span>
					<span>{{ MemberFollowerCnt }}명</span>
				</div>
				<div class="col-4 " style="display: flex; justify-content: space-between; flex-direction: column; align-items: center;"
					v-on:click="showPageModal">
					<span>페이지</span>
					<span>{{ MemberPageCnt }}명</span>
				</div>
			</div>
			
			<div class="modal" tabindex = "-1" role="dialog" id="modal" data-bs-backdrop="static" ref="modal">
				<div class="modal-dialog" role="document">
					<div class="modal-content	">
						<div class="modal-header">
							<i class="fa-solid fa-xmark" style="color: #bcc0c8;" data-bs-dismiss="modal" aria-label="Close"></i>
						</div>
						<div class="modal-body text-center">
							<img :src="memberProfileImageObj !== ''  && memberProfileImageObj.attachmentNo !== undefined ? '/download/?attachmentNo='+memberProfileImageObj.attachmentNo :  ' /static/image/profileDummy.png' "
								class="profile-image">
							<h3>
					            <span v-if="!editingNickname">{{ memberNick }}</span>
					            <input v-else type="text" v-model="editedNickname" class="form-control" placeholder="새로운 닉네임"
					            	:class="{'is-invalid':editedNickname !== '' && (!memberNickValid || nickDuplicated)}" @blur="nickDuplicatedCheck(memberNick)">
					            <div class="invalid-feedback">{{memberNickMessage}}</div>
					            <i v-if="!editingNickname" class="fa-solid fa-pen-to-square" style="font-size: 14px; margin-left: 10px; cursor: pointer;" @click="editingNickname=true"></i>
					            <i v-else class="fa-solid fa-check" style="font-size: 14px; margin-left: 10px; cursor: pointer;" @click="updateNickname(memberNick)"></i>
					        </h3>
							<h5>@{{memberId}}</h5>
						</div>
					</div>
				</div>
			</div>
			
			<div class="modal" tabindex = "-1" role="dialog" id="followModal" data-bs-backdrop="static" ref="followModal">
				<div class="modal-dialog" role="document">
					<div class="modal-content	">
						<div class="modal-header">
							<i class="fa-solid fa-xmark" style="color: #bcc0c8;" data-bs-dismiss="modal" aria-label="Close"></i>
						</div>
						<div class="modal-body text-center">
							{{FollowMemberList}}
						</div>
					</div>
				</div>
			</div>
			
			<div class="modal" tabindex = "-1" role="dialog" id="followerModal" data-bs-backdrop="static" ref="followerModal">
				<div class="modal-dialog" role="document">
					<div class="modal-content	">
						<div class="modal-header">
							<i class="fa-solid fa-xmark" style="color: #bcc0c8;" dat	a-bs-dismiss="modal" aria-label="Close"></i>
						</div>
						<div class="modal-body text-center">
							{{FollowerMemberList}}
						</div>
					</div>
				</div>
			</div>
			
			<div class="modal" tabindex = "-1" role="dialog" id="pageModal" data-bs-backdrop="static" ref="pageModal">
				<div class="modal-dialog" role="document">
					<div class="modal-content	">
						<div class="modal-header">
							<i class="fa-solid fa-xmark" style="color: #bcc0c8;" data-bs-dismiss="modal" aria-label="Close"></i>
						</div>
						<div class="modal-body text-center">
							{{FollowPageList}}
						</div>
					</div>
				</div>
			</div>
			
			<hr>
			
			<div class="row">
				<div class="col-6 text-center" @click="pageMinus()">
					<i class="fa-solid fa-list"></i>
				</div>
				<div class="col-6 text-center">
					<i class="fa-sharp fa-regular fa-heart" @click="pagePlus()"></i>
				</div>
			</div>
			<div class="row page">
				<div v-show = "page > 0">
				
					<h1>내가 쓴 글 </h1>
				
				</div>
				<div v-show = "page < 3">
					
					<h1>내가 좋아요 한 글 </h1>
				
				</div>
			</div>
			
		</div>
	
	</div>
	</div>	
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
		<script>
			Vue.createApp({
				data(){
					return{
						memberId:"",
						memberNick:"",
						modal:null,
						followModal:null,
						followerModal:null,
						pageModal:null,
						memberProfileImageObj: {},
						editedNickname:"",
						editingNickname:false,
						nickDuplicated:false,
						MemberFollowCnt:0,
						MemberFollowerCnt:0,
						MemberPageCnt:0,
						FollowMemberList:[],
						FollowerMemberList:[],
						FollowPageList:[],
						page : 1,
					};
				},		
				methods:{
					async profile() {
						const response = await axios.get("/member/profile");
						const {memberId, memberNick} = response.data;
						
						this.memberId = memberId;
						this.memberNick=memberNick;
						
					},
					
					async followCnt() {
						const response = await axios.get("/member/followCnt");
						const{MemberFollowCnt, MemberFollowerCnt, MemberPageCnt} = response.data;
						
						this.MemberFollowCnt = MemberFollowCnt;
						this.MemberFollowerCnt = MemberFollowerCnt;
						this.MemberPageCnt = MemberPageCnt;
					},
					
					async followList() {
						const response = await axios.get("/member/followList");
						const{FollowMemberList, FollowerMemberList, FollowPageList} = response.data;
						
						this.FollowMemberList = FollowMemberList;
						this.FollowerMemberList = FollowerMemberList;
						this.FollowPageList = FollowPageList;
					},
					
					showModal(){
						if(this.modal == null) return;
						this.modal.show();
					},
					hideModal(){
						if(this.modal == null) return;
						this.modal.hide();
					},
					
					showFollowModal() {
						if(this.followModal == null) return;
						this.followModal.show();
					},
					hideFollowModal() {
						if(this.followModal == null) return;
						this.followModal.hide();
					},
					
					showFollowerModal() {
						if(this.followerModal == null) return;
						this.followerModal.show();
					},
					hideFollowerModal() {
						if(this.followerModal == null) return;
						this.followerModal.hide();
					},
					
					showPageModal() {
						if(this.pageModal == null) return;
						this.pageModal.show();
					},
					hidePageModal() {
						if(this.pageModal == null) return;
						this.pageModal.hide();
					},
					
					async profileImage() {
						const response = await axios.get("/member/profileImage");
						
						this.memberProfileImageObj = response.data;
						
					},
					
					
					async nickDuplicatedCheck(memberNick) {

	                    const resp = await axios.get("/member/nickDuplicatedCheck", {
	                        params : {
	                            memberNick : this.editedNickname
	                        }
	                    });
	                    if(resp.data === "N") {
	                        this.nickDuplicated = true;
	                    }
	                    else {
	                        this.nickDuplicated = false;
	                    }
	                  },
					
					async updateNickname(memberNick) {
						const response = await axios.get("/member/nickname",{
							params:{
								memberNick : this.editedNickname
							}
						});
	                	  if (this.nickDuplicated === true) {
	                		  return;
	                	  }
	                	  
	                	  this.memberNick = this.editedNickname;
	                	  this.editingNickname = false;
						Toastify({
	                        text: "변경 완료",
	                        duration: 1000,
	                        newWindow: false,
	                        close: true,
	                        gravity: "bottom", // `top` or `bottom`
	                        position: "right", // `left`, `center` or `right`
	                        style: {
	                            background: "linear-gradient(to right, #84FAB0, #8FD3F4)",
	                        },
	                        // onClick: function(){} // Callback after click
	                    }).showToast();
					},
					
					pagePlus(){
						this.page++;
					},
					pageMinus() {
						this.page--;
					},
					
				},
				computed:{
					 memberNickValid(){
		                    const regex = /^[가-힣0-9a-z!@#$.-_]{1,10}$/;
		                    return regex.test(this.editedNickname);
		                },
		                memberNickMessage(){
		                  
		                    if(this.memberNickValid && !this.nickDuplicated) {
		                        return "사용 가능한 닉네임입니다.";
		                    }
		                    else if(this.nickDuplicated) {
		                        return "이미 사용중인 닉네임입니다.";
		                    }
		                    else{
		                        return "한글, 영문, 숫자, 특수문자 등을 사용하여 1~16자로 작성하세요.";
		                    }
		                },
				},
				created(){
					this.profileImage();
				},
				mounted() {
					this.profile();
					this.followCnt();
					this.followList();
					this.modal = new bootstrap.Modal(this.$refs.modal);
					this.followModal = new bootstrap.Modal(this.$refs.followModal);
					this.followerModal = new bootstrap.Modal(this.$refs.followerModal);
					this.pageModal = new bootstrap.Modal(this.$refs.pageModal);
				},
			}).mount("#app");
		</script>
		
</body>    

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>