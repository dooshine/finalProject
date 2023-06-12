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
            <a href="/post/update?postNo=${postWithNickDto.postNo}">수정</a>
            <a href="/post/delete?postNo=${postWithNickDto.postNo}">삭제</a>
            <a href="/post/rest">비동기</a>
            <br><br>
            <hr>
            <h2>${postWithNickDto}</h2>

        </article>
        <div class="col-3 back-gray">
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	
	