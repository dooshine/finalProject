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
		
<%-- 		<c:forEach var="fundPostDto" items="${fundList}"> --%>
<%-- 			${fundPostDto}<br> --%>
<%-- 		</c:forEach> --%>


		  <div id="app">
        		 <div class="container rounded p-3" style="background-color:white;">
	
					  <div class="funding-list justify-content-center mt-5">
					  
					    <div class="funding-item" v-for="(funding, index) in fundings" :key="funding.memberId"
					    									v-on:click="link(funding)">
					      <img :src="getImageUrl(funding)" alt="Funding Image">
					      <h3 class="title">{{ funding.fundTitle }}</h3>
					      <p class="description">{{ funding.fundShortTitle }}</p>
					      <div class="progress-bar">
					        <div class="progress" :style="{ width: funding.progress + '%' }"></div>
					      </div>
					      <div class="info">
					        <div>
							<span style="font-weight:bold">
							{{ (funding.totalPrice / funding.fundGoal * 100).toFixed(1) }}
							</span>%
					          <span class="fund_span">{{ formatCurrency(funding.totalPrice) }}</span>원
					        </div>
					        <div>
					          <span class="value">{{ getTimeDiff(funding) }}</span>
					        </div>
					      </div>
					    </div>
					  </div>
					</div>
					
				</div>	
  					
		<script src="https://unpkg.com/vue@3.2.36"></script>
	    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
	    
		<script>
		 Vue.createApp({
	            //데이터 설정 영역
	            data(){
            	   return{
            		// 목록을 위한 데이터
       		    	percent: 0,
       		    	page: 1,
       		    	finish: false,
			        fundings: [],
			        // 무한스크롤 안전장치
			        loading: false,
	            	};
	            	},
            	computed: {
            	},
            	methods: {
	           		// FundPostImageDto 불러오기
	           		async loadFundPostImageList(){
	           			if(this.loading == true) return; // 로딩중이면
	                       if(this.finish == true) return; // 다 불러왔으면
	                       
	                       this.loading = true;
	                       
						const resp = await axios.get("http://localhost:8080/rest/fund/page/"+this.page)	  
						console.log(resp.data);
						this.fundings.push(...resp.data);
						this.page ++;
						
						this.loading = false;
						
						// 데이터가 10개 미만이면 더 읽을게 없다
	                    if(resp.data.length < 10){ 
	                        this.finish = true;
	                    }
						
	           		},
	           		getTimeDiff(funding) {
	           			const startDate = new Date(funding.postStart);
	           		      const endDate = new Date(funding.postEnd);
	           		      const timeDiff = endDate.getTime() - startDate.getTime();
	           		      if (timeDiff >= 24 * 60 * 60 * 1000) {
	           		        // 1일 이상인 경우
	           		        return Math.ceil(timeDiff / (24 * 60 * 60 * 1000))+"일 남음";
	           		      } else {
	           		    	// 1일 미만인 경우
	           		          return "오늘마감";
	           		        }
	           		},
	           		getProgress(funding) {
	           			
	           		},
	           		link(funding){
	           			console.log(funding.postNo)
	           			const url = "/fund/detail?postNo="+funding.postNo;
	           			window.location.href = url;
	           		},
	           		getImageUrl(funding) {
	           		      if (funding.attachmentNo === null) {
	           		        return "https://via.placeholder.com/150x150";
	           		      } else {
	           		        return "/rest/attachment/download/" + funding.attachmentNo;
	           		      }
	          		    },
	          		    
	          		 	// 3자리 마다 ,
	      		      	formatCurrency(value) {
	      		            return value.toLocaleString();
	      	          	},
	           	},
	           	watch: {
	                // percent가 변하면 eprcent의 값을 읽어와서 80% 이상인지 판정
	                percent(){
	                    if(this.percent >= 80) {
	                        // console.log("데이터를 불러올 때가 된거 같아");
	                        this.loadFundPostImageList();
	                    }
	                }
	            },
	            mounted() {
	            	window.addEventListener("scroll", _.throttle(()=>{
	                    // - 현재 스크롤의 위치(window.scrollY)
	                    // - 브라우저의 높이(window.innerHeight)
	                    // - ScreenFull.js나 Rallax.js 등 라이브러리 사용 가능
	                    const height = document.body.clientHeight - window.innerHeight;
	                    const current = window.scrollY;
	                    const percent = (current/ height) * 100;
	                    // console.log("percentage = " + Math.round(percent)+"%");

	                    // data의 percent를 계산된 값으로 갱신
	                    this.percent = Math.round(percent);
	                },250));
	            },
	           	created() {
	           		this.loadFundPostImageList();
	           	}
	  		}).mount("#app");


		</script>

		
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
		
