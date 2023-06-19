			// 페이지 로드
			$(function(){				
				
				// 지도 위치 출력
				$(".bttest").click(function(){
					//console.log(mapPlace);
				});

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
				
				
				// 2-0. 고정 태그를 저장할 배열 선언 및 고정 태그 전역변수 fixedTag에 저정
				let fixedTag = [];				
				$(".fixed-tag-end").click(function(){
					fixedTagInputs = $(".fixed-tag1");
					var temp = "";
					fixedTagInputs.each(function(){
						temp = $(this).text();
						if(!fixedTag.includes(temp)){
							fixedTag.push(temp);	
						}						
					})
					
				});

				// 2. 태그를 저장할 배열 선언 및 태그 전역 변수 tag에 저장
				let tag = [];
				let showTag = []; 			
				// 태그 추가 버튼 클릭 시, 
				$(".tag-btn").click(function(){
					//console.log("클릭함")
					let tagInput = $(".tag-input").val();
					//console.log(tagInput);								
					if(tagInput==""||tagInput==null) // 태그 입력창에 아무것도 안적혀 있다면
					{		
						return
					}
					else{ // 태그 입력창에 적혀 있다면
						if(!tag.includes(tagInput)){ // 입력받은 태그가 중복이 아닐경우에만 
							tag.push(tagInput);	   // 없으면 indexOf가 -1을 반환
							showTag.push('#'+tagInput);
						}
						
					}
					
					$(".tag-input").val(""); // 입력창 초기화	
					let allTag = showTag.join(", "); // 배열 문자열로 변환
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
						memberId: memberId,
						postType: categori,
						postContent: postText		
					}
					
					
					
					//console.log(postDto+"보낸 데이터");
					// 게시글을 비동기로 서버에 등록 
					$.ajax({
						  url: contextPath + "/rest/post/",
						  method: "post",
						  data: postDto,
						  success: function(postNo) {
							
							// 게시물 등록 성공 시에, 고정 태그 정보를 비동기로 서버에 등록
						 	let fixedTagData ={
								 fixedTag: fixedTag,
								 postNo: postNo
							};
							$.ajax({
								url: contextPath + "/rest/post/fixed",
								method: "post",
								data: JSON.stringify(fixedTagData),
								contentType: "application/json; charset=utf-8",
								success: function(result) {
									//console.log(result);
								},
								  error: function(xhr, status, error) {
								    //console.log(error);
								}
							});
						 	// 게시물 등록 성공 시에, 태그 정보를 비동기로 서버에 등록  
						 	let tagData = {
						 		tag: tag,
						 		postNo: postNo
						 	};
						 	//console.log("태그등록은?");
						 	$.ajax({
								url: contextPath + "/rest/post/tag",
								method: "post",
								data: JSON.stringify(tagData),
								contentType: "application/json; charset=utf-8",
								success: function(result) {
									//console.log("태그 등록은 됌");
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
								    //console.log("태그 등록은 안됌");
								    
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
									url: contextPath + "/rest/post/postType",
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
							
							// 게시물 지도 등록
							if(mapPlace!="기본" && mapName!="기본"){
								let postDto = {
									postNo : postNo,
									mapPlace : mapPlace,
									mapName : mapName
								};
								//console.log(mapPlace);
								$.ajax({
									url: contextPath + "/rest/post/map",
									method: "post",									
									data: postDto,
									success: function(result){
										//console.log(result);
										
									},
									error: function(xhr,status,error){
										//console.log(error);
									}									
									
								});
							}
							
							// 게시물 등록 성공 시에, 파일 입력을 비동기로 서버에 전송 
							var files = $("#fileInput").get(0).files;
							for(var i =0; i < files.length;i++){
								formData.append("attach",files[i]);						
							}
							
							if(files.length>0){
								//console.log("총 "+files.length+"개의 파일이 전송되었습니다");
								$.ajax({
								      url: contextPath + "/rest/attachment/upload2?postNo="+postNo,
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
										location.reload();
								      },
								      error: function(xhr, status, error) {
								        // handle error response
								       // console.log(error);
								      }
								});
							}
							else{
								location.reload();
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
					  imageCount = 0;
					  videoCount = 0;
					  const files = this.files;
					
					  preview.empty();
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
//					    if (imageCount >= MAX_FILES && isImage(file)) {
//					      alert('이미지 파일은 최대 5개까지만 업로드 가능합니다.');
//					      continue; // 다음 파일로 건너뛰기
//					    }
//					    if (videoCount > 0 && isVideo(file) && imageCount ==0) {
//					      alert('동영상 파일은 1개만 업로드 가능합니다.');
//					      break; // 반복문 종료
//					    }						
					    if (isImage(file)) {
					      const img = $('<img>').attr('src', URL.createObjectURL(file)).attr('width', '100').attr('height', '100');
//					      const img = $('<img>').attr('src', URL.createObjectURL(file)).addClass('w-50');
					      preview.append(img);
					      imageCount++;
					    } else if (isVideo(file)) {
					      const video = $('<video>').attr('src', URL.createObjectURL(file)).attr('width', '400').attr('height', '300').attr('controls', '');
					      preview.append(video);
					      videoCount++;
					    }
					    else{
						  alert('파일은 이미지, 비디오 파일만 업로드 가능합니다.');
						  preview.empty();
						  $("#fileInput").val(null);
						  break;
							
						}
					    
					    if(i==(MAX_FILES)){
							alert('파일은 최대 5개까지만 업로드 가능합니다.');
							preview.empty();
							$("#fileInput").val(null);
							break;	
						}
					    
					  }
				});
			});