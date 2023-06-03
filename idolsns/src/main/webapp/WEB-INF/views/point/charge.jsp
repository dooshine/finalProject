<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 


   <style>
   	     @media screen and (max-width:992px) {
		  	.col-6 {
		    width: 100%; 
		  }
    	}

	
	    
	    .point_select {
	    	width: 100%;
	    
	    }
	    
	    .radio_label {
			white-space: nowrap;
		}


		input[type="radio"] {
			accent-color: #6A53FB;
		}
	</style>



	
	  <div id="app">
  
        	
        	<!-- <div class="container rounded-3 p-4 shadow-sm" style="background-color:white;"> -->
        	<div class="container custom-container">
		        <ul class="custom-tab-header">
		            <li class="custom-tab-list active"><a href="#">스타 충전</a></li>
		            <li class="custom-tab-list"><a href="history">충전 내역</a></li>
		            <li class="custom-tab-list"><a href="order">사용 내역</a></li>
		        </ul>
		      
		        
		        
		        <h3 class="font-bold mt-5 mb-3" style="padding-left: 12px;">스타 충전</h3>
				
        <div style="padding-left: 0.5em; padding-right: 0.5em;">
            <div class="container my-3 custom-border-box">내 포인트: 
				<span class="amount" style="color:#6A53FB; font-weight:bold">{{ formattedAmount }}</span>원</div>
        </div>

        <form id="chargeForm" method="post" style="padding-left: 0.7em; padding-right: 0.7em;">
            
            
                <label class="point_select">
                    <input type="radio" name="total_amount" v-model="selectedAmount" value="1000"> 
                    <span class="amount"> 1,000</span>스타
                </label>        

                <label class="point_select">
                    <input type="radio" name="total_amount" v-model="selectedAmount" value="5000"> 
                   <span class="amount"> 5,000</span>스타
                </label>        

                <label class="point_select">
                    <input type="radio" name="total_amount" v-model="selectedAmount" value="10000"> 
                    <span class="amount"> 10,000</span>스타
                </label>        

                <label class="point_select">
                    <input type="radio" name="total_amount" v-model="selectedAmount" value="20000"> 
                    <span class="amount"> 20,000</span>스타
                </label>        

                <label class="point_select">
                    <input type="radio" name="total_amount" v-model="selectedAmount" value="50000"> 
                    <span class="amount"> 50,000</span>스타
                </label>        
                
                
                
                
                
                <label class="point_select d-flex">
				  
				    <p class="amount">직접 입력</span>
				    <div class="input-form" style="width:20%">
				        <input type="number" value="custom" name="total_amount" v-model="selectedAmount" class="custom-input p-0" 
							placeholder="금액 입력" min="1000">    
				    </div>스타
				    
				    
				</label>
												
								
				<div class="mt-3 mb-3">
				    <p class="my-3">충전 후 내 스타: 
				    <span class="amount">{{ (amount+parseInt(selectedAmount || 0)).toLocaleString() }}
				    </span>스타
				    
				    </p>
				</div>
				

				<div>
					<span style="font-weight:bold">결제 수단</span>
					<div class = "rounded bg-light p-3">
						  <label>
						    <input type="radio" name="payment-method" value="kakaopay" checked>
						    카카오페이
						  </label>
					
					</div>
				</div>

				<div>
					<input style="display: none" name="quantity" value="1">
				</div>

	            <div class="justify-content-center d-flex mt-5">
	                <button type="submit" class="custom-btn btn-purple1 mb-4" @click="charge">충전하기</button>
	            </div>

	       	 </form>
	       	 
	       	 </div>
           
		</div>

    

	
	
    
    <script>
   
	    Vue.createApp({
	        //데이터 설정 영역
	        data() {
	            return {
	            	  item_name: '스타 충전',
	                  amount: '',
	                  selectedAmount: null,
	                  customAmount: ''
	            }
	        },
	        computed: {
	       
	        	formattedAmount() {
	        	    if (this.selectedAmount === 'custom') {
	        	        const customAmount = parseInt(this.customAmount);
	        	        if (!isNaN(customAmount)) {
	        	            return (this.amount + customAmount).toLocaleString();
	        	        }
	        	        return this.amount.toLocaleString();
	        	    }
	        	    return this.amount.toLocaleString();
	        	},
	            
                
	        },
	        methods: {
	            charge(event) {
	                if (!this.selectedAmount) {
	                	event.preventDefault();
	                    alert("충전할 금액을 선택해주세요.");
	                    return;
	                }
	          		
	                if (this.selectedAmount === 'custom' && (!this.customAmount || this.customAmount < 1000)) {
	                    event.preventDefault();
	                    alert("최소 1000스타 이상 입력해야 합니다.");
	                    return;
	                }

	              
	                var chargeForm = document.getElementById("chargeForm");
	               
	                chargeForm.submit();
	                
	            },
			
	           	 async loadMemberPoint() {
	                     const url = "/rest/member/" + memberId;
	                     const data = {
	                         memberId: this.memberId // 로그인된 멤버 아이디 사용
	                     };
	                     const resp = await axios.get(url);

	                     this.amount = resp.data.memberPoint;
	            	// MemberRestController(rest/member)에 getMapping method 추가 후
	        		// Axios로 method 호출(await 사용, 전달 data-> 멤버아이디), 로 멤버DTO 정보 불러와서
	        		// 멤버 DTO의 point를 this.amount 대입
	        	}
	            
	        },
	        created(){
	        	
	        	this.loadMemberPoint();
	        }
	    }).mount("#app");

    </script>

	
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> 