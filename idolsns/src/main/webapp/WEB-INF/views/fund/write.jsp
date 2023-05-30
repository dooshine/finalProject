<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!--summernote cdn-->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<script type="text/javascript">
    $(function(){
        $('[name=postContent]').summernote({
            placeholder: '내용을 입력해주세요',
            tabsize: 4,
            height: 600,
            toolbar: [
                ['style', ['style']],
                ['font', ['bold', 'underline', 'clear']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['table', ['table']],
                ['insert', ['link', 'picture']]
            ],
            callbacks: {
				onImageUpload: function(files) {
					if(files.length != 1) return;
					
					const fd = new FormData();
					fd.append("attach", files[0]);
					
					$.ajax({
						url:"/rest/attachment/upload",
						method:"post",
						data:fd,
						processData:false,
						contentType:false,
						success:function(response){
							const input = $("<input>").attr("type", "hidden")
														.attr("name", "attachmentNo")
														.val(response.attachmentNo);
							$("form").prepend(input);

							var imgNode = $("<img>").attr("src", "http://localhost:8080/rest/attachment/download/"+response.attachmentNo);
							$("[name=postContent]").summernote('insertNode', imgNode.get(0));
						},
						error:function(){}
					});
					
				}
			}
        });
        
    });
</script>


   <style>
   	     @media screen and (max-width:992px) {
		  	.col-6 {
		    width: 100%; 
		  }
    	}

		   	section {
			  font-family: "Noto Sans KR", sans-serif;
			}
			 
			.title {
	   			font-weight:bold;
		   	}
	
	</style>


	<div id="d-flex justify-content-center">
	  <div class="container rounded p-3" style="background-color:white">
	    <h3 class="title mt-5 mb-5" style="padding-left: 0.5em">펀딩 게시글 작성</h3>
	    <div style="padding-left:1em; padding-right:1em;">


	<form action="write3" method="post" enctype="multipart/form-data"> <!--  -->

	<div class="input-group mb-3">
	    <span class="input-group-text" id="inputGroup-sizing-default">제목</span>
	  <input type="text" name="fundTitle" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default">
	</div>
	
	<div class="input-group mb-3">
	    <span class="input-group-text" id="inputGroup-sizing-default">한줄 소개</span>
	  <input type="text" name="fundShortTitle" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default">
	</div>
	
	<div class="input-group mb-3">
	    <span class="input-group-text" id="inputGroup-sizing-default">시작일</span>
	  <input type="date" name="postStart" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default">
	</div>
	
	<div class="input-group mb-3">
	    <span class="input-group-text" id="inputGroup-sizing-default">종료일</span>
	  <input type="date" name="postEnd" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default">
	</div>
	
	<div class="input-group mb-3">
	    <span class="input-group-text" id="inputGroup-sizing-default">목표 금액</span>
	  <input type="text" name="fundGoal" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default">
	</div>
	
	
	<div class="input-group mb-3">
	  <textarea name="postContent" class="form-control" aria-label="With textarea"></textarea>
	</div>
	

<!-- 		이미지(여러 개) : <input type="file" name="attaches" multiple> -->

	<div class="input-group mb-3">
	  <div class="input-group-prepend">
	    <span class="input-group-text">대표 이미지(1개)</span>
	  </div>
	  <div class="custom-file">
	    <input type="file" name="attach" class="custom-file-input" id="inputGroupFile01">

	  </div>
	</div>




		<button class="btn btn-primary mb-5" type="submit">글쓰기</button>
	</form>
</div>
	</div>
	  </div>

	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
