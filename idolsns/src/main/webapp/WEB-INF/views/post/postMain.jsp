<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	<!-- 게시글 작성 코드 async-post.js -->
	<script src="${pageContext.request.contextPath}/static/js/async-post.js"></script>
	
	<!------- 카카오 지도 관련-------->
	<!-- 카카오 api 키 등록 -->
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=047888df39ba653ff171c5d03dc23d6a&libraries=services"></script>
	<!-- 맵 관련 css -->
	<link rel="stylesheet" type="text/css" href="/static/css/map.css">
	<!------- 카카오 지도 관련-------->
     
      
    <!-- 카카오 API구현 JS -->
	<script>
	// 마커를 담을 배열입니다
	var markers = [];
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
	
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places();  
	
	// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});
	
	// 키워드로 장소를 검색합니다
	// searchPlaces();
	
	// 키워드 검색을 요청하는 함수입니다
	function searchPlaces() {
	
	    var keyword = document.getElementById('keyword').value;
	
	    if (!keyword.replace(/^\s+|\s+$/g, '')) {
	        alert('키워드를 입력해주세요!');
	        return false;
	    }
	
	    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
	    ps.keywordSearch( keyword, placesSearchCB); 
	}
	
	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	function placesSearchCB(data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {
	
	        // 정상적으로 검색이 완료됐으면
	        // 검색 목록과 마커를 표출합니다
	        displayPlaces(data);
	
	        // 페이지 번호를 표출합니다
	        displayPagination(pagination);
	
	    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
	
	        alert('검색 결과가 존재하지 않습니다.');
	        return;
	
	    } else if (status === kakao.maps.services.Status.ERROR) {
	
	        alert('검색 결과 중 오류가 발생했습니다.');
	        return;
	
	    }
	}
	
	// 검색 결과 목록과 마커를 표출하는 함수입니다
	function displayPlaces(places) {
	
	    var listEl = document.getElementById('placesList'), 
	    menuEl = document.getElementById('menu_wrap'),
	    fragment = document.createDocumentFragment(), 
	    bounds = new kakao.maps.LatLngBounds(), 
	    listStr = '';
	    
	    // 검색 결과 목록에 추가된 항목들을 제거합니다
	    removeAllChildNods(listEl);
	
	    // 지도에 표시되고 있는 마커를 제거합니다
	    removeMarker();
	    
	    for ( var i=0; i<places.length; i++ ) {
	
	        // 마커를 생성하고 지도에 표시합니다
	        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
	            marker = addMarker(placePosition, i), 
	            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
	
	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        bounds.extend(placePosition);
	
	        // 마커와 검색결과 항목에 mouseover 했을때
	        // 해당 장소에 인포윈도우에 장소명을 표시합니다
	        // mouseout 했을 때는 인포윈도우를 닫습니다
	        (function(marker, title) {
	            kakao.maps.event.addListener(marker, 'mouseover', function() {
	                displayInfowindow(marker, title);
	            });
	
	            kakao.maps.event.addListener(marker, 'mouseout', function() {
	                infowindow.close();
	            });
	
	            itemEl.onmouseover =  function () {
	                displayInfowindow(marker, title);
	            };
	
	            itemEl.onmouseout =  function () {
	                infowindow.close();
	            };
	        })(marker, places[i].place_name);
	
	        fragment.appendChild(itemEl);
	    }
	
	    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
	    listEl.appendChild(fragment);
	    menuEl.scrollTop = 0;
	
	    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	    map.setBounds(bounds);
	}
	
	// 검색결과 항목을 Element로 반환하는 함수입니다
	function getListItem(index, places) {
	
	    var el = document.createElement('li'),
	    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
	                '<div class="info">' +
	                '   <h5>' + places.place_name + '</h5>';
	
	    if (places.road_address_name) {
	        itemStr += '    <span>' + places.road_address_name + '</span>' +
	                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
	    } else {
	        itemStr += '    <span>' +  places.address_name  + '</span>'; 
	    }
	                 
	      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
	                '</div>';           
	
	    el.innerHTML = itemStr;
	    el.className = 'item';
	
	    return el;
	}
	
	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	function addMarker(position, idx, title) {
	    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
	        imgOptions =  {
	            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
	            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	        },
	        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	            marker = new kakao.maps.Marker({
	            position: position, // 마커의 위치
	            image: markerImage 
	        });
	
	    marker.setMap(map); // 지도 위에 마커를 표출합니다
	    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
	
	    return marker;
	}
	
	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
	    for ( var i = 0; i < markers.length; i++ ) {
	        markers[i].setMap(null);
	    }   
	    markers = [];
	}
	
	// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
	function displayPagination(pagination) {
	    var paginationEl = document.getElementById('pagination'),
	        fragment = document.createDocumentFragment(),
	        i; 
	
	    // 기존에 추가된 페이지번호를 삭제합니다
	    while (paginationEl.hasChildNodes()) {
	        paginationEl.removeChild (paginationEl.lastChild);
	    }
	
	    for (i=1; i<=pagination.last; i++) {
	        var el = document.createElement('a');
	        el.href = "#";
	        el.innerHTML = i;
	
	        if (i===pagination.current) {
	            el.className = 'on';
	        } else {
	            el.onclick = (function(i) {
	                return function() {
	                    pagination.gotoPage(i);
	                }
	            })(i);
	        }
	
	        fragment.appendChild(el);
	    }
	    paginationEl.appendChild(fragment);
	}
	
	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	// 인포윈도우에 장소명을 표시합니다
	function displayInfowindow(marker, title) {
	    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
	
	    infowindow.setContent(content);
	    infowindow.open(map, marker);
	}
	
	 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {   
	    while (el.hasChildNodes()) {
	        el.removeChild (el.lastChild);
	    }
	}
	</script>

	<!-- 카카오 API구현 JSㅇ -->


	<div class="container-fluid" id="app">
		
		<!----------- 글쓰기 버튼 ------------>
	    <div class="bg-white p-3 rounded-4">
	        <div class="row mt-1">
	            <div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">
	               <img class="rounded-circle img-fluid" src="static/image/profileDummy.png">
	            </div>
	            <div class="col-11 col-md-11 col-lg-11 d-flex align-items-center justify-content-center">
	                <button type="button" class="btn btn-white btn-outline-dark rounded-pill col-12 " data-bs-target="#modal1" data-bs-toggle="modal">${memberId}님 무슨 생각을 하고 계신가요?</button>
<!-- 	                <button type="button" class="btn btn-white btn-outline-dark rounded-pill col-12 " v-on:click="showModal">무슨 생각을 하고 계신가요?</button> -->
					
	            </div>
	            
	        </div>	        
	    </div>
	    <br><br>
	    <!----------- 글쓰기 버튼 ------------>
	    
	    
	    <!-- 지도 테스트 -->
	    <div class="modal" tabindex="-1" role="dialog" id="modalt"
        					data-bs-backdrop="static">
        	<div class="modal-dialog" role="document">
        		<div class="modal-content">
        			
        			<div class="modal-body row">
        				<div class="col-1">
        				</div>
        				 <div class="map_wrap">
					          <div id="map" style="width:30%;height:30%;position:relative;overflow:visible;"></div>
					
					          <div id="menu_wrap" class="bg_white">
					              <div class="option">
					                  <div>
					                      <!-- <form onsubmit="searchPlaces(); return false;"> -->
					                          키워드 : <input type="text" id="keyword" size="15"> 
					                          <button type="click" onclick="searchPlaces();">검색하기</button> 
					                      <!-- </form> -->
					                  </div>
					              </div>
					              <hr>
					              <ul id="placesList"></ul>
					              <div id="pagination"></div>
					          </div>
					      </div>
        				
        				<div class="col-1">
        				</div>
        			</div>
        			
        		</div>
        	</div>
        	
        </div>
	    <button type="button" class="btn btn-white btn-outline-dark rounded-pill col-12 " data-bs-target="#modalt" data-bs-toggle="modal">지도 테스트 모달</button>
	    <!----------------------------------- 네개의 모달창 구성------------------------------------------------->
		<!-- 1. 카테고리 선택 -->
        <div class="modal" tabindex="-1" role="dialog" id="modal1"
                            data-bs-backdrop="static"> <!-- static이면 모달창 외부 클릭해도 안꺼짐 -->
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                
                	<!-- header -->
                    <div class="modal-header">
                        <h5 class="modal-title">글 카테고리 설정</h5>
                    </div>
                    
                    <!-- body -->
                    <div class="modal-body">
                        <!-- 태그 버튼 선택 -->
                        <p class="text-center">무엇에 대한 글인가요?(카테고리 설정)</p>
                        <div class="row justify-content-center"> 
                        	<button type="button" class="col-3 btn btn-primary modal2"
	                        	data-bs-target="#modal2" data-bs-toggle="modal">
	                        	자유
	                        </button>
	                        &nbsp;&nbsp;
	                        <button type="button" class="col-3 btn btn-primary modal2"
	                        	data-bs-target="#modal1-1" data-bs-toggle="modal">
	                        	행사일정
	                        </button>
                     	    &nbsp;&nbsp;
	                        <button type="button" class="col-3 btn btn-primary modal2"
	                        	data-bs-target="#modal1-2" data-bs-toggle="modal">
	                        	같이가요
	                        </button>
                        </div>
                    </div>
                   
                    <!-- footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary"
                                data-bs-dismiss="modal">닫기</button>
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
                        <h5 class="modal-title">행사일정 기간</h5>
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
                        <button type="button" class="btn btn-primary"
	                        	data-bs-target="#modal2" data-bs-toggle="modal">
	                        	다음
	                    </button>
                        <button type="button" class="btn btn-secondary"
                                data-bs-dismiss="modal">닫기</button>
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
                        <h5 class="modal-title">같이가요 기간</h5>
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
                        <button type="button" class="btn btn-primary"
	                        	data-bs-target="#modal2" data-bs-toggle="modal">
	                        	다음
	                    </button>
                        <button type="button" class="btn btn-secondary"
                                data-bs-dismiss="modal">닫기</button>
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
                        <h5 class="modal-title">태그 연결</h5>
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
                       	<button type="button" class="btn btn-primary"
                            data-bs-target="#modal3" data-bs-toggle="modal">
                        	글작성하기
                        </button>
                        <button type="button" class="btn btn-secondary"
                                data-bs-dismiss="modal">닫기</button>
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
                        <h5 class="modal-title">글 작성</h5>
                    </div>
                    
                    <!-- body -->
                    <div class="modal-body">
                        <textarea class="col-12 post" style="height: 200px;" placeholder="글 작성란"></textarea>
                        <div id="preview" contenteditable="true"></div>
                        
                    </div>
                    
                    <!-- footer -->
                    <div class="modal-footer">
                    	<input type="file" id="fileInput" multiple>
                    	<button type="button" class="btn btn-primary write-finish"
                                data-bs-dismiss="modal">작성완료</button>
                    
                        <button type="button" class="btn btn-secondary"
                                data-bs-dismiss="modal">닫기</button>
                    </div>
                    
                </div>      
            </div>
         </div>
	    
	    
	    
	    
	    
	    <!--------------- 게시물들 반복구간 ------------->
	    <div v-for="(post, index) in posts" :key="index">
	    
	    		<!-- 글 박스 루프 1개-->
                <div class="bg-white p-2 rounded-4">
                
                	<!-- 프로필 사진과 아이디 -->
                	<div class="row mt-1">
			            <div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">
			               <img class="rounded-circle img-fluid" src="static/image/profileDummy.png">
			            </div>
<!-- 			            	<p>{{ post.postNo }}</p> -->
			            <div class="col-11 col-md-11 col-lg-11 d-flex align-items-center justify-content-start">
							<p>{{ post.memberId }}</p>            
			            </div>
	       			</div>	
					<!-- 프로필 사진과 아이디 -->
					
					
					
					<!-- 태그와 글 태그들 -->
	                <div class="row">
	                	<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">			            
			            </div>
			            <div class="col-10 col-md-10 col-lg-10 d-flex align-items-center justify-content-start">
							<div class="row bg-info rounded-pill align-items-center justify-content-center">
								<p >{{ post.postType }}</p>
							</div>
<!-- 							<div v-if="post.postNo !== null"> -->
<!-- 							{{this.getTags(post.postNo)}} -->
<!-- 				                <div v-for="(tag, tagidx) in tags[index]" :key="tagidx"> -->
<!-- 				                    <div class="row bg-info rounded-pill align-items-center justify-content-center"> -->
<!-- 				                        <p>{{ tag }}</p> -->
<!-- 				                    </div> -->
<!-- 				                </div> -->
<!-- 				             </div> -->
				             					       
			            </div>
						<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center"> 
			            </div>	                
	                </div>
	                <!-- 태그와 글 태그들 -->
	                
	                
	                
	                <!-- 글 내용 -->
	                <div class="row">
	                	<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">
			               
			            </div>
			            <div class="col-10 col-md-10 col-lg-10 d-flex align-items-center justify-content-start">
							<!-- 	                <p>{{ post.postTime }}</p> -->
	                	<p>{{ post.postContent }}</p>
	                		  
			            </div>
						<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center"> 
			            </div>                
	                </div>
	                <!-- 글 내용 -->
	                

                </div>
                <!-- 글 박스 루프 1개-->
                
                <br><br>
       	 </div>
       	 <!--------------- 게시물들 반복구간 ------------->
       	 
      
	</div>

    
    <script>
        Vue.createApp({
            data(){
                return {
                	posts: [],
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
            	getTags(postNo) {
            	    for (const post of this.posts) {
            	        try {
            	            const response = axios.get(`http://localhost:8080/rest/post/tag/`+postNo);
//             	            this tags = response.data;            	            
            	        } catch (error) {
            	            console.error(error);
            	        }
            	    }
            	},
            	
            },
            mounted(){
            	
            	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                mapOption = {
                    center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
                    level: 3 // 지도의 확대 레벨
                };  
            	
	            // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	            // 지도를 생성합니다    
				var map = new kakao.maps.Map(mapContainer, mapOption); 

                
                this.fetchPosts();
//                 this.getTags();
                // 
                
            },
        }).mount("#app");
    </script>


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=047888df39ba653ff171c5d03dc23d6a"></script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>