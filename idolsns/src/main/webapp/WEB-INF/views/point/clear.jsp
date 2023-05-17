<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 

    <title>내 지갑</title>



	<div id="app">
	  <div class="container rounded p-3" style="background-color:white">
	    <div>
	      <p>{{ memberId }}님의 충전이 완료되었습니다.</p>
	      <h2>결제 상태: ${response.status}</h2>
	      <h2>주문 번호: ${response.partner_order_id}</h2>
	      <h2>주문자: ${response.partner_user_id}</h2>
	      <h2>결제 수단: ${response.payment_method_type}</h2>
	      <h2>결제 금액: ${response.amount.total}원</h2>
	    </div>
	  </div>
	</div>

	

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> 