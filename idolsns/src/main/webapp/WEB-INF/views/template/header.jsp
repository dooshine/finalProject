<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>홈페이지 레이아웃</title>
    <!-- 폰트어썸 cdn -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
    <!-- jquery cdn -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <!-- 뷰 cdn -->
    <script src="https://unpkg.com/vue@3.2.26"></script>
    <!-- axios -->
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <!-- lodash -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
    <!-- moment -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
    <!-- 부트스트랩 css(공식) -->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">

    <!-- custom 테스트 css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/test.css">
    
    <!-- 폰트css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/load.css" />

    <script>
    	const contextPath = "${pageContext.request.contextPath}";
        const memberId = "${memberId}";
        const memberLevel = "${memberLevel}";
    </script>
</head>



<body style="background-color: #f5f5f5;">
    <main>
        <header>
            <div class="row">
                <div class="col">
                    <img src="https://via.placeholder.com/400x100?text=final" alt="로고">
                </div>
                <div class="col">
                    <h1>파이널 프로젝트</h1>
                </div>
            </div>
            <div class="row">
            	<c:if test="${memberId == null}">
            		<a href="${pageContext.request.contextPath}/member/login">로그인</a>
            		<a href="${pageContext.request.contextPath}/member/join">회원가입</a>
            	</c:if>
            	<c:if test="${memberId != null}">
            		<a href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
            		<a href="${pageContext.request.contextPath}/member/mypage">마이페이지</a>
            	</c:if>
            </div>
        </header>
          <hr>
        
        
         <aside class="col-3 d-flex">
	         <jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>
	     </aside>

        
        
        <section>
            <article>
              
                
                
                