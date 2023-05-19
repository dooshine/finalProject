<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


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
    


    </style>
    
    

		
	<div id="app">
	  <div class="container rounded p-3" style="background-color:white">
    	<div style="padding-left:0.5em; padding-right:0.5em;">
    		
    		
    		
    		
    		
    		
    		
    		<div class="container border mt-5 d-flex" style="padding:1em;">
    			<img src="http://via.placeholder.com/200x150" class="col-5">
    			
    			<div  class="col-7">
    			${fundPostDto.fundTitle}펀딩제목~~ <br>
    			${fundPostDto.fundGoal}펀딩목표금액~~<br>
    			<button class="btn btn-primary">메시지</button>
    			</div>
    		
    		</div>
    		
    		
    		
    		<div class= "mt-5">
    			<h4 class="title">후원정보</h4>
    		</div>
    		<hr style="background-color: black; height: 2px">
    	
			<table class="table">
				<tr>
					<th>펀딩 상태</th>
					<td>${fundPostDto.fundStatus}</td>
				</tr>
				
				<tr>
					<th>후원 번호</th>
					<td>${fundDto.fundNo}</td>
				</tr>
				
				<tr>
					<th>후원 날짜</th>
					<td>${fundPostDto.fundDate}</td>
				</tr>
				
				<tr>
					<th>결제일</th>
					<td>${fundDto.fundTime}</td>
				</tr>
				
				
				<tr>
					<th>펀딩 마감일</th>
					<td>${fundPostDto.post_end}</td>
				</tr>
				
				
			</table>
			
			
			<div class="input-group mt-5 mb-3">
			  <span class="input-group-text" id="inputGroup-sizing-default">후원 금액</span>
			  <input type="number" name="fundPrice" class="form-control" 
			  aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"
			  placeholder="후원 금액을 입력하세요">
			</div>
			
			
			
			 <div class="form-check">
		        <input class="form-check-input" type="checkbox" value="" id="privacyCheck">
		        <label class="form-check-label" for="privacyCheck">
		          개인정보 제 3자 제공 동의
		        </label>
		      </div>
		      
		      <div class="form-check">
		        <input class="form-check-input" type="checkbox" value="" id="guidelinesCheck">
		        <label class="form-check-label" for="guidelinesCheck">
		          후원 유의사항 확인
		        </label>
		      </div>
			
			
			
						
			
			  <button class="btn btn-lg btn-primary mt-3 mb-5" style="width:100%" 
			  v-bind:disabled="!isCheckboxChecked">
			  후원하기</button>
			
			
			
			
		</div>
	  </div>
	</div>
		
			
			
		<script>
   
		  Vue.createApp({
	        //데이터 설정 영역
	        data() {
	            return {
			    isCheckboxChecked: false
	            }
				  },
				  mounted() {
				    const privacyCheckbox = document.getElementById('privacyCheck');
				    const guidelinesCheckbox = document.getElementById('guidelinesCheck');
				    
				    privacyCheckbox.addEventListener('change', this.updateCheckboxState);
				    guidelinesCheckbox.addEventListener('change', this.updateCheckboxState);
				  },
				  methods: {
				    updateCheckboxState() {
				      const privacyCheckbox = document.getElementById('privacyCheck');
				      const guidelinesCheckbox = document.getElementById('guidelinesCheck');
				      
				      this.isCheckboxChecked = privacyCheckbox.checked && guidelinesCheckbox.checked;
				    }
				    
				  
				  }
	       
	        }).mount("#app");

		    </script>
			
			
			
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>