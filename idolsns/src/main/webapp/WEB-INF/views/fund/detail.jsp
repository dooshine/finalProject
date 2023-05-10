<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 

    <title>타이틀</title>

	<script src="https://cdn.jsdelivr.net/npm/vue"></script>
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
    <script>
    	const contextPath = "${pageContext.request.contextPath}";
    </script>
    
    
    
    
<section id = "my_point">
	

	<div class= "container-fluid d-flex justify-content-center">
      	<div class="col-6">    
     
		<div>
			<h2>제목 위치</h2>
		</div>
		
				<div class="container">
					<table class="table table-striped">
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
	
	