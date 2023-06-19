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
           
         	#calendar {
		  		display: none;
		  	}
			.col-3.calendar-area {
				width: 0%;
			}
			.col-6.article {
				width: 85%;
			}
			.col-3.left-aside {
				width: 15%;
			}
			#aside-bar {
				width: 15%;
			}

			.nav .aside-name-tag {
				/* font-size: 0px; */
				display: none;
		  	}
			.nav img {
				margin-left: 0px !important;
			}
			.nav a {
				text-align: center;
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
           overflow: hidden;
           /* 하트 고정 */
           position: relative;
         }
         
         .heart-icon {
         	position: absolute;
         	top: 175px; 
         	right: 20px;
         	transform: scale(1.1); /* 하트 크기 조정 */
         	color: #6A53FB;
         }
         
         
         /*펀딩 이미지 컨테이너*/
         
         	.image-container {
		/* 	  width: 300px; */
			  height: 200px; 
			  overflow: hidden;
			}

			.image-container img {
			  width: 100%;
			  height: 100%;
			  object-fit: cover;
			  transition: transform 0.3s;
			  border-radius: 5px;
			}

			.funding-item:hover .image-container img {
			  transform: scale(1.05);
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
            background-color: #6A53FB;
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
            
         /* 로그인 모달 스타일*/
	      .custom-modal-wrapper {
		   position: fixed;
		   top: 0;
		   left: 0;
		   width: 100%;
		   height: 100%;
		   display: flex;
		   align-items: center;
		   justify-content: center;
		   z-index: 9999;
		}
		
      </style>
      
        <div id="app">
        	<div class="custom-container">
		
			
			
		<div class="d-flex col rounded-4 bg-light p-3 mt-3 mb-3" style="width:100%; height:300px; float: none;
			background-image: url('${pageContext.request.contextPath}/static/image/fund_main.jpg'); background-size: cover; background-position: center;">
			    <div class="mx-5" style="display: flex; flex-direction: column; justify-content: center; align-items: left; text-align: left;">
			        <div class="font-bold" style="font-size:35px; color:white;">
			            내 손으로 만드는 아이돌 이벤트!
			        </div>
			        <!-- 펀딩 글 작성 -->
			        <div class="mt-3">
			        <button class="custom-btn btn-round btn-purple1" style="font-size:20px;" @click="startFunding">
			        	프로젝트 올리기
			        </button>
			        </div>
		    </div>
		</div>
						
				
			
			<div class="d-flex mt-4 px-2 justify-content-between">
				<div class="d-flex align-items-center">
		    		<!-- 검색 조건1 -->           
					<div class="me-2">
						<select class="form-select" v-model="selectedValue1" @change="updateOrderList1">
						  	<option value="post_time desc" selected>최신순</option>
						  	<option	value="post_time asc">오래된순</option>
						  	<option value="total_price desc">후원금액↑</option>
						  	<option value="total_price asc">후원금액↓</option>
						</select>
					</div>
					<!-- 검색 조건2 -->
					<div>
						<select class="form-select" v-model="selectedValue2" @change="updateOrderList2">
						  	<option value="" selected>진행상태</option>
						  	<option value="">전체</option>
						  	<option value="1">펀딩완료</option>
						  	<option value="2">펀딩진행중</option>
						</select>
					</div>
				</div>
	            <!-- 검색창 -->
             	<div class="search-box me-2 ">
                  <input class="search-input" type="text" v-model="searchQuery" placeholder="검색" 
                  @keyup.enter="fetchOrderedFundingList" @input="finish=false">
             	</div>
		          
			</div>
	             	
               	
               	<!-- 펀딩 리스트 -->
                 <div class="funding-list justify-content-center mt-4">
                 
                   <div class="funding-item" v-for="(funding, index) in fundings" :key="index"
                                              @click="link(funding)" >
                     <div class="image-container">
                     	<img :src="getImageUrl(funding)" alt="Funding Image" style="height:200px;">
                     </div>
                     
                     <!-- 좋아요 -->
                     <span class="heart-icon" v-if="postLikeIndexList.includes(index)">
					      <i class="fs-4 ti ti-heart-filled" @click="checkLike(funding.postNo, index); $event.stopPropagation()"></i> 
                     </span>
                     <span class="heart-icon" v-else>
					      <i class="fs-4 ti ti-heart" @click="checkLike(funding.postNo, index); $event.stopPropagation()"></i> 
                     </span>
                     <!-- 좋아요 끝! -->
					    
                     
                     <h3 class="title">{{ funding.fundTitle }}</h3>
                     <p class="description">{{ funding.fundShortTitle }}</p>
                     <div class="progress-bar">
                       	<div class="progress" :style="{ width: (funding.totalPrice / funding.fundGoal * 100).toFixed(1) + '%' }"></div>
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
                 <!-- 펀딩 리스트 끝! -->
                 
               </div>
               
               <!-- 로그인 모달 -->
		      <div v-if="loginModal" class="custom-modal-wrapper">
		      	<div class="custom-modal">
		         <div class="custom-modal-body" style="width: 300px;">
		            <div class="text-center mb-3">
		               <i class="ti ti-alert-triangle"></i>
		            </div>
		            <div class="text-center">로그인이 필요한 기능입니다</div>
		            <div class="d-flex justify-content-center mt-4">
		               <button class="custom-btn btn-round btn-purple1-secondary me-2 w-100" @click="linkToLogin">로그인</button>
		               <button class="custom-btn btn-round btn-purple1 w-100" @click="loginModal = false">취소</button>
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
                    searchPage: 1,
                    finish: false,
                 	fundings: [],
                 // 무한스크롤 안전장치
                	loading: false,
                 // 검색 키워드
                	searchQuery: "",
                	searchQueryTemp: "",
                	
                	// 정렬
                	selectedValue1: "post_time desc",
                	selectedValue2: "",
                	
                	orderList: "post_time desc",
                	fundState: "",
                	
                	
                	// 시간순 정렬 버튼
                	dateSort: false,
                	
                	// 로그인 모달
    			   	loginModal: false,
    			   	
    			   	// 세션 memberId
    			   	memberId: memberId,
    			   	
    			 	// 좋아요 게시글 인덱스 배열
                	postLikeIndexList: [], 
                	 
                  };
                  },
               computed: {
                  currentDate() {
                     return new Date().toISOString().split('T')[0];
                  }
                  
               },
               methods: {
            	   
           	   	// # 펀딩 리스트 불러오기
                  async fetchFundingList() {
           	   		if(this.finish) return;
           	   		
                  const resp = await axios.get(contextPath + "/rest/fund/page/"+this.searchPage,
                        {
                	  params: {
                		  	// 검색어
                        	searchKeyword : this.searchQuery,
                        	// 정렬 조건
                        	orderList : this.orderList,
                        	// 펀딩상태
                        	fundState: this.fundState
                        },
                        paramsSerializer: params => {
                    		return new URLSearchParams(params).toString();
                    	}
                        });     
               	  this.fundings.push(...resp.data);
               	  
               	  this.getLikePostIndex(this.fundings);
                  //console.log(resp.data);
                  this.searchPage++;
                  
                  // 데이터가 12개 미만이면 더 읽을게 없다
                       if(resp.data.length < 12){
                           this.finish = true;
                          }
                   },
                   
                   async fetchOrderedFundingList(){
                	   	if(this.finish) return;
                	   	  this.searchPage=1;
                	   	  
		                  const resp = await axios.get(contextPath + "/rest/fund/page/"+this.searchPage,
		                        {
		                	  params: {
		                		  	// 검색어
		                        	searchKeyword : this.searchQuery,
		                        	// 정렬 조건
		                        	orderList : this.orderList,
		                        	// 펀딩상태
		                        	fundState: this.fundState
		                        },
		                        paramsSerializer: params => {
		                    		return new URLSearchParams(params).toString();
		                    	}
		                        });
// 		                  console.log(resp.data);
		                  this.fundings = [...resp.data];
		                  this.searchPage++;
		                  
		                  // 데이터가 12개 미만이면 더 읽을게 없다
		                       if(resp.data.length < 12){
		                           this.finish = true;
		                          }
                   },
                   
                // 정렬 리스트 설정
                   updateOrderList1() {
                   	this.orderList = this.selectedValue1;
                   },
                   updateOrderList2() {
                   	this.fundState = this.selectedValue2;
                   },
                   
                // postNo를 List로 송신하고 좋아요 되있는 index 번호를 수신
                   getLikePostIndex(fundings){
                   	postNoList = [];
                   	fundings.forEach(function(funding){
                   		postNoList.push(funding.postNo); 
                   	})
                   	
               		axios.get(contextPath + '/rest/fund/like/index/'+postNoList)
               			.then(response => {               			
               			this.postLikeIndexList = response.data;  
               			//console.log("postLikeIndexList--------"+this.postLikeIndexList);
               		})
               		.catch(error => {
               			console.error(error);
               		})
                   	              		
                   },
                    
                    // 남은 시간 설정
                    getTimeDiff(funding) {
                          const startDate = new Date(funding.postStart);
                          const endDate = new Date(funding.postEnd);
                          endDate.setHours(23, 59, 0, 0); // endDate를 23:59:00.000으로 설정
//                           console.log(startDate);
//                           console.log(endDate);
                          const currentDate = new Date();
                          const fundState = funding.fundState;
                          const timeDiff = endDate.getTime() - currentDate.getTime();
                          const timeDiff2 = startDate.getTime() - currentDate.getTime();
                          
                          // 시작날짜가 오늘보다 뒤인경우
                          if(timeDiff2 >= 0) {
                        	  return "D-"+Math.ceil(timeDiff2 / (24 * 60 * 60 * 1000));
                          }
                          // 마간기간이 남은 경우
                          if(timeDiff >= 0){
	                          // 1일 이상인 경우
	                          if (timeDiff >= 24 * 60 * 60 * 1000) {
	                            return Math.ceil(timeDiff / (24 * 60 * 60 * 1000))+"일 남음";
	                          } 
	                          // 당일인 경우
	                          else {
	                              return "오늘 마감";
	                          }
                          }
                          // 이미 마감된 경우
                          else {
                        	  return fundState;
                          }
                    },
                    
                    // 상세페이지로 이동
                    link(funding){
                       window.location.href = contextPath + "/fund/detail?postNo="+funding.postNo;;
                    },
                    getImageUrl(funding) {
                       const imageUrl = contextPath + "/rest/attachment/download/" + funding.attachmentNo;
                       return imageUrl;
                       },
                       
                    // 3자리 마다 ,
                     formatCurrency(value) {
                        return value.toLocaleString();
                      },
                      
                      // 펀딩 글쓰기로 이동
                      startFunding() {
                    	  // if not logged in
                    	  if(!this.checkLogin()) return;
                    	  window.location.href = contextPath + "/fund/write";
                      },
                      
                   // 로그인 체크
      				checkLogin() {
                      	// 로그인이 안되어 있으면
      					if(this.memberId == "") {
      						this.loginModal = true;
      						return false
      					}
                      	// 되어있으면
      					else return true;
      				},
      				
      				// 로그인 페이지로
    				linkToLogin() {
    					window.location.href= contextPath + "/member/login";
    				},
    				
    				// 좋아요 체크 후 추가&삭제
//     				async checkLike(funding) {
//     					// 로그인이 안되어 있으면
//     					if(!this.checkLogin()) return;
    					
//     					const postNo = funding.postNo;
//     					axios.get(contextPath + '/rest/post/like/'+postNo)
//                 		.then(response => {
//                 			console.log("checkLike = " +response.data);
//                 			this.checkFundLike();
                			
                				
//                 		})
//                 		.catch(error => {
//                 			console.error(error);
//                 		})
    					
//     				},
    				// 좋아요 체크
    				async checkFundLike() {
    					const postNo = this.fundDetail.postNo;
    					const resp = await axios.get(contextPath + "/rest/post/like/check/"+postNo);
    					this.fundings.isLiked = resp.data;
    				},
    				// 아이디 접속해 있고, 좋아요 클릭시에 실행
                 	checkLike(postNo,index){
    					// if not logged in
    					if(!this.checkLogin()) return;
                    	axios.get(contextPath + '/rest/post/like/'+postNo)
                    		.then(response => {
                    			//console.log(response.data);
                    			// 응답이 좋아요면
                    			if(response.data== 'Like'){
                    				this.postLikeIndexList.push(index);                			
                    			}
                    			// 응답이 좋아요 취소면
                    			else if(response.data=='disLike'){
                    				this.postLikeIndexList.splice(this.postLikeIndexList.indexOf(index),1);
                    			}
                    			
                    				
                    		})
                    		.catch(error => {
                    			console.error(error);
                    		})
                    },
    				
                 },
                 watch: {
                   // percent가 변하면 percent의 값을 읽어와서 80% 이상인지 판정
                   percent(){
                       if(this.percent >= 80) {
                           // console.log("데이터를 불러올 때가 된거 같아");
//                            this.loadFundPostImageList();
                           this.fetchFundingList();
                       }
                   },
                   // 정렬하면
                   orderList() {
//                 	   this.fetchFundingList();
						this.finish = false;
						this.fetchOrderedFundingList();
                   },
                   fundState() {
                	   	this.finish = false;
						this.fetchOrderedFundingList();
                   },
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
                   },100));
               },
                 created() {
                    this.fetchFundingList();
                 }
           }).mount("#app");


      </script>

      
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>