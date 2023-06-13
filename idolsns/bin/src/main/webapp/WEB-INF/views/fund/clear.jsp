<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


    
    <style>
    
          /*조건부 스타일 - 태블릿*/
        @media screen and (max-width:1200px) {
    
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
    	<div style="padding-left:0.5em; padding-right:0.5em;">
    		
    		
    		<div class="my-5 mb-5">
    			<h2 class="font-bold" style="text-align: center;">{{ fundDetail.fundSponsorCount }} 번째 후원자입니다 🎉</h2>
    		</div>
    		
			<div class="p-4">
			
				<div>
					<h4 class="font-bold">후원정보</h4>
				</div>
			
			
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
			
			</div>
			
		</div>
	  </div>
	</div>
		
						
    <script src="https://unpkg.com/vue@3.2.36"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
			

	
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
	          fundSponsorCount: "",
	        },
	        fundDto: [],
	      };
	    },
	    methods: {
	      async loadOrderDetail() {
	        const url = "/rest/fund/order/" + this.fundNo;
	        const resp = await axios.get(url);
	        this.fundDto = resp.data;
	        this.fundDetail.postNo = resp.data.postNo;
	        this.loadFundPosts(); // loadOrderDetail()에서 loadFundPosts()를 호출합니다.
	        this.loadFundVO();

	      },
	      async loadFundPosts() {
	        const postNo = this.fundDetail.postNo;
	        const resp = await axios.get("/rest/fund/" + postNo);
	        this.fundDetail = { ...this.fundDetail, ...resp.data };
	      },
	      formatCurrency(value) {
	        return value.toLocaleString();
	      },
	      async loadFundVO() {
	    	  const postNo = this.fundDetail.postNo;
	    	  const resp = await axios.get("${contextPath}/rest/fund/fundlist/"+postNo);
	    	  this.fundDetail.fundSponsorCount = resp.data.fundSponsorCount;
	      }
	    },
	    created() {
	      this.loadFundPosts();
	      this.fundNo = window.location.search.split("=")[1]; // URL에서 fundNo 값을 추출합니다.
	      this.loadOrderDetail();
	      this.loadFundVO();
	    },
	  }).mount("#app");
	</script>
			
			
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>