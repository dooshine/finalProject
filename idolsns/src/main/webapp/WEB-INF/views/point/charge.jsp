<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 


   <style>
   	     @media screen and (max-width:992px) {
		  	.col-6 {
		    width: 100%; 
		  }
    	}

		   	section {
			  font-family: "Noto Sans KR", sans-serif;
			}
			   	
		   
	    
	    .point_select {
	    	width: 100%;
	    
	    }
	    
	    .radio_label {
			white-space: nowrap;
		}
	    
    	.custom-title {
   			font-weight:bold;
			padding-left: 12px;
	   	}
	    .custom-border-box {
			margin-top: 16px;
			margin-bottom: 16px;
			border: 0.3px solid #dee2e6;
			padding: 16px;
			border-radius: 0.5rem;
		}
		.custom-hr {
			margin-top: 16px;
			margin-bottom: 16px;
			background-color: #dee2e6;
			height: 0.3px;
		}
		.custom-container {
			box-shadow: 0px 3px 4px rgba(3, 21, 17, 0.1);
			background-color: white;
			padding: 24px;
			border-radius: 0.5rem;
		}
		.btn-primary {
			background-color: #6a53fb;
			border-color: #6A53FB;
		}
		.btn-primary:hover{
			background-color: #6a53fb;
			border-color: #6A53FB;
		}
		input[type="radio"] {
			accent-color: #6A53FB;
		}
	</style>



	
	  <div id="app">
  
        	
        	<!-- <div class="container rounded-3 p-4 shadow-sm" style="background-color:white;"> -->
        	<div class="container custom-container">
		        <ul class="custom-tab-header">
		            <li class="custom-tab-list active"><a href="#">포인트 충전</a></li>
		            <li class="custom-tab-list"><a href="history">충전 내역</a></li>
		            <li class="custom-tab-list"><a href="order">사용 내역</a></li>
		        </ul>
		      
		        
		        
		        <h3 class="title mt-5 mb-3" style="padding-left: 12px;">포인트 충전</h3>
				
        <div style="padding-left: 0.5em; padding-right: 0.5em;">
            <div class="container my-3 custom-border-box">내 포인트: 
				<span class="amount" style="color:#6A53FB; font-weight:bold">{{ formattedAmount }}</span>원</div>
        </div>

        <form id="chargeForm" method="post" style="padding-left: 0.7em; padding-right: 0.7em;">
            
            
                <label class="point_select">
                    <input type="radio" name="total_amount" v-model="selectedAmount" value="1000"> 
                    <span class="amount"> 1,000</span>원
                </label>        

                <label class="point_select">
                    <input type="radio" name="total_amount" v-model="selectedAmount" value="5000"> 
                   <span class="amount"> 5,000</span>원
                </label>        

                <label class="point_select">
                    <input type="radio" name="total_amount" v-model="selectedAmount" value="10000"> 
                    <span class="amount"> 10,000</span>원
                </label>        

                <label class="point_select">
                    <input type="radio" name="total_amount" v-model="selectedAmount" value="20000"> 
                    <span class="amount"> 20,000</span>원
                </label>        

                <label class="point_select">
                    <input type="radio" name="total_amount" v-model="selectedAmount" value="50000"> 
                    <span class="amount"> 50,000</span>원
                </label>        
				
				
				<div class="mt-3">
				    <p class="my-3">충전 후 내 포인트: 
				    <span class="amount">{{ (amount+parseInt(selectedAmount || 0)).toLocaleString() }}
				    </span>원
				    
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

	            <div class="justify-content-center d-flex mt-3">
	                <button type="submit" class="btn btn-lg btn-primary mb-4" @click="charge">충전하기</button>
	            </div>

	       	 </form>
	       	 
	       	 </div>
           
		</div>

    

	
	
    
    <script>
   
	    Vue.createApp({
	        //데이터 설정 영역
	        data() {
	            return {
	                item_name: '포인트충전',
	                amount: '',
	                selectedAmount: null,
	                memberId: ''
	            }
	        },
	        computed: {
	       
	            formattedAmount() {
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