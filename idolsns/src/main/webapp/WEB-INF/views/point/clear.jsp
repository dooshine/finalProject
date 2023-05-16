<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 

    <title>내 지갑</title>


    <script>
    	const contextPath = "${pageContext.request.contextPath}";
    </script>


	<section>
	  <div id="app">
	    <div class="container-fluid d-flex justify-content-center">
	      <div class="container rounded p-3 col-6" style="background-color:white">
	        <div>
	          <p>{{ memberId }}님의 충전이 완료되었습니다.</p>
	          <h2>결제 상태 : ${response.status}</h2>
	          <h2>주문 번호 : ${response.partner_order_id}</h2>
	          <h2>주문자 : ${response.partner_user_id}</h2>
	          <h2>결제 수단 : ${response.payment_method_type}</h2>
	          <h2>결제 금액 : {{ amount }}원</h2>
	          ${paymentDto.paymentTime}
	        </div>
	      </div>
	    </div>
	  </div>
	</section>
	
	<script>
		Vue.createApp({
		  // 데이터 설정 영역
		  data() {
		    return {
		      memberId: '',
		      amount: '',
		      response: null // response 변수 추가
		    }
		  },
		  mounted() {
		    // 세션에서 memberId와 amount 정보를 가져옴
		    this.memberId = sessionStorage.getItem("memberId");
		    this.amount = parseInt(sessionStorage.getItem("amount"));
		
		    // response 변수 초기화
		    this.response = {
		      status: '',
		      partner_order_id: '',
		      partner_user_id: '',
		      payment_method_type: '',
		      amount: { total: 0 }
		    };
		  }
		}).mount("#app");
		</script>