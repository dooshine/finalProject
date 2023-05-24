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
  <div class="container rounded p-3" style="background-color: white">
    <h3 class="title mt-5 mb-3" style="padding-left: 0.5em">포인트 사용 상세 정보</h3>

    <div style="padding-left: 0.5em; padding-right: 0.5em;">
      <table class="table">
        <tr>
          <th>구분</th>
          <td>{{ fundDto.fundTitle }}</td>
        </tr>
        <tr>
          <th>사용금액</th>
          <td>{{ fundDto.fundPrice }}원</td>
        </tr>
        <tr>
          <th>사용일</th>
          <td>{{ fundDto.fundTime }}</td>
        </tr>
      </table>

      <div class="d-flex justify-content-end">
		  <!-- 결제 취소 버튼: 잔여 금액이 존재한다면 -->
		  <template v-if="fundDto.fundPrice > 0">
		    <a :href="'cancelOrder?fundNo=' + fundDto.fundNo" style="padding-left: 0.5em">
		      <button class="btn btn-sm btn-danger" :disabled="isCancellationDisabled">
		        후원 취소
		      </button>
		    </a>
		    <p v-if="isCancellationDisabled" style="color: red; padding-left: 0.5em">
		      펀딩 종료일 1일 전까지만 취소 가능합니다.
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
        fundDto: {},
        fundNo: ''
      }
    },
 
    methods: {
      async loadOrderDetail() {
        try {
          const url = "/rest/order/" + this.fundNo;
          const response = await axios.get(url);
          this.fundDto = response.data;
          } catch (error) {
          console.error(error);
        }
      }
    },
    created() {
      this.fundNo = window.location.search.split("=")[1]; // URL에서 fundNo 값을 추출합니다.
      this.loadOrderDetail();
    }
  }).mount("#app");
</script>

		
		
		<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> 
