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
    </style>
   
	

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
<!-- 			            	<p>{{ post.postNo }}</p> -->
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
	                <!-- 지도 -->
	                
	                
	                <!-- 글 내용 -->
	                <div class="row my-2">
	                	<div class="col-1 col-md-1 col-lg-1 align-items-center justify-content-center">
			               
			            </div>
			            <div class="col-10 col-md-10 col-lg-10 align-items-center">							
		                	<div class="row">
		                		<p>{{ post.postContent }}</p>
		                	</div>
		                	<div class="row">
		                		<hr style="width:100%;">
		                	</div>
		                	<div class="row">		                		
		                		<div class="col-4 text-start text-primary"><i class="fs-4 ti ti-heart"></i></div>
							    <div class="col-4 text-center text-secondary"><i class="fs-4 ti ti-message"></i></div>
							    <div class="col-4 text-end text-secondary"><i class="fs-4 ti ti-share"></i></div> 
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
                	showMapModalText: '',
                };
            },
            methods:{
				// 모든 게시글 불러오기 
                fetchPosts: function() {
	                axios.get('http://localhost:8080/rest/post/all')
	                    .then(response => {
	                        this.posts = response.data; // 데이터를 할당
	                    })
	                    .catch(error => {
	                        console.error(error);                           
	                    }) 
            	},
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
            mounted() {
                // 게시글 불러오기
                this.fetchPosts();
            },
        }).mount("#app");
    </script>
    
    
	 <!-- 카카오 API구현 JS -->
	<script src="${pageContext.request.contextPath}/static/js/post-map.js"></script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>