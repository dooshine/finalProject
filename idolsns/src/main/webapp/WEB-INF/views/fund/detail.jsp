<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


    <title>타이틀</title>

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
		
		.fund_d {
		
			font-weight: bold; 
			font-size: 15px;
			padding-left:1em;
		}
		
		.fund_dd {
			font-size: 15px;
		}
		

		.like-btn {
		  
		}
		
		.like-count {
		  font-size: 14px;
		  color: #777;
		  
		}
		
		
	

    </style>
    
    

			<div class="container rounded p-3" style="background-color:white">
			
				  
			<div>
				<h2 class="title text-center mt-5 mb-5">펀딩 제목 위치</h2>
			</div>
				
			
			
				<div class="col-12 d-flex">
					<img class="col-7" src="http://via.placeholder.com/500x400" alt="예시사진">
				
			
				<div class="col-5">
		
					<label class="fund_label">모인 금액</label>
					<span class="fund_span">15,000,000</span>원<span style="font-weight:bold">150</span>%
			
				
			
					<label class="fund_label">남은 시간</label>
					<span class="fund_span">3</span>일
				
		
					<label class="fund_label">후원자</label>
					<span class="fund_span">3,421</span>명
		
				
				
			
			<div class="d-flex row mt-3" style="padding-left: 1em">
			
				<hr>
			
				<div class="fund_d col-4">목표 금액		</div>
				<div class="fund_dd col-7">1,500,000원 달성</div>
				<br>
				
				<div class="fund_d col-4">펀딩 기간		</div>
				<div class="fund_dd col-7">2023.04.01~2023.04.17</div>
				
				<div class="fund_d col-4">결제		</div>
				<div class="fund_dd col-7">2023.04.18 결제 진행</div>
				
			
				<div class="d-flex row mt-3" style="padding-left: 1em">
				
				<div id="app">
	
					    <button class="btn btn-primary like-btn col-2" @click="likeCount++">
					      <i class="fa fa-heart"></i> 
					      <!-- {{ likeCount }}  -->
					    </button>
			
				
						 <button class="btn btn-primary share-btn col-2" @click="shareCount++">
					      <i class="fa fa-share"></i> 
					      <!-- {{ likeCount }}  -->
					    </button>
				
					
						<button type="button" data-bs-target="#modal01" 
						data-bs-toggle="modal" class="btn btn-primary col-7">
						이 프로젝트 후원하기</button>
						
						<!-- 후원 모달창 -->
						<div class="modal" tabindex="-1" role="dialog" id="modal01"
                            data-bs-backdrop="static">
            				<div class="modal-dialog" role="document">
                				<div class="modal-content">
                    				<div class="modal-header">
                        				<h5 class="modal-title">후원하기</h5>
                    				</div>
                    		<div class="modal-body">
							<!-- 모달에서 표시할 실질적인 내용 구성 -->
                        
                <label>후원금</label>
                <input type="text" v-model="fund.fundPrice">
                
                
                <button type="button" v-on:click="sendItem">
				    후원하기
				</button>
                        
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary"
                                data-bs-dismiss="modal">닫기</button>
                    </div>
        	        </div>      
    	        </div>
	        </div>
				</div>
				</div>
				</div>
				</div>
				</div>
				
				
				
		
			
				</div>
		
				<hr>
			
			
			
			
			<div class="row">
				<div class="col-12">
					<h3>프로젝트 소개</h3>
						<h5>이것저것
						</h5>
					
					<h3>일정</h3>
						<h5>이것저것
						ㄴㅁㅇㅁ
						<br>
						ㅁㄴㅇㅁㄴㅇㅁㄴ
						<br>
						ㄴㅁㅇㅇㅁㄴㅁㄴ
						<br>
						ㅇㅁㄴㄴㅁ<br>
						ㅇㄴ<br>
						ㅇㅁ<br>
						</h5>
					
				</div>
			</div>
			
			
			
			
				postImageDto : ${postImageList}<br>
				fundPostDto: ${fundPostDto }<br>
				
				<c:forEach var="postImageDto" items="${postImageList}">
					<img src="${postImageDto.imageURL}">
				</c:forEach>
	</section>
			
			
    <script src="https://unpkg.com/vue@3.2.36"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script>
        Vue.createApp({
            //데이터 설정 영역
            data(){
                return {
                    //화면에서 사용할 데이터 선언
                    fund:{
                        fundPrice:"",
                    },
                };
            },
            computed:{
            },
            methods:{
                // 데이터 중 fund를 서버로 전송
                async sendItem() {

                    // const resp = await axios.post("주소", {데이터});
                    const url = "http://localhost:8080/rest/fund/";
                    const resp = await axios.post(url, this.fund);
                    console.log(resp);


                },
            },
        }).mount("#app");
    </script>
			
	
		

	
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	