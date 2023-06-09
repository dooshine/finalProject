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
    
    
    </style>
    
    

		
	<div id="app">
	  <div class="custom-container">
    	<div style="padding-left:0.5em; padding-right:0.5em;">
    		
    		
    		
   		  <form id="orderProcess" method="post" action="/fund/order">
    		
    		<div class="container border mt-5 d-flex" style="padding:1em;">
    			<img src="/download?attachmentNo=${fundMainImageDto.attachmentNo}" class="col-5">
    			
    			<div class="col-7">
    			${fundPostDto.fundTitle} <br>
    			${fundPostDto.fundGoal}원 <br>
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
					<td>${fundPostDto.fundState}</td>
				</tr>

				<tr>
					<th>펀딩 마감일</th>
					<td>${fundPostDto.postEnd}</td>
				</tr>
				
				
			</table>
			
			<input type="hidden" name="postNo" value="${fundPostDto.postNo}">

			
	  	<div>
        	<p class="container rounded p-3 border">내 스타: 
        	<span class="amount" style="color:#77E9CC; font-weight:bold">{{ formattedAmount }}</span>원</p>
        </div>	
			
			
			
			<div class="input-group mt-3 mb-3">
			  <span class="input-group-text" id="inputGroup-sizing-default">후원 금액</span>
			  <input type="number" name="fundPrice" class="form-control" 
			    aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"
			    placeholder="후원 금액을 입력하세요" v-model="fundPrice" @input="validateFundPrice" min="0">
			</div>
						
			<!-- Add the error message -->
			<p v-if="fundPriceExceedsAmount" style="color: red">
			  보유 스타 이상으로 후원할 수 없습니다.
			</p>
						
						
			
		
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
			
			
			  <button type="submit" class="custom-btn btn-purple1 mt-3 mb-5" 
			  style="width:100%" v-bind:disabled="!isCheckboxChecked">
			  후원하기</button>
			  
				
			
				</form>
			
			
		</div>
	  </div>
	</div>

			
			
		<script>
		  Vue.createApp({
		    data() {
		      return {
		        isCheckboxChecked: false,
		        amount: '',
		        selectedAmount: null,
		        memberId: '',
		        fundPriceExceedsAmount: false,
		        fundPriceEntered: false
		      }
		    },
		    computed: {
		      formattedAmount() {
		        return this.amount.toLocaleString();
		      },
		    },
		    mounted() {
		      const privacyCheckbox = document.getElementById('privacyCheck');
		      const guidelinesCheckbox = document.getElementById('guidelinesCheck');
		
		      privacyCheckbox.addEventListener('change', this.updateCheckboxState);
		      guidelinesCheckbox.addEventListener('change', this.updateCheckboxState);
		    },
		    methods: {
		      async loadMemberPoint() {
		        const url = "http://localhost:8080/rest/member/" + memberId;
		        const data = {
		          memberId: this.memberId
		        };
		        const resp = await axios.get(url);
		
		        this.amount = resp.data.memberPoint;
		      },
		      validateFundPrice() {
		    	    const fundPrice = parseInt(this.fundPrice);
		    	    this.fundPriceExceedsAmount = fundPrice > parseInt(this.amount);
		    	    this.fundPriceEntered = true;
		    	  },
		      updateCheckboxState() {
		        const privacyCheckbox = document.getElementById('privacyCheck');
		        const guidelinesCheckbox = document.getElementById('guidelinesCheck');
		
		        this.isCheckboxChecked = privacyCheckbox.checked && guidelinesCheckbox.checked; 
		      }
		    },
		    created() {
		      this.loadMemberPoint();
		    }
		  }).mount("#app");
		</script>

			
			
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>