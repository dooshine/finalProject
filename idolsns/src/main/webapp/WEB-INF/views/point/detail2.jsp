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
		    <h3 class="title mt-5 mb-3" style="padding-left: 0.5em">결제 상세 정보</h3>
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
		          <td>${response.amount.total}원</td>
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
		    <div class="d-flex justify-content-end">
		      <%-- 결제 취소 버튼: 잔여 금액이 존재하고 7일 이내인 경우에만 표시 --%>
		      <c:if test="${paymentDto.paymentRemain > 0}">
		        <a href="cancel?paymentNo=${paymentDto.paymentNo}" style="padding-left: 0.5em">
		          <button class="btn btn-sm btn-danger">
		            결제 취소
		          </button>
		        </a>
		      </c:if>
		      <%-- 7일 경과 후 충전 취소 안내 문구 --%>
		      <c:if test="">
		        <p class="text-muted" style="padding-left: 0.5em">
		          결제 7일 경과 후 충전 취소가 불가합니다.
		        </p>
		      </c:if>
		    </div>
		  </div>
		</div>
	


		<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> 
