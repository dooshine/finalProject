<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 

    <title>내 지갑</title>

	<script src="https://cdn.jsdelivr.net/npm/vue"></script>
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
    <script>
    	const contextPath = "${pageContext.request.contextPath}";
    </script>
    
    
    
    
    <script>
	    var app = new Vue({
	        el: '#app',
	        data: {
	            amount: 0,
	            selectedAmount: null
	        },
	        computed: {
	            formattedAmount: function() {
	                return this.amount.toLocaleString();
	            }
	        },
	        methods: {
	            charge: function() {
	                if (!this.selectedAmount) {
	                    alert("충전할 금액을 선택해주세요.");
	                    return;
	                }
	                var chargeForm = document.getElementById("chargeForm");
	                chargeForm.submit();
	            }
	        }
	    });
</script>
    
   <style>
	    /* 탭 메뉴 스타일 */
	    .point_header_tab {
	        overflow: hidden;
			width:100%;

	    }
	
	    .tab_list {
	        background-color: inherit;
	        float: left;
	        border: none;
	        outline: none;
	        cursor: pointer;
	        padding: 14px 16px;
	        transition: 0.3s;
	        font-size: 17px;
	        list-style: none; /* 불렛포인트 없애기 */
	        position: relative; /* 하위 요소에 적용할 수 있는 유사 클래스(자식 셀렉터)를 사용하기 위해 position을 추가 */
	    }
	
	    .tab_list.active {
	        background-color: #f8f8f8;
	    }
	
	    .tab_list a {
	        text-decoration: none;
	        color: #333;
	    }
	
	    .tab_list:hover {
	        background-color: #f8f8f8;
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
	   
	    
	</style>


<section id = "my_point">
	
	  <div id="app">
      	<div class= "container-fluid d-flex justify-content-center">
        	<div class="col-6">    
		        <ul class="point_header_tab">
		            <li class="tab_list active"><a href="#">포인트 충전</a></li>
		            <li class="tab_list"><a href="history">충전 내역</a></li>
		            <li class="tab_list"><a href="order">사용 내역</a></li>
		        </ul>
		        
		        
		        <h3>포인트 충전</h3>

        <div>
            <p>내 포인트: <span class="amount">{{ formattedAmount }}</span>원</p>
        </div>

        <form id="chargeForm" method="post" action="${contextPath}/charge">
            
            
                <label class="point_select">
                    <input type="radio" name="chargeAmount" v-model="selectedAmount" value="1000"> 
                    <span class="amount">1,000</span>원
                </label>        

                <label class="point_select">
                    <input type="radio" name="chargeAmount" v-model="selectedAmount" value="5000"> 
                   <span class="amount">5,000</span>원
                </label>        

                <label class="point_select">
                    <input type="radio" name="chargeAmount" v-model="selectedAmount" value="10000"> 
                    <span class="amount">10,000</span>원
                </label>        

                <label class="point_select">
                    <input type="radio" name="chargeAmount" v-model="selectedAmount" value="20000"> 
                    <span class="amount">20,000</span>원
                </label>        

                <label class="point_select">
                    <input type="radio" name="chargeAmount" v-model="selectedAmount" value="50000"> 
                    <span class="amount">50,000</span>원
                </label>        
				
				
				<div>
				    <p>충전 후 내 포인트: 
				    <span class="amount">{{ (amount+parseInt(selectedAmount || 0)).toLocaleString() }}
				    </span>원
				    </p>
				</div>
				

				<div>
					<span>결제 수단</span>
					<div class = "rounded bg-light p-3">
						  <label>
						    <input type="radio" name="payment-method" value="kakaopay">
						    카카오페이
						  </label>
					
					</div>
				</div>





	            <div>
	                <button type="button" @click="charge">충전하기</button>
	            </div>
	       	 </form>
	       	 
	       	 
            </div>
		</div>
    </div>
    
    
    
	
	
	
	
	
	</section>
	
	
	
	