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
		.table th {
			background-color: #f8f7fc;
			padding-left: 12px;
		}
		.table td {
			padding-left: 12px;
		}	   

	
	</style>
	
	
<div id="app">
  <div class="custom-container">
    <h3 class="font-bold mt-5 mb-3" style="padding-left: 0.5em">결제 상세 정보</h3>
      
      <div style="padding-left:0.5em; padding-right:0.5em;">
      
      <div class="custom-hr-big" style="background-color: #7f7f7f;"></div>
      
      
      
      <table class="table">
        <tr class="col-12">
          <th class="col-3">주문번호</th>
			<td>{{ response.partner_order_id }}</td>
        </tr>
        <tr>
          <th>구분</th>
          	<td>{{ paymentDto.paymentName }}</td>
        </tr>
        <tr>
          <th>주문금액</th>
			<td>{{ formatCurrency(response.amount.total) }}스타</td>
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
     
      
	<div class="d-flex justify-content-end mb-5">
		<a :href="'history'">
	      <button class="custom-btn-sm btn-purple1">
			결제 내역
	      </button>
      	</a>
	
      <!-- 결제 취소 버튼: 잔여 금액이 존재하고 7일 이내인 경우에만 표시 -->
      <template v-if="paymentDto.paymentRemain > 0 && !isCancellationDisabled">
        <a :href="'cancel?paymentNo=' + paymentDto.paymentNo">
          <button class="custom-btn-sm btn-danger" style="margin-left:0.5em">
            결제 취소
          </button>
        </a>
      </template>
      <!-- 7일 경과 후 충전 취소 안내 문구 -->
      <template v-if="isCancellationDisabled && paymentDto.paymentRemain > 0">
        <p class="font-bold start" style="color: red; font-size: 15px;">
          결제 7일 경과 후 충전 취소가 불가합니다.
        </p>
      </template>
      </div>

 
    </div>
     </div>
    
  </div>





<script>
Vue.createApp({
    data() {
      return {
        paymentDto: {},
        paymentNo: '',
        response: {},
      }
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
    	formatCurrency(value) {
	        return value.toLocaleString();
	      },
      async loadPaymentDetail() {
        try {
          const url = "/rest/point/" + this.paymentNo;
          //console.log(url);
          const response = await axios.get(url);
          this.paymentDto = response.data;
          
          const paymentTid = this.paymentDto.paymentTid;

          const url2 = "/rest/point/order/" + "?paymentTid=" +paymentTid;
          const response2 = await axios.get(url2);
          this.response = response2.data;
        
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



		<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> 
