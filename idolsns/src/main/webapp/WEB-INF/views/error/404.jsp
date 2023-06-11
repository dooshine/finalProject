<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
  	
  	<div>
		<img src="${pageContext.request.contextPath}/static/image/404.png">
		<%-- <h3>${requestScope['javax.servlet.error.exception_type'].contains("NoHandlerFoundException")}</h3> --%>
	</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>