<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
    
    
<div style="height:800px; background-image: url('${pageContext.request.contextPath}/static/image/sorry.png'); background-size: cover; background-position: center; 
display: flex; flex-direction: column; justify-content: center; align-items: center;">
	<div>
		<a href="${pageContext.request.contextPath}/">
		<button class="custom-btn btn-round btn-purple1" style="font-size:25px; margin-top: 350px;">메인으로 돌아가기</button>
		</a>
	</div>
</div>


	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>