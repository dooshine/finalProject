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
          <td>{{ fundDetail.fundTitle }}</td>
        </tr>
        <tr>
          <th>사용 포인트</th>
          <td>{{ fundDto.fundPrice }}</td>
        </tr>
        <tr>
          <th>사용일</th>
          <td>{{ fundDto.fundTime }}</td>
        </tr>
        
        

        <tr>
          <th>펀딩 마감일</th>
          <td>{{ fundDetail.postEnd }}</td>
        </tr>

        
        <tr>
          <th>후원 상태</th>
          <td>{{ fundDetail.fundState }}</td>
        </tr>
        
      </table>

      <div class="d-flex justify-content-end">
		  <!-- 후원 취소 버튼: 잔여 금액이 존재한다면 -->
		  <template v-if="fundDto.fundRemain > 0">
		    <a :href="'cancelOrder?fundNo=' + fundDto.fundNo" style="padding-left: 0.5em">
		      <button class="btn btn-sm btn-danger" :disabled="isCancellationDisabled">
		        후원 취소
		      </button>
		    </a>
		    <p v-if="isCancellationDisabled" style="color: red; padding-left: 0.5em">
		      펀딩 종료 1일 전까지만 취소 가능합니다.
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
	        fundDetail: {
	          fundNo: "",
	          postNo: "",
	          fundTitle: "",
	          postStart: "",
	          postEnd: "",
	          fundGoal: "",
	          fundState: "",
	          fundTotal: "",
	          fundTime: "",
	          fundPrice: "",
	        },
	      };
	    },
	    computed: {
	      isCancellationDisabled() {
	        const startDate = new Date(this.fundDetail.postStart);
	        const endDate = new Date(this.fundDetail.postEnd);
	        const timeDiff = endDate.getTime() - startDate.getTime();
	        const oneDayInMillis = 1000 * 60 * 60 * 24;
	        return timeDiff <= oneDayInMillis;
	      },
	    },
	    methods: {
	      async loadOrderDetail() {
	        const url = "/rest/fund/order/" + this.fundNo;
	        const resp = await axios.get(url);
	        this.fundDto = resp.data;
	        this.fundDetail.postNo = resp.data.postNo;
	        this.loadFundPosts(); // loadOrderDetail()에서 loadFundPosts()를 호출합니다.
	      },
	      async loadFundPosts() {
	        const postNo = this.fundDetail.postNo;
	        const resp = await axios.get("/rest/fund/" + postNo);
	        this.fundDetail = { ...this.fundDetail, ...resp.data };
	      },
	      formatCurrency(value) {
	        return value.toLocaleString();
	      },
	    },
	    created() {
	      this.fundNo = window.location.search.split("=")[1]; // URL에서 fundNo 값을 추출합니다.
	      this.loadOrderDetail();
	      this.loadFundPosts();
	    },
	  }).mount("#app");
	</script>
			
		
		<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> 
