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
    		
    		
    		00번째 후원자입니다 ㅊㅋㅊㅋ
			
			<table class="table">
			
				<tr>
					<th>펀딩 프로젝트</th>
					<td>${fundInfoDto.fundTitle}</td>
				</tr>
			
			
			
			
				<tr>
					<th>펀딩 상태</th>
					<td>${fundPostDto.fundState}</td>
				</tr>
				
				<tr>
					<th>후원 번호</th>
					<td>${fundDto.fundNo}</td>
				</tr>
				
				<tr>
					<th>후원 날짜</th>
					<td>${fundDto.fundTime}</td>
				</tr>
				
				<tr>
					<th>결제일</th>
					<td>${fundDto.fundTime}</td>
				</tr>
				
				<tr>
					<th>결제 금액</th>
					<td>${fundDto.fundPrice}</td>
				</tr>
				
				
				
				<tr>
					<th>펀딩 마감일</th>
					<td>${fundPostDto.postEnd}</td>
				</tr>
				
				
			</table>
			
			
		</div>
	  </div>
	</div>
		
			
			
	
			
			
			
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>