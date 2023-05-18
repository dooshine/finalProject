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
			   	
		   
		    ul.point_header_tab {
		      padding: 0;
		      margin: 0;
		    }
		   
	    /* 탭 메뉴 스타일 */
	    .point_header_tab {
	        overflow: hidden;
			width:100%;
	
	    }
	
	    .tab_list {
	        background-color: inherit;
	        float: left;
	      	border-bottom: 0.5px solid #f5f5f5;
	        outline: none;
	        cursor: pointer;
	        padding: 15px 15px;
	        transition: 0.3s;
	        font-size: 17px;
	        list-style: none; /* 불렛포인트 없애기 */
	        position: relative; /* 하위 요소에 적용할 수 있는 유사 클래스(자식 셀렉터)를 사용하기 위해 position을 추가 */
	        
	    }
	
	   
	    .tab_list a {
	        text-decoration: none;
	        color: #333;
	        
	    }
	    
	     .tab_list.active {
	      color: #77E9CC;
	       font-weight:bold;
	        
	    }
	
	
	    .tab_list:hover {
	    
	    
	    }
	
	    /* 하위 요소에 적용할 스타일 */
	    .tab_list.active::after {
	        content: '';
	        position: absolute;
	        bottom: 0;
	        left: 0;
	        width: 100%;
	        height: 4px;
	        background-color: #77E9CC;
	        
	    }
	    
	    .point_select {
	    	width: 100%;
	    
	    }
	    
	    .radio_label {
			white-space: nowrap;
		}
	   
	    
    	.title {
   		font-weight:bold;
	   	}
	    
	    
	</style>




	
	  <div id="app">
  
        	
        	<div class="container rounded p-3" style="background-color:white">
        		 
		        <ul class="point_header_tab">
		            <li class="tab_list active"><a href="#">포인트 충전</a></li>
		            <li class="tab_list"><a href="history">충전 내역</a></li>
		            <li class="tab_list"><a href="order">사용 내역</a></li>
		        </ul>
		      
		        
		        
		        <h3 class="title mt-5 mb-3" style="padding-left: 0.5em">포인트 충전</h3>

        <div style="padding-left: 0.5em; padding-right: 0.5em;">
            <p class="container rounded p-3 border">내 포인트: 
            <span class="amount" style="color:#77E9CC; font-weight:bold" >{{ formattedAmount }}</span>원</p>
        </div>

        <form id="chargeForm" method="post" style="padding-left: 0.7em; padding-right: 0.7em;">
            
            
                <label class="point_select">
                    <input type="radio" name="total_amount" v-model="selectedAmount" value="1000"> 
                    <span class="amount">1,000</span>원
                </label>        

                <label class="point_select">
                    <input type="radio" name="total_amount" v-model="selectedAmount" value="5000"> 
                   <span class="amount">5,000</span>원
                </label>        

                <label class="point_select">
                    <input type="radio" name="total_amount" v-model="selectedAmount" value="10000"> 
                    <span class="amount">10,000</span>원
                </label>        

                <label class="point_select">
                    <input type="radio" name="total_amount" v-model="selectedAmount" value="20000"> 
                    <span class="amount">20,000</span>원
                </label>        

                <label class="point_select">
                    <input type="radio" name="total_amount" v-model="selectedAmount" value="50000"> 
                    <span class="amount">50,000</span>원
                </label>        
				
				
				<div class="mt-3">
				    <p>충전 후 내 포인트: 
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
	                <button type="submit" class="btn btn-lg btn-primary mb-5" @click="charge">충전하기</button>
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
	                     const url = "http://localhost:8080/rest/member/"+memberId;
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