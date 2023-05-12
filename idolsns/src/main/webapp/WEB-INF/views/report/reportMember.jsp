<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
// c태그 라이브러리
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container">
    <div class="row">
        <article class="col">
            <h1>아티클</h1>
            <c:forEach var="memberDto" items="${list}">
                <a ></a>${memberDto}
                <br>
                <hr>
            </c:forEach>
        </article>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	
	