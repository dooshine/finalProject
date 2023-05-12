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
	
	    .tab_list.active {
	       font-weight:bold;
	      	color: #77E9CC;
	        
	    }
	
	    .tab_list a {
	        text-decoration: none;
	        color: #333;
	        
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



<section id = "my_point">
	

      	<div class= "container-fluid d-flex justify-content-center">
        	<div class="col-6"> 
        	
        		 <div class="container rounded p-3" style="background-color:white">
        		 
		        <ul class="point_header_tab">
		            <li class="tab_list"><a href="charge">포인트 충전</a></li>
		            <li class="tab_list"><a href="history">충전 내역</a></li>
		            <li class="tab_list active"><a href="#">사용 내역</a></li>
		        </ul>
		        
		        
		        
		        <h3 class="title mt-5 mb-3" style="padding-left: 0.5em">사용 내역</h3>
				
				<div class="modal-body" style="padding-left: 0.5em; padding-right: 0.5em;">
				  <table class="table">
				    <thead>
				      <tr>
				        <th>사용일</th>
				        <th>사용 내역</th>
				        <th>사용포인트</th>
				        <th>더보기</th>
				      </tr>
				    </thead>
				    <tbody>
				      <tr>
				        <td>2023-05-09</td>
				        <td>상품 구매</td>
				        <td>-500</td>
				        <td><button class="btn btn-sm btn-primary">더보기</button></td>
				      </tr>
				      <tr>
				        <td>2023-05-08</td>
				        <td>이벤트 참여</td>
				        <td>100</td>
				        <td><button class="btn btn-sm btn-primary">더보기</button></td>
				      </tr>
				      <tr>
				        <td>2023-05-05</td>
				        <td>상품 구매</td>
				        <td>800</td>
				        <td><button class="btn btn-sm btn-primary">더보기</button></td>
				      </tr>
				    </tbody>
				  </table>
				  </div>
				</div>
			</div>
		</div>
	</section>
	