<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  


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

			
	   <h3 class="title mt-5 mb-3" style="padding-left: 0.5em">결제 상세 정보</h3>

		<div style="padding-left:0.5em; padding-right:0.5em;">

		<table class="table" >
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
				<th>결제 수단</th>
				<td>카카오페이</td>
			</tr>

			
			<tr>
				<th>결제 상태</th>
				<td>${paymentDto.paymentStatus}</td>
			</tr>
				
			
		
		</table>
		</div>
			  ${response.status} 
			<div class="d-flex justify-content-end">
			<!--  결제 취소 버튼 : 잔여 금액이 존재한다면 -->
			<c:if test="${paymentDto.paymentRemain > 0}">
			
				<a href = "cancel?paymentNo=${paymentDto.paymentNo}" style="padding-left: 0.5em">
				 <button class="btn btn-sm btn-danger ">
				 결제 취소
				 </button>
				 </a>
			</c:if>
		
			</div>
		
	
	</div>
	
</div>
		<%-- 
		
		카드 정보는 카드 결제일 때만 나옴
		<c:if test = "${response.payment_method_type == 'CARD'}"></c:if>
		<c:if test = "${response.selected_card_info != null}">
			<h3>카드사 정보 : ${response.selected_card_info.card_corp_name}</h3>
			<h3>카드 BIN 코드 : ${response.selected_card_info.card_bin}</h3>
			<h3>할부 개월 수 : ${response.selected_card_info.install_month}</h3>
			<h3>무이자할부 여부 : ${response.selected_card_info.interest_free_install}</h3>
		</c:if>
		
		
		<hr>
		<h2>결제 순서 및 상세 내역</h2>
		<c:forEach var="paymentAction" items="${response.payment_action_details}">
			<h3>요청번호 : ${paymentAction.aid}</h3>
			<h3>거래시각 : ${paymentAction.approved_at}</h3>
			<h3>총액 : ${paymentAction.amount}원</h3>
			<h3>포인트 : ${paymentAction.point_amount}원</h3>
			<h3>유형 : ${paymentAction.payment_action_type}</h3>	
		</c:forEach>
		
		--%>
		
		<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> 
