<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .back-gray {
        background-color: gray;
    }
</style>
<div class="container" style="height: 800px;">
    <div class="row">
        <aside class="col-3 back-gray">
        </aside>
        <article class="col-6">
            <h1>통합게시물 예제</h1>
            <a href="/post/insert">글쓰기</a>
            <a href="/post/selectList">목록조회</a>
            <a href="/post/rest">비동기</a>
            <br><br>
            <hr>

            <h2>비동기 생성</h2>
            <textarea class="input-input"></textarea>
            <button class="input-btn">비동기 생성</button>
            <br><br>

            <h2>비동기 목록조회</h2>
            <button class="list-btn">비동기 목록</button>
            <div class="list-target">

            </div>
            <br><br>
            
            <h2>비동기 상세조회</h2>
            <input class="detail-postNo">
            <button class="detail-btn">비동기 상세</button>
            <div class="detail-target">

            </div>
            <br><br>

            <h2>비동기 수정</h2>
            <button class="input-btn">비동기 수정</button>
            <textarea class="update-input"></textarea>
            <br><br>

            <h2>비동기 삭제</h2>
            <input class="delete-postNo">
            <button class="delete-btn">비동기 삭제</button>
            <br><br>
        </article>
        <div class="col-3 back-gray">
        </div>
    </div>
</div>

<script>
    $(function(){
        // 비동기 생성
        $(".input-btn").click(function(){
            const data = {"postContent": $(".input-input").val()};

            $.ajax({
                url: "${contextPath}/rest/post/",
                method: "post",
                data: data,
                success: function(){
                    $(".input-input").val("");
                    console.log("비동기 생성 성공");
                },
                error: function(){
                    console.log("비동기 생성 실패")
                }
            })
        })
        // 비동기 목록조회
        $(".list-btn").click(function(){

            $.ajax({
                url: "${contextPath}/rest/post/",
                method: "get",
                success: function(response){
                    console.log(response);
                    // $(".list-target").append()
                },
                error: function(){
                    console.log("비동기 생성 실패")
                }
            })
        })

        // 비동기 상세조회
        $(".detail-btn").click(function(){
            const postNo = $(".detail-postNo").val();
            $.ajax({
                url: "${contextPath}/rest/post/" + postNo,
                method: "get",
                success: function(response){
                    console.log(response);
                    // $(".list-target").append()
                },
                error: function(){
                    console.log("비동기 생성 실패")
                }
            })
        })
        // 비동기 수정
        // 비동기 삭제
    })
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	
	