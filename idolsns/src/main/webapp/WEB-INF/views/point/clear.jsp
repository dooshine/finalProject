<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 

 
	<div id="app">
	  <div class="container rounded p-3" style="background-color:white">
    	<div style="padding-left:0.5em; padding-right:0.5em;">
    		
    		<div class="mb-5">
    			${memberDto.memberId}님의 충전이 완료되었습니다.
    		</div>
    	
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