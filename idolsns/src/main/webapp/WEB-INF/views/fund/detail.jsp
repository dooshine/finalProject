<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h2>펀딩 상세페이지임</h2>
${postImageDto}<br>
${fundPostDto }<br>

<c:forEach var="postImageDto" items="${list}">
	<img src="${postImageDto.imageURL}">
</c:forEach>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>