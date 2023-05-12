<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container">
    <div class="row">
        <aside class="col">
            <h1>어사이드</h1>
        </aside>
        <article class="col">
            <div class="row">
                <div class="col">
                    <h1>파일 업로드</h1>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <form action="upload3" method="post" enctype="multipart/form-data">
                        <input type="file" name="attach">
                        <br><br>
                        <button>업로드</button>
                    </form>
                </div>
            </div>            
        </article>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	
	