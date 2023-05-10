<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펀딩 게시글 작성</title>

<!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<!--summernote cdn-->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<script>
	$(function(){
		$('[name=fundContent]').summernote({
			  placeholder: '내용을 작성하세요.',
			  tabsize: 2, // 탭키를 누르면 띄어쓰기 몇 번 할지
			  height: 120, // 최초 표시될 높이(px)
			  toolbar: [ // 메뉴 설정
				  ['style', ['style']],
		          ['font', ['bold', 'underline', 'clear']],
		          ['color', ['color']],
		          ['para', ['ul', 'ol', 'paragraph']],
		          ['table', ['table']],
		          ['insert', ['link', 'picture']],
			  ]
			});
	});
</script>
</head>
<body>
	<div style="width:600px";>
		<h2>게시글 작성</h2>
		<form action="writeProcess" method="post" enctype="multipart/form-data">
			게시물 번호: <input type="text" name="postNo"><br><br>
			아이디 : <input type="text" name="memberId"><br><br>
			제목 : <input type="text" name="fundTitle"><br><br>
			내용 : <textarea name="fundContent"></textarea>
			시작일 : <input type="date" name="postStart"><br><br>
			종료일 : <input type="date" name="postEnd"><br><br>
			목표 금액 : <input type="text" name="fundGoal"><br><br>
			후원자 수 : <input type="text" name="fundSponsorCount"><br><br>
			펀딩 상태 : <input type="text" name="fundState"><br><br>
			<button type="submit">글쓰기</button>
		</form>
	</div>
</body>
</html>