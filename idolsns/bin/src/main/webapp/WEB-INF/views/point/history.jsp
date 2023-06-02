<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 

    <title>내 지갑</title>


    <script>
    	const contextPath = "${pageContext.request.contextPath}";
    </script>
    
  <style>
   
   			
   
		   	section {
			  font-family: "Noto Sans KR", sans-serif;
			}
			   	
		   
		    ul.custom-tab-header {
		      padding: 0;
		      margin: 0;
		    }
		   
	    /* 탭 메뉴 스타일 */
	    .custom-tab-header {
	        overflow: hidden;
			width:100%;
	
	    }
	
	    .custom-tab-list {
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
	
	    .custom-tab-list.active {
	    	color: #77E9CC;
	       font-weight:bold;
	      	
	        
	    }
	
	    .custom-tab-list a {
	        text-decoration: none;
	        color: #333;
	        
	    }
	
	    .custom-tab-list:hover {
	    
	    }
	
	    /* 하위 요소에 적용할 스타일 */
	    .custom-tab-list.active::after {
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



<section id = "my_point">
	

      	<div class= "container-fluid d-flex justify-content-center">
        	<div class="col-6"> 
        	
        		 <div class="container rounded p-3" style="background-color:white">
        		 
		        <ul class="custom-tab-header">
		            <li class="custom-tab-list"><a href="charge">포인트 충전</a></li>
		            <li class="custom-tab-list active"><a href="#">충전 내역</a></li>
		            <li class="custom-tab-list"><a href="order">사용 내역</a></li>
		        </ul>
		        
		        
		        <h3 class="title mt-5 mb-3" style="padding-left: 0.5em">충전 내역</h3>
		
		   <div style="padding-left: 0.5em; padding-right: 0.5em;">
	            <p class="container rounded p-3 border">내 포인트: <span class="amount" style="color:#77E9CC; font-weight:bold" >{{ formattedAmount }}</span>원</p>
	        </div>
        
				<div class="modal-body" style="padding-left: 0.5em; padding-right: 0.5em;">
				  <table class="table">
						<thead>
						
							<tr>
								<th>충전일</th>
								<th>충전 금액</th>
								<th>결제 수단</th>
								<th>더보기</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<c:forEach var ="paymentDto" items="${list}">
								<td>${paymentDto.paymentTime}</td>
								<td>${paymentDto.paymentTotal}</td>
								<td>카카오페이</td>
								<td>
									<a href="detail?paymentNo=${paymentDto.paymentNo}">
									더보기
									</a>
								</td>
								</c:forEach>
							</tr>
						</tbody>
						
						
			
					</table>
				</div>
			</div>
		  </div>
	</div>
	
	
	</section>
	