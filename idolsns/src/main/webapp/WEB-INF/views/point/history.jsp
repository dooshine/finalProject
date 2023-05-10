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
	 
	</style>


<section id = "my_point">
	

      	<div class= "container-fluid d-flex justify-content-center">
        	<div class="col-6">    
		        <ul class="point_header_tab">
		            <li class="tab_list"><a href="charge">포인트 충전</a></li>
		            <li class="tab_list active"><a href="#">충전 내역</a></li>
		            <li class="tab_list"><a href="order">사용 내역</a></li>
		        </ul>

		<h3>충전 내역</h3>
		
		 <div>
            <p>내 포인트: <span class="amount">{{ formattedAmount }}</span>원</p>
        </div>
        
				<div class="modal-body">
				  <table class="table">
						<thead>
							<tr>
								<th>충전일</th>
								<th>구분</th>
								<th>충전 금액</th>
								<th>결제 수단</th>
								<th>더보기</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>2023-05-09</td>
								<td>카카오페이</td>
								<td>10,000원</td>
								<td>신용카드</td>
								<td>더보기</td>
							</tr>
							<tr>
								<td>2023-05-07</td>
								<td>오프라인</td>
								<td>50,000원</td>
								<td>카카오페이</td>
								<td>더보기</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
	</div>
	
	
	</section>
	