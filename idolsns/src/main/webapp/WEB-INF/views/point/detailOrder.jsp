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
    <h3 class="font-bold mt-5 mb-3" style="padding-left: 0.5em">스타 사용 내역</h3>
    <div style="padding-left: 0.5em; padding-right: 0.5em;">
      <div class="custom-hr-big" style="background-color: #7f7f7f;"></div>
      <table class="table">
        <tr class="col-12">
          <th class="col-3">참여 펀딩</th>
          <td>{{ fundDetail.fundTitle }}</td>
        </tr>
        <tr>
          <th>후원 스타</th>
          <td>{{ formatCurrency(fundDto.fundPrice) }}스타</td>
        </tr>
        <tr>
          <th>후원일</th>
          <td>{{ fundDto.fundTime }}</td>
        </tr>
        <tr>
          <th>펀딩 마감일</th>
          <td>{{ fundDetail.postEnd }}</td>
        </tr>
        <tr>
          <th>펀딩 진행 상황</th>
          <td>{{ fundDetail.fundState }}</td>
        </tr>
        <tr>
          <th>후원 상태</th>
          <td>{{ fundDto.fundStatus }}</td>
        </tr>
      </table>
      <div class="d-flex justify-content-end">
        <!-- 후원 취소 버튼: 잔여 금액이 존재하고 펀딩 종료 1일 전이 아닌 경우 -->
        <template v-if="fundDto.fundRemain > 0 && !isCancellationDisabled">
          <a :href="'cancelOrder?fundNo=' + fundDto.fundNo" style="padding-left: 0.5em">
            <button class="btn btn-sm btn-danger">
              후원 취소
            </button>
          </a>
        </template>
        <!-- 펀딩 종료 1일 전이면서 잔여 금액이 존재하는 경우 -->
        <template v-if="isCancellationDisabled && fundDto.fundRemain > 0">
          <p style="padding-left: 0.5em; color: red; font-size: 15px">
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
          fundStatus: "",
        },
      };
    },
    computed: {
      isCancellationDisabled() {
        if (this.fundDetail && this.fundDetail.postEnd) {
          const currentDate = new Date();
          const endDate = new Date(this.fundDetail.postEnd);
          const timeDiff = endDate.getTime() - currentDate.getTime();
          const oneDayInMillis = 1000 * 60 * 60 * 24;
          return timeDiff <= oneDayInMillis;
        }
        return false;
      },
    },
    methods: {
      async loadOrderDetail() {
        const url = "/rest/fund/order/" + this.fundNo;
        const resp = await axios.get(url);
        this.fundDto = resp.data;
        this.fundDetail.postNo = resp.data.postNo;
        this.loadFundPosts();
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
      this.fundNo = window.location.search.split("=")[1];
      this.loadOrderDetail();
      this.loadFundPosts();
    },
  }).mount("#app");
</script>
			
		
		<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> 
