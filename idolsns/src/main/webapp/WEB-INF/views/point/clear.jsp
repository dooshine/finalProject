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
    			<h2 class="title" style="text-align: center;">${paymentDto.memberId}님의 충전이 완료되었습니다.</h2>
    		</div>
    	
    		<div>
    			<h4 class="title">결제정보</h4>
    		</div>
    		
    		
    		
    		
    		<hr style="background-color: black; height: 2px">
    		
    	
			<table class="table">
				<tr>
					<th>주문번호</th>
					<td>${response.partner_order_id}</td>
				</tr>
				
				<tr>
					<th>구분</th>
					<td>${paymentDto.paymentName}</td>
				</tr>
				
				<tr>
					<th>주문금액</th>
					<td> 
						${response.amount.total}원
					</td>
				</tr>
				
				<tr>
					<th>결제일</th>
					<td>${paymentDto.paymentTime}</td>
				</tr>
				
				
				<tr>
					<th>결제 상태</th>
					<td>${paymentDto.paymentStatus}</td>
				</tr>
				
				
			</table>
		</div>
	  </div>
	</div>

	

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> 