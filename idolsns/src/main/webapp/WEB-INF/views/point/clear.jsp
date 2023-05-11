<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 

    <title>내 지갑</title>


    <script>
    	const contextPath = "${pageContext.request.contextPath}";
    </script>



<section>
	
	<div id="app">
      	<div class= "container-fluid d-flex justify-content-center">
  
        	
        		 <div class="container rounded p-3 col-6" style="background-color:white">
        		 
		       
							{{memberId}}님의 포인트 충전이 완료되었습니다.


				</div>
			</div>
		  </div>

	
	
	</section>