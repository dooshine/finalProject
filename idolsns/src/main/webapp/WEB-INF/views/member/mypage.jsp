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
    <title>마이페이지</title>
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
      <!-- swiper cdn -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css"/>
	<script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
	<!------- 카카오 지도 관련-------->
	<!-- 카카오 api 키 등록 -->
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=047888df39ba653ff171c5d03dc23d6a&libraries=services"></script>
	<!-- 맵 관련 css -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/map.css">
	<!------- 카카오 지도 관련-------->
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
	/*   이미지 스와이핑 창 스타일 */
    	.swiper { 
		width: 600px;
		height: 600px;
		}
		
    	.address{
    	font-size:10px;
    	}
    	.grey{
    	color: grey;
    	}
    	.fs-7{
    	font-size: 10px;
    	}
    	.h-20{
    	height: 20px;
    	}
    	.reply-text{
    	font-size: 5px;
    	}
   </style>
</head>
<body>
   <div class="container rounded p-3" style="background-color:white">
   <div id="app">
      <br><br>
      <div class="container">
         <div class="row" style="margin-left:30px">
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
            	<div class="row" v-if="mypage">
	               <button type = "button" class="btn btn-primary mt-4" v-on:click = "showModal">프로필 수정</button>
    	           <i class="fa-solid fa-gear" v-on:click="showSettingsModal"></i>
            	</div>
            	<div class="row" v-if="!mypage && follow">
            		<button type ="button" class="custom-btn btn-round btn-purple2" v-on:click="memberFollowDelete()">팔로우 취소</button>
            	</div>
            	<div class="row" v-if="!mypage && !follow">
	               <button type = "button" class="custom-btn btn-round btn-purple1" v-on:click = "memberFollowNew()">팔로우</button>
            	</div>
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
         
          <div class="modal" tabindex = "-1" role="dialog" id="settingsModal" data-bs-backdrop="static" ref="settingsModal">
            <div class="modal-dialog" role="document">
               <div class="modal-content   ">
                  <div class="modal-header">
                     <i class="fa-solid fa-xmark" style="color: #bcc0c8;" data-bs-dismiss="modal" aria-label="Close"></i>
                  </div>
                  <div class="modal-body ">
                  	<div class="row">
	                     <i class="fa-solid fa-lock" @click="goToPassword()">비밀번호 변경</i>
                  	</div>
                  	<div class="row">
	                     <i class="fa-solid fa-pen-to-square" @click="goToLogout()">로그아웃</i>
                  	</div>
                  	<div class="row">
	                     <i class="fa-sharp fa-solid fa-circle-minus " @click="goToExit()">회원탈퇴</i>
                  	</div>
                  </div>
               </div>
            </div>
         </div>	
         
         <div class="modal" tabindex = "-1" role="dialog" id="modal" data-bs-backdrop="static" ref="modal">
            <div class="modal-dialog" role="document">
               <div class="modal-content   ">
                  <div class="modal-header">
                     <i class="fa-solid fa-xmark" style="color: #bcc0c8;" data-bs-dismiss="modal" aria-label="Close"></i>
                  </div>
                  <div class="modal-body text-center">
                     <img :src="previewURL"
                        class="profile-image" @click="openFileInput">
                     <input type="file" ref="fileInput" style="display: none;"@change="uploadFile($event)">
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
               <div class="modal-content   ">
                  <div class="modal-header">
                     <i class="fa-solid fa-xmark" style="color: #bcc0c8;" data-bs-dismiss="modal" aria-label="Close"></i>
                  </div>
                  <div class="modal-body text-left">
                     <div v-for="(board,index) in FollowListProfile"  :key="index">
                     <img :src="getAttachmentUrl(board.attachmentNo)" class="profile-image" style="width:54px; height:54px;">
                     <a :href="'/member/mypage/' + board.followTargetPrimaryKey">
					    <span>{{board.followTargetPrimaryKey}}</span>
					</a>
                    <button @click="deleteFollow(board.followNo)">팔로잉</button>
                     </div>
                  </div>
               </div>
            </div>
         </div>	
        
         
         <div class="modal" tabindex = "-1" role="dialog" id="followerModal" data-bs-backdrop="static" ref="followerModal">
            <div class="modal-dialog" role="document">
               <div class="modal-content   ">
                  <div class="modal-header">
                     <i class="fa-solid fa-xmark" style="color: #bcc0c8;" dat   a-bs-dismiss="modal" aria-label="Close"></i>
                  </div>
                  <div class="modal-body text-left">
                     <div v-for="(board,index) in FollowerListProfile"  :key="index">
                     <img :src="getAttachmentUrl(board.attachmentNo)" class="profile-image" style="width:54px; height:54px;">
                     <a :href="'/member/mypage/' + board.memberId">
                    <span> {{board.memberId}}</span>
                    </a>
                    <button @click="deleteFollow(board.followNo)">팔로잉</button>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         
         <div class="modal" tabindex = "-1" role="dialog" id="pageModal" data-bs-backdrop="static" ref="pageModal">
            <div class="modal-dialog" role="document">
               <div class="modal-content   ">
                  <div class="modal-header">
                     <i class="fa-solid fa-xmark" style="color: #bcc0c8;" data-bs-dismiss="modal" aria-label="Close"></i>
                  </div>
                  <div class="modal-body text-left">
                     <div v-for="(board,index) in PageListProfile"  :key="index">
                    <img :src="getAttachmentUrl(board.attachmentNo)" class="profile-image" style="width:54px; height:54px;">
                    <a :href="'/artist/' + board.followTergetPrimarykey">
                    <span> {{board.followTargetPrimaryKey}}</span>
                    </a>
                    <button @click="deleteFollow(board.followNo)">팔로잉</button>
                     </div>
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
         
         <!-- 내가 쓴 글  -->
            <div v-show = "page == 1">
            
             <!-- 게시글 지도 게시 모달창 (게시글에서 위치나 지도 마크 클릭 시 모달 띠우기)-->
        <div class="modal" tabindex="-1" role="dialog" id="showMap"
                            data-bs-backdrop="static">
            <div class="modal-dialog" role="document">
                <div class="modal-content mx-2">
                
                	<!-- header -->
                    <div class="modal-header">
                        <h5 class="modal-title">위치 정보</h5>
                    </div>
                    
                    <!-- body -->
                    <div class="modal-body row">
                        <div class="col-1">
        				</div>
        				<div class="map_wrap col-10 ">
        					<div id="mapShow" style="width:100%;height:100%;position:relative;overflow:visible;align-content:center;"></div>
					    </div>
        				<div class="col-1">
        				</div>
                    </div>
                    
                    <!-- footer -->
                    <div class="modal-footer">
                    	<div class="col-6 text-start">
                    		{{showMapModalText}}
                    	</div>
                    	<div class="col-5 text-end">     
	                        <button type="button" class="btn btn-secondary btn-sm"
	                                data-bs-dismiss="modal">닫기</button>
                        </div>
                    </div>
                    
                </div>      
            </div>
         </div>

	     
<!-- 	    <button type="button" onclick="relayout();" class="btn btn-white btn-outline-dark rounded-pill col-12 " data-bs-target="#modalmap" data-bs-toggle="modal">지도 테스트 모달</button> -->
	    <!--------------- 게시물들 반복구간 ------------->
	    <div v-for="(post, index) in posts" :key="index">
	    
	    		<!-- 글 박스 루프 1개-->
                <div class="bg-white mb-2 px-3 py-1 rounded-4">
                
                	<!-- 프로필 사진과 아이디 -->
                	<div class="row mt-1">
			            <div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">
			               <img class="rounded-circle img-fluid" src="static/image/profileDummy.png">
			            </div>
			            <div class="col-10 col-md-10 col-lg-10 align-items-center justify-content-start">
														
								<div class="row">
								<h4>{{ post.memberId }}</h4>   
								</div>
								<div class="row">
								<p class="text-secondary">@{{post.memberNick }} </p>
								</div>
			            </div>
			            <div class="col-1 col-md-1 col-lg-1 d-flex align-items-start justify-content-end">
			               <i class="fs-3 text-secondary ti ti-dots-vertical" data-toggle="dropdown"></i>
			               <i class="ti ti-x" @click="deletePost(post.postNo)"></i>
			            </div>
							
	       			</div>	
					<!-- 프로필 사진과 아이디 -->
					
					<!-- 고정 태그와 글 타입들 -->
	                <div class="row mb-3 ">
	                	<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">			            
			            </div>
			            <div class="col-10 col-md-10 col-lg-10 d-flex align-items-center justify-content-start">
							<div class="mx-1 px-2 h-20 bg-primary rounded-4 align-items-center justify-content-center">
								<p class="fs-7 text-light">{{ post.postType }}</p>										 
							</div>
							<div v-for="fixedTag in post.fixedTagList" :key="fixedTag" class="mx-1 px-2 h-20 bg-primary rounded-pill align-items-center justify-content-center">
								<p class="fs-7 text-light">{{ fixedTag }}</p>
							</div>
														 													    
			            </div>
						<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center"> 
			            </div>	                
	                </div>
	                <!-- 고정 태그와 글 타입들 -->	 
	                               
	                <!-- 지도 맵이 있는 경우에만 지도 정보 표기 -->						
	                <div class="row my-2" v-if="post.mapPlace !== '' && post.mapPlace !== null && post.mapPlace !== undefined">	                	
	                	<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">			            
			            </div>
			            <div class="col-10 col-md-10 col-lg-10 d-flex align-items-center justify-content-start fs-6 text-secondary " @click="showMap(post.mapPlace)" data-bs-target="#showMap" data-bs-toggle="modal">
							 <i class="fa-solid fa-location-dot"></i>&nbsp;{{ post.mapPlace}}								
			            </div>
						<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center"> 
			            </div>            
	                </div>
	                <!-- 지도 맵이 있는 경우에만 지도 정보 표기 -->	
	                
	                
	                <!-- 글 내용 -->
	                <div class="row my-2">
	                	<div class="col-1 col-md-1 col-lg-1 align-items-center justify-content-center">
			               
			            </div>
			            <div class="col-10 col-md-10 col-lg-10 align-items-center">							
		                	
		                	
		                	<!-- 글 -->
		                	<div class="row">
		                		<p>{{ post.postContent }}</p>
		                		<div class="d-flex">
		                		<p v-for="freeTag in post.freeTagList" :key="freeTag" class="fs-6 text-primary">\#{{ freeTag }} &nbsp;</p>	
		                		</div>
		                	</div>
							
		                	
		                	<!-- 이미지 표시 -->
		                	<div class="row">
		                		<div v-if="post.attachmentList && post.attachmentList.length > 0"  class="d-flex">
					                <!-- 단일 이미지인 경우 -->
					                <div v-if="post.attachmentList.length == 1" class="row text-center" >
					                	<div v-for="(attachmentNo, attachmentIndex) in post.attachmentList" :key="attachmentIndex" class="col-6">
					                		<img :src="getAttachmentUrl(attachmentNo)" @click="setModalImageUrl(attachmentNo)" class="img-fluid" style="max-width:100%;aspect-ratio:1/1;" alt="Attachment" data-bs-target="#image-modal" data-bs-toggle="modal">
					                	</div>                	        	
					                </div>
					                <!-- 두 개 이상의 이미지인 경우 -->
					                <div v-else-if="post.attachmentList.length > 1" class="row text-center">
					                	<div v-for="(attachmentNo, attachmentIndex) in post.attachmentList" :key="attachmentIndex" class="col-6">
					                		<img :src="getAttachmentUrl(attachmentNo)"  @click="setModalImageUrl(attachmentNo)" class="img-fluid mb-3" style="max-width:100%;aspect-ratio:1/1;" alt="Attachment" data-bs-target="#image-modal" data-bs-toggle="modal">
					                	</div>
					                </div>
					                
					                <!-- 두 개 이상의 이미지인 경우 (이미지 스와이핑 : 나중에하자 ㅅ....) -->
<!-- 					                <div v-else-if="post.attachmentList.length = -999" class="row text-center"> -->
<!-- 					                	<div v-for="(attachmentNo, attachmentIndex) in post.attachmentList" :key="attachmentIndex" class="col-6"> -->
<!-- 					                		첫 번째 이미지는 그냥 모달로 보여줌 -->
<!-- 					                		<div v-if="attachmentIndex === 0"> -->
<!-- 					                			<img :src="getAttachmentUrl(attachmentNo)" @click="setModalImageUrl(attachmentNo)" class="img-fluid" style="max-width:100%;aspect-ratio:1/1;" alt="Attachment" data-bs-target="#image-modal" data-bs-toggle="modal"> -->
<!-- 					                		</div> -->
<!-- 					                		이후의 이미지는 swiper를 사용하여 보여줌 -->
<!-- 					                		<div v-else-if="attachmentIndex == 1 "> -->
<!-- 					                			<img :src="getAttachmentUrl(attachmentNo)" @click="setModalImageUrlList(post.attachmentList)" class="img-fluid" style="max-width:100%;aspect-ratio:1/1;" alt="Attachment" data-bs-target="#imageList-modal" data-bs-toggle="modal"> -->
<!-- 					                		</div> -->
<!-- 					                	</div> -->
<!-- 					                </div> -->

					                <!-- 이미지 출력 모달창 -->
					                <div class="modal" tabindex="-1" role="dialog" id="image-modal"
                           					 data-bs-backdrop="true">
                           					 <div class="modal-dialog modal-lg" role="image">
                           					 	<div class="modal-content">
                           					 		<img :src="modalImageUrl">
                           					 	</div>                           					 	
                           					 </div>
                           			</div>
                           			<!-- 다중 이미지 스와이핑 모달창 나중에 보자...-->
<!-- 					                <div class="modal" tabindex="-1" role="dialog" id="imageList-modal" -->
<!--                            					 data-bs-backdrop="true"  test> -->
<!--                            					 <div class="modal-dialog modal-lg" role="image"> -->
<!--                            					 	<div class="modal-content"> -->
<!--                            					 		header -->
<!-- 										            <div class="modal-header"> -->
<!-- 										                <h5 class="modal-title"><i class="fa-solid fa-xmark fa-lg grey" data-bs-dismiss="modal"></i></h5> -->
<!-- 										            </div> -->
										            
<!-- 										            body -->
<!--                            					 		<div class="modal-body"> -->
<!-- 	                           					 		Slider main container -->
<!-- 														<div class="swiper-container w-100"> -->
<!-- 														  Additional required wrapper -->
<!-- 														  <div class="swiper-wrapper"> -->
<!-- 														  	<div class="swiper-slide mx-5"> -->
<!-- 														  		<img class="img-fluid" style="width:200px;height:200px;" src="https://cdn.pixabay.com/photo/2023/05/21/06/05/water-jet-8007873_640.jpg"> -->
<!-- 														  	</div> -->
<!-- 														  	<div class="swiper-slide mx-5"> -->
<!-- 														  		<img class="img-fluid" style="width:200px;height:200px;" src="https://cdn.pixabay.com/photo/2023/05/21/06/05/water-jet-8007873_640.jpg"> -->
<!-- 														  	</div> -->
<!-- 														  	<div class="swiper-slide mx-5"> -->
<!-- 														  		<img class="img-fluid"  style="width:200px;height:200px;" src="https://cdn.pixabay.com/photo/2023/05/21/06/05/water-jet-8007873_640.jpg"> -->
<!-- 														  	</div> -->
<!-- 														  	<div v-for="(modalImageUrlitem, urlIdx) in modalImageUrlList" :key="urlIdx"> -->
<!-- 														  		Slides -->
<!-- 														  		<div  class="swiper-slide" style="width:80%;height:80%;"> -->
<!-- 														  			<img v-if="urlIdx>0" :src="getAttachmentUrl(modalImageUrlitem)" class="swiper-slide img-fluid"> -->
<!-- 														  		</div> -->
<!-- 														  	</div> -->
<!-- 														  </div>													   -->
<!-- 														  If we need pagination -->
<!-- 														  <div class="swiper-pagination"></div> -->
														
														 
														
	<!-- 													  If we need scrollbar -->
	<!-- 													  <div class="swiper-scrollbar"></div> -->
<!-- 														</div> -->
<!-- 													</div> -->
													
<!-- 													footer -->
<!-- 										            <div class="modal-footer"> -->
<!-- 										            If we need navigation buttons -->
<!-- 														  <div class="swiper-button-prev"></div> -->
<!-- 														  <div class="swiper-button-next"></div> -->
<!-- 										            </div> -->
<!--                            					 	</div>					 	 -->
<!--                            					 </div> -->
<!--                            			</div> -->
                           			
					               
					                
					                <div v-for="(attachmentNo, attachmentIndex) in post.attachmentList" :key="attachmentIndex">
					                	<!-- 일단 이미지만 -->
					                	
					                	
					                
<!-- 					                	이미지인 경우 -->
<!-- 					                	<div v-if="checkFileType(attachmentNo) === 'image' "> -->
<!-- 					                		<img :src="getAttachmentUrl(attachmentNo)" class="mx-1 px-1"style="max-width:100%;max-height:100%" alt="Attachment"> -->
<!-- 					                	</div> -->
<!-- 					                	<div v-else-if="checkFileType(attachmentNo) === 'video'"> -->
<!-- 					                		<video :src="getAttachmentUrl(attachmentNo)" class="mx-1 px-1" style="max-width:100%;max-height:100%"  controls> -->
<!-- 				                		 	</video> -->
<!-- 					                	</div> -->
<!-- 					                	<div v-else-if="checkFileType(attachmentNo) === 'unknown'"> -->
<!-- 					                		<h1>언노운</h1> -->
<!-- 					                	</div>					                     -->
					                </div>
					                <br>
					            </div>
					            <div v-else>
					            </div>
		                	</div>
		                	
		                	
		                	<!-- 구분선 -->
		                	<div class="row">
		                		<hr style="width:100%;">
		                	</div>
		                	
		                	<!-- 좋아요, 댓글, 공유하기 -->
		                	<div class="row">
		                	
		                		<!-- 좋아요 -->		                		
		                		<div class="col-4 text-start text-primary">
		                			<div class="row" v-if="postLikeIndexList.includes(index)">
		                				<div class="col-2">
		                					<i class="fs-4 ti ti-heart-filled" @click="checkLike(post.postNo,index)"></i>
		                				</div>
		                				<div class="col-4 ">
		                					<h6 class="postlikeCount">{{post.likeCount}}</h6>
		                				</div>		                						                				
		                			</div>
		                			<div class="row" v-else>
		                				<div class="col-2">
		                					<i class="fs-4 ti ti-heart" @click="checkLike(post.postNo,index)"></i>
		                				</div>
		                				<div class="col-4 ">
		                					<h6 class="postlikeCount">{{post.likeCount}}</h6>
		                				</div>
		                			</div>
		                		</div>
		                		<!-- 좋아요 -->
		                		
		                		<!-- 댓글 작성버튼 -->
							    <div class="col-4 text-center text-secondary">				
							    	<i class="fs-4 ti ti-message" @click="showReplyInput(index)"></i>					    
							    </div>
							    <!-- 댓글 작성버튼 -->
							    
							    <!-- 공유하기 버튼 -->
							    <div class="col-4 text-end text-secondary"><i class="fs-4 ti ti-share"></i></div>
							    <!-- 공유하기 버튼 -->
							     
		                	</div>
		                	
		                	<!-- 구분선 -->
		                	<div class="row">
		                		<hr class="mt-2" style="width:100%;">		                
		                	</div>
		                	
		                	<!-- 댓글, 대댓글 보여주는 창 -->
		                	<div class="row" v-if="post.replyList.length >= 1">
								<div v-for="(reply,replyIdx) in post.replyList" :key="replyIdx">
									<!-- 댓글 표시 -->
									<div class="d-flex align-items-center justify-content-center mb-1" v-if="reply.replyNo == reply.replyGroupNo">
										
				                		<div class="col-2 text-center ">
				                			<div class="row w-50 h-50 text-center m-auto">
				                				<img class="img-fluid rounded-circle " src="static/image/profileDummy.png">
				                			</div>
				                			<div class="row w-50 h-50 text-center m-auto">
				                				<h6 class="fs-7">{{reply.replyId}}</h6>
				                			</div>
				                		</div>
				                		
				                		<div class="col-8">
				                			<div class="row">
				                				<h6>{{reply.replyContent}}</h6>
				                			</div>
				                			<div class="row d-flex flex-nowrap">
<!-- 				                				<h6 class="col-1 text-start reply-text" style="white-space: nowrap;">좋아요 </h6> -->
				                				<h6 class="col-1 text-start reply-text text-secondary" @click="showRereplyInput(post.postNo,reply.replyNo),hideReplyInput()" style="white-space: nowrap;">댓글 달기</h6>	
				                			</div>			                			
				                		</div>
				                		<div class="col-1" v-if="memberId === reply.replyId">
				                			<i class="ti ti-x" @click="deleteReply(reply.replyNo)"></i>
				                		</div>
			                		</div>
			                		<!-- 댓글 표시 -->
			                		
			                		<!-- 대댓글 표시 -->
			                		<div v-for="(rereply,rereplyIdx) in post.replyList.slice(replyIdx+1)" :key='rereplyIdx'>			                							                				             				
			                				<!-- 대댓글이 들어갈 조건 -->
				                			<div v-if="reply.replyNo === rereply.replyGroupNo"><!-- 특정 댓글의 그룹번호가 특정 댓글번호와 일치할 때, -->				                				
				                				<!-- 대댓글 들 -->
				                				<div class="row ">
				                					<div class="col-2">
				                					</div>
				                					<div class="col-2 text-center">
				                						<div class="row w-50 h-50 text-center m-auto">
					                						<img class="img-fluid rounded-circle " src="static/image/profileDummy.png">
					                					</div>
							                			<div class="row w-50 h-50 text-center m-auto">
							                				<h6 class="fs-7">{{rereply.replyId}}</h6>
							                			</div>
				                					</div>
				                					<div class="col-6">
				                						<h6>{{rereply.replyContent}}</h6>
				                					</div>
				                					<div class="col-1">				                						
				                						<i class="ti ti-x" @click="deleteRereply(rereply.replyNo)" v-if="rereply.replyId == memberId"></i>
				                					</div>
				                				</div>
				                				<!-- 대댓글 들 -->
				                			</div>
				                			<!-- 대댓글이 들어갈 조건 -->
				                	</div>
				                	
				                	<!-- 대댓글 작성 창 -->
		                			<div v-if=" post.postNo === tempPostNo && reply.replyNo === tempReplyNo">
		                				<div class="row">
		                					<div class="col-2">
		                					</div>
		                					<div class="col-2 text-center">
		                						<div class="row w-50 h-50 text-center m-auto">
			                						<img class="img-fluid rounded-circle " src="static/image/profileDummy.png">
			                					</div>
					                			<div class="row w-50 h-50 text-center m-auto">
					                				<h6 class="fs-7">${memberId }</h6>
					                			</div>
		                					</div>
		                					<div class="col-7">
		                						<input type="text" v-model="rereplyContent" class="w-100 rounded-4 border border-secondary ">
		                					</div>
		                					<div class="col-1">
		                						<i class="fs-2 text-primary ti ti-arrow-badge-right-filled" @click="rereplySending(post.postNo,reply.replyNo,index)"></i>
		                					</div>
		                				</div>
		                			</div>
				                	<!-- 대댓글 작성 창 -->
				                	
				                	<!-- 대댓글 표시 -->
							    </div> 								             		
		                	</div>
		                	<!-- 댓글, 대댓글 보여주는 창 -->
		                	
		                	<!-- 댓글 작성창  -->
							<!-- 댓글 작성버튼 눌렸을 때만 나오게됨 -->
		                	<div class="row" v-if="replyFlagList[index]"> 
		                		<div class="col-1">
		                			<img class="rounded-circle img-fluid" src="static/image/profileDummy.png">
		                		</div>
		                		<div class="col-10 mt-1">
		                			<input type="text" placeholder=" 댓글을 입력하세요." v-model="replyContent" class="w-100 rounded-4 border border-secondary "> 
		                		</div>
		                		<div class="col-1">
		                			<i class="fs-2 text-primary ti ti-arrow-badge-right-filled" @click="replySending(post.postNo,index)"></i>
		                		</div>		                		
		                	</div>
		                	<!-- 댓글 작성창  -->
		                	
			            </div>
						<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center"> 
			            </div>       
	                </div>
	                <!-- 글 내용 -->
	                
	                <!-- 이미지 -->
<!-- 	                <div class="row my-2"> -->
<!-- 	                	<div class="col-1 col-md-1 col-lg-1 align-items-center justify-content-center"> -->
			               
<!-- 			            </div> -->
<!-- 			            <div class="col-10 col-md-10 col-lg-10 align-items-center">							 -->
<!-- 		                	<div class="row"> -->

<!-- 		                	</div>		                		    -->
<!-- 			            </div> -->
<!-- 						<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">  -->
<!-- 			            </div>        -->
<!-- 	                </div> -->
	                <!-- 글 내용 -->

                </div>
                <!-- 글 박스 루프 1개-->
                
       	 </div>
       	 <!--------------- 게시물들 반복구간 ------------->
            
            </div>
            
            <!-- 내가 좋아요 한 글  -->
            <div v-show = "page == 2">
               
               <!-- 게시글 지도 게시 모달창 (게시글에서 위치나 지도 마크 클릭 시 모달 띠우기)-->
        <div class="modal" tabindex="-1" role="dialog" id="showMap"
                            data-bs-backdrop="static">
            <div class="modal-dialog" role="document">
                <div class="modal-content mx-2">
                
                	<!-- header -->
                    <div class="modal-header">
                        <h5 class="modal-title">위치 정보</h5>
                    </div>
                    
                    <!-- body -->
                    <div class="modal-body row">
                        <div class="col-1">
        				</div>
        				<div class="map_wrap col-10 ">
        					<div id="mapShow" style="width:100%;height:100%;position:relative;overflow:visible;align-content:center;"></div>
					    </div>
        				<div class="col-1">
        				</div>
                    </div>
                    
                    <!-- footer -->
                    <div class="modal-footer">
                    	<div class="col-6 text-start">
                    		{{showMapModalText}}
                    	</div>
                    	<div class="col-5 text-end">     
	                        <button type="button" class="btn btn-secondary btn-sm"
	                                data-bs-dismiss="modal">닫기</button>
                        </div>
                    </div>
                    
                </div>      
            </div>
         </div>

	     
<!-- 	    <button type="button" onclick="relayout();" class="btn btn-white btn-outline-dark rounded-pill col-12 " data-bs-target="#modalmap" data-bs-toggle="modal">지도 테스트 모달</button> -->
	    <!--------------- 게시물들 반복구간 ------------->
	    <div v-for="(post, index) in posts" :key="index">
	    
	    		<!-- 글 박스 루프 1개-->
                <div class="bg-white mb-2 px-3 py-1 rounded-4">
                
                	<!-- 프로필 사진과 아이디 -->
                	<div class="row mt-1">
			            <div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">
			               <img class="rounded-circle img-fluid" src="static/image/profileDummy.png">
			            </div>
			            <div class="col-10 col-md-10 col-lg-10 align-items-center justify-content-start">
														
								<div class="row">
								<h4>{{ post.memberId }}</h4>   
								</div>
								<div class="row">
								<p class="text-secondary">@{{post.memberNick }} </p>
								</div>
			            </div>
			            <div class="col-1 col-md-1 col-lg-1 d-flex align-items-start justify-content-end">
			               <i class="fs-3 text-secondary ti ti-dots-vertical" data-toggle="dropdown"></i>
			               <i class="ti ti-x" @click="deletePost(post.postNo)"></i>
			            </div>
							
	       			</div>	
					<!-- 프로필 사진과 아이디 -->
					
					<!-- 고정 태그와 글 타입들 -->
	                <div class="row mb-3 ">
	                	<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">			            
			            </div>
			            <div class="col-10 col-md-10 col-lg-10 d-flex align-items-center justify-content-start">
							<div class="mx-1 px-2 h-20 bg-primary rounded-4 align-items-center justify-content-center">
								<p class="fs-7 text-light">{{ post.postType }}</p>										 
							</div>
							<div v-for="fixedTag in post.fixedTagList" :key="fixedTag" class="mx-1 px-2 h-20 bg-primary rounded-pill align-items-center justify-content-center">
								<p class="fs-7 text-light">{{ fixedTag }}</p>
							</div>
														 													    
			            </div>
						<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center"> 
			            </div>	                
	                </div>
	                <!-- 고정 태그와 글 타입들 -->	 
	                               
	                <!-- 지도 맵이 있는 경우에만 지도 정보 표기 -->						
	                <div class="row my-2" v-if="post.mapPlace !== '' && post.mapPlace !== null && post.mapPlace !== undefined">	                	
	                	<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">			            
			            </div>
			            <div class="col-10 col-md-10 col-lg-10 d-flex align-items-center justify-content-start fs-6 text-secondary " @click="showMap(post.mapPlace)" data-bs-target="#showMap" data-bs-toggle="modal">
							 <i class="fa-solid fa-location-dot"></i>&nbsp;{{ post.mapPlace}}								
			            </div>
						<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center"> 
			            </div>            
	                </div>
	                <!-- 지도 맵이 있는 경우에만 지도 정보 표기 -->	
	                
	                
	                <!-- 글 내용 -->
	                <div class="row my-2">
	                	<div class="col-1 col-md-1 col-lg-1 align-items-center justify-content-center">
			               
			            </div>
			            <div class="col-10 col-md-10 col-lg-10 align-items-center">							
		                	
		                	
		                	<!-- 글 -->
		                	<div class="row">
		                		<p>{{ post.postContent }}</p>
		                		<div class="d-flex">
		                		<p v-for="freeTag in post.freeTagList" :key="freeTag" class="fs-6 text-primary">\#{{ freeTag }} &nbsp;</p>	
		                		</div>
		                	</div>
							
		                	
		                	<!-- 이미지 표시 -->
		                	<div class="row">
		                		<div v-if="post.attachmentList && post.attachmentList.length > 0"  class="d-flex">
					                <!-- 단일 이미지인 경우 -->
					                <div v-if="post.attachmentList.length == 1" class="row text-center" >
					                	<div v-for="(attachmentNo, attachmentIndex) in post.attachmentList" :key="attachmentIndex" class="col-6">
					                		<img :src="getAttachmentUrl(attachmentNo)" @click="setModalImageUrl(attachmentNo)" class="img-fluid" style="max-width:100%;aspect-ratio:1/1;" alt="Attachment" data-bs-target="#image-modal" data-bs-toggle="modal">
					                	</div>                	        	
					                </div>
					                <!-- 두 개 이상의 이미지인 경우 -->
					                <div v-else-if="post.attachmentList.length > 1" class="row text-center">
					                	<div v-for="(attachmentNo, attachmentIndex) in post.attachmentList" :key="attachmentIndex" class="col-6">
					                		<img :src="getAttachmentUrl(attachmentNo)"  @click="setModalImageUrl(attachmentNo)" class="img-fluid mb-3" style="max-width:100%;aspect-ratio:1/1;" alt="Attachment" data-bs-target="#image-modal" data-bs-toggle="modal">
					                	</div>
					                </div>
					                
					                <!-- 두 개 이상의 이미지인 경우 (이미지 스와이핑 : 나중에하자 ㅅ....) -->
<!-- 					                <div v-else-if="post.attachmentList.length = -999" class="row text-center"> -->
<!-- 					                	<div v-for="(attachmentNo, attachmentIndex) in post.attachmentList" :key="attachmentIndex" class="col-6"> -->
<!-- 					                		첫 번째 이미지는 그냥 모달로 보여줌 -->
<!-- 					                		<div v-if="attachmentIndex === 0"> -->
<!-- 					                			<img :src="getAttachmentUrl(attachmentNo)" @click="setModalImageUrl(attachmentNo)" class="img-fluid" style="max-width:100%;aspect-ratio:1/1;" alt="Attachment" data-bs-target="#image-modal" data-bs-toggle="modal"> -->
<!-- 					                		</div> -->
<!-- 					                		이후의 이미지는 swiper를 사용하여 보여줌 -->
<!-- 					                		<div v-else-if="attachmentIndex == 1 "> -->
<!-- 					                			<img :src="getAttachmentUrl(attachmentNo)" @click="setModalImageUrlList(post.attachmentList)" class="img-fluid" style="max-width:100%;aspect-ratio:1/1;" alt="Attachment" data-bs-target="#imageList-modal" data-bs-toggle="modal"> -->
<!-- 					                		</div> -->
<!-- 					                	</div> -->
<!-- 					                </div> -->

					                <!-- 이미지 출력 모달창 -->
					                <div class="modal" tabindex="-1" role="dialog" id="image-modal"
                           					 data-bs-backdrop="true">
                           					 <div class="modal-dialog modal-lg" role="image">
                           					 	<div class="modal-content">
                           					 		<img :src="modalImageUrl">
                           					 	</div>                           					 	
                           					 </div>
                           			</div>
                           			<!-- 다중 이미지 스와이핑 모달창 나중에 보자...-->
<!-- 					                <div class="modal" tabindex="-1" role="dialog" id="imageList-modal" -->
<!--                            					 data-bs-backdrop="true"  test> -->
<!--                            					 <div class="modal-dialog modal-lg" role="image"> -->
<!--                            					 	<div class="modal-content"> -->
<!--                            					 		header -->
<!-- 										            <div class="modal-header"> -->
<!-- 										                <h5 class="modal-title"><i class="fa-solid fa-xmark fa-lg grey" data-bs-dismiss="modal"></i></h5> -->
<!-- 										            </div> -->
										            
<!-- 										            body -->
<!--                            					 		<div class="modal-body"> -->
<!-- 	                           					 		Slider main container -->
<!-- 														<div class="swiper-container w-100"> -->
<!-- 														  Additional required wrapper -->
<!-- 														  <div class="swiper-wrapper"> -->
<!-- 														  	<div class="swiper-slide mx-5"> -->
<!-- 														  		<img class="img-fluid" style="width:200px;height:200px;" src="https://cdn.pixabay.com/photo/2023/05/21/06/05/water-jet-8007873_640.jpg"> -->
<!-- 														  	</div> -->
<!-- 														  	<div class="swiper-slide mx-5"> -->
<!-- 														  		<img class="img-fluid" style="width:200px;height:200px;" src="https://cdn.pixabay.com/photo/2023/05/21/06/05/water-jet-8007873_640.jpg"> -->
<!-- 														  	</div> -->
<!-- 														  	<div class="swiper-slide mx-5"> -->
<!-- 														  		<img class="img-fluid"  style="width:200px;height:200px;" src="https://cdn.pixabay.com/photo/2023/05/21/06/05/water-jet-8007873_640.jpg"> -->
<!-- 														  	</div> -->
<!-- 														  	<div v-for="(modalImageUrlitem, urlIdx) in modalImageUrlList" :key="urlIdx"> -->
<!-- 														  		Slides -->
<!-- 														  		<div  class="swiper-slide" style="width:80%;height:80%;"> -->
<!-- 														  			<img v-if="urlIdx>0" :src="getAttachmentUrl(modalImageUrlitem)" class="swiper-slide img-fluid"> -->
<!-- 														  		</div> -->
<!-- 														  	</div> -->
<!-- 														  </div>													   -->
<!-- 														  If we need pagination -->
<!-- 														  <div class="swiper-pagination"></div> -->
														
														 
														
	<!-- 													  If we need scrollbar -->
	<!-- 													  <div class="swiper-scrollbar"></div> -->
<!-- 														</div> -->
<!-- 													</div> -->
													
<!-- 													footer -->
<!-- 										            <div class="modal-footer"> -->
<!-- 										            If we need navigation buttons -->
<!-- 														  <div class="swiper-button-prev"></div> -->
<!-- 														  <div class="swiper-button-next"></div> -->
<!-- 										            </div> -->
<!--                            					 	</div>					 	 -->
<!--                            					 </div> -->
<!--                            			</div> -->
                           			
					               
					                
					                <div v-for="(attachmentNo, attachmentIndex) in post.attachmentList" :key="attachmentIndex">
					                	<!-- 일단 이미지만 -->
					                	
					                	
					                
<!-- 					                	이미지인 경우 -->
<!-- 					                	<div v-if="checkFileType(attachmentNo) === 'image' "> -->
<!-- 					                		<img :src="getAttachmentUrl(attachmentNo)" class="mx-1 px-1"style="max-width:100%;max-height:100%" alt="Attachment"> -->
<!-- 					                	</div> -->
<!-- 					                	<div v-else-if="checkFileType(attachmentNo) === 'video'"> -->
<!-- 					                		<video :src="getAttachmentUrl(attachmentNo)" class="mx-1 px-1" style="max-width:100%;max-height:100%"  controls> -->
<!-- 				                		 	</video> -->
<!-- 					                	</div> -->
<!-- 					                	<div v-else-if="checkFileType(attachmentNo) === 'unknown'"> -->
<!-- 					                		<h1>언노운</h1> -->
<!-- 					                	</div>					                     -->
					                </div>
					                <br>
					            </div>
					            <div v-else>
					            </div>
		                	</div>
		                	
		                	
		                	<!-- 구분선 -->
		                	<div class="row">
		                		<hr style="width:100%;">
		                	</div>
		                	
		                	<!-- 좋아요, 댓글, 공유하기 -->
		                	<div class="row">
		                	
		                		<!-- 좋아요 -->		                		
		                		<div class="col-4 text-start text-primary">
		                			<div class="row" v-if="postLikeIndexList.includes(index)">
		                				<div class="col-2">
		                					<i class="fs-4 ti ti-heart-filled" @click="checkLike(post.postNo,index)"></i>
		                				</div>
		                				<div class="col-4 ">
		                					<h6 class="postlikeCount">{{post.likeCount}}</h6>
		                				</div>		                						                				
		                			</div>
		                			<div class="row" v-else>
		                				<div class="col-2">
		                					<i class="fs-4 ti ti-heart" @click="checkLike(post.postNo,index)"></i>
		                				</div>
		                				<div class="col-4 ">
		                					<h6 class="postlikeCount">{{post.likeCount}}</h6>
		                				</div>
		                			</div>
		                		</div>
		                		<!-- 좋아요 -->
		                		
		                		<!-- 댓글 작성버튼 -->
							    <div class="col-4 text-center text-secondary">				
							    	<i class="fs-4 ti ti-message" @click="showReplyInput(index)"></i>					    
							    </div>
							    <!-- 댓글 작성버튼 -->
							    
							    <!-- 공유하기 버튼 -->
							    <div class="col-4 text-end text-secondary"><i class="fs-4 ti ti-share"></i></div>
							    <!-- 공유하기 버튼 -->
							     
		                	</div>
		                	
		                	<!-- 구분선 -->
		                	<div class="row">
		                		<hr class="mt-2" style="width:100%;">		                
		                	</div>
		                	
		                	<!-- 댓글, 대댓글 보여주는 창 -->
		                	<div class="row" v-if="post.replyList.length >= 1">
								<div v-for="(reply,replyIdx) in post.replyList" :key="replyIdx">
									<!-- 댓글 표시 -->
									<div class="d-flex align-items-center justify-content-center mb-1" v-if="reply.replyNo == reply.replyGroupNo">
										
				                		<div class="col-2 text-center ">
				                			<div class="row w-50 h-50 text-center m-auto">
				                				<img class="img-fluid rounded-circle " src="static/image/profileDummy.png">
				                			</div>
				                			<div class="row w-50 h-50 text-center m-auto">
				                				<h6 class="fs-7">{{reply.replyId}}</h6>
				                			</div>
				                		</div>
				                		
				                		<div class="col-8">
				                			<div class="row">
				                				<h6>{{reply.replyContent}}</h6>
				                			</div>
				                			<div class="row d-flex flex-nowrap">
<!-- 				                				<h6 class="col-1 text-start reply-text" style="white-space: nowrap;">좋아요 </h6> -->
				                				<h6 class="col-1 text-start reply-text text-secondary" @click="showRereplyInput(post.postNo,reply.replyNo),hideReplyInput()" style="white-space: nowrap;">댓글 달기</h6>	
				                			</div>			                			
				                		</div>
				                		<div class="col-1" v-if="memberId === reply.replyId">
				                			<i class="ti ti-x" @click="deleteReply(reply.replyNo)"></i>
				                		</div>
			                		</div>
			                		<!-- 댓글 표시 -->
			                		
			                		<!-- 대댓글 표시 -->
			                		<div v-for="(rereply,rereplyIdx) in post.replyList.slice(replyIdx+1)" :key='rereplyIdx'>			                							                				             				
			                				<!-- 대댓글이 들어갈 조건 -->
				                			<div v-if="reply.replyNo === rereply.replyGroupNo"><!-- 특정 댓글의 그룹번호가 특정 댓글번호와 일치할 때, -->				                				
				                				<!-- 대댓글 들 -->
				                				<div class="row ">
				                					<div class="col-2">
				                					</div>
				                					<div class="col-2 text-center">
				                						<div class="row w-50 h-50 text-center m-auto">
					                						<img class="img-fluid rounded-circle " src="static/image/profileDummy.png">
					                					</div>
							                			<div class="row w-50 h-50 text-center m-auto">
							                				<h6 class="fs-7">{{rereply.replyId}}</h6>
							                			</div>
				                					</div>
				                					<div class="col-6">
				                						<h6>{{rereply.replyContent}}</h6>
				                					</div>
				                					<div class="col-1">				                						
				                						<i class="ti ti-x" @click="deleteRereply(rereply.replyNo)" v-if="rereply.replyId == memberId"></i>
				                					</div>
				                				</div>
				                				<!-- 대댓글 들 -->
				                			</div>
				                			<!-- 대댓글이 들어갈 조건 -->
				                	</div>
				                	
				                	<!-- 대댓글 작성 창 -->
		                			<div v-if=" post.postNo === tempPostNo && reply.replyNo === tempReplyNo">
		                				<div class="row">
		                					<div class="col-2">
		                					</div>
		                					<div class="col-2 text-center">
		                						<div class="row w-50 h-50 text-center m-auto">
			                						<img class="img-fluid rounded-circle " src="static/image/profileDummy.png">
			                					</div>
					                			<div class="row w-50 h-50 text-center m-auto">
					                				<h6 class="fs-7">${memberId }</h6>
					                			</div>
		                					</div>
		                					<div class="col-7">
		                						<input type="text" v-model="rereplyContent" class="w-100 rounded-4 border border-secondary ">
		                					</div>
		                					<div class="col-1">
		                						<i class="fs-2 text-primary ti ti-arrow-badge-right-filled" @click="rereplySending(post.postNo,reply.replyNo,index)"></i>
		                					</div>
		                				</div>
		                			</div>
				                	<!-- 대댓글 작성 창 -->
				                	
				                	<!-- 대댓글 표시 -->
							    </div> 								             		
		                	</div>
		                	<!-- 댓글, 대댓글 보여주는 창 -->
		                	
		                	<!-- 댓글 작성창  -->
							<!-- 댓글 작성버튼 눌렸을 때만 나오게됨 -->
		                	<div class="row" v-if="replyFlagList[index]"> 
		                		<div class="col-1">
		                			<img class="rounded-circle img-fluid" src="static/image/profileDummy.png">
		                		</div>
		                		<div class="col-10 mt-1">
		                			<input type="text" placeholder=" 댓글을 입력하세요." v-model="replyContent" class="w-100 rounded-4 border border-secondary "> 
		                		</div>
		                		<div class="col-1">
		                			<i class="fs-2 text-primary ti ti-arrow-badge-right-filled" @click="replySending(post.postNo,index)"></i>
		                		</div>		                		
		                	</div>
		                	<!-- 댓글 작성창  -->
		                	
			            </div>
						<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center"> 
			            </div>       
	                </div>
	                <!-- 글 내용 -->
	                
	                <!-- 이미지 -->
<!-- 	                <div class="row my-2"> -->
<!-- 	                	<div class="col-1 col-md-1 col-lg-1 align-items-center justify-content-center"> -->
			               
<!-- 			            </div> -->
<!-- 			            <div class="col-10 col-md-10 col-lg-10 align-items-center">							 -->
<!-- 		                	<div class="row"> -->

<!-- 		                	</div>		                		    -->
<!-- 			            </div> -->
<!-- 						<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">  -->
<!-- 			            </div>        -->
<!-- 	                </div> -->
	                <!-- 글 내용 -->

                </div>
                <!-- 글 박스 루프 1개-->
                
       	 </div>
       	 <!--------------- 게시물들 반복구간 ------------->
            
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
                  memberNick:"",
                  modal:null,
                  followModal:null,
                  followerModal:null,
                  pageModal:null,
                  settingsModal:null,
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
                  file : null,
                  attachment: "",
                  previewURLList:[], 
                  artistViewList:[],
                  previewURL: "",
                  //팔로우 리스트 멤버별 프로필
                  FollowListProfile : [],
                  //팔로워 리스트 멤버별 프로필
                  FollowerListProfile : [],
                  //페이지 리스트 멤버별 프로필
                  PageListProfile:[],
                  
                  targetMemberFollowObj: {},
                  
                  //내페이지 or 남의페이지
                  mypage:false,
                  //팔로우 여부
                  follow : true,
                  
               // 게시글 VO를 저장할 배열
              	posts: [],
              	
              	// 지도에 주소 표시하는 문자열
              	showMapModalText: '',
              	          	
              	// 좋아요 게시글 인덱스 배열
              	postLikeIndexList: [], 
              	
              	// 댓글 작성 여부 체크용 배열
              	replyFlagList: [],
              	
              	// 댓글 작성 글자 
              	replyContent: '',
              	
              	// 대댓글 위치 특정용 임시 postNo, replyNo
              	tempPostNo:null ,
              	tempReplyNo:null ,
              	
              	// 대댓글 작성 글자
              	rereplyContent: '', 
              	
              	// 무한 페이징 영역
              	percent:0,
              	
              	// 목록을 위한 데이터
              	page:1, 
              	finish:false,
              	
              	// 안전장치
              	loading:false,
              	
              	// 입력시 고정태그 불러오기
              	findFixedTagName: "",
              	findFixedTagList: [],
              	newFixedTagList: [],                	
              	
              	// 세션 맴버아이디
              	memberId:"${memberDto.memberId}",
              	
              	// 좋아요한 맴버의 아이디
              	likedMemberId: null,
               //글쓴이 아이디
            	writeMemberId: null,

              	
              	// 모달 이미지 URL
              	modalImageUrl:null,
              	
              	modalImageUrlList:[],
              	
               };
            },      
            methods:{
               openFileInput() {
                     this.$refs.fileInput.click();
                   },
               async profile() {
                  const response = await axios.get("/member/profile",{
                	  params : {
                		  memberId : this.memberId
                	  }
                  });
                  const {memberId, memberNick} = response.data;
                  
                  this.memberId = memberId;
                  this.memberNick=memberNick;
                  console.log("아이디 : "+this.memberId);
                  console.log("닉네임 : "+this.memberNick);
               },
               
               async followCnt() {
                  const response = await axios.get("/member/followCnt",{
                	  params : {
                		  memberId : this.memberId
                	  }
                  });
                  const{MemberFollowCnt, MemberFollowerCnt, MemberPageCnt} = response.data;
                  
                  this.MemberFollowCnt = MemberFollowCnt;
                  this.MemberFollowerCnt = MemberFollowerCnt;
                  this.MemberPageCnt = MemberPageCnt;
               },
               
               async followList() {
                  const response = await axios.get("/member/followList/"+this.memberId);
                  const{FollowMemberList, FollowerMemberList, FollowPageList} = response.data;
                  
                  this.FollowMemberList = FollowMemberList;
                  this.FollowerMemberList = FollowerMemberList;
                  this.FollowPageList = FollowPageList;
                  console.log("팔로우리스트 : "+this.FollowMemberList);
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
               
               showSettingsModal() {
            	   if(this.settingsModal == null) return;
                   this.settingsModal.show();
               },
               hideSettingsModal() {
            	   if(this.settingsModal == null) return;
                   this.settingsModal.hide();
               },
               
               async profileImage() {
                   const response = await axios.get("/member/profileImage",{
                	   params : {
                		   memberId : this.memberId
                	   }
                   });
                   
                   this.memberProfileImageObj = response.data;
                   console.log("this.memberProfileImageObj : "+this.memberProfileImageObj);
                   const attachmentNo = this.memberProfileImageObj.attachmentNo;   
                      console.log("attachmentNo : " +attachmentNo);
                      const url = "/rest/attachment/download/"+attachmentNo;
                   this.previewURL = url;                   
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
                  if(this.page == 1) {
                  this.page++;
                  }
                  return;
               },
               pageMinus() {
                  if(this.page == 2) {
                  this.page--;
                  }
                  return;
               },
               
               // 파일 업로드 시 프로필 사진 변경
                  handleFileUpload(event) {
                      // 업로드 파일
                      const file = event.target.files[0];
                      // 첨부사진 임시보관
                      this.attachment = file;
                      // 사진 미리보기 구현
                       this.previewURL = URL.createObjectURL(file);
                  },

                  // 대표페이지 프로필 사진 설정
                  async uploadFile(event) {
                     // 업로드 파일
                     const file = event.target.files[0];
                     
                     // 첨부사진 임시보관
                     this.attachment = file;
                     
                     // 사진 미리보기 구현
                       this.previewURL = URL.createObjectURL(file);
                     
                      // URL
                      const url = "http://localhost:8080/rest/member/memberProfile";

                      // 폼데이터 생성
                      const formData = new FormData();
                      formData.append('attachment', this.attachment);
                      formData.append('memberId', this.memberId);

                      // 대표페이지 프로필사진 설정
                      const resp = await axios.post(url, formData);
                      
                      alert("대표페이지 프로필사진 설정완료!");
                  },
                  
                  //팔로우 리스트 멤버별 프로필 조회
                  async followListProfile() {
                	  const response =await axios.get("/member/followListProfile",{
                		  params :{
                			  memberId : this.memberId
                		  }
                	  });
                	  this.FollowListProfile.push(...response.data);
                	  
                	  console.log("로그인 :  " +this.memberId);
                  },
                  
                  //팔로워 리스트 멤버별 프로필 조회
                  async followerListProfile() {
					  const response = await axios.get("/member/followerListProfile", {
					    params: {
					    	followTargetPrimaryKey: this.memberId
					    }
					  });
					  this.FollowerListProfile = response.data;
					},
					
					//페이지 리스트 멤버별 프로필 조회
	                  async pageListProfile() {
						const response = await axios.get("/member/pageListProfile",{
							params : {
								memberId : this.memberId
							}
						});

						  this.PageListProfile.push(...response.data);
						  console.log(" this.PageListProfile : "+ this.PageListProfile);
						},
                  
                  //프로필 리스트 팔로우 취소
				async deleteFollow(followNo) {
					const response = await axios.get("/member/deleteFollow",{
						params : {followNo:followNo}
					});
					if (response.data.success) {
					    // 삭제 성공 시, FollowListProfile에서 해당 항목을 제거합니다.
					    this.FollowListProfile = this.FollowListProfile.filter(item => item.followNo !== followNo);
					  }
				},
				
				//비밀번호 변경페이지로 이동
				goToPassword() {
			        window.location.href = '/member/password';
			    },
			    
			    //로그아웃
			    goToLogout() {
			    	window.location.href = '/member/logout';
			    },
			    
			    //회원탈퇴 페이지로 이동
			    goToExit() {
			    	window.location.href = '/member/exit';
			    },
			    
			    //페이지 확인
			    async mypageCheck() {
			    	const response = await axios.get("/member/mypage")
			    	if(response.data === this.memberId) {
			    		this.mypage = true;
			    	}
			    	else {
				    	this.mypage = false;
			    	}
			    },
			    // 회원 팔로우 버튼
		        async followMember(memberSearch){
		            // 1. 회원 로그인 확인
		            // if(memberId === ""){
		            //     if(confirm("로그인 한 회원만 사용할 수 있는 기능입니다. 로그인 하시겠습니까?")) {
		            //         window.location.href = contextPath + "/member/login";
		            //     }
		            // }

		            // artistEngNameLower
		            // 2. toggle 팔로우 삭제, 팔로우 생성
					const targetMemberId = window.location.pathname.split('/').slice(-1);
		            if(isFollowingMember){
		                if(!confirm(this.fullName(targetMemberId) + "님 팔로우를 취소하시겠습니까?")) return;
		                // this.setFollowMemberObj(targetMemberId);
		                // await this.deleteMemberFollow();
		            } else {
		                // this.setFollowMemberObj(targetMemberId);
		                // await this.createFollow();
		            }

		            // await this.loadMemberFollowInfo();
		            // this.loadMemberSearchList();
		        },

				// 대표페이지 팔로우 생성
				async createFollow(){
					// 팔로우 생성 url
					const url = "http://localhost:8080/rest/follow/";
					await axios.post(url, this.followObj);
					// [develope] 
				},
				// 대표페이지 팔로우 취소
				async deleteMemberFollow(){
					// 팔로우 생성 url
					const url = "http://localhost:8080/rest/follow/";
					await axios.delete(url, {
						data: this.followObj,
					});
					// [develope]
				},


		        // 회원 팔로우 대상 설정
		        setFollowMemberObj (followMemberId){
		            // 팔로우 대상 유형
		            this.followObj.followTargetType = "회원";
		            // 팔로우 대상 PK
		            this.followObj.followTargetPrimaryKey = followMemberId;
		        },
			    
			    //팔로우 여부 
			    async followCheck() {
			    	const response = await axios.get("/member/checkFollowMember", {
			    		params : {
							Id : this.memberId
						}
			    	});
			    	console.log(response.data);
			    	if(response.data == true) {
			    		this.follow = true;
			    	}	
			    	else { 
			    		this.follow = false;
			    	}
			    },
			    
			    //팔로우
			    async memberFollowNew() {
			    	const response = await axios.get("/member/follow", {
			    		params : {
							Id : this.memberId
						}
			    	});
			    	this.followCheck();
			    },
                  



                  // 로그인 회원 팔로우 정보 로드
                  async loadMemberFollowInfo() {
                      // 로그인X → 실행 X
                      if (memberId === "") return;
                      // url
                      const url = "http://localhost:8080/rest/follow/memberFollowProfileInfo/"
                      // 팔로우 목록 load
                      const resp = await axios.get(url, { params: { memberId: this.memberId } });

                      // 로그인 팔로우 정보 로드
                      this.targetMemberFollowObj = resp.data;
                      console.table(this.targetMemberFollowObj);
                  },
                  
               // 무한 페이징 게시글 불러오기 1페이지당 10개씩 매 페이지 별로 불러옴,!!!좋아요한글!!!
              	async fetchPosts(){
                      if(this.loading == true) return;//로딩중이면
                      if(this.finish == true) return;//다 불러왔으면
                      
                      this.loading = true;
                      
                      // 1페이지 부터 현재 페이지 까지 전부 가져옴 
                      this.likedMemberId 
                      var likedPostData ={
                      		page: this.page,
                      		likedMemberId: this.memberId
                      };
                     	
                      console.log(likedPostData);
                      
                      const resp = await axios.post("http://localhost:8080/rest/post/pageReload/memberLikePost",likedPostData);
  	                this.posts = resp.data;
  	                this.getLikePostIndex(this.posts);
  	                this.page++;
  	                
  	                this.loading=false;
  	                
  	                if(resp.data.length < 10){
  	                	this.finish = true;
  	                }
              	},
              	
             // 무한 페이징 게시글 불러오기 1페이지당 10개씩 매 페이지 별로 불러옴,!!!내가쓴글!!!
            	async fetchPostsW(){
                    if(this.loading == true) return;//로딩중이면
                    if(this.finish == true) return;//다 불러왔으면
                    
                    this.loading = true;
                    
                    // 1페이지 부터 현재 페이지 까지 전부 가져옴 
                    this.writeMemberId 
                    var writePostData ={
                    		page: this.page,
                    		writeMemberId: this.writeMemberId
                    };
                   	
                    console.log(writePostData);
                    
                    const resp = await axios.post("http://localhost:8080/rest/post/pageReload/memberWritePost",writePostData);
	                this.posts = resp.data;
	                this.getLikePostIndex(this.posts);
	                this.page++;
	                
	                this.loading=false;
	                
	                if(resp.data.length < 10){
	                	this.finish = true;
	                }
            	},
              	
              	// 게시글 삭제 !!!좋아요!!!
              	async deletePost(postNo){
                  	try{
                  		await axios.delete('http://localhost:8080/rest/post/'+postNo);
                  		this.fetchPosts();
                  	}
                  	catch (error){
                  		console.error(error);
                  	}
  			    },
  			    
  			// 게시글 삭제 !!!내가!!!
            	async deletePost(postNo){
                	try{
                		await axios.delete('http://localhost:8080/rest/post/'+postNo);
                		this.fetchPostsW();
                	}
                	catch (error){
                		console.error(error);
                	}
			    },
  			    
  				 // 이미지, 비디오 관련 
  			    setModalImageUrl(attachmentNo){
  			    	this.modalImageUrl = this.getAttachmentUrl(attachmentNo)
  			    },
                  getAttachmentUrl(attachmentNo) {		
              		return "http://localhost:8080/rest/attachment/download/"+attachmentNo;
                  },
                  async checkFileType(attachmentNo) {
                      try {
                          const response = await axios.head('http://localhost:8080/rest/attachment/download/post/' + attachmentNo);
                          const contentType = response.headers['content-type'];
                          if (contentType.includes('image')) {
                              return 'image';
                          } else if (contentType.includes('video')) {
                              return 'video';
                          }
                          return;
                      } catch (error) {
                          console.error(error);
                          // 오류 처리
                      }
                  },
                  setModalImageUrlList(attachmentList)
                  {
                  	this.modalImageUrlList = attachmentList;
                  },
                  
               	// 좋아요 관련 비동기 처리-----------------------------------
               	// 아이디 접속해 있고, 좋아요 클릭시에 실행
               	checkLike(postNo,index){
                  	axios.get('http://localhost:8080/rest/post/like/'+postNo)
                  		.then(response => {
                  			console.log(response.data);
                  			// 응답이 좋아요면 좋아요 +1
                  			if(response.data== 'Like'){
                  				this.posts[index].likeCount = this.posts[index].likeCount + 1; 
                  				this.postLikeIndexList.push(index);                			
                  			}
                  			// 응답이 좋아요 취소면 좋아요 -1
                  			else if(response.data=='disLike'){
                  				this.posts[index].likeCount = this.posts[index].likeCount - 1;
                  				this.postLikeIndexList.splice(this.postLikeIndexList.indexOf(index),1);
                  			}
                  			
                  				
                  		})
                  		.catch(error => {
                  			console.error(error);
                  		})
                  },
                  
                  // postNo를 List로 송신하고 좋아요 되있는 index 번호를 수신
                  getLikePostIndex(posts){
                  	
                  	postNoList = [];
                  	posts.forEach(function(post){
                  		postNoList.push(post.postNo); 
                  	})
                  	
                 		axios.get('http://localhost:8080/rest/post/like/index/'+postNoList)
                 			.then(response => {               			
                 			this.postLikeIndexList = response.data;                			
                 		})
                 		.catch(error => {
                 			console.error(error);
                 		})
                  	              		
                  },
               	// 좋아요 관련 비동기 처리------------------------------------
                  
               	
               	
                  // 댓글 창 관련 클릭 함수 -------------------------------              
                	// 전송 버튼 클릭 시
                  async replySending(postNo,index){
                  	try{
                  		const replyDto = {postNo: postNo, replyContent:this.replyContent};
                      	const response = await axios.post('http://localhost:8080/rest/post/reply/',replyDto);
                      	this.fetchPosts();
                      }
                  	catch (error){
                  		console.error(error);
                  	}
                  	
                  	this.hideReplyInput(index)
                  },
                  // 댓글 쓰기 창 띄우기 (다른 창들은 모두 닫음) 
                  showReplyInput(index){
  					this.replyContent = '';                 	
                  	this.replyFlagList = this.replyFlagList.map(() => false); 
                  	this.replyFlagList[index] = true;
                  },
                  // 댓글 쓰기 창 숨기기
                  hideReplyInput(index){
                  	this.replyFlagList[index] = false;
                  },
                  
                  // 대댓글 전송 버튼 클릭 시 
                  async rereplySending(postNo,replyNo,index){
                  	try{
                  		const replyDto = {postNo: postNo, replyContent:this.rereplyContent, replyGroupNo: replyNo};
                      	const response = await axios.post('http://localhost:8080/rest/post/rereply/',replyDto);
                      	this.fetchPosts();
                      }
                  	catch (error){
                  		console.error(error);
                  	}
                  	
                  	this.hideRereplyInput();
                  },
                  
//               	// 대댓글 쓰기 창 띄우기 (다른 창들은 모두 닫음)
                  showRereplyInput(postNo,replyNo){
  					this.rereplyContent = ''; 
  					this.tempPostNo = postNo;
  					this.tempReplyNo = replyNo;
  					console.log(postNo);
                  	console.log(replyNo);
                  },
                  
                  hideRereplyInput(){
                  	this.rereplyContent = '';
                  	this.tempPostNo = null;
                  	this.tempReplyNo = null;
                  },
                  
                  // 댓글 삭제 !!!좋아요!!!
                  async deleteReply(replyNo){
                  	try{
                  		await axios.delete('http://localhost:8080/rest/post/reply/delete/'+replyNo);
                  		this.fetchPosts();
                  	}
                  	catch (error){
                  		console.error(error);
                  	}
                  
                  },
                  
                  // 댓글 삭제!!!내가!!!
                  async deleteReply(replyNo){
                  	try{
                  		await axios.delete('http://localhost:8080/rest/post/reply/delete/'+replyNo);
                  		this.fetchPostsW();
                  	}
                  	catch (error){
                  		console.error(error);
                  	}
                  
                  },
                  
                  // 대댓글 삭제!!!좋아요!!!
                  async deleteRereply(replyNo){
                  	try{
                  		await axios.delete('http://localhost:8080/rest/post/reply/reDelete/'+replyNo);
                  		this.fetchPosts();
                  	}
                  	catch(error){
                  		console.error(error);
                  	}
                  },
               // 대댓글 삭제!!!내가!!!
                  async deleteRereply(replyNo){
                  	try{
                  		await axios.delete('http://localhost:8080/rest/post/reply/reDelete/'+replyNo);
                  		this.fetchPostsW();
                  	}
                  	catch(error){
                  		console.error(error);
                  	}
                  },
                
                  // 댓글 창 관련 클릭 함수 -------------------------------
               	
                  
               	
              	// 모달창 클릭 시 지도 정보 불러오기-------------------------
              	showMap(keyword){
              		this.showMapModalText = keyword;
              		// 마커를 담을 배열입니다
              		var markers = [];
  	
              		// 지도 정보를 담을 변수
              		let mapPlace = "기본";

              		var mapContainer = document.getElementById('mapShow'), // 지도를 표시할 div 
              		    mapOption = {
              		        center: new kakao.maps.LatLng(37.606826, 126.8956567), // 지도의 중심좌표
              		        level: 8 // 지도의 확대 레벨
              		    };  

              		// 지도를 생성합니다    
              		var map = new kakao.maps.Map(mapContainer, mapOption); 

              		// 장소 검색 객체를 생성합니다
              		var ps = new kakao.maps.services.Places();  
  		
              		// 키워드 검색 완료 시 호출되는 콜백함수 입니다
              		function showMapPlacesSearchCB (data, status, pagination) {
              		    if (status === kakao.maps.services.Status.OK) {

              		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
              		        // LatLngBounds 객체에 좌표를 추가합니다
              		        var bounds = new kakao.maps.LatLngBounds();

              		        for (var i=0; i<data.length; i++) {
              		            displayMarker(data[i]);    
              		            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
              		        }       

              		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
              		        map.setBounds(bounds);
              		    } 
              		}            		
              		
              		ps.keywordSearch(keyword,showMapPlacesSearchCB);
              		
              		// 지도에 마커를 표시하는 함수입니다
              		function displayMarker(place) {
              		    
              		    // 마커를 생성하고 지도에 표시합니다
              		    var marker = new kakao.maps.Marker({
              		        map: map,
              		        position: new kakao.maps.LatLng(place.y, place.x) 
              		    });

              		    // 마커에 클릭이벤트를 등록합니다
              		    kakao.maps.event.addListener(marker, 'click', function() {
              		        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
              		        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
              		        infowindow.open(map, marker);
              		    });
              		}
              	},
              	setId(){ // 아이디 세팅
              		const memberId = '${memberId}';
                  	if (memberId && memberId.trim() !== '') {
                  		    // memberId가 존재하고 빈 문자열이 아닌 경우
                  		    this.memberId = memberId;
                  	} else {
                  		    // memberId가 없거나 빈 문자열인 경우 기본 값 또는 예외 처리를 수행합니다.
                  		    this.memberId = null; // 기본 값으로 null을 할당하거나
                  		    // 예외 처리 로직을 추가합니다.
                  		    // 예: 오류 메시지 표시, 다른 로직 실행 등
                  	}            		
              	},
              	setLikedMemberId(){
              		const likedMemberId = '${likedMemberId}';
              		if(likedMemberId && likedMemberId.trim() !== ''){
              			this.likedMemberId = likedMemberId;
         
              		}
              		else{
              			this.likedMemberId = null;
              		}
              	},
              	setWriteMemberId(){
            		const writeMemberId = '${writeMemberId}';
            		if(writeMemberId && writeMemberId.trim() !== ''){
            			this.writeMemberId = writeMemberId;
       
            		}
            		else{
            			this.writeMemberId = null;
            		}
            	},
              	
              	async loadFindFixedTagList(){
                      if(this.findFixedTagName.length == 0) return;

                      const resp = await axios.get("http://localhost:8080/rest/fixedTag/"+this.findFixedTagName);
                      this.findFixedTagList = resp.data;
  					// console.log(this.findFixedTagList);
                      // console.log("조회 실행");
                  },
                  // 고정태그 추가
                  addNewFixedTag (newFixedTag){
                  	if(!this.newFixedTagList.includes(newFixedTag))
                  	{
                  		this.newFixedTagList.push(newFixedTag);
                          this.findFixedTagName = "";
                          this.findFixedTagList = [];                		
                  	}                    
                  },
                  

            },
            watch:{
            	percent(){
            		if(this.percent >= 80){
            			this.fetchPosts();
            		}
            	},
            	findFixedTagName:_.throttle(function(){
                    //this == 뷰 인스턴스
                    this.loadFindFixedTagList();
        		}, 250),
            	
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
       		this.pageListProfile();
       		this. mypageCheck();
       		this.followCheck();
               
            // 게시글 불러오기
           	this.setId();
           	this.setLikedMemberId();
           	this.fetchPosts();
            },
            
            mounted() {
               this.profile();
               this.followList();
               this.followListProfile();
           		this.followerListProfile();
           
               this.followCnt();
               this.modal = new bootstrap.Modal(this.$refs.modal);
               this.followModal = new bootstrap.Modal(this.$refs.followModal);
               this.followerModal = new bootstrap.Modal(this.$refs.followerModal);
               this.pageModal = new bootstrap.Modal(this.$refs.pageModal);
               this.settingsModal = new bootstrap.Modal(this.$refs.settingsModal);
               
               //윈도우 전체에 스크롤 이벤트를 설정(Vue가 아닌 JS 사용)
               //- 주의할 점은 스크롤 이벤트는 발생빈도가 엄청나다는 것
               //- 쓰로틀링, 디바운스 등으로 억제시킬 필요가 있음
               //- this를 통일시키기 위해 화살표 함수(arrow function)를 사용
           	 window.addEventListener("scroll", _.throttle(()=>{
                    //console.log("스크롤 이벤트");
                    //console.log(this);

                    //스크롤은 몇 % 위치에 있는가? 를 알고 싶다면
                    //- 전체 문서의 높이(document.body.clientHeight)
                    //- 현재 스크롤의 위치(window.scrollY)
                    //- 브라우저의 높이(window.innerHeight)
                    //- ScreenFull.js나 Rallax.js 등 라이브러리 사용 가능
                    const height = document.body.clientHeight - window.innerHeight;
                    const current = window.scrollY;
                    const percent = (current / height) * 100;
                    //console.log("percent = " + Math.round(percent));
                    
                    //data의 percent를 계산된 값으로 갱신
                    this.percent = Math.round(percent);
                }, 250));
            },
         }).mount("#app");
         <!--algPggg-->
      </script>
      
</body>    

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> 