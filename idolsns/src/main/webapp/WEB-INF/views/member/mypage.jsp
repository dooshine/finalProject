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
<body test>
	<div class="container rounded p-3" style="background-color:white">
	<div id="app">
		
		<div class="container">
			<div class="row">
				<a href="${pageContext.request.contextPath}/member/exit">회원탈퇴</a>
				<a href="${pageContext.request.contextPath}/member/password">비밀번호 변경</a>
				<a href="${pageContext.request.contextPath}/member/nickname">닉네임 변경</a>
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
					            	:class="{'is-invalid':nickDuplicated}" @blur="nickDuplicatedCheck(memberNick)">
					            <div class="invalid-feedback">이미 존재하는 아이디입니다.</div>
					            <i v-if="!editingNickname" class="fa-solid fa-pen-to-square" style="font-size: 14px; margin-left: 10px; cursor: pointer;" @click="editingNickname=true"></i>
					            <i v-else class="fa-solid fa-check" style="font-size: 14px; margin-left: 10px; cursor: pointer;" @click="updateNickname(memberNick)"></i>
					        </h3>
							<h5>@{{memberId}}</h5>
						</div>
					</div>
				</div>
			</div>
			
			<hr>
			
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
						memberProfileImageObj: {},
						editedNickname:"",
						editingNickname:false,
						nickDuplicated:false,
					};
				},		
				methods:{
					async profile() {
						const response = await axios.get("/member/profile");
						const {memberId, memberNick} = response.data;
						
						this.memberId = memberId;
						this.memberNick=memberNick;
						
					},
					
					showModal(){
						if(this.modal == null) return;
						this.modal.show();
					},
					hideModal(){
						if(this.modal == null) return;
						this.modal.hide();
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
					
				},
				created(){
					this.profileImage();
				},
				mounted() {
					this.profile();
					this.modal = new bootstrap.Modal(this.$refs.modal);
				},
			}).mount("#app");
		</script>
		
</body>    

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>