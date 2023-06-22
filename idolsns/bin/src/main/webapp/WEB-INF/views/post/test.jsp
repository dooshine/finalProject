<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> --%>
  <head>
    <!-- <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"> -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.2.3/cosmo/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <style>
    	.post{
    		border-style: none;
    	}
    </style>
  </head>
  <body>
    <div class="container-fluid mt-4" id="app">

        <div class="row">
            <div class="offset-md-2 col-md-8">
            
                <div class="row mt-4">
                    <div class="col">
                        <button type="button" class="btn btn-primary"
                            data-bs-target="#modal1" data-bs-toggle="modal">
                        	글쓰기
                        </button>
                    </div>
                </div>

            </div>
        </div>

		<script>
			// 페이지 로드
			$(function(){				
				
				// 1. 카테고리를 저장할 변수 선언 및 카테고리 전역 변수 categori에 저장
				let categori = ""; 
				$(".modal2").click(function(){
					categori = this.innerText.trim();
					//console.log(categori);					
				});				
				
				// 1-1. 행사일정의 날짜 및 시간 scheduleStart, scheduleEnd에 저장
				let scheduleStart = null;
				let scheduleEnd = null;
				$("#schedule-start").on("change",function(){
					scheduleStart = $(this).val();
				});
				$("#schedule-end").on("change",function(){
					scheduleEnd = $(this).val();
				});				
				
				// 1-2. 같이가요의 날짜 및 시간 togetherStart, togetherEnd에 저장
				let togetherStart = null;
				let togetherEnd = null; 
				$("#together-start").on("change",function(){
					togetherStart = $(this).val();
				});
				$("#together-end").on("change",function(){
					togetherEnd = $(this).val();
				});	
				
				// 2. 태그를 저장할 배열 선언 및 태그 전역 변수 tag에 저장
				let tag = [];			
				// 태그 추가 버튼 클릭 시, 
				$(".tag-btn").click(function(){
					//console.log("클릭함")
					let tagInput = $(".tag-input").val();
										
					if(tagInput==""||tagInput==null) // 태그 입력창에 아무것도 안적혀 있다면
					{		
						return
					}
					else{ // 태그 입력창에 적혀 있다면
						
						if(!tag.includes(tagInput)){ // 입력받은 태그가 중복이 아닐경우에만 
							tag.push(tagInput);	   // 없으면 indexOf가 -1을 반환
						}
						
					}
					
					$(".tag-input").val(""); // 입력창 초기화	
					let allTag = tag.join(", "); // 배열 문자열로 변환
					$(".all-tag").text(allTag); // 변환된 문자열을 출력
					
					//console.log("태그에 저장된 내용은 다음과 같습니다  : "+tag);
					});
				
				// 파일들을 저장할 객체 
				var formData = new FormData();		
				// 3. 글 작성 버튼 클릭 시, 업로드 과정-----------------------------------------------
				$(".write-finish").click(function(){
					
					
					let postText = $(".post").val();					
					// postDto에 삽입하기 위해 post로 송신할 JSON 객체생성
					let postDto = {
						memberId: "testuser1",
						postType: categori,
						postContent: postText		
					}
					
					
					//console.log(postDto)
					
					// 게시글을 비동기로 서버에 등록 
					$.ajax({
						  url: "${contextPath}/rest/post/",
						  method: "post",
						  data: postDto,
						  success: function(postNo) {		  
						 	// 게시물 등록 성공 시에, 태그 정보를 비동기로 서버에 등록  
						 	let tagData = {
						 		tag: tag,
						 		postNo: postNo
						 	}
						 	$.ajax({
								url: "${contextPath}/rest/post/tag",
								method: "post",
								data: JSON.stringify(tagData),
								contentType: "application/json; charset=utf-8",
								success: function(result) {
									// 게시글 작성 이후 변수들 초기화 
									categori ="";
									$(".tag-input").val("");
									tag=[];
									allTag="";
									$(".all-tag").text(""); 
									$(".post").val("");
								},
								  error: function(xhr, status, error) {
								    //console.log(error);
								}
							});
							// 게시물 등록 성공 시에, JSON 형태의 postData 전송
							let postTypeData = {
								postNo: postNo,
								postDto: postDto,
								togetherStart: togetherStart,
								togetherEnd: togetherEnd,
								scheduleStart: scheduleStart,
								scheduleEnd: scheduleEnd
							};
							
							//console.log("게시물 일정 체크 scheduleStart : "+scheduleStart);
							
							// 게시물 타입 등록 
							$.ajax({
									url: "${contextPath}/rest/post/postType",
									method: "post",
									contentType: "application/json",
								    data: JSON.stringify(postTypeData),
									success: function(result){
										//console.log(result)
									},
									error: function(xhr,status,error){
										//console.log(error);
									}
							});														
							
		
							
							// 게시물 등록 성공 시에, 파일 입력을 비동기로 서버에 전송 
							var files = $("#fileInput").get(0).files;
							for(var i =0; i < files.length;i++){
								formData.append("attach",files[i]);						
							}
							
							if(files.length>0){
								//console.log("총 "+files.length+"개의 파일이 전송되었습니다");
								$.ajax({
								      url: "${contextPath}/rest/attachment/upload2?postNo="+postNo,
								      type: 'POST',
								      data: formData,
								      contentType: false, // do not set content type
								      processData: false, // do not process data
								      success: function(data) {
								        //console.log(data);
										// 전송할 파일 초기화 기존에 선언했던 formData를 다시 재 선언함으로써 초기화 진행  
										formData = new FormData();
										// 미리보기에 존재하는 데이터를 모두 초기화
										$('#preview').html("");
										$("#fileInput").text("선택된 파일이 없습니다.");
										
										window.alert("글 게시가 완료되었습니다");	
								      },
								      error: function(xhr, status, error) {
								        // handle error response
								        //console.log(error);
								      }
								});
							}
				 	
						  },
						  error: function(xhr, status, error) {
							//console.log("글을 생성하지 못했오")
						    //console.log(error);
						  }
						  
						  
					});				
					
					
					
					
					
				
				});
				//-------------------------------------------------------------------------
				
				// 파일 업로드 사진은 5장 까지만, 동영상을 업로드 할 시에는 한개만..				
				let imageCount = 0; // 이미지 파일 갯수
				let videoCount = 0; // 동영상 파일 갯수
				const preview = $('#preview'); // 미리보기 파일들 
				
				// 파일이 선택될 때 마다 함수 실행
				$('#fileInput').on('change', function() {
					  const files = this.files;

					  const isImage = (file) => {
					    return file['type'].includes('image');
					  };

					  const isVideo = (file) => {
					    return file['type'].includes('video'); 
					  }

					  const MAX_FILES = 5; // 최대 파일 갯수
					  
					  //console.log("파일길이는 : "+files.length)

					  for (let i = 0; i < files.length; i++) {
					    const file = files[i];
					    if (imageCount >= MAX_FILES && isImage(file)) {
					      alert('이미지 파일은 최대 5개까지만 업로드 가능합니다.');
					      continue; // 다음 파일로 건너뛰기
					    }
					    if (videoCount > 0 && isVideo(file) && imageCount ==0) {
					      alert('동영상 파일은 1개만 업로드 가능합니다.');
					      break; // 반복문 종료
					    }
					    if (isImage(file)) {
					      const img = $('<img>').attr('src', URL.createObjectURL(file)).attr('width', '100').attr('height', '100');
					      preview.append(img);
					      imageCount++;
					    } else if (isVideo(file)) {
					      const video = $('<video>').attr('src', URL.createObjectURL(file)).attr('width', '400').attr('height', '300').attr('controls', '');
					      preview.append(video);
					      videoCount++;
					    }
					  }
				});
			});
		</script>
		
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
         
            
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
<%--  <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> --%>