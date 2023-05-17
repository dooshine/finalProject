<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


    <title>ㅇㅇㅇ</title>



<style scoped>
		
	
        /*메인 스타일 - 데스크톱*/
        * {
            box-sizing : border-box;
            
              }
            
  
            
            
            
      
        .funding-list {
            display:flex;
            flex-wrap: wrap;
   
        }
        
    
        
        .funding-list > .funding-item {
            width : 32%;
            transition: width 0.1s ease-out;
        }
      
        /*조건부 스타일 - 태블릿*/
        @media screen and (max-width:1200px) {
    
    	 .col-6 {
		    width: 100%;
		  }
            .funding-list > .funding-item  {
            width : 49%;
        	}
    	}

        /*조건부 스타일 - 모바일*/
        @media screen and (max-width:800px) {
		 
            .funding-list > .funding-item  {
            width : 100%;
        }
        
    }
					
			.funding-list {
			  display: flex;
			  flex-wrap: wrap;
			  gap: 10px;
			}
			
			.funding-item {
			
			  box-sizing: border-box;
			  padding: 10px;
			  border: 1px solid #ccc;
			  border-radius: 5px;
			  
			  
			}
			
			
			
			
			.funding-item img {
			  width: 100%;
			  border-radius: 5px;
			  
			  }
			
			.funding-item .title {
				margin: 10px 0;
				font-size: 1.2em;
				font-weight: bold;
				}
			
			.funding-item .description {
				margin: 10px 0;
				font-size: 0.9em;
				color: #666;
				}
			
			.progress-bar {
				height: 10px;
				background-color: #eee;
				border-radius: 5px;
				overflow: hidden;
				margin: 10px 0;
				}
			
			.progress {
				height: 100%;
				background-color: #2ecc71;
				}
			
			.info {
				display: flex;
				justify-content: space-between;
				}
			
			.info .col {
				text-align: center;
				color: #888;
				}
			
			.info .col .value {
				font-size: 1.2em;
				font-weight: bold;
				}
				
			.info .col .label {
				font-size: 0.9em;
				}
		</style>


		  <div id="app">

	    
        		 <div class="container rounded p-3" style="background-color:white;">
        		 
        		 
		
					  <div class="funding-list justify-content-center mt-5">
					  
					    <div class="funding-item" v-for="funding in fundings" :key="funding.id">
					      <img :src="funding.imageUrl" alt="Funding Image">
					      <h3 class="title">{{ funding.title }}</h3>
					      <p class="description">{{ funding.description }}</p>
					      <div class="progress-bar">
					        <div class="progress" :style="{ width: funding.progress + '%' }"></div>
					      </div>
					      <div class="info">
					        <div class="col">
					          <span class="value">{{ funding.amount }}원</span>
					          <span class="label">목표금액</span>
					        </div>
					        <div class="col">
					          <span class="value">{{ funding.daysLeft }}일</span>
					          <span class="label">남은 일수</span>
					        </div>
					        <div class="col">
					          <span class="value">{{ funding.supporters }}명</span>
					          <span class="label">서포터</span>
					        </div>
					      </div>
					    </div>
					  </div>
					</div>
					
					
			

				</div>	
			<c:forEach var="fundPostDto" items="${fundList}">
			${fundPostDto}<br>
			</c:forEach>


		<script>
		 Vue.createApp({
	            //데이터 설정 영역
	            data(){
            	   return{
				      fundings: [
				        {
				          id: 1,
				          title: '지하철광고',
				          description: '6/25 제 생일입니다',
				          imageUrl: 'https://via.placeholder.com/400x300',
				          amount: 1000000,
				          progress: 75,
				          daysLeft: 10,
				          supporters: 20,
				        },
				        {
				          id: 2,
				          title: '성공적인 파이널프로젝트를 위해',
				          description: '6/12 파이널 프로젝트 종료',
				          imageUrl: 'https://via.placeholder.com/400x300',
				          amount: 2000000,
				          progress: 50,
				          daysLeft: 20,
				          supporters: 30,
				        },
				        {
				          id: 3,
				          title: '부자의 그릇',
				          description: '돈을 주세요',
				          imageUrl:'https://via.placeholder.com/400x300',
				          amount: 5000000,
				          progress: 30,
				          daysLeft: 30,
				          supporters: 40,
				        },
				        {
					          id: 4,
					          title: '지하철광고',
					          description: '6/25 제 생일입니다2222',
					          imageUrl: 'https://via.placeholder.com/400x300',
					          amount: 1000000,
					          progress: 75,
					          daysLeft: 10,
					          supporters: 20,
					        },
					        {
					          id: 5,
					          title: '성공적인 파이널프로젝트를 위해22',
					          description: '6/12 파이널 프로젝트 종료',
					          imageUrl: 'https://via.placeholder.com/400x300',
					          amount: 2000000,
					          progress: 50,
					          daysLeft: 20,
					          supporters: 30,
					        },
					        {
					          id: 6,
					          title: '부자의 그릇',
					          description: '돈을 주세요',
					          imageUrl:'https://via.placeholder.com/400x300',
					          amount: 5000000,
					          progress: 30,
					          daysLeft: 30,
					          supporters: 40,
					        },
				      ],
	            	}
	            	}
		  		}).mount("#app");
		
		</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
		
