<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 
    
   
	  <div id="app">

	      <div class="container rounded p-3" style="background-color:white">
	        <p>{{ memberId }}님의 충전이 취소되었습니다.</p>
	        <p>취소 후 잔여 포인트: {{ amount }}</p>
	      </div>
	    </div>

		
	
	
	
	
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> 