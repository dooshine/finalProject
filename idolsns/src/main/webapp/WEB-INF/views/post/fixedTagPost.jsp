<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


		
	<!------- 카카오 지도 관련-------->
	<!-- 카카오 api 키 등록 -->
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=047888df39ba653ff171c5d03dc23d6a&libraries=services"></script>
	<!-- 맵 관련 css -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/map.css">
	<!------- 카카오 지도 관련-------->
    
    <!-- tabler 아이콘 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">
     
    <!-- swiper cdn -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css"/>
	<script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
	
	     
    <style>
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
   

	<div class="container-fluid" id="app">
		
		<h1>고정태그가 {{fixedTagName}}인 글입니다.</h1>
	    
	    
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
                	
                	// 입력시 고정태그 불러오기
                	findFixedTagName: "",
                	findFixedTagList: [],
                	newFixedTagList: [],                	
                	
                	// 세션 맴버아이디
                	memberId:null,
                	
                	// 고정 태그이름
                	fixedTagName: null,
                	
                	// 모달 이미지 URL
                	modalImageUrl:null,
                	
                	modalImageUrlList:[],
                	
                };
            },
            computed:{  
            	
            },
            methods:{
            		
            	// 무한 페이징 게시글 불러오기 1페이지당 10개씩 매 페이지 별로 불러옴,
            	async fetchPosts(){
                    if(this.loading == true) return;//로딩중이면
                    if(this.finish == true) return;//다 불러왔으면
                    
                    this.loading = true;
                    
                    // 1페이지 부터 현재 페이지 까지 전부 가져옴 
                    this.fixedTagName 
                    var fixedTagPostData ={
                    		page: this.page,
                    		fixedTagName: this.fixedTagName
                    };
                   	
                    //console.log(fixedTagPostData);
                    
                    const resp = await axios.post("${contextPath}/rest/post/pageReload/fixedTagPost",fixedTagPostData);
	                this.posts = resp.data;
	                this.getLikePostIndex(this.posts);
	                this.page++;
	                
	                this.loading=false;
	                
	                if(resp.data.length < 10){
	                	this.finish = true;
	                }
            	},
            	
            	// 게시글 삭제 
            	async deletePost(postNo){
                	try{
                		await axios.delete('${contextPath}/rest/post/'+postNo);
                		this.fetchPosts();
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
            		return "${contextPath}/rest/attachment/download/"+attachmentNo;
                },
                async checkFileType(attachmentNo) {
                    try {
                        const response = await axios.head('${contextPath}/rest/attachment/download/post/' + attachmentNo);
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
                	axios.get('${contextPath}/rest/post/like/'+postNo)
                		.then(response => {
                			//console.log(response.data);
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
                	
               		axios.get('${contextPath}/rest/post/like/index/'+postNoList)
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
                    	const response = await axios.post('${contextPath}/rest/post/reply/',replyDto);
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
                    	const response = await axios.post('${contextPath}/rest/post/rereply/',replyDto);
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
					//console.log(postNo);
                	//console.log(replyNo);
                },
                
                hideRereplyInput(){
                	this.rereplyContent = '';
                	this.tempPostNo = null;
                	this.tempReplyNo = null;
                },
                
                // 댓글 삭제
                async deleteReply(replyNo){
                	try{
                		await axios.delete('${contextPath}/rest/post/reply/delete/'+replyNo);
                		this.fetchPosts();
                	}
                	catch (error){
                		console.error(error);
                	}
                
                },
                // 대댓글 삭제
                async deleteRereply(replyNo){
                	try{
                		await axios.delete('${contextPath}/rest/post/reply/reDelete/'+replyNo);
                		this.fetchPosts();
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
            	setFixedTagName(){
            		const fixedTagName = '${fixedTagName}';
            		if(fixedTagName && fixedTagName.trim() !== ''){
            			this.fixedTagName = fixedTagName;
       
            		}
            		else{
            			this.fixedTagName = null;
            		}
            	},
            	
            	async loadFindFixedTagList(){
                    if(this.findFixedTagName.length == 0) return;

                    const resp = await axios.get("${contextPath}/rest/fixedTag/"+this.findFixedTagName);
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
            	this.setId();
            	this.setFixedTagName();
            	this.fetchPosts();
            	
            	
            	
            	
            	
            },
        }).mount("#app");
    </script>
    
    <!-- 이미지 스와이핑 창 -->
    <script src="${pageContext.request.contextPath}/static/js/swiping-image.js"></script>
    <!-- 게시글 작성 ajax -->
	<script src="${pageContext.request.contextPath}/static/js/async-post.js"></script>
	 <!-- 카카오 API구현 JS -->
	<script src="${pageContext.request.contextPath}/static/js/post-map.js"></script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>