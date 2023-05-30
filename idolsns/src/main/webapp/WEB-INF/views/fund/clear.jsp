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
					<td>{{ fundDto.fundTitle }}</td>
				</tr>
			
			
			
				<tr>
					<th>펀딩 상태</th>
					<td>{{ fundPostDto.fundState }}</td>
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
					<td>{{ fundDto.fundPrice }}</td>
				</tr>
				
				
				
				<tr>
					<th>펀딩 마감일</th>
					<td>{{ fundDetail.postEnd }}</td>
				</tr>
				
				
			</table>
			
			
		</div>
	  </div>
	</div>
		
			
			
<script>
  Vue.createApp({
    data() {
      return {
    	     postNo:'',
   	    	fundNo:'',
   	        fundDto: {},
   	        fundPostDto: {},
    	    
    	  fundDetail: {
	          fundPrice: "",
	          fundNo: "",
	          postNo: "",
	          memberId: memberId, // memberId를 Vue 데이터에 추가하고, 값을 바인딩합니다.
	          fundTime: "",
	          attachmentNos: [],
	          attachmentNo: "",
	          fundTitle: "",
	          postStart: "",
	          postEnd: "",
	          postTime: "",
	          fundGoal: "",
	          fundSponsorCount: "",
	          fundState: "",
	          postType: "",
	          postContent: "",
	          imageURL: "",
	          fundTotal: "",
	        },
   
      }
    },

    methods: {
		// postNo 설정		    	
	    setPostNo() {
	      const params = new URLSearchParams(location.search);
	      const postNo = params.get("postNo");
	      this.fundDetail.postNo = postNo;
	    },
	    // FundPostListDto 불러오기
	    async loadFundPosts(){
	    	const postNo = this.fundDetail.postNo;
			const resp = await axios.get("http://localhost:8080/rest/fund/"+postNo)	  
			this.fundDetail = { ...this.fundDetail, ...resp.data };
		},
	
       // fundTotal & fundSponsorCount 불러오기
		async loadFundVO(){
	    	const postNo = this.fundDetail.postNo;
			const resp = await axios.get("http://localhost:8080/rest/fund/fundlist/"+postNo)	  
			this.fundDetail.fundState = resp.date.fundState;
			this.fundDetail.postEnd = resp.data.postEnd;
		},
		
      async loadOrderDetail() {
        try {
          const url = "/rest/fund/order/" + this.fundNo;
          const response = await axios.get(url);
          this.fundDto = response.data;
          } catch (error) {
          console.error(error);
        }
      },
     
    },
    created() {

      	this.setPostNo();
   		this.fundNo = window.location.search.split("=")[1]; // URL에서 fundNo 값을 추출합니다.
      	this.loadOrderDetail();
	  	  this.loadFundPosts();

	  	  this.loadFundVO();

	      
    }
  }).mount("#app");
</script>
	
			
			
			
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>