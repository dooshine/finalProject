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
    
    
    	section {
		  font-family: "Noto Sans KR", sans-serif;
		}
		   	
    
    
    	.title {
    		font-weight: bold; 
    		
    		}
    


    </style>
    

		
	<div id="app">
	  <div class="container rounded p-3" style="background-color:white">
    	<div style="padding-left:0.5em; padding-right:0.5em;">
    		
    		
    		00번째 후원자입니다 ㅊㅋㅊㅋ
			
			<table class="table">
			
				<tr>
					<th>펀딩 프로젝트</th>
					<td>{{ fundDetail.fundTitle }}</td>
				</tr>
			
			
			
				<tr>
					<th>펀딩 상태</th>
					<td>{{ fundDetail.fundState }}</td>
				</tr>
				
				<tr>
					<th>후원 번호</th>
					<td>{{ fundDto.fundNo }}</td>
				</tr>
				
				<tr>
					<th>후원 날짜</th>
					<td>{{ fundDto.fundTime }}</td>
				</tr>
				
		
			  	<tr>
			         <th>후원 금액</th>
			         <td>{{ formatCurrency(fundDto.fundPrice) }}</td>
		        </tr>
				
				<tr>
					<th>펀딩 마감일</th>
					<td>{{ fundDetail.postEnd }}</td>
					
				</tr>
				
				
			</table>
			
			
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
	        },
	      };
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