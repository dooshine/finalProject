<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


    <title>타이틀</title>



    
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
    
    

			<div class="container rounded p-3" style="background-color:white">
			
			후원 금액 <input type="number" name="fundPrice"><br><br>
			
			</div>
			
			
			
			
			
			
			
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>