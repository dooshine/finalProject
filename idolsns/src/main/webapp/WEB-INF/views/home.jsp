<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>



<!------- 카카오 지도 관련-------->
<!-- 카카오 api 키 등록 -->
<script
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=047888df39ba653ff171c5d03dc23d6a&libraries=services"></script>
<!-- 맵 관련 css -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/css/map.css">
<!------- 카카오 지도 관련-------->

<!-- tabler 아이콘 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">

<!-- swiper cdn -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css" />
<script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>


<style>
/*@media screen and (max-width:992px) {
		  	.col-6 {
		    width: 100%; 
		  }
    	}*/

/*   이미지 스와이핑 창 스타일 */
.swiper {
	width: 600px;
	height: 600px;
}

.grey {
	color: grey;
}

.grey-e0e0e0 {
	background-color: #E0E0E0;
}

.grey-f5f5f5 {
	background-color: #f5f5f5;
}

.fs-7 {
	font-size: 10px;
}

.fs-18px {
	font-size: 18px;
}

.fs-17px {
	font-size: 17px;
}

.fs-16px {
	font-size: 16px;
}

.fs-15px {
	font-size: 15px;
} 

.fs-14px {
	font-size: 14px;
}

.fs-13px {
	font-size: 13px;
}

.fs-12px {
	font-size: 12px;
}

.fs-11px {
	font-size: 11px;
}

.fs-10px {
	font-size: 10px;
}
.fs-9px {
	font-size: 9px;
}
.fs-8px {
	font-size: 8px;
}
.fs-7px {
	font-size: 7px;
}
.fs-6px {
	font-size: 6px;
}
.h-20 {
	height: 20px;
}

.reply-text {
	font-size: 14px;
}

.post-modal {
	z-index: 9999;
	position: absolute;
}

.post-modal-content {
	box-shadow: 0px 3px 4px rgba(3, 21, 17, 0.1);
	background-color: white;
	padding: 24px;
	border-radius: 0.5rem;
	border-width: 1px;
	/* 		  border-color: black; /* 테두리 색상 지정 */
	border-style: solid;
}
</style>





<!-- 	<div class="container-fluid" id="app" test> -->
<div class="container-fluid" id="app">
<!-- 	<button class="custom-btn btn-purple1-secondary" @click="changeCustom">커스텀모달</button> -->
<!-- 	<div v-if="customOn" class="custom-modal" id="deleteAlertModal"> -->
<!-- 		<div class="custom-modal-body"> -->
<!-- 			<div class="text-center mb-3"> -->
<!-- 				<i class="ti ti-alert-triangle"></i> -->
<!-- 			</div> -->
<!-- 			<div class="text-center">삭제한 일정은 복구할 수 -->
<!-- 				없습니다.zzzzzzzzzzzzzzzzzzzzzzzzzzz</div> -->
<!-- 			<div class="text-center">일정을 정말 삭제하시겠습니까?</div> -->
<!-- 			<div class="d-flex justify-content-center mt-4"> -->
<!-- 				<button -->
<!-- 					class="custom-btn btn-round btn-purple1-secondary me-2 w-100" -->
<!-- 					id="delete-schedule">삭제</button> -->
<!-- 				<button class="custom-btn btn-round btn-purple1 w-100" -->
<!-- 					@click="changeCustom" id="delete-cancel">취소</button> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
	<!----------- 글쓰기 버튼 ------------>
	<div class="bg-white mb-4 p-4 rounded-4" v-if="memberId!=null">
		<div class="row mt-1">
			<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center p-0">
					<!-- 세션이 프로필 사진이 있는 경우 -->  
					<img v-if="sessionMemberAttachmentNo && sessionMemberAttachmentNo != null"
						class="rounded-circle img-fluid" style="max-width: 100%; min-width: 100%; aspect-ratio: 1/1;"
						:src="getAttachmentUrl(sessionMemberAttachmentNo)">
					
					<!-- 세션이 프로필 사진이 없는 경우 -->
					<img v-else class="rounded-circle img-fluid" style="max-width: 100%; min-width: 100%; aspect-ratio: 1/1;"
						src="static/image/profileDummy.png">
			</div>
			<div
				class="col-11 col-md-11 col-lg-11 d-flex align-items-center justify-content-center">
				<button type="button"
					class="custom-btn btn-round btn-purple1-secondary me-2 w-100"
					data-bs-target="#modal1" data-bs-toggle="modal">${memberId}님
					무슨 생각을 하고 계신가요?</button>
			</div>

		</div>
	</div>
	<!----------- 글쓰기 버튼 ------------>

	<!-- 지도 테스트 모달 버튼 (클릭 시 지도 relayout함수 호출 -> 안하면 지도 이미지 깨짐)-->
<!-- 		    <button type="button" onclick="relayout();" class="btn btn-white btn-outline-dark rounded-pill col-12 " data-bs-target="#modalmap" data-bs-toggle="modal">지도 테스트 모달</button> -->

	<!----------------------------------- 단계별 모달창 구성------------------------------------------------->
	<!-- 1. 카테고리 선택 -->
	<div class="modal" tabindex="-1" role="dialog" id="modal1"
		data-bs-backdrop="static">
		<!-- static이면 모달창 외부 클릭해도 안꺼짐 -->
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<!-- header -->
				<div class="modal-header">
					<h5 class="modal-title">
						<i class="fa-solid fa-xmark fa-lg grey" data-bs-dismiss="modal"></i>
					</h5>
				</div>

				<!-- body -->
				<div class="modal-body">
					<!-- 태그 버튼 선택 -->

					<p class="text-center">무엇에 대한 글인가요?(카테고리 설정)</p>
					<div class="row justify-content-center">
						<button type="button"
							class="col-3 custom-btn btn-round btn-purple1 btn-sm modal2 rounded-pill"
							data-bs-target="#modalfixed" @click="setPostType('자유')" data-bs-toggle="modal">자유</button>
						&nbsp;&nbsp;
						<button type="button"
							class="col-3 custom-btn btn-round btn-purple1 btn-sm modal2 rounded-pill"
							data-bs-target="#modal1-1" @click="setPostType('행사일정')" data-bs-toggle="modal">행사일정</button>
						&nbsp;&nbsp;
						<button type="button"
							class="col-3 custom-btn btn-round btn-purple1 btn-sm modal2 rounded-pill"
							data-bs-target="#modal1-2" @click="setPostType('같이가요')" data-bs-toggle="modal">같이가요</button>
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
		data-bs-backdrop="static">
		<!-- static이면 모달창 외부 클릭해도 안꺼짐 -->
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<!-- header -->
				<div class="modal-header">
					<h5 class="modal-title">
						<i class="fa-solid fa-xmark fa-lg grey" data-bs-dismiss="modal"></i>
					</h5>
				</div>

				<!-- body -->
				<div class="modal-body">
					<!-- 태그 버튼 선택 -->
					<p class="text-center">행사일정의 시작, 종료 날짜 및 시간을 선택하세요</p>
					<div class="row justify-content-center">
						<div class="col-1"></div>
						<h6 class="col-5 text-center">시작 날짜 및 시간</h6>
						<input type="datetime-local" id="schedule-start" class="col-5">
						<div class="col-1"></div>
					</div>
					<br>
					<div class="row justify-content-center">
						<div class="col-1"></div>
						<h6 class="col-5 text-center">종료 날짜 및 시간</h6>
						<input type="datetime-local" id="schedule-end" class="col-5">
						<div class="col-1"></div>
					</div>
				</div>

				<!-- footer -->
				<div class="modal-footer">
					<button type="button"
						class="custom-btn btn-round btn-purple1 btn-sm"
						data-bs-target="#modalfixed" data-bs-toggle="modal">다음</button>
					<!--                         <button type="button" class="btn btn-secondary btn-sm" -->
					<!--                                 data-bs-dismiss="modal">닫기</button> -->
				</div>

			</div>
		</div>
	</div>

	<!-- 1-2. 같이가요 기간 -->
	<div class="modal" tabindex="-1" role="dialog" id="modal1-2"
		data-bs-backdrop="static">
		<!-- static이면 모달창 외부 클릭해도 안꺼짐 -->
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<!-- header -->
				<div class="modal-header">
					<h5 class="modal-title">
						<i class="fa-solid fa-xmark fa-lg grey" data-bs-dismiss="modal"></i>
					</h5>
				</div>

				<!-- body -->
				<div class="modal-body">
					<!-- 태그 버튼 선택 -->
					<p class="text-center">같이가요의 시작, 종료 날짜 및 시간을 선택하세요</p>
					<div class="row justify-content-center">
						<div class="col-1"></div>
						<h6 class="col-5 text-center">시작 날짜</h6>
						<input type="datetime-local" id="together-start" class="col-5">
						<div class="col-1"></div>
					</div>
					<br>
					<div class="row justify-content-center">
						<div class="col-1"></div>
						<h6 class="col-5 text-center">종료 날짜</h6>
						<input type="datetime-local" id="together-end" class="col-5">
						<div class="col-1"></div>
					</div>
				</div>

				<!-- footer -->
				<div class="modal-footer">
					<button type="button"
						class="custom-btn btn-round btn-purple1 btn-sm"
						data-bs-target="#modalfixed" data-bs-toggle="modal">다음</button>
					<!--                         <button type="button" class="btn btn-secondary btn-sm" -->
					<!--                                 data-bs-dismiss="modal">닫기</button> -->
				</div>

			</div>
		</div>
	</div>

	<!-- 2-0.  고정 태그 창 -->
	<div class="modal" tabindex="-1" role="dialog" id="modalfixed"
		data-bs-backdrop="static">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<!-- header -->
				<div class="modal-header">
					<h5 class="modal-title">
						<i class="fa-solid fa-xmark fa-lg grey" data-bs-dismiss="modal"></i>
					</h5>
				</div>

				<!-- body -->
				<div class="modal-body">
					<p class="text-center">글에 적용할 고정 태그를 입력해주세요</p>
					<div class="row text-center">
						<div class="col-2"></div>
						<input type="text" class="col-8" placeholder="태그를 입력하세요"
							@input="findFixedTagName = $event.target.value"
							v-model="findFixedTagName">
						<div class="col-2"></div>
						<!--                         	<div class="col-1"></div> -->
						<!--                         	<button class="col-2 tag-btn">입력</button> -->
					</div>
					<div class="row">
						<div class="mb-1" v-for="(findFixedTag, i) in findFixedTagList"
							:key="i">
							<button
								class="custom-btn btn-purple1-secondary btn-sm rounded-pill mx-2"
								@click="addNewFixedTag(findFixedTag)">{{ findFixedTag
								}}</button>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col">
							<button
								class="custom-btn btn-purple1 btn-sm rounded-pill mx-2 my-2 fixed-tag"
								v-for="(newFixedTag, i) in newFixedTagList">{{
								newFixedTag }}</button>
						</div>
					</div>

					<div class="row">
						<h6 class="all-tag text font-purple1"></h6>
					</div>
				</div>

				<!-- footer -->
				<div class="modal-footer">
					<button type="button"
						class="custom-btn btn-round btn-purple1 btn-sm fixed-tag-end"
						data-bs-target="#modal2" data-bs-toggle="modal">자유태그 작성하기
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
					<h5 class="modal-title">
						<i class="fa-solid fa-xmark fa-lg grey" data-bs-dismiss="modal"></i>
					</h5>
				</div>

				<!-- body -->
				<div class="modal-body">
					<p class="text-center">글에 적용할 자유 태그를 입력해주세요</p>
					<div class="row text-center">
						<div class="col-1"></div>
						<input type="text" class="tag-input col-7" placeholder="태그를 입력하세요">
						<div class="col-1"></div>
						<button
							class="col-2 custom-btn btn-round btn-purple1 btn-sm tag-btn">입력</button>
					</div>
					<div class="row">
						<h6 class="all-tag text font-purple1 my-2"></h6>
					</div>
				</div>

				<!-- footer -->
				<div class="modal-footer">
					<button type="button"
						class="custom-btn btn-round btn-purple1 btn-sm"
						data-bs-target="#modal3" data-bs-toggle="modal">글작성하기</button>
					<!--                         <button type="button" class="btn btn-secondary btn-sm" -->
					<!--                                 data-bs-dismiss="modal">닫기</button> -->
				</div>

			</div>
		</div>
	</div>

	<!-- 3. 글 및 파일 업로드 창 (두 번째 창에서 다음 버튼이 클릭 되었을 때, 비동기로 현존하는 아이돌 태그들을 가져옴)-->
	<div class="modal" tabindex="-1" role="dialog" id="modal3"
		data-bs-backdrop="static">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<!-- header -->
				<div class="modal-header">
					<h5 class="modal-title">
						<i class="fa-solid fa-xmark fa-lg grey" data-bs-dismiss="modal"></i>
					</h5>
				</div>

				<!-- body -->
				<div class="modal-body">
					<!-- 지도 구간 -->
					<div class="row" v-if="address!=''">
						<div class="text-secondary text-start fs-15px">
							<i class="ms-2 fa-solid fa-location-dot"></i>&nbsp;{{placeName}} ({{address}})	
						</div>
					</div>
					<!--         -->
					<div class="row">
						<div class="col">
							<button
								class="custom-btn btn-purple1 btn-sm rounded-pill mx-2 my-2 fixed-tag">
								{{postType}}</button>
							<button
								class="custom-btn btn-purple1 btn-sm rounded-pill mx-2 my-2 fixed-tag"
								v-for="(newFixedTag, i) in newFixedTagList">{{
								newFixedTag }}</button>
						</div>
					</div>
					<textarea class="col-12 mt-2 post border border-secondary rounded-2"
						style="height: 200px;" placeholder=" 글 작성란"></textarea>
					
					
					<div class="row">	
						<h6 class="all-tag text font-purple1 my-2"></h6>
					</div>
					
					
					<!-- 사진 보여주는 구간 -->
					<div id="preview" contenteditable="true"></div>
					<!-- 사진 보여주는 구간 -->
					
				</div>

				<!-- footer -->
				<div class="modal-footer">
					<div class="col-5 col-md-5 col-lg-5 text-start">
<!-- 						<label class="fakeBtn d-flex align-items-center justify-content-center me-2"> -->
<!-- 				            		<i class="ti ti-photo-up"></i> -->
<!-- 				            		d-none -->
<!-- 				            		<input class="form-control picInput d-none" type="file" accept=".png, .jpg, .gif" @change="sendPic" /> -->
<!-- 				        </label> -->

						<input type="file" class="fs-6" id="fileInput" multiple>
					</div>
					<div class="col-6 col-md-6 col-lg-6 text-end fs-4">
						<button type="button"
							class="custom-btn btn-round btn-purple1 btn-sm write-finish mx-2"
							data-bs-dismiss="modal">작성완료</button>
						<button type="button"
							class="custom-btn btn-round btn-purple1 btn-sm"
							data-bs-target="#modalmap" onclick="relayout();"
							data-bs-toggle="modal">지도정보삽입</button>
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
					<h6>지역을 검색하고 선택하세요 ex) 이레빌딩 or 선유동2로</h6>
				</div>

				<div class="modal-body row">
					<div class="col-1"></div>
					<div class="map_wrap col-10">
						<div id="map"
							style="width: 100%; height: 100%; position: relative; overflow: visible; align-content: center;"></div>

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

					<div class="col-1"></div>
				</div>
				<br>
				<!-- footer -->
				<div class="modal-footer justify-content-end">
					<div class="col-7 col-md-7 col-lg-7">
						<div class="row text-start">
							<span class="placeName fs-15px"></span>
						</div>
						<div class="row text-start">
							<span class="address fs-15px"></span>
						</div>
					</div>


					<div class="col-4 col-md-4 col-lg-4 ">
						<div class="row text-end">
							<div class="col-7">
								<button type="button"
									class="custom-btn btn-round btn-purple1 btn-sm bttest"
									data-bs-target="#modal3" @click="setMapPlace()" data-bs-toggle="modal">글쓰기</button>
							</div>

							<div class="col-5">
								<button type="button"
									class=" custom-btn btn-round btn-purple1-secondary btn-sm"
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
					<div class="col-1"></div>
					<div class="map_wrap col-10 ">
						<div id="mapShow"
							style="width: 100%; height: 100%; position: relative; overflow: visible; align-content: center;"></div>
					</div>
					<div class="col-1"></div>
				</div>

				<!-- footer -->
				<div class="modal-footer">
					<div class="col-6 col-6-md col-6-lg text-start">
						<div class="row">
							<h6> {{showMapName}} </h6>
						</div>
						<div class="row">
							<h6> {{showMapPlace}} </h6>
						</div>
					</div>
					<div class="col-5 text-end">
						<button type="button" class="btn btn-secondary btn-sm"
							data-bs-dismiss="modal">닫기</button>
					</div>
				</div>

			</div>
		</div>
	</div>


	<!-- 게시물 삭제 확인 모달  -->
	<div class="modal" tabindex="-1" role="dialog" id="deleteConfirm"
		data-bs-backdrop="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<!-- header -->
				<div class="modal-header">
					<!--                         <h5 class="modal-title">해당 게시글을 삭제하시겠습니까?</h5> -->
				</div>

				<!-- body -->
				<div class="modal-body my-3">
					<div class="row">
						<div class="text-center">
							<h6>해당 게시글을 삭제 하시겠습니까?</h6>
						</div>
					</div>
					<br>
					<div class="row ">
						<div class="text-center ">
							<button
								class="custom-btn btn-round btn-purple1 btn-sm col-3 mx-3"
								data-bs-target="#deleteEnd" data-bs-toggle="modal"
								@click="deletePost(get)">네</button>
							<button
								class=" custom-btn btn-round btn-purple1-secondary btn-sm col-3"
								data-bs-dismiss="modal">아니오</button>
						</div>
					</div>
				</div>

				<!-- footer -->
				<div class="modal-footer"></div>

			</div>
		</div>
	</div>

	<!-- 게시물 삭제 종료 모달 -->
	<div class="modal" tabindex="-1" role="dialog" id="deleteEnd"
		data-bs-backdrop="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<!-- header -->
				<div class="modal-header">
					<!--                         <h5 class="modal-title">해당 게시글을 삭제하시겠습니까?</h5> -->
				</div>

				<!-- body -->
				<div class="modal-body my-3">
					<div class="row">
						<div class="text-center">
							<h6>게시물이 삭제 되었습니다.</h6>
						</div>
					</div>
					<br>
					<div class="row ">
						<div class="text-center ">
							<button
								class="custom-btn btn-round btn-purple1 btn-sm col-3 mx-3"
								data-bs-dismiss="modal">확인</button>
						</div>
					</div>
				</div>

				<!-- footer -->
				<div class="modal-footer"></div>

			</div>
		</div>
	</div>

	<!-- 게시글 수정 모달 -->
	<div class="modal" tabindex="-1" role="dialog" id="updatePost"
		data-bs-backdrop="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<!-- header -->
				<div class="modal-header text-center">
					<h5 class="modal-title">글을 수정하세요</h5>
				</div>

				<!-- body -->
				<div class="modal-body my-3">
					<div class="row">
						<div class="text-center">
							<textarea class="col-12 post border border-secondary rounded-2"
								style="height: 200px;" v-if="updatePost != null"
								v-model="updatePost.postContent"></textarea>
						</div>
					</div>
					<br>
					<div class="row ">
						<div class="text-center ">
							<button
								class="custom-btn btn-round btn-purple1 btn-sm col-3 mx-3"
								data-bs-toggle="modal" data-bs-target="#editEnd"
								@click="updatePostFunc(updatePost.postContent)">확인</button>
						</div>
					</div>
				</div>

				<!-- footer -->
				<div class="modal-footer"></div>

			</div>
		</div>
	</div>

	<!-- 게시물 수정 종료 모달 -->
	<div class="modal" tabindex="-1" role="dialog" id="editEnd"
		data-bs-backdrop="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<!-- header -->
				<div class="modal-header">
					<!--                         <h5 class="modal-title">해당 게시글을 삭제하시겠습니까?</h5> -->
				</div>

				<!-- body -->
				<div class="modal-body my-3">
					<div class="row">
						<div class="text-center">
							<h6>게시물이 수정 되었습니다.</h6>
						</div>
					</div>
					<br>
					<div class="row ">
						<div class="text-center ">
							<button
								class="custom-btn btn-round btn-purple1 btn-sm col-3 mx-3"
								data-bs-dismiss="modal" @click="confirmUpdate">확인</button>
						</div>
					</div>
				</div>

				<!-- footer -->
				<div class="modal-footer"></div>

			</div>
		</div>
	</div>
	
	<!-- 유저 신고 모달 -->
	<div class="modal" tabindex="-1" role="dialog" id="reportMember"
		data-bs-backdrop="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<!-- header -->
				<div class="modal-header">
					
				</div>

				<!-- body -->
				<div class="modal-body my-3">
					<div class="row">
						<div class="text-center mb-2">
							<h6>신고 사유를 선택하세요</h6>
						</div>
						<div class="text-center mb-1">
							<button class="custom-btn btn-round btn-purple1-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#reportConfirm" @click="setReportReason('부적절한 컨텐츠 게시')">부적절한 컨텐츠 게시</button>
						</div>
						<div class="text-center mb-1">
							<button class="custom-btn btn-round btn-purple1-secondary btn-sm " data-bs-toggle="modal" data-bs-target="#reportConfirm" @click="setReportReason('선정/폭력성')">선정/폭력성</button>
						</div>
						<div class="text-center mb-1">						
							<button class="custom-btn btn-round btn-purple1-secondary btn-sm " data-bs-toggle="modal" data-bs-target="#reportConfirm" @click="setReportReason('스팸/광고')">스팸/광고</button>
						</div>
						<div class="text-center mb-1">
							<button class="custom-btn btn-round btn-purple1-secondary btn-sm " data-bs-toggle="modal" data-bs-target="#reportConfirm" @click="setReportReason('거짓 또는 사기')">거짓 또는 사기</button>
						</div>
						<div class="text-center mb-1">
							<button class="custom-btn btn-round btn-purple1-secondary btn-sm " data-bs-toggle="modal" data-bs-target="#reportConfirm" @click="setReportReason('테스트리폿사유')">테스트리폿사유</button>
						</div>
					</div>
					<br>
					<div class="row ">
						
					</div>
				</div>

				<!-- footer -->
				<div class="modal-footer"></div>

			</div>
		</div>
	</div>
	
	<!-- 유저 신고 확인 목달  -->
	<div class="modal" tabindex="-1" role="dialog" id="reportConfirm"
		data-bs-backdrop="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<!-- header -->
				<div class="modal-header">
					
				</div>

				<!-- body -->
				<div class="modal-body my-3">
					<div class="row">
						<div class="text-center mb-5">
							<h6>신고 사유가 맞습니까?</h6>
						</div>
						<div class="text-center mb-5">
							<h4 class="font-purple1" >{{reportReason}}</h4>
						</div>
						<div class="text-center mb-2">
							<button class="mx-2 custom-btn btn-round btn-purple1 btn-sm" data-bs-toggle="modal" data-bs-target="#reportEnd" @click="reportMember()">네</button>
							<button class="mx-2 custom-btn btn-round btn-purple1-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#reportMember">아니오</button>
						</div>
					</div>
				</div>

				<!-- footer -->
				<div class="modal-footer"></div>

			</div>
		</div>
	</div>
	
	<!-- 유저 신고 확인 목달  -->
	<div class="modal" tabindex="-1" role="dialog" id="reportEnd"
		data-bs-backdrop="static">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<!-- header -->
				<div class="modal-header">
					
				</div>

				<!-- body -->
				<div class="modal-body my-3">
					<div class="row">
						<div class="text-center mb-5">
							<h5>{{reportMemberId}}유저에 대한 신고가 접수 되었습니다.</h5>
						</div>
						<div class="row  mb-5">
							<div class="text-end col-5">
								<h5>사유 : </h5>
							</div>
							<div class="text-start col-7">
								<h5 class="font-purple1" >{{reportReason}}</h5>
							</div>
						</div>
						<div class="text-center mb-2">
							<button class="mx-2 custom-btn btn-round btn-purple1" data-bs-dismiss="modal" @click="fetchPosts()" >네</button>							
						</div>
					</div>
				</div>

				<!-- footer -->
				<div class="modal-footer"></div>

			</div>
		</div>
	</div>
	
	
<!-- 	<button type="button" onclick="relayout();" class="btn btn-white btn-outline-dark rounded-pill col-12 " data-bs-target="#modalmap" data-bs-toggle="modal">지도 테스트 모달</button> -->
	<!--------------- 게시물들 반복구간 ------------->
	<div v-for="(post, index) in posts" :key="index">

		<!-- 글 박스 루프 1개-->
		<div class="mb-2 custom-container">
			<!-- 프로필 사진과 아이디 -->
			<div class="row mt-1">			
				<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">
					<!-- 프로필 사진이 있는 경우 -->
					<img v-if="post.attachmentNo && post.attachmentNo != null"
						class="rounded-circle img-fluid" style="max-width: 100%; aspect-ratio: 1/1;"
						:src="getAttachmentUrl(post.attachmentNo)">
					
					<!-- 프로필 사진이 없는 경우 -->
					<img v-else class="rounded-circle img-fluid" style="max-width: 100%; aspect-ratio: 1/1;"
						src="static/image/profileDummy.png">
				</div>
				<div class="col-5 col-md-5 col-lg-5 align-middle justify-content-center">

					<div class="row">
						<h4>{{ post.memberNick}}</h4>
					</div>
					<div class="row">
						<p class="text-secondary">@{{post.memberId}}
							{{getTimeDifference(post.postTime) }}</p>

					</div>
				</div>
				<div
					class="col-5 col-md-5 col-lg-5 align-items-center justify-content-end">
					<!-- 								{{memberFollowObj.followMemberList}} -->
					<!-- 								memberId와 post.memebrId가 다른데 팔로우목록이 있는 경우에,																 -->
					<div
						v-if="memberFollowObj.followMemberList && memberId != post.memberId && memberFollowObj.followMemberList.includes(post.memberId)"
						class="row text-end">
						<div class="col-9"></div>
						<button
							class="col-3 custom-btn btn-purple1-secondary btn-sm rounded-3"
							@click="deleteFollowMember(post.memberId)">팔로우 취소</button>
					</div>

					<!-- 								memberId와 post.memeberId가 다른데 팔로우 목록에 없는 경우에  -->
					<div
						v-else-if="memberFollowObj.followMemberList && memberId != post.memberId && !(memberFollowObj.followMemberList.includes(post.memberId))"
						@click="createFollowMember(post.memberId)" class="row text-end">
						<div class="col-10"></div>
						<button class="col-2 custom-btn btn-purple1 btn-sm rounded-3">팔로우</button>
					</div>

					<!-- 								memberId와 post.memberId가 같으면 -->
					<div v-else class="row"></div>
				</div>
				<div
					class="col-1 col-md-1 col-lg-1 d-flex align-items-start justify-content-end">
					<i class="fs-3 text-secondary ti ti-dots-vertical"
						@click="setPostModalIndex(index)" data-toggle="dropdown"></i>
					<!-- 			               <i class="ti ti-x" @click="deletePost(post.postNo)"></i> -->
					<div v-if="index === getPostModalIndex()" class="post-modal">
						<div class="mt-3 mr-4"></div>
						<div class="post-modal-content">
							<div v-if="post.memberId === memberId">
								<div class="row">
									<div class="text-start col-1 mb-2">
										<i class="ti ti-x" @click="hidePostModal"></i>
									</div>
								</div>
								<div class="row">
									<div class="col-1"></div>
									<div class="col-11 ms-2">
										<h6 data-bs-target="#deleteConfirm" data-bs-toggle="modal"
											@click="setDeletePostNo(post.postNo)">게시물 삭제</h6>
									</div>
								</div>
								<div class="row">
									<div class="col-1"></div>
									<div class="col-11 ms-2">
										<div class="custom-hr my-2 me-4"></div>
										<h6 data-bs-target="#updatePost" data-bs-toggle="modal"
											@click="setUpdatePost(post)">게시물 글 내용 수정</h6>
									</div>
								</div>



							</div>
							<div v-else>
								<div class="row">
									<div class="text-start col-1 mb-2">
										<i class="ti ti-x" @click="hidePostModal"></i>
									</div>
								</div>
								<div class="row"></div>
								<div class="row">
									<div class="col-1"></div>
									<div class="col-11 ms-2">
										<div class="custom-hr my-2 me-4"></div>
										<h6 data-bs-toggle="modal" data-bs-target="#reportMember" @click="reportModal(post.memberId)">유저 신고 하기</h6>
									</div>
								</div>
								<div class="row">
									<div class="col-1"></div>
									<div class="col-11 ms-2">
										<div class="custom-hr my-2 me-4"></div>
										<h6>게시물 신고 하기</h6>
									</div>
								</div>

							</div>
						</div>
					</div>


				</div>

			</div>
			<!-- 프로필 사진과 아이디 -->

			<!-- 고정 태그와 글 타입들 -->
			<div class="row mb-3 ">
				<div
					class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">
				</div>
				<div
					class="col-10 col-md-10 col-lg-10 d-flex align-items-center justify-content-start">
					<button
						class="mx-1 px-2 h-20 custom-btn btn-round btn-purple1 rounded-4 align-items-center justify-content-center fs-7 text-light">
						{{ post.postType }}</button>

					<a :href="searchUrl">
						<button v-for="fixedTag in post.fixedTagList" :key="fixedTag"
							@click="searchFixedTag(fixedTag)"
							class="mx-1 px-2 h-20 custom-btn btn-round btn-purple1 align-items-center justify-content-center fs-7 text-light">
							{{ fixedTag }}</button>
					</a>

				</div>
				<div
					class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">
				</div>
			</div>
			<!-- 고정 태그와 글 타입들 -->

			<!-- 지도 맵이 있는 경우에만 지도 정보 표기 -->
			<div class="row my-2"
				v-if="post.mapPlace !== '' && post.mapPlace !== null && post.mapPlace !== undefined">
				<div
					class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">
				</div>
				<div
					class="col-10 col-md-10 col-lg-10 d-flex align-items-center justify-content-start fs-6 text-secondary "
					@click="showMap(post.mapName,post.mapPlace)" data-bs-target="#showMap"
					data-bs-toggle="modal">
					<i class="fa-solid fa-location-dot"></i>&nbsp;{{post.mapName}} ({{
					post.mapPlace}})
				</div>
				<div
					class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">
				</div>
			</div>
			<!-- 지도 맵이 있는 경우에만 지도 정보 표기 -->


			<!-- 글 내용 -->
			<div class="row my-2">
				<div
					class="col-1 col-md-1 col-lg-1 align-items-center justify-content-center">

				</div>

				<!-- 하얀색 글박스증 co1-10인 가운데 부분 -->
				<div class="col-10 col-md-10 col-lg-10 align-items-center">


					<!-- 글 -->
					<div class="row">
						<p>{{ post.postContent }}</p>
						<div class="d-flex">
							<p v-for="freeTag in post.freeTagList" :key="freeTag"
								class="fs-6 font-purple1">\#{{ freeTag }} &nbsp;</p>
						</div>
					</div>


					<!-- 이미지 표시 -->
					<div class="row">
						<div v-if="post.attachmentList && post.attachmentList.length > 0"
							class="d-flex">
							<!-- 단일 이미지인 경우 -->
							<div v-if="post.attachmentList.length == 1"
								class="row text-center">
								<div
									v-for="(attachmentNo, attachmentIndex) in post.attachmentList"
									:key="attachmentIndex" class="col-6">
									<img :src="getAttachmentUrl(attachmentNo)"
										@click="setModalImageUrl(attachmentNo)" class="img-fluid"
										style="max-width: 100%; aspect-ratio: 1/1;" alt="Attachment"
										data-bs-target="#image-modal" data-bs-toggle="modal">
								</div>
							</div>
							<!-- 두 개 이상의 이미지인 경우 -->
							<div v-else-if="post.attachmentList.length > 1"
								class="row text-center">
								<div
									v-for="(attachmentNo, attachmentIndex) in post.attachmentList"
									:key="attachmentIndex" class="col-6">
									<img :src="getAttachmentUrl(attachmentNo)"
										@click="setModalImageUrl(attachmentNo)" class="img-fluid mb-3"
										style="max-width: 100%; aspect-ratio: 1/1;" alt="Attachment"
										data-bs-target="#image-modal" data-bs-toggle="modal">
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



							<div
								v-for="(attachmentNo, attachmentIndex) in post.attachmentList"
								:key="attachmentIndex">
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
						<div v-else></div>
					</div>


					<!-- 구분선 -->
					<div class="row">
						<hr style="width: 100%;">
					</div>

					<!-- 좋아요, 댓글, 공유하기 -->
					<div class="row">

						<!-- 좋아요 -->
						<div class="col-4 text-start font-purple1">
							<div class="row" v-if="postLikeIndexList.includes(index)">
								<div class="col-2">
									<i class="fs-4 ti ti-heart-filled"
										@click="checkLike(post.postNo,index)"></i>
								</div>
								<div class="col-4 ">
									<h6 class="postlikeCount">{{post.likeCount}}</h6>
								</div>
							</div>
							<div class="row" v-else>
								<div class="col-2">
									<i class="fs-4 ti ti-heart"
										@click="checkLike(post.postNo,index)"></i>
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
						<div class="col-4 text-end text-secondary">
							<i class="fs-4 ti ti-share"></i>
						</div>
						<!-- 공유하기 버튼 -->

					</div>

					<!-- 구분선 -->
					<div class="row">
						<hr class="mt-2" style="width: 100%;">
					</div>





					<!-- 댓글, 대댓글 보여주는 창-->
					<div v-if="post.replyList.length && post.replyList.length >= 1">

						<!-- 댓글이 다섯개 이하인 경우 -->
						<div v-if="5 >= post.replyList.length ">
							<div v-for="(reply,replyIdx) in post.replyList" :key="replyIdx">
								<!-- 댓글 표시 -->
								<div class="row" v-if="reply.replyNo == reply.replyGroupNo">

									<!-- 댓글 프로필 이미지 -->북마크1
									<div class="col-1 ">
										<div class="row mt-2 text-center">
											<!-- 프로필 사진이 있는 경우 -->
											<img v-if="reply.attachmentNo && reply.attachmentNo != null"
												class="rounded-circle img-fluid" style="max-width: 100%; aspect-ratio: 1/1;"
												:src="getAttachmentUrl(reply.attachmentNo)">
											
											<!-- 프로필 사진이 없는 경우 -->
											<img v-else class="rounded-circle img-fluid" style="max-width: 100%; aspect-ratio: 1/1;"
												src="static/image/profileDummy.png">
										</div>
									</div>

									<!-- 댓글 상자 -->
									<div class="col-11 align-items-center">
										<div class="mt-1"></div>
										<div class="mx-2"></div>

										<!-- 댓글 아이디가 내용보다 길면 -->
										<div
											v-if="reply.replyContent.length &lt; reply.replyId.length"
											style="max-width: 100%"
											class="row grey-f5f5f5 rounded-3 text-left"
											:style="{ width: (reply.replyId.length * 12 + 30) + 'px' }">
											<div class="row mt-2"></div>
											<h6 class="mr-1 fw-bold">{{reply.memberNick}}</h6>
											<h6 class="mr-1 lh-lg">{{reply.replyContent}}</h6>
											<div class="row mb-1"></div>
										</div>

										<!-- 댓글 내용이 아이디보다 길면 -->
										<div v-else class="row grey-f5f5f5 rounded-3 text-left"
											style="max-width: 100%"
											:style="{width: (reply.replyContent.length * 11 +30) + 'px' }">
											<div class="row mt-2"></div>
											<h6 class="mr-1 fw-bold">{{reply.memberNick}}</h6>
											<h6 class="mr-1 lh-lg">{{reply.replyContent}}</h6>
											<div class="row mb-1"></div>
										</div>

										<!-- 댓글창 아이콘 -->
										<div class="row d-flex flex-nowrap text-start">
											<!-- 				                				<h6 class="col-1 text-start reply-text" style="white-space: nowrap;">좋아요 </h6> -->
											<h6 class="col-1 mt-1  reply-text text-secondary"
												style="white-space: nowrap">{{getTimeDifference(reply.replyTime)}}</h6>
											<h6 class="col-1 mt-1  reply-text text-secondary"
												@click="showRereplyInput(post.postNo,reply.replyNo),hideReplyInput()"
												style="white-space: nowrap; cursor: pointer;">댓글 달기</h6>
											<!-- 댓글 삭제  -->
											<h6 v-if="reply.replyId === memberId"
												class="col-l mt-1 text-start reply-text text-danger"
												style="cursor: pointer;" @click="deleteReply(reply.replyNo)">댓글
												삭제</h6>
										</div>
										<div class="mb-1"></div>
									</div>
									<!-- 댓글 상자 -->
								</div>
								<!-- 댓글 표시 -->

								<!-- 대댓글 표시 -->
								<div
									v-for="(rereply,rereplyIdx) in post.replyList.slice(replyIdx+1)"
									:key='rereplyIdx'>
									<!-- 대댓글이 들어갈 조건 -->
									<div v-if="reply.replyNo === rereply.replyGroupNo">
										<!-- 특정 댓글의 그룹번호가 특정 댓글번호와 일치할 때(대댓글인경우) -->
										<!-- 대댓글 들 -->
										<div class="row ">
											<div class="col-1"></div>
											<div class="col-1">
												<div class="row my-2 text-center">
													<!-- 대댓글 프로필 사진이 있는 경우 -->
													<img v-if="rereply.attachmentNo && rereply.attachmentNo != null"
														class="rounded-circle img-fluid" style="max-width: 100%; aspect-ratio: 1/1;"
														:src="getAttachmentUrl(rereply.attachmentNo)">
													
													<!-- 대댓글 프로필 사진이 없는 경우 -->
													<img v-else class="rounded-circle img-fluid" style="max-width: 100%; aspect-ratio: 1/1;"
														src="static/image/profileDummy.png">
												</div>
											</div>
											<div class="col-10">
												<div class="mt-1"></div>
												<div class="mx-2"></div>
												<!-- 대댓글 아이디가 내용보다 길면 -->
												<div
													v-if="rereply.replyContent && rereply.replyId && rereply.replyContent.length &lt; rereply.replyId.length"
													style="max-width: 100%"
													class="row grey-f5f5f5 rounded-3 text-left"
													:style="{ width: (rereply.replyId.length * 12 +30) + 'px' }">
													<div class="row mt-2"></div>
													<h6 class="mr-1 fw-bold">{{rereply.memberNick}}</h6>
													<h6 class="mr-1 lh-lg">{{rereply.replyContent}}</h6>
													<div class="row mb-1"></div>
												</div>
												<!-- 대댓글 내용이 아이디보다 길면 -->
												<div v-else class="row grey-f5f5f5 rounded-3 text-left"
													style="max-width: 100%"
													:style="{ width: (rereply.replyContent.length * 11 +30) + 'px' }">
													<div class="row mt-2"></div>
													<h6 class="mr-1 fw-bold">{{rereply.memberNick}}</h6>
													<h6 class="mr-1 lh-lg">{{rereply.replyContent}}</h6>
													<div class="row mb-1"></div>
												</div>

												<!-- 대댓글창 아이콘 -->
												<div class="row d-flex flex-nowrap">
													<h6 class="col-1 mt-1 text-start reply-text text-secondary">{{getTimeDifference(rereply.replyTime)}}</h6>
													<h6 class="col-1 mt-1 text-start reply-text text-secondary"
														@click="showRereplyInput(post.postNo,reply.replyNo),hideReplyInput()"
														style="white-space: nowrap; cursor: pointer;">댓글 달기</h6>
													<!-- 대댓글 삭제  -->
													<h6 v-if="rereply.replyId == memberId"
														class="col-l mt-1 text-start reply-text text-danger"
														style="cursor: pointer;"
														@click="deleteRereply(rereply.replyNo)">댓글 삭제</h6>
												</div>
												<div class="mb-1"></div>

											</div>

										</div>
									</div>
								</div>
								<!-- 대댓글 표시 -->


								<!-- 대댓글 작성 창 -->
								<div
									v-if=" post.postNo === tempPostNo && reply.replyNo === tempReplyNo">
									<div class="row">
										<div class="col-1"></div>
										<div class="col-1">
											<!-- 대댓글 작성 시, 프로필 사진이 있는 경우 -->  
											<img v-if="sessionMemberAttachmentNo && sessionMemberAttachmentNo != null"
												class="rounded-circle img-fluid" style="max-width: 100%; aspect-ratio: 1/1;"
												:src="getAttachmentUrl(sessionMemberAttachmentNo)">
											
											<!-- 프로필 사진이 없는 경우 -->
											<img v-else class="rounded-circle img-fluid" style="max-width: 100%; aspect-ratio: 1/1;"
												src="static/image/profileDummy.png">
										</div>
										<div class="col-10 mt-1">

											<div class="pt-2 ps-2 pe-2 w-100 rounded-4 grey-f5f5f5">

												<div class="mt-1"></div>
												<textarea placeholder=" 댓글을 입력하세요."
													class="grey-f5f5f5 border-0 "
													style="min-width: 100%; height: 3em; outline: none; overflow: hidden;"
													v-model="rereplyContent"></textarea>
												<div class="d-flex">
													<div class="col text-start">
														<i class="ti ti-x fx-12px font-purple1"
															@click="hideRereplyInput()"></i>
													</div>
													<div class="col text-end">
														<i
															class="fs-5 font-purple1 ti ti-arrow-badge-right-filled"
															@click="rereplySending(post.postNo,reply.replyNo,index)"></i>
													</div>
												</div>

											</div>
										</div>
									</div>
								</div>
								<!-- 대댓글 작성 창 -->

							</div>
						</div>
						<!-- 댓글이 다섯개 이하인 경우 -->




						<!-- 댓글이 다섯 개 초과인 경우 -->
						<div v-else-if="post.replyList.length && post.replyList.length >5">
							<div v-for="(reply,replyIdx) in post.replyList" :key="replyIdx">
								<!-- 댓글이 다섯 개 초과인 경우중, 댓글이 5개 이하 이거나 글 인덱스의 전체보기 버튼이 눌렸을 때, -->
								<div v-if="4 >= replyIdx || replyAllList[index] ">

									<!-- 댓글 표시 -->
									<div class="row" v-if="reply.replyNo == reply.replyGroupNo">

										<!-- 댓글 프로필 이미지 -->
										<div class="col-1">
											<div class="row mt-2 text-center">
												<!-- 프로필 사진이 있는 경우 -->
												<img v-if="reply.attachmentNo && reply.attachmentNo != null"
													class="rounded-circle img-fluid" style="max-width: 100%; aspect-ratio: 1/1;"
													:src="getAttachmentUrl(reply.attachmentNo)">
												
												<!-- 프로필 사진이 없는 경우 -->
												<img v-else class="rounded-circle img-fluid" style="max-width: 100%; aspect-ratio: 1/1;"
													src="static/image/profileDummy.png">
											</div>
											
											
										</div>

										<!-- 댓글 상자 -->
										<div class="col-11 align-items-center">
											<div class="mt-1"></div>
											<div class="mx-2"></div>

											<!-- 댓글 아이디가 내용보다 길면 -->
											<div
												v-if="reply.replyContent.length &lt; reply.replyId.length"
												style="max-width: 100%"
												class="row grey-f5f5f5 rounded-3 text-left"
												:style="{ width: (reply.replyId.length * 12 + 30) + 'px' }">
												<div class="row mt-2"></div>
												<h6 class="mr-1 fw-bold">{{reply.memberNick}}</h6>
												<h6 class="mr-1 lh-lg">{{reply.replyContent}}</h6>
												<div class="row mb-1"></div>
											</div>

											<!-- 댓글 내용이 아이디보다 길면 -->
											<div v-else class="row grey-f5f5f5 rounded-3 text-left"
												style="max-width: 100%"
												:style="{width: (reply.replyContent.length * 11 +30) + 'px' }">
												<div class="row mt-2"></div>
												<h6 class="mr-1 fw-bold">{{reply.memberNick}}</h6>
												<h6 class="mr-1 lh-lg">{{reply.replyContent}}</h6>
												<div class="row mb-1"></div>
											</div>

											<!-- 댓글창 아이콘 -->
											<div class="row d-flex flex-nowrap">
												<!-- 				                				<h6 class="col-1 text-start reply-text" style="white-space: nowrap;">좋아요 </h6> -->
												<h6 class="col-1 mt-1 text-start reply-text text-secondary"
													style="white-space: nowrap">{{getTimeDifference(reply.replyTime)
													}}</h6>
												<h6 class="col-1 mt-1 text-start reply-text text-secondary"
													@click="showRereplyInput(post.postNo,reply.replyNo),hideReplyInput()"
													style="white-space: nowrap; cursor: pointer;">댓글 달기</h6>
												<!-- 댓글 삭제  -->
												<h6 v-if="reply.replyId === memberId"
													class="col-l mt-1 text-start reply-text text-danger"
													style="cursor: pointer;"
													@click="deleteReply(reply.replyNo)">댓글 삭제</h6>
											</div>
											<div class="mb-1"></div>
										</div>
										<!-- 댓글 상자 -->
									</div>
									<!-- 댓글 표시 -->

									<!-- 대댓글 표시 -->
									<div
										v-for="(rereply,rereplyIdx) in post.replyList.slice(replyIdx+1)"
										:key='rereplyIdx'>
										<!-- 대댓글이 들어갈 조건 -->
										<div
											v-if="(reply.replyNo === rereply.replyGroupNo) && (3 >= (replyIdx + rereplyIdx) || replyAllList[index])">
											<!-- 특정 댓글의 그룹번호가 특정 댓글번호와 일치할 때(대댓글인경우) -->
											<!-- 대댓글 들 -->
											<div class="row ">
												<div class="col-1"></div>
												<div class="col-1">
													<div class="row my-2 text-center">
														<!-- 대댓글 프로필 사진이 있는 경우 -->
														<img v-if="rereply.attachmentNo && rereply.attachmentNo != null"
															class="rounded-circle img-fluid" style="max-width: 100%; aspect-ratio: 1/1;"
															:src="getAttachmentUrl(rereply.attachmentNo)">
														
														<!-- 대댓글 프로필 사진이 없는 경우 -->
														<img v-else class="rounded-circle img-fluid" style="max-width: 100%; aspect-ratio: 1/1;"
															src="static/image/profileDummy.png">
													</div>
												</div>
												<div class="col-10">
													<div class="mt-1"></div>
													<div class="mx-2"></div>
													<!-- 대댓글 아이디가 내용보다 길면 -->
													<div
														v-if="rereply.replyContent.length &lt; rereply.replyId.length"
														style="max-width: 100%"
														class="row grey-f5f5f5 rounded-3 text-left"
														:style="{ width: (rereply.replyId.length * 12 +30) + 'px' }">
														<div class="row mt-2"></div>
														<h6 class="mr-1 fs-12px fw-bold">{{rereply.memberNick}}</h6>
														<h6 class="mr-1 fs-11px lh-lg">{{rereply.replyContent}}</h6>
														<div class="row mb-1"></div>
													</div>
													<!-- 대댓글 내용이 아이디보다 길면 -->
													<div v-else class="row grey-f5f5f5 rounded-3 text-left"
														style="max-width: 100%"
														:style="{ width: (rereply.replyContent.length * 11 +30) + 'px' }">
														<div class="row mt-2"></div>
														<h6 class="mr-1 fs-12px fw-bold">{{rereply.memberNick}}</h6>
														<h6 class="mr-1 fs-11px lh-lg">{{rereply.replyContent}}</h6>
														<div class="row mb-1"></div>
													</div>

													<!-- 대댓글창 아이콘 -->
													<div class="row d-flex flex-nowrap">
														<h6
															class="col-1 mt-1 text-start reply-text text-secondary"
															style="white-space: nowrap">{{getTimeDifference(rereply.replyTime)
															}}</h6>
														<h6
															class="col-1 mt-1 text-start reply-text text-secondary"
															@click="showRereplyInput(post.postNo,reply.replyNo),hideReplyInput()"
															style="white-space: nowrap; cursor: pointer;">댓글 달기</h6>
														<!-- 대댓글 삭제  -->
														<h6 v-if="rereply.replyId == memberId"
															class="col-l mt-1 text-start reply-text text-danger"
															style="cursor: pointer;"
															@click="deleteRereply(rereply.replyNo)">댓글 삭제</h6>
													</div>
													<div class="mb-1"></div>

												</div>

											</div>
										</div>
									</div>
									<!-- 대댓글 작성 창 -->
									<div
										v-if=" post.postNo === tempPostNo && reply.replyNo === tempReplyNo">
										<div class="row">
											<div class="col-1"></div>
											<div class="col-1">
												<!-- 대댓글 작성 시, 프로필 사진이 있는 경우 -->  
												<img v-if="sessionMemberAttachmentNo && sessionMemberAttachmentNo != null"
													class="rounded-circle img-fluid" style="max-width: 100%; aspect-ratio: 1/1;"
													:src="getAttachmentUrl(sessionMemberAttachmentNo)">
												
												<!-- 프로필 사진이 없는 경우 -->
												<img v-else class="rounded-circle img-fluid" style="max-width: 100%; aspect-ratio: 1/1;"
													src="static/image/profileDummy.png">
											</div>
											<div class="col-10 mt-1">

												<div class="pt-2 ps-2 pe-2 w-100 rounded-4 grey-f5f5f5">

													<div class="mt-1"></div>
													<textarea placeholder=" 댓글을 입력하세요."
														class="grey-f5f5f5 border-0 "
														style="min-width: 100%; height: 3em; outline: none; overflow: hidden;"
														v-model="rereplyContent"></textarea>
													<div class="d-flex">
														<div class="col text-start">
															<i class="ti ti-x fx-12px font-purple1"
																@click="hideRereplyInput()"></i>
														</div>
														<div class="col text-end">
															<i
																class="fs-5 font-purple1 ti ti-arrow-badge-right-filled"
																@click="rereplySending(post.postNo,reply.replyNo,index)"></i>
														</div>
													</div>

												</div>
											</div>
										</div>
									</div>

								</div>
								<!-- 댓글이 다섯 개 초과인 경우중, 댓글이 5개 이하 이거나 글 인덱스의 전체보기 버튼이 눌렸을 때, -->


							</div>
						</div>
						<!-- 댓글이 다섯 개 초과인 경우 -->

					</div>
					<!-- 댓글, 대댓글 보여주는 창 (댓글이 다섯 개 이하일때) -->

					<!-- 댓글 작성창  -->
					<div class="row" v-if="replyFlagList[index]">
						<div class="col-1">
							<!-- 대댓글 작성 시, 프로필 사진이 있는 경우 -->  
							<img v-if="sessionMemberAttachmentNo && sessionMemberAttachmentNo != null"
								class="rounded-circle img-fluid" style="max-width: 100%; aspect-ratio: 1/1;"
								:src="getAttachmentUrl(sessionMemberAttachmentNo)">
							
							<!-- 프로필 사진이 없는 경우 -->
							<img v-else class="rounded-circle img-fluid" style="max-width: 100%; aspect-ratio: 1/1;"
								src="static/image/profileDummy.png">
						</div>
						<div class="col-11 mt-1">
							<div class="pt-2 ps-2 pe-2 w-100 rounded-4 grey-f5f5f5">

								<div class="mt-1"></div>
								<textarea placeholder=" 댓글을 입력하세요."
									class="grey-f5f5f5 border-0 "
									style="min-width: 100%; height: 6em; outline: none; overflow: hidden;"
									v-model="replyContent"></textarea>
								<div class="d-flex">
									<div class="col text-start">
										<i class="ti ti-x fx-12px font-purple1"
											@click="hideReplyInput(index)"></i>
									</div>
									<div class="col text-end">
										<i class="fs-5 font-purple1 ti ti-arrow-badge-right-filled"
											@click="replySending(post.postNo,index)"></i>
									</div>
								</div>

							</div>
						</div>
					</div>
					<!-- 댓글 더보기 버튼 -->
					<div v-if="post.replyList.length &&  post.replyList.length >5">
						<h6 class="mt-2 fs-11px text-secondary"
							v-if="!replyAllList[index]" @click="showReplyMoreThanFive(index)">댓글
							더보기 ({{post.replyList.length -5}}개의 댓글)</h6>
						<h6 class="mt-2 fs-11px text-secondary" v-else
							@click="hideReplyMoreThanFive(index)">댓글 숨기기</h6>
					</div>
					<!-- 댓글 더보기 버튼 -->

				</div>
				<!-- 하얀색 글박스증 co1-10인 가운데 부분 -->



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
					// 처음 마운트 될때 
                	firstMountFlag : false,               
                	 
                	// 게시글 VO를 저장할 배열
                	posts: [],
                	
                	// 지도에 주소 표시하는 문자열
                	showMapName: '',
                	showMapPlace: '',
                	
                	// 좋아요 게시글 인덱스 배열
                	postLikeIndexList: [], 
                	
                	// 댓글 작성 여부 체크용 배열
                	replyFlagList: [],
                	
                	// 댓글 작성 글자 
                	replyContent: '',
                	
                	// 댓글 전체 표시 체크용 배열
                	replyAllList: [],
                	
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
                	
                	// 게시글 모달 버튼 클릭 시, 보여줄 모달 번호
                	postModalIndex: null,
                	
                	// 안전장치
                	loading:false,
                	
                	// 입력시 고정태그 불러오기
                	findFixedTagName: "",
                	findFixedTagList: [],
                	newFixedTagList: [],                	
                	
                	// 세션 맴버아이디
                	memberId:null,
                	
                	// 모달 이미지 URL
                	modalImageUrl:null,
                	modalImageUrlList:[],
                	
                	// 게시글 삭제 시 확인 용모달
                	deletePostNo: null,                	               	
                	
                	// 게시글 수정 용 post
                	updatePost: null,
                	customOn: false,
                	
                	// 검색 주소
                	searchUrl: null,
                	
                	 
                	// 로그인 맴버 팔로우 목록 조회
                	memberFollowObj: {},
                	
                	// 게시글 타입
                	postType: null,
                	
                	// 지도 타입
                	placeName: '',
                	address: '',
                	
                	// 신고 아이디, 신고 사요
                	reportMemberId: null,
                	reportReason: null,
                	
                	// 세션 맴버 첨부파일 번호
                	sessionMemberAttachmentNo: null,
                	
                };
            },
            computed:{
            
            },
            methods:{
            	changeCustom()
            	{
            		this.customOn = !this.customOn;
            	},
            	
            	
            	// 무한 페이징 게시글 불러오기 1페이지당 10개씩 매 페이지 별로 불러옴,
            	async fetchPosts(){
            		
            		// 페이지가 1페이지고(10개의 게시물만 보이고), 최초 mounted가 실행된 이후에 새로 호출 되었을 경우,
            		// 아예 페이지 새로 고침
            		if(this.page == 2 && this.firstMountFlag)
            		{
            			location.reload();	
            		}
            		
                    if(this.loading == true) return;//로딩중이면
                    if(this.finish == true) return;//다 불러왔으면
                    
                    this.loading = true;
                    
                    // 1페이지 부터 현재 페이지 까지 전부 가져옴 
                    const resp = await axios.get("http://localhost:8080/rest/post/pageReload/"+this.page);
	                this.posts = resp.data;
	                this.getLikePostIndex(this.posts);
	                this.getReplyAllList(this.posts);
	                this.page++;
	                
	                this.loading=false;
	                
	                if(resp.data.length < 10){
	                	this.finish = true;
	                }
	                this.firstMountFlag = true;
            	},
            	
            	// 무한 스크롤용 페치 
            	async fetchScroll(){
            		if(this.loading == true) return;//로딩중이면
                    if(this.finish == true) return;//다 불러왔으면
                    
                    this.loading = true;
                    
                    // 1페이지 부터 현재 페이지 까지 전부 가져옴 
                    const resp = await axios.get("http://localhost:8080/rest/post/pageReload/"+this.page);
	                this.posts = resp.data;
	                this.getLikePostIndex(this.posts);
	                this.getReplyAllList(this.posts);
	                this.page++;
	                
	                this.loading=false;
	                
	                if(resp.data.length < 10){
	                	this.finish = true;
	                }
            	},
            	
            	// 게시글 작성 시 글타입을 표현하기 위한 함수
            	setPostType(type){
            		this.postType = type;
            		console.log(this.postType);
            	},
            	
            	// 게시글 삭제 
            	async deletePost(){
            		var postNo = this.deletePostNo;
                	try{
                		await axios.delete('http://localhost:8080/rest/post/'+postNo);
                		this.fetchPosts();
                	}
                	catch (error){
                		console.error(error);
                	}
			    },
			    
			    
			    // 게시물 업데이트 (글 내용 만) 
			    async updatePostFunc(postContent){
			    	var postNo = this.updatePost.postNo;
			    				 
			    	var postDto = { 
			    			postNo : postNo,
			    			postContent : postContent
			    	};
			    	
			    	try {
			    		await axios.put('http://localhost:8080/rest/post/',postDto);
			    		
			    	}
			    	catch(error){
			    		console.error(error);
			    	}
			    	
			    },
			    confirmUpdate(){
			    	this.fetchPosts();
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
                
                 
                // 게시글, 댓글 시간 철리
                getTimeDifference(time){
                	const writeTime = new Date(time);
                	const currentTime = new Date();
                	const timeDifference = currentTime.getTime() - writeTime.getTime();
					
                	if (timeDifference < 20000) { // 20초 내                       
                        return '방금전';
                      } else if (timeDifference < 60000){ // 1분 내 
                    	const seconds = Math.floor(timeDifference / 1000);
                        return seconds+'초전';
                      }
                		else if (timeDifference < 3600000) { // 1시간 내
                        const minutes = Math.floor(timeDifference / 60000);
                        return minutes+'분전';
                      } else if (timeDifference < 86400000) { // 24시간 내
                        const hours = Math.floor(timeDifference / 3600000);
                        return hours+'시간전';
                      } else if (timeDifference < 604800000) { // 1주일 내
                        const days = Math.floor(timeDifference / 86400000);
                        return days+'일전';
                      } else { // 1주일 이상
                    	var dateOptions; 
                    	// 년도 비교  
                    	if ( writeTime.getFullYear() === currentTime.getFullYear()){ // 년도가 같으면
                    		dateOptions = {month: 'short', day: 'numeric' };
                    	} 
                    	else{
                    		dateOptions = { year: 'numeric', month: 'short', day: 'numeric' }; // 년도가 다르면 
                    	}
                        return writeTime.toLocaleDateString('ko-KO', dateOptions);
                      }
                },
                
                // 팔로우 관련 비동기 처리-----------------------------------
                // 팔로우 목록 불러오기 
                async loadMemberFollowInfo(){
        			// 로그인X → 실행 X
        			if(this.memberId===null) return;
        			// url
        			const url = "http://localhost:8080/rest/follow/memberFollowInfo/"
        			// 팔로우 목록 load
        			const resp = await axios.get(url, {params:{memberId: this.memberId}});

        			// 로그인 팔로우 정보 로드
        			this.memberFollowObj = resp.data;
        			//console.log(this.memberFollowObj);
        			this.fetchPosts();
        			
        		},
        		
                // 팔로우 생성 
        		async createFollowMember(followedMemberId){
//                     // 1. 회원 로그인 확인
                    if(this.memberId === ""){
                        if(confirm("로그인 한 회원만 사용할 수 있는 기능입니다. 로그인 하시겠습니까?")) {
                            window.location.href = contextPath + "/member/login";
                        }
                    }
                    
                    
                    // 팔로우 설정                   
                    var followDto = {
                        memberId: this.memberId,
                        followTargetType: "회원",
                        followTargetPrimaryKey: followedMemberId
                    };
                    
                    const url = "http://localhost:8080/rest/follow/";
                    await axios.post(url,followDto);
                   

                    this.loadMemberFollowInfo();
                  	this.fetchPosts();
                    
                },
                
                // 팔로우 삭제 
        		async deleteFollowMember(followedMemberId){
//                 	// 1. 회원 로그인 확인
                    if(this.memberId === ""){
                        if(confirm("로그인 한 회원만 사용할 수 있는 기능입니다. 로그인 하시겠습니까?")) {
                            window.location.href = contextPath + "/member/login";
                        }
                    }
                                        
                    // 팔로우 설정                   
                    var followDto = {
                        memberId: this.memberId,
                        followTargetType: "회원",
                        followTargetPrimaryKey: followedMemberId
                    };                    
                    
                    // 팔로우 삭제 
                    const url = "http://localhost:8080/rest/follow/";
                    await axios.delete(url, {
                        data: followDto,
                    });
                    
                    this.loadMemberFollowInfo();
                  	this.fetchPosts();
                },
                // 팔로우 관련 비동기 처리-----------------------------------
                
                // 유저 신고 관련 처리 ------------------------------------
                // 유저 신고하기 버튼 클릭, 
                reportModal(reportMemberId){
                	this.reportMemberId = reportMemberId;
                	this.hidePostModal();   
                },
                
             	// 유저 신고 사유 선택--------------------------
                setReportReason(reportReason){
                	this.reportReason = reportReason; 
                	             	
                },
                
                // 유저 신고 생성--------------------------
                async reportMember(){
                	if(this.memberId ===null && this.reportMemberId ===null){
                		return;
                	}
                	let reportDto = {
                		memberId: this.memberId,
                		reportTargetType: "회원",
                		reportTargetPrimaryKey: this.reportMemberId,
                		reportFor: this.reportReason
                	};
                	console.log(this.reportDto);
                	
                	const url = "http://localhost:8080/rest/report/";
                	try{
                		const resp = await axios.post(url, reportDto);
                	}
                	catch(error){
                		console.log(error);
                	}
                },
             	// 유저 신고 관련 처리 ------------------------------------
                
                
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
                
             	// 고정 태그 맵핑
             	searchFixedTag(data){
                	this.searchUrl = 'http://localhost:8080/search/post/?q='+data;
                },
             	
             	
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
                // 댓글 쓰기 창 띄우기 (다른 창들은 모두 닫음, 대댓글창도 닫음) 
                showReplyInput(index){
					this.replyContent = '';                 	
					if(this.replyFlagList[index]==true)
					{
						this.replyFlagList[index] = !this.replyFlagList[index];
						this.hideRereplyInput();
					}
					else{
						this.replyFlagList = this.replyFlagList.map(() => false);
						this.replyFlagList[index] = true;
						this.hideRereplyInput();
					}
                	
                	
                	
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
                
            	// 대댓글 쓰기 창 띄우기 (다른 창들은 모두 닫음)
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
                
                // 댓글 삭제
                async deleteReply(replyNo){
                	try{
                		await axios.delete('http://localhost:8080/rest/post/reply/delete/'+replyNo);
                		this.fetchPosts();
                	}
                	catch (error){
                		console.error(error);
                	}
                
                },
                // 대댓글 삭제
                async deleteRereply(replyNo){
                	try{
                		await axios.delete('http://localhost:8080/rest/post/reply/reDelete/'+replyNo);
                		this.fetchPosts();
                	}
                	catch(error){
                		console.error(error);
                	}
                },

                // 댓글 다섯 개이상 보여주는 함수 
                showReplyMoreThanFive(index){
                	this.replyAllList[index] = true;
                },
                
                hideReplyMoreThanFive(index){
                	this.replyAllList[index] = false;
                },
                
                // 맨 처음 게시글 개수 만큼 답글 전체보기 T/F 저장용 배열 만들기 
                getReplyAllList(posts){
                	this.replyAllList = new Array(posts.length).fill(false);
                },
                
                // 댓글 창 관련 클릭 함수 -------------------------------
             	
                
                
                // 게시글 모달창 --------------------------------------
                setPostModalIndex(index){
                	this.postModalIndex = index;
                },
                
                hidePostModal(){
                	this.postModalIndex = null;
                },
                
                
                getPostModalIndex(){
                	return this.postModalIndex;
                },
             	// 게시글 모달창 --------------------------------------
                
             	// 게시글 삭제 ----------------------------------
             	setDeletePostNo(postNo){
  					this.deletePostNo = postNo;
  					this.hidePostModal();
             	},
             	             	
             	
             	// 게시글 삭제 -----------------------------------
             	
             	// 게시글 수정
             	setUpdatePost(post){             		
             		this.updatePost = post;
             		this.hidePostModal();
             	},
             	// 게시글 수정----
             	
             	setMapPlace(){
             		this.placeName = document.querySelector('.placeName').innerText;
             		console.log("하하"+this.placeName);
             		this.address = document.querySelector('.address').innerText;
             		console.log("호호"+this.address);
             	},             	
             	
            	// 모달창 클릭 시 지도 정보 불러오기-------------------------
            	showMap(keyword1,keyword2){
            		this.showMapName = keyword1;
            		this.showMapPlace = keyword2;
            		// 마커를 담을 배열입니다
            		var markers = [];
            		keyword2 = keyword2.replace(/\s+\d+$/, '');
					var keyword = keyword1
					console.log(keyword);
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
            		            if(i==0) break;
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
                
                // 세션 아이디의 프로필 이미지 불러오기
                async getSessionMemberAttachmentNo(){
                	if(this.memberId !=null)
                	{
                		const resp = await axios.get("http://localhost:8080/rest/post/sessionAttachmentNo/");	
                		this.sessionMemberAttachmentNo = resp.data;
                		return this.sessionMemberAttachmentNo; 
                	}
                },
            },
            watch:{
            	percent(){
            		if(this.percent >= 80){
            			this.fetchScroll();
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
            	this.fetchPosts();
            	this.setId();
            	//created()에 추가
            	this.getSessionMemberAttachmentNo();
            	this.loadMemberFollowInfo();
            	
            	
            },
        }).mount("#app");
    </script>


<!-- 이미지 스와이핑 창 -->
<script
	src="${pageContext.request.contextPath}/static/js/swiping-image.js"></script>
<!-- 게시글 작성 ajax -->
<script src="${pageContext.request.contextPath}/static/js/async-post.js"></script>
<!-- 카카오 API구현 JS -->
<script src="${pageContext.request.contextPath}/static/js/post-map.js"></script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>