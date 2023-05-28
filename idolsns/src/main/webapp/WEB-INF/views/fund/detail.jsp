<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

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
    
        .fund_label {
        	color: gray;
			width:100%;
			font-size: 80%;
			padding-left:1em;
		}
		
		.fund_span {
			font-size: 30px;
			padding-left:0.5em;
			
		}
	

		.like-btn {
		  
		}
		
		.like-count {
		  font-size: 14px;
		  color: #777;
		  
		}
		
    </style>
    
   	<div id="app">
		<div class="container rounded p-3" style="background-color:white">
			  
		<div>
			<h2 class="title text-center mt-5 mb-5">{{ fundDetail.fundTitle }}</h2>
		</div>
			
		
		<img :src="fundDetail.imageURL" alt="예시사진">
			
		
		<div>

			<label>모인 금액</label>
			<span class="fund_span">{{ formatCurrency(fundDetail.fundTotal) }}</span>원
			<span style="font-weight:bold">{{ (fundDetail.fundTotal / fundDetail.fundGoal * 100).toFixed(1) }}</span>%
	
		
	
			<label>남은 시간</label>
			<span class="fund_span">{{ getTimeDiff }}</span>일
		

			<label>후원자</label>
			<span class="fund_span">{{ fundDetail.fundSponsorCount }}</span>명

		
		</div>
		
		<div class="d-flex row mt-3" style="padding-left: 1em">
		
			<hr>
		
			<div>목표 금액</div>
			<div>{{ formatCurrency(fundDetail.fundGoal) }}원</div>
			<br>
			
			<div>펀딩 기간		</div>
			<div>{{ fundDetail.postStart }} ~ {{ fundDetail.postEnd }}</div>
			
			<div >결제</div>
			<div>{{ fundDetail.postEnd }} 결제 진행</div>
			
		
			<div class="row mt-3" style="padding-left: 1em">
			    <button class="btn btn-primary like-btn">
			      <i class="fa fa-heart"></i> 
			      <!-- {{ likeCount }}  -->
			    </button>
	
		
				 <button class="btn btn-primary share-btn">
			      <i class="fa fa-share"></i>
			      <!-- {{ likeCount }}  -->
			    </button>
		
			
				<button type="submit" class="btn btn-primary" @click="order">
				후원하기</button>
			</div>	
					
			<div class="row mt-3" style="padding-left: 1em">
				<div v-html="fundDetail.postContent"></div>
			</div>
					
		</div>
	</div>             
	<hr>
	
	  <h3>댓글</h3>
	  <div v-if="replies.length === 0">댓글이 없습니다.</div>
	  <div v-else>
	    <ul>
	      <li v-for="(reply, i) in replies" :key="reply.replyNo">
	        <div>{{ reply.replyId }}: {{ reply.replyContent }}</div>
	        {{reply.replyNo}}<br>
	        {{reply.replyGroupNo}}
	        <button v-if="reply.replyNo == reply.replyGroupNo" @click="reReplies[i] = true">대댓글달기</button>
	        <div v-if="reReplies[i] == true">
	        	<textarea @blur="setReReplyObj($event, i)">대댓글</textarea>
	        	<button @click="addReReply(i)">작성</button>
	        	<button @click="reReplies[i] = false">취소</button>
	        </div>
	      </li>
	    </ul>
	  </div>
	  	<form @submit.prevent="addReply">
	    <div>
	      <input type="hidden" v-model="replyObj.replyId" required>
	      <input type="hidden" v-model="replyObj.postNo" required>
	    </div>
	    <div>
	      <textarea type="text" v-model="replyObj.replyContent" placeholder="댓글 내용" required></textarea>
	    </div>
	    <div>
	      <button type="submit">댓글 작성</button>
	    </div>
    	</form>
	</div>
	
				
				
			
			
				
			
			
    <script src="https://unpkg.com/vue@3.2.36"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
			
	
		
		<script>
		  Vue.createApp({
		    data() {
		      return {
		        fundDetail: {
		          fundPrice: "",
		          fundNo: "",
		          postNo: "",
		          memberId: memberId, // memberId를 Vue 데이터에 추가하고, 값을 바인딩합니다.
		          fundTime: "",
		          attachmentNos: [],
		          attachmentNo: "",
		          fundTitle: "",
		          postStart: "",
		          postEnd: "",
		          postTime: "",
		          fundGoal: "",
		          fundSponsorCount: "",
		          fundState: "",
		          postType: "",
		          postContent: "",
		          imageURL: "",
		          fundTotal: "",
		        },
		        replies: [],
		        // 댓글창 보여주기
		        reReplies: [],
		        reRepliesObjList: [],
		        replyObj: {
		          replyId: memberId,
		          replyContent: "",
		          postNo:"",
		        },
		        reReplyObj: {
			          replyId: memberId,
			          replyContent: "",
			          postNo:"",
			          replyGroupNo: "",
			        }
		      };
		    },
		    computed: {
		    	getTimeDiff() {
        			const startDate = new Date(this.fundDetail.postStart);
        		      const endDate = new Date(this.fundDetail.postEnd);
        		      const timeDiff = endDate.getTime() - startDate.getTime();
        		      if (timeDiff >= 24 * 60 * 60 * 1000) {
        		        // 1일 이상인 경우
        		        return Math.ceil(timeDiff / (24 * 60 * 60 * 1000))+"일";
        		      } else {
        		    	// 1일 미만인 경우
        		          const currentDate = new Date();
        		          const endOfDay = new Date(currentDate.getFullYear(), currentDate.getMonth(), currentDate.getDate(), 23, 59, 59);
        		          const remainingTime = endOfDay.getTime() - currentDate.getTime();
        		          const remainingHours = Math.floor(remainingTime / (60 * 60 * 1000));
        		          const remainingMinutes = Math.floor((remainingTime % (60 * 60 * 1000)) / (60 * 1000));
        		          const remainingSeconds = Math.floor((remainingTime % (60 * 1000)) / 1000);
        		          return remainingHours+"시간";
        		        }
        		},
		    },
		    methods: {
				// postNo 설정		    	
			    setPostNo() {
			      const params = new URLSearchParams(location.search);
			      const postNo = params.get("postNo");
			      this.fundDetail.postNo = postNo;
			    },
			    // FundPostListDto 불러오기
			    async loadFundPosts(){
			    	const postNo = this.fundDetail.postNo;
					const resp = await axios.get("http://localhost:8080/rest/fund/"+postNo)	  
					console.log(resp);
					this.fundDetail = { ...this.fundDetail, ...resp.data };
        		},
        		// postNo의 attachmentNo list 불러오기 
        		async loadAttachNos(){
        			const postNo = this.fundDetail.postNo;
					const resp = await axios.get("http://localhost:8080/rest/fund/attaches/"+postNo)	  
					this.fundDetail.attachmentNos.push(...resp.data);
        		},
		       // fundTotal & fundSponsorCount 불러오기
        		async loadFundVO(){
			    	const postNo = this.fundDetail.postNo;
					const resp = await axios.get("http://localhost:8080/rest/fund/fundlist/"+postNo)	  
					console.log(resp);
					this.fundDetail.fundTotal = resp.data.fundTotal;
					this.fundDetail.fundSponsorCount = resp.data.fundSponsorCount;
        		},
        		
                // 데이터 중 fund를 서버로 전송
		      	order() {
		      	  const postNo = this.fundDetail.postNo; // Vue 데이터의 postNo 값을 사용
		      	  window.location.href = "http://localhost:8080/fund/order?postNo=" + postNo;
		      	},
		      	
		      	// 3자리 마다 ,
		      	formatCurrency(value) {
		            return value.toLocaleString();
	          	},
	          	// replies 불러오기
	          	async loadReplies() {
	                const postNo = this.fundDetail.postNo; // 게시물 번호
	                const resp = await axios.get("http://localhost:8080/rest/reply/fund/"+postNo);
	                this.replies = resp.data; // Vue data에 저장
	              },
	            // 작성한 comment 서버로 전송
                async addReply() {
	            	if(this.replyObj.replyId == "") return;
				  const resp = await axios.post("http://localhost:8080/rest/reply/fund", 
						  										this.replyObj);
				  this.replyObj.replyContent = ""; // 내용 초기화
				  this.loadReplies(); // 댓글목록 다시 불러옴
				},
				// 대댓글 작성
                async addReReply(i) {
	            	if(this.reRepliesObjList[i].replyId == "") return;
				   const resp = await axios.post("http://localhost:8080/rest/reply/fund", 
						  										this.reRepliesObjList[i]);
				   // 댓글창 지우기
				   this.reReplies[i] = false
				   this.loadReplies(); // 댓글목록 다시 불러옴
				},
				
				// 대댓글Obj 데이터 반영
				setReReplyObj(event, index){
					const reReplyObj = {
							 replyId: memberId,
					         replyContent: "",
					         postNo:"",
					         replyGroupNo: "",
					}
					// 대댓글 펀딩게시물 번호 설정					
					reReplyObj.postNo = this.fundDetail.postNo;
					// 대댓글 내용 설정
// 					this.reReplyObj.replyContent = event.target.value;
					reReplyObj.replyContent = event.target.value;
					// 대댓글 그룹 설정
// 					this.reReplyObj.replyGroupNo = parentReplyNo;
					reReplyObj.replyGroupNo = this.replies[index].replyGroupNo;
					console.table(reReplyObj);
					this.reRepliesObjList[index] =  reReplyObj;
				}
		      	
		    },
		    created() {
		    	  this.setPostNo();
		    	  this.loadFundPosts();
		    	  this.loadAttachNos();
		    	  this.loadFundVO();
		    	  this.loadReplies();
		    	  this.replyObj.postNo = this.fundDetail.postNo;
		    	},
		    mounted() {
		    	}
		  }).mount("#app");
		</script>

	
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	