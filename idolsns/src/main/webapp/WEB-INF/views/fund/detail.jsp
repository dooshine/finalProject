<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

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
    
        .fund_label {
        	color: gray;
			width:100%;
			font-size: 80%;
			padding-left:1em;
		}
		
		.fund_span {
			font-size: 30px;
			padding-left:0.5em;
			
		}
	

		.like-btn {
		  
		}
		
		.like-count {
		  font-size: 14px;
		  color: #777;
		  
		}
		
    </style>
    
   	<div id="app">
		<div class="container rounded p-3" style="background-color:white">
			  
		<div v-for="(fundpost, index) in fundPosts" :key="fundpost.memberId">
			
		<div>
			<h2 class="title text-center mt-5 mb-5">${fundPostDto.fundTitle}</h2>
		</div>
			
		
		<img src="/download?attachmentNo=${fundMainImageDto.attachmentNo}" alt="예시사진">
			
		
			<div>
	
				<label>모인 금액</label>
				<span class="fund_span">${fundTotal}</span>원
				<span style="font-weight:bold">${fundTotal / fundPostDto.fundGoal * 100}</span>%
		
			
		
				<label>남은 시간</label>
				<span class="fund_span"></span>일
			
	
				<label>후원자</label>
				<span class="fund_span">3,421</span>명
	
			
			</div>
		
		<div class="d-flex row mt-3" style="padding-left: 1em">
		
			<hr>
		
			<div>목표 금액		</div>
			<div>${fundPostDto.fundGoal}원</div>
			<br>
			
			<div>펀딩 기간		</div>
			<div>${fundPostDto.postStart}~${fundPostDto.postEnd}</div>
			
			<div >결제		</div>
			<div>${fundPostDto.postEnd} 결제 진행</div>
			
		
			<div class="row mt-3" style="padding-left: 1em">
			
				    <button class="btn btn-primary like-btn">
				      <i class="fa fa-heart"></i> 
				      <!-- {{ likeCount }}  -->
				    </button>
		
			
					 <button class="btn btn-primary share-btn">
				      <i class="fa fa-share"></i>
				      <!-- {{ likeCount }}  -->
				    </button>
			
				
					<button type="submit" class="btn btn-primary" @click="order">
					후원하기</button>
					
					</div>	
					
					<div class="row mt-3" style="padding-left: 1em">
						<c:forEach var="image" items="${postImageList}">
							<img src="/download?attachmentNo=${image.attachmentNo}">
						</c:forEach>
					</div>
					
				</div>
		</div>
	</div>             
	</div>
				<hr>
			
			
				postImageList : ${postImageList}<br>
				<br>
				fundPostDto: ${fundPostDto}<br>
				<br>
				fundMainImageDto: ${fundMainImageDto }
				
				
			
			
    <script src="https://unpkg.com/vue@3.2.36"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
			
	
		
		<script>
		  Vue.createApp({
		    data() {
		      return {
		        fund: {
		          fundPrice: "",
		          fundNo: "",
		          postNo: "",
		          memberId: "{{ memberId }}", // memberId를 Vue 데이터에 추가하고, 값을 바인딩합니다.
		          fundName: "",
		          fundTime: "",
		          attachmentNos: [],
		          attachmentNo: ""
		        },
		      };
		    },
		    methods: {
				// postNo 설정		    	
			    setPostNo() {
			      const params = new URLSearchParams(location.search);
			      const postNo = params.get("postNo");
			      this.fund.postNo = postNo;
			      console.log("postNo=" + this.fund.postNo);
			    },
			    async loadFundPosts(){
			    	const postNo = this.fund.postNo;
					const resp = await axios.get("http://localhost:8080/rest/fundlist/"+postNo)	  
					console.log("FundPostDto=" + resp.data);
					this.fund.push(...resp.data);
        		},
        		async loadAttachNos(){
        			const postNo = this.fund.postNo;
					const resp = await axios.get("http://localhost:8080/rest/fundlist/attaches/"+postNo)	  
					console.log("attachmentNos=" + resp.data);
					this.fund.push(...resp.data);
        		},
		       
                // 데이터 중 fund를 서버로 전송
		      	order() {
		      	  const postNo = this.fund.postNo; // Vue 데이터의 postNo 값을 사용
		      	  window.location.href = "http://localhost:8080/fund/order?postNo=" + postNo;
		      	},
		    },
		    created() {
		    	  this.setPostNo();
		    	  this.loadFundPosts();
		    	  this.loadAttachNos();
		    	}
		  
		  }).mount("#app");
		</script>

	
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	