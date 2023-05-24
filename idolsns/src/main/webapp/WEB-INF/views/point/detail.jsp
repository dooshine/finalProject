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
		 <td>{{ response.partner_order_id }}</td> 
        </tr>
        <tr>
          <th>구분</th>
          <td>{{ paymentDto.paymentName }}</td>
        </tr>
        <tr>
          <th>주문금액</th>
          <td>{{ response.amount.total }}원</td>
        </tr>
        <tr>
          <th>결제일</th>
          <td>{{ paymentDto.paymentTime }}</td>
        </tr>
        <tr>
          <th>결제 수단</th>
          <td>카카오페이</td>
        </tr>
        <tr>
          <th>결제 상태</th>
          <td>{{ paymentDto.paymentStatus }}</td>
        </tr>
      </table>
  </div>
      <div class="d-flex justify-content-end">
      <!-- 결제 취소 버튼: 잔여 금액이 존재하고 7일 이내인 경우에만 표시 -->
      <template v-if="paymentDto.paymentRemain > 0 && !isCancellationDisabled">
        <a :href="'cancel?paymentNo=' + paymentDto.paymentNo" style="padding-left: 0.5em">
          <button class="btn btn-sm btn-danger">
            결제 취소
          </button>
        </a>
      </template>
      <template v-else>
        <!-- 7일 경과 후 충전 취소 안내 문구 -->
        <p class="text-muted" style="padding-left: 0.5em">
          결제 7일 경과 후 충전 취소가 불가합니다.
        </p>
      </template>
    </div>
  </div>
</div>

	<script>
	  Vue.createApp({
	    data() {
	      return {
	    	paymentDto: {},
	        paymentNo: '', // 결제 번호를 초기에 빈 문자열로 선언합니다.
	        response: {}
	      };
	    },
	    computed: {
	      isCancellationDisabled() {
	        if (this.paymentDto && this.paymentDto.paymentTime) {
	          const currentDate = new Date();
	          const differenceInDays = Math.floor((currentDate - new Date(this.paymentDto.paymentTime)) / (24 * 60 * 60 * 1000));
	          return differenceInDays > 7;
	        }
	        return false;
	      }
	    },
	    methods: {
	      async loadPaymentDetail() {
	        try {
	          const url = "/rest/point/" + this.paymentNo; // 결제 번호에 this.paymentNo를 사용합니다.
	          const response = await axios.get(url);
	          this.paymentDto = response.data;
	
	        } catch (error) {
	          console.error(error);
	        }
	      }
	    },
	    created() {
	    	this.paymentNo = window.location.search.split("=")[1];
	      	this.loadPaymentDetail();
	    }
	  }).mount("#app");
	</script>


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
