<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>



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
					  
					  
					  <!-- 
					  <div v-for="(funding, index) in fundings" v-bind:key="funding.memberId">
						{{ funding }}
						</div>
						<div>
					   -->
					  
					    <div class="funding-item" v-for="(funding, index) in fundings" :key="funding.memberId">
					      <img :src="funding.imageUrl" alt="Funding Image">
					      <h3 class="title">{{ funding.fundTitle }}</h3>
					      <h3>{{ funding.postNo }}</h3>
					      <p class="description">{{ funding.postContent }}</p>
					      <div class="progress-bar">
					        <div class="progress" :style="{ width: funding.progress + '%' }"></div>
					      </div>
					      <div class="info">
					        <div>
					          <span class="value">{{ funding.fundGoal }}원</span>
					          <span class="label">목표금액</span>
					        </div>
					        <div>
					          <span class="value">{{ getTimeDiff(funding) }}</span>
					          <span class="label">남은 기간</span>
					        </div>
					        <div>
					          <span class="value">{{ funding.fundSponsorCount }}명</span>
					          <span class="label">서포터</span>
					        </div>
					      </div>
					    </div>
					  </div>
					</div>
					
				</div>	
				
				
				
					  <!-- 
				<c:forEach var="fundPostDto" items="${fundList}">
				${fundPostDto}<br>
				</c:forEach>
				
  					-->
  					
  					
	<script src="https://unpkg.com/vue@3.2.36"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script>
        Vue.createApp({
            //데이터 설정 영역
            data(){
                return {
                    //화면에서 사용할 데이터 선언
                    fund:{
                        fundPrice:"",
                        fundNo: "",
                        postNo: "",
                        memberId: memberId,
                        fundName: "",
                        fundTime: ""
                    },
                };
            },
            computed:{
            },
            methods:{
                             	//글 번호를 가져온다
                setPostNo() {
                	var params = new URLSearchParams(location.search);
                	var postNo = params.get("postNo");
                	this.fund.postNo = postNo;
                	console.log(this.fund.postNo);
                }
            },
            created() {
            	this.setPostNo();
            }
        }).mount("#app");
    </script>
			
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
		
