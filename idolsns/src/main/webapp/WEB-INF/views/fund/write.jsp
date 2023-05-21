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
						url:"http://localhost:8080/rest/attachment/upload",
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

<div style="width:600px">
	<h2>펀딩 게시글 작성</h2>
	<form action="write3" method="post" > <!-- enctype="multipart/form-data" -->
		제목 : <input type="text" name="fundTitle"><br><br>
		시작일 : <input type="date" name="postStart"><br><br>
		종료일 : <input type="date" name="postEnd"><br><br>
		목표 금액 : <input type="text" name="fundGoal"><br><br>
<!-- 		후원자 수 : <input type="text" name="fundSponsorCount"><br><br> -->
		내용 : <textarea name="postContent"></textarea><br><br>
<!-- 		이미지(여러 개) : <input type="file" name="attaches" multiple> -->
<!-- 		대표 이미지(1개) : <input type="file" name="attach"> -->
		<button type="submit">글쓰기</button>
	</form>
</div>
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
