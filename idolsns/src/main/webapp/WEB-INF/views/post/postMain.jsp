<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	<!-- 게시글 작성 코드 async-post.js -->
	<script src="${pageContext.request.contextPath}/static/js/async-post.js"></script>
		
	<!------- 카카오 지도 관련-------->
	<!-- 카카오 api 키 등록 -->
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=047888df39ba653ff171c5d03dc23d6a&libraries=services"></script>
	<!-- 맵 관련 css -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/map.css">
	<!------- 카카오 지도 관련-------->
    
    <!-- tabler 아이콘 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">
     
    <style>
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
   
<!--    	model.addAttribute로 받은 memberId Vue의 Data영역에서 활용할 수 있도록 선언 -->
<!--    	<script> -->
<%-- //    		var sessionMemberId = '${memberId}'; --%>
<!-- //   		Vue.provide('$sessionMemberId', sessionMemberId); -->
<!--    	</script>  -->
	

	<div class="container-fluid" id="app">
		
		<!----------- 글쓰기 버튼 ------------>
	    <div class="bg-white mb-2 p-4 rounded-4">
	        <div class="row mt-1">
	            <div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">
	               <img class="rounded-circle img-fluid" src="static/image/profileDummy.png">
	            </div>
	            <div class="col-11 col-md-11 col-lg-11 d-flex align-items-center justify-content-center">
	                <button type="button" class="btn btn-white btn-outline-secondary rounded-pill col-12 border border-secondary" data-bs-target="#modal1" data-bs-toggle="modal">${memberId}님 무슨 생각을 하고 계신가요?</button>
	            </div>
	            
	        </div>	        
	    </div>
	    <!----------- 글쓰기 버튼 ------------>
	    
        <!-- 지도 테스트 모달 버튼 (클릭 시 지도 relayout함수 호출 -> 안하면 지도 이미지 깨짐)-->
<!-- 	    <button type="button" onclick="relayout();" class="btn btn-white btn-outline-dark rounded-pill col-12 " data-bs-target="#modalmap" data-bs-toggle="modal">지도 테스트 모달</button> -->
	    
	    <!----------------------------------- 단계별 모달창 구성------------------------------------------------->
		<!-- 1. 카테고리 선택 -->
        <div class="modal" tabindex="-1" role="dialog" id="modal1"
                            data-bs-backdrop="static"> <!-- static이면 모달창 외부 클릭해도 안꺼짐 -->
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                
                	<!-- header -->
                    <div class="modal-header">
                        <h5 class="modal-title"><i class="fa-solid fa-xmark fa-lg grey" data-bs-dismiss="modal"></i></h5>
                    </div>
                   
                    <!-- body -->
                    <div class="modal-body">
                        <!-- 태그 버튼 선택 -->
                        
                        <p class="text-center">무엇에 대한 글인가요?(카테고리 설정)</p>
                        <div class="row justify-content-center"> 
                        	<button type="button" class="col-3 btn btn-primary btn-sm modal2 rounded-pill"
	                        	data-bs-target="#modal2" data-bs-toggle="modal">
	                        	자유
	                        </button>
	                        &nbsp;&nbsp;
	                        <button type="button" class="col-3 btn btn-primary btn-sm modal2 rounded-pill"
	                        	data-bs-target="#modal1-1" data-bs-toggle="modal">
	                        	행사일정
	                        </button>
                     	    &nbsp;&nbsp;
	                        <button type="button" class="col-3 btn btn-primary btn-sm modal2 rounded-pill"
	                        	data-bs-target="#modal1-2" data-bs-toggle="modal">
	                        	같이가요
	                        </button>
                        </div>
                    </div>
                   
                    <!-- footer -->
                    <div class="modal-footer">
                    		<br>
<!--                         <button type="button" class="btn btn-secondary btn-sm" -->
<!--                                 data-bs-dismiss="modal">닫기</button> -->
                    </div>
                    
                </div>      
            </div>
        </div>
 
        <!-- 1-1. 행사일정 기간 -->
        <div class="modal" tabindex="-1" role="dialog" id="modal1-1"
                            data-bs-backdrop="static"> <!-- static이면 모달창 외부 클릭해도 안꺼짐 -->
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                
                	<!-- header -->
                    <div class="modal-header">
                         <h5 class="modal-title"><i class="fa-solid fa-xmark fa-lg grey" data-bs-dismiss="modal"></i></h5>
                    </div>
                    
                    <!-- body -->
                    <div class="modal-body">
                        <!-- 태그 버튼 선택 -->
                        <p class="text-center">행사일정의 시작, 종료 날짜 및 시간을 선택하세요</p>
                        <div class="row justify-content-center"> 
                        	<h6 class="col-5 text-center">시작 날짜 및 시간</h6>
                        	<input type="datetime-local" id="schedule-start" class="col-7">
                        </div>
                        <br>
                        <div class="row justify-content-center"> 
                        	<h6 class="col-5 text-center">종료 날짜 및 시간</h6>
                        	<input type="datetime-local" id="schedule-end" class="col-7">
                        </div>
                    </div>
                   
                    <!-- footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary btn-sm"
	                        	data-bs-target="#modal2" data-bs-toggle="modal">
	                        	다음
	                    </button>
<!--                         <button type="button" class="btn btn-secondary btn-sm" -->
<!--                                 data-bs-dismiss="modal">닫기</button> -->
                    </div>
                    
                </div>      
            </div>
        </div>
   
        <!-- 1-2. 같이가요 기간 -->
        <div class="modal" tabindex="-1" role="dialog" id="modal1-2"
                            data-bs-backdrop="static"> <!-- static이면 모달창 외부 클릭해도 안꺼짐 -->
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                
                	<!-- header -->
                    <div class="modal-header">
                         <h5 class="modal-title"><i class="fa-solid fa-xmark fa-lg grey" data-bs-dismiss="modal"></i></h5>
                    </div>
                    
                    <!-- body -->
                    <div class="modal-body">
                        <!-- 태그 버튼 선택 -->
                        <p class="text-center">같이가요의 시작, 종료 날짜 및 시간을 선택하세요</p>
                        <div class="row justify-content-center"> 
                        	<h6 class="col-5 text-center">시작 날짜</h6>
                        	<input type="datetime-local" id="together-start" class="col-7">
                        </div>
                        <br>
                        <div class="row justify-content-center"> 
                        	<h6 class="col-5 text-center">종료 날짜</h6>
                        	<input type="datetime-local" id="together-end" class="col-7">
                        </div>
                    </div>
                   
                    <!-- footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary btn-sm"
	                        	data-bs-target="#modal2" data-bs-toggle="modal">
	                        	다음
	                    </button>
<!--                         <button type="button" class="btn btn-secondary btn-sm" -->
<!--                                 data-bs-dismiss="modal">닫기</button> -->
                    </div>
                    
                </div>      
            </div>
        </div>
                                
		<!-- 2.  태그 창 (첫번 째 창에서 다음 버튼이 클릭 되었을 때, 비동기로 현존하는 이벤트 태그들을 가져옴)-->
        <div class="modal" tabindex="-1" role="dialog" id="modal2"
                            data-bs-backdrop="static">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                
                	<!-- header -->
                    <div class="modal-header">
                         <h5 class="modal-title"><i class="fa-solid fa-xmark fa-lg grey" data-bs-dismiss="modal"></i></h5>
                    </div>
                    
                    <!-- body -->
                    <div class="modal-body">
                        <p class="text-center">글에 적용할 태그를 입력해주세요</p>
                        <div class="row text-center">
                     	    <div class="col-1"></div>
                        	<input type="text" class="tag-input col-7" placeholder="태그를 입력하세요">
                        	<div class="col-1"></div>
                        	<button class="col-2 tag-btn">입력</button>
                        </div>
                        <div class="row">
                        	<h6 class="all-tag"></h6>
                        </div>                         
                    </div>
                    
                    <!-- footer -->
                    <div class="modal-footer">
                       	<button type="button" class="btn btn-primary btn-sm"
                            data-bs-target="#modal3" data-bs-toggle="modal">
                        	글작성하기
                        </button>
<!--                         <button type="button" class="btn btn-secondary btn-sm" -->
<!--                                 data-bs-dismiss="modal">닫기</button> -->
                    </div>
                    
                </div>      
            </div>
         </div>
                  
        <!-- 3. 글 및 업로드 창 (두 번째 창에서 다음 버튼이 클릭 되었을 때, 비동기로 현존하는 아이돌 태그들을 가져옴)-->
        <div class="modal" tabindex="-1" role="dialog" id="modal3"
                            data-bs-backdrop="static">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                
                	<!-- header -->
                    <div class="modal-header">
                         <h5 class="modal-title"><i class="fa-solid fa-xmark fa-lg grey" data-bs-dismiss="modal"></i></h5>
                    </div>
                    
                    <!-- body -->
                    <div class="modal-body">
                        <textarea class="col-12 post border border-secondary rounded-2" style="height: 200px;" placeholder=" 글 작성란"></textarea>
                        <div id="preview" contenteditable="true"></div>
                        
                    </div>
                    
                    <!-- footer -->
                    <div class="modal-footer">
                    	<div class="col-7 text-start">
                    		<input type="file" class="fs-6" id="fileInput" multiple>
                    	</div>
                    	<div class="col-4 text-end fs-4">
                    		<button type="button" class="btn btn-primary btn-sm write-finish mx-2"
                                data-bs-dismiss="modal">작성완료</button>
							<button type="button" class="btn btn-primary btn-sm"
								data-bs-target="#modalmap" onclick="relayout();" data-bs-toggle="modal">지도정보삽입</button>                    
<!--                         <button type="button" class="btn btn-secondary btn-sm" -->
<!--                                 data-bs-dismiss="modal">닫기</button> -->
                    	</div>
                    	
                    	
                    </div>
                    
                </div>      
            </div>
         </div>
         
        <!-- 4. 지도 정보 및 업로드 창 -->
	    <div class="modal" tabindex="-1" role="dialog" id="modalmap"
        					data-bs-backdrop="static">
        	<div class="modal-dialog" role="document">
        		<div class="modal-content">
        			<div class="modal-header">
        				<h6> 지역을 검색하고 선택하세요 ex) 이레빌딩 or 선유동2로</h6>
        			</div>
        			
        			<div class="modal-body row">
        				<div class="col-1">
        				</div>
        				<div class="map_wrap col-10">
					          <div id="map" style="width:100%;height:100%;position:relative;overflow:visible;align-content:center;"></div>
					
					          <div id="menu_wrap" class="bg_white">
					              <div class="option">
					                  <div>
					                      <!-- <form onsubmit="searchPlaces(); return false;"> -->
					                          키워드 : <input type="text" id="keyword" size="15"> 
					                          <button type="button" onclick="searchPlaces();">검색하기</button> 
					                      <!-- </form> -->
					                  </div>
					              </div>
					              <ul id="placesList"></ul>
					              <div id="pagination"></div>
					          </div>
					      </div>
        				
        				<div class="col-1">
        				</div>
        			</div>
        			<br>
        			<!-- footer -->
                    <div class="modal-footer justify-content-end">
                    	
						  <div class="col-6 text-start">
						    	<span class="address"></span>
						  </div>

	
						  <div class="col-5 ">
						  	<div class="row justify-content-end">
						  		 <div class="col-7">
<!-- 						  		 	<button type="button" class="btn btn-primary btn-sm"> -->
<!-- 						  		 	작성완료</button> -->
						  		 	<button type="button" class="btn btn-primary btn-sm bttest"
                            			data-bs-target="#modal3" data-bs-toggle="modal">
                        			글쓰기
                        			</button>
						  		 </div>
						  		 
						  		 <div class="col-5">
						  		 	<button type="button" class="btn btn-secondary btn-sm"
							        	    data-bs-dismiss="modal">닫기</button>	
						  		 </div>
						  		  
						  	</div>
							
						  </div>
                    </div>
                    
        		</div>
        	</div>
        </div>
	    
	    
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
			               <i class="fs-3 text-secondary ti ti-dots-vertical"></i>
			            </div>
							
	       			</div>	
					<!-- 프로필 사진과 아이디 -->
					
					<!-- 태그와 글 태그들 -->
	                <div class="row mb-3 ">
	                	<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">			            
			            </div>
			            <div class="col-10 col-md-10 col-lg-10 d-flex align-items-center justify-content-start">
							<div class="mx-1 px-2 h-20 bg-primary rounded-4 align-items-center justify-content-center">
								<p class="fs-7 text-light">{{ post.postType }}</p>										 
							</div>
							<div v-for="tag in post.tagList" :key="tag" class="mx-1 px-2 h-20 bg-primary rounded-pill align-items-center justify-content-center">
								<p class="fs-7 text-light">{{ tag }}</p>
							</div>
														 													    
			            </div>
						<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center"> 
			            </div>	                
	                </div>
	                <!-- 태그와 글 태그들 -->	 
	                               
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
		                	</div>
		                	
		                	<!-- 이미지 표시 -->
		                	<div class="row">
		                		<div v-if="post.attachmentList && post.attachmentList.length > 0"  class="d-flex">
					                <div v-for="(attachmentNo, attachmentIndex) in post.attachmentList" :key="attachmentIndex">
					                	<!-- 이미지인 경우 -->
					                	<div v-if="checkImage(attachmentNo)">
					                		<img :src="getAttachmentUrl(attachmentNo)" class="mx-1 px-1"style="max-width:100%;max-height:100%" alt="Attachment">
					                	</div>
					                	<div v-else>
					                		<video :src="getAttachmentUrl(attachmentNo)" class="mx-1 px-1" style="max-width:100%;max-height:100%"  controls>
				                		 	</video>
					                	</div>					                    
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
				                		
				                		<div class="col-9">
				                			<div class="row">
				                				<h6>{{reply.replyContent}}</h6>
				                			</div>
				                			<div class="row d-flex flex-nowrap">
<!-- 				                				<h6 class="col-1 text-start reply-text" style="white-space: nowrap;">좋아요 </h6> -->
				                				<h6 class="col-1 text-start reply-text" @click="showRereplyInput(post.postNo,reply.replyNo),hideReplyInput()" style="white-space: nowrap;">댓글 달기</h6>	
				                			</div>			                			
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
				                					<div class="col-7">
				                						<h6>{{rereply.replyContent}}</h6>
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
	                <div class="row my-2">
	                	<div class="col-1 col-md-1 col-lg-1 align-items-center justify-content-center">
			               
			            </div>
			            <div class="col-10 col-md-10 col-lg-10 align-items-center">							
		                	<div class="row">

		                	</div>		                		   
			            </div>
						<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center"> 
			            </div>       
	                </div>
	                <!-- 글 내용 -->

                </div>
                <!-- 글 박스 루프 1개-->
                
       	 </div>
       	 <!--------------- 게시물들 반복구간 ------------->

	</div>

    <!-- Vue.createApp구간 -->
    <script>
        Vue.createApp({
            data(){
                return {
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
                	
                };
            },
            computed:{  
            	
            },
            methods:{
				// 모든 게시글 불러오기 
//                 async fetchPosts() {
// 	                await axios.get('http://localhost:8080/rest/post/all')
// 	                    .then(response => {
// 	                    	// 전체 게시글 데이터 가져오기
// 	                        this.posts = response.data;
// 	                     	// 게시글 인덱스별 좋아요 처리
// 	                        this.getLikePostIndex(this.posts);
// 	                     	this.replyFlagList = new Array(this.posts.length).fill(false);
// 	                    })
// 	                    .catch(error => {
// 	                        console.error(error);                           
// 	                    }) 
//             	},
            	
            	// 무한 페이징 게시글 불러오기 1페이지당 10개씩 매 페이지 별로 불러옴,
            	async fetchPosts(){
                    if(this.loading == true) return;//로딩중이면
                    if(this.finish == true) return;//다 불러왔으면
                    
                    this.loading = true;
                    
                    // 1페이지 부터 현재 페이지 까지 전부 가져옴 
                    const resp = await axios.get("http://localhost:8080/rest/post/pageReload/"+this.page);
	                this.posts = resp.data;
	                this.page++;
	                
	                this.loading=false;
	                
	                if(resp.data.length < 10){
	                	this.finish = true;
	                }
            	},
            	
            	// 사진 관련 
                getAttachmentUrl(attachmentNo) {
            		return "http://localhost:8080/rest/attachment/download/"+attachmentNo;
                },
                async checkImage(attachmentNo) {
                    try {
                      const response = await axios.head('http://localhost:8080/rest/attachment/download/' + attachmentNo);
                      const contentType = response.headers['content-type'];
                      return contentType.includes('image');
                    } catch (error) {
                      console.error(error);
                      return false;
                    }
                },
                
             	// 좋아요 관련 비동기 처리-----------------------------------
             	// 아이디 접속해 있고, 좋아요 클릭시에 실행
             	async checkLike(postNo,index){
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
                
//             	// 대댓글 쓰기 창 띄우기 (다른 창들은 모두 닫음)
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
            	}
            },
            watch:{
            	percent(){
            		if(this.percent >= 80){
            			this.fetchPosts();
            		}
            	}
            },
            mounted() {
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
            created(){
            	// 게시글 불러오기
            	this.fetchPosts();
            },
        }).mount("#app");
    </script>
    
    
	 <!-- 카카오 API구현 JS -->
	<script src="${pageContext.request.contextPath}/static/js/post-map.js"></script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>