<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 

    <title>내 지갑</title>



	<div id="app">
	  <div class="container rounded p-3" style="background-color:white">
	    	<div style="padding-left:0.5em; padding-right:0.5em;">
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