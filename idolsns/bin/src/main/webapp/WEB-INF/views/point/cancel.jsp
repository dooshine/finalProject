<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 

 
 <style>
   @media screen and (max-width:992px) {
		  	.col-6 {
		    width: 100%; 
		  }
    	}
		   	section {
			  font-family: "Noto Sans KR", sans-serif;
			}
			   	
		
	   
	   	.title {
	   		font-weight:bold;
	   	}
	   
	 
	   
	    
	</style>
 
   
	  	<div id="app">
		  <div class="container rounded p-3" style="background-color:white">
	    	<div style="padding-left:0.5em; padding-right:0.5em;">
	    		
	    		<div class="mt-5 mb-5">
	    			<h2 class="title" style="text-align: center;">${paymentDto.memberId}님의 충전이 취소되었습니다.</h2>
	    		</div>
	   
	   		</div>
	      </div>
	    </div>

		
	
	
	
	
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> 