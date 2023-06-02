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
		.grey-f5f5f5{
    	background-color: 	#f5f5f5;
    	}
		
    </style>
    
   	<div id="app">
		<div class="custom-container">
			  
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
	
		<hr>
			<!-- 태그 출력 -->
			<div class="row mt-3">
				<div class="col">
					<button class="btn btn-primary" v-for="(tag, i) in fundDetail.tagNames"
								@click="tagLink(i)">
					{{ tag }}
					</button>
				</div>
			</div>
		</div>
		
		<hr>
		
	<!-- ------------------------ 댓글 ------------------------------- -->

	<!-- 댓글창 -->
	  <div v-if="replies.length == 0" >댓글이 없습니다.</div>
	  <div v-else class="p-3">
	      <div v-for="(reply, i) in replies" :key="reply.replyNo">
	         
	        <!-- 최상위 댓글이면 -->
	        <div v-if="reply.replyNo == reply.replyGroupNo">
	        
		        	<div class="d-flex">
		        		{{ reply.replyId }}
		        		<i class="fs-5 text-secondary ti ti-dots-vertical ms-auto me-3"
		        				@click="showModal(i)" style="position: relative;">
		        				<div class="custom-modal" v-if="replies[i].modal" style="position: absolute; top: 0px; right: 0px; width:100px; ">
							        <div class="custom-modal-header">
							            <button type="button" @click="hideModal(i)" class="btn-close" style="position: absolute; top: 5px; right: 5px; height: 5px; width: 5px;"></button>
							        </div>
							        <div @click="hideModal(i)" class="custom-modal-body p-0" style="font-size: 16px;">
							        	<div class="p-2" style=" border-bottom: 0.3px solid #dee2e6;" @click="replies[i].reReply=true;">댓글달기</div>
							        	<div class="p-2"  style=" border-bottom: 0.3px solid #dee2e6;" @click="replies[i].edit=true;">수정</div>
							        	<div class="p-2"  style=" border-bottom: 0.3px solid #dee2e6; ">삭제</div>
							        </div>
							    </div>
		        		</i>
		        	</div>
		        	
					
					<!-- 최상위 댓글 내용 -->
	        		<div v-if="reply.edit == false" class="row grey-f5f5f5 rounded-3 font-gray2 mx-0 ps-3" 
	        				:style="{ width: reply.replyId.length * 11 + 'px' }">
		        		{{ reply.replyContent }}
	        		</div>
	        		<div v-else>
	        			<textarea  @blur="setUpdateReplyObj($event, i)" class="row grey-f5f5f5 rounded-3 font-gray2 mx-0 ps-3" 
	        				:style="{ width: reply.replyId.length * 11 + 'px' }">{{ reply.replyContent }}</textarea>
	        			<button @click="saveUpdate(i)">수정</button>
	        			<button @click="replies[i].edit = false;">취소</button>
	        		</div>
	        		
		        	<div v-if="reply.reReply" >
		        		<textarea @blur="setReReplyObj($event, i)" placeholder="대댓글 내용"></textarea>
			        	<button @click="addReReply(i)">작성</button>
			        	<button @click="reReplies[i] = false">취소</button>
		        	</div>
	        	
	        </div>
	        
	        <!-- 대댓글이면 -->
	        <div v-else>
	        	<!-- 수정 폼 -->
	        	<div v-if="updateReplyObj.index == i">
	        		<div>
		        		{{reply.replyId}} :<br>
				    	<textarea @blur="setUpdateReplyObj($event, i)" 
				    	placeholder="수정 내용">{{ reply.replyContent }}</textarea>
					    <button @click="saveUpdate(i)">저장</button>
					    <button @click="cancelUpdate()">취소</button>
	        		</div>
				</div>
				
				<div class="custom-modal" v-if="reply.modal == true">
			        <div class="custom-modal-header">
			            헤더
			            <button type="button" class="btn-close"></button>
			        </div>
			        <div class="custom-modal-body">바디</div>
			        <div class="custom-modal-footer">푸터</div>
			    </div>
								
				<!-- 대댓글 내용 -->
				<div v-else class="ms-4">
					<div class="d-flex">
						{{reply.replyId}}
						<i class="fs-5 text-secondary ti ti-dots-vertical ms-auto me-3" 
						data-toggle="dropdown"></i>
					</div>
					<div>
						<div class="row grey-f5f5f5 rounded-3 font-gray2 mx-0 ps-3"
								:style="{ width: reply.replyId.length * 11 + 'px' }">
						 {{ reply.replyContent }}
						</div>
						<textarea v-if="reply.edit == true" class="row grey-f5f5f5 rounded-3 font-gray2 mx-0 ps-3"
								:style="{ width: reply.replyId.length * 11 + 'px' }">{{ reply.replyContent }}</textarea>
		        		<!-- 대댓글 버튼 -->
			        	<button v-if="reply.replyNo == reply.replyGroupNo" 
			        			@click="showRereplyForm(i)">
			        		<i class="fa-solid fa-reply"></i>
						</button>
						<!-- 수정 버튼 -->
			        	<button v-if="reply.replyId == replyObj.replyId"
								@click="showUpdateForm(i)">
			        		<i class="fa-solid fa-edit"></i>
			        	</button>
			        	<!-- 삭제 버튼 -->
			        	<button v-if="reply.replyId == replyObj.replyId"
								@click="deleteReply(i)">
							<i class="fa-solid fa-trash-alt"></i>
						</button>	
					</div>
				</div>
				<!-- 대댓글 내용 끝 -->
				
	        </div>
	        
	        <!-- 대댓글 폼 -->
	        <div v-if="reReplies[i] == true">
	        	<textarea @blur="setReReplyObj($event, i)" placeholder="대댓글 내용"></textarea>
	        	<button @click="addReReply(i)">작성</button>
	        	<button @click="reReplies[i] = false">취소</button>
	        </div>
	        <!-- 대댓글 폼 끝 -->
	        
	      </div>
 	 </div>
	</div>             
		
 	 
 	 <hr>
 	 
	  	<!-- 새댓글 폼 -->
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
		          tagNames: [],
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
		        // 대댓글 객체
		        reReplyObj: {
		          replyId: memberId,
		          replyContent: "",
		          postNo:"",
		          replyGroupNo: "",
			        },
			    // 수정댓글 객체
			   	updateReplyObj: {
				  index: -1,
				  replyNo: "",
				  replyContent: "",
			   	},
			   	// 댓글 설정 모달
			   	modal: null,
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
					this.fundDetail = { ...this.fundDetail, ...resp.data };
        		},
        		// postNo의 attachmentNo list 불러오기 
        		async loadAttachNos(){
        			const postNo = this.fundDetail.postNo;
					const resp = await axios.get("http://localhost:8080/rest/fund/attaches/"+postNo)	  
					this.fundDetail.attachmentNos.push(...resp.data);
        		},
        		async loadTagNames() {
        			const postNo = this.fundDetail.postNo;
        			const resp = await axios.get("/rest/fund/tag/"+postNo);
        			this.fundDetail.tagNames.push(...resp.data);
        		},
		       // fundTotal & fundSponsorCount 불러오기
        		async loadFundVO(){
			    	const postNo = this.fundDetail.postNo;
					const resp = await axios.get("http://localhost:8080/rest/fund/fundlist/"+postNo)	  
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
	                
	                // 모달 토글 false 초기화
	                for(let i = 0; i<this.replies.length; i++){
	                	this.replies[i].modal = false;
	                	this.replies[i].edit = false;
	                	this.replies[i].reReply = false;
	                }
	              },
	            // 작성한 comment 서버로 전송
                async addReply() {
	            	if(this.replyObj.replyId == "") return;
	              this.replyObj.postNo = this.fundDetail.postNo;
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
					reReplyObj.replyContent = event.target.value;3
					// 대댓글 그룹 설정
// 					this.reReplyObj.replyGroupNo = parentReplyNo;
					reReplyObj.replyGroupNo = this.replies[index].replyGroupNo;
					console.table(reReplyObj);
					this.reRepliesObjList[index] = reReplyObj;
				},
				// 댓글 삭제
				async deleteReply(i){
					const replyNo = this.replies[i].replyNo;
					const resp = await axios.delete("http://localhost:8080/rest/reply/fund/"+replyNo);
					this.loadReplies();
				},
				
				// 수정하려는 댓글의 인덱스와 내용을 updateReply객체에 저장 
				setUpdateReplyObj($event, i) {
					this.replies[i].edit = false; // 켜져있는 대댓글 작성폼 닫기
					this.updateReplyObj.index = i;
					this.updateReplyObj.replyNo = this.replies[i].replyNo;
					this.updateReplyObj.replyContent = event.target.value;
				},
				// 댓글 수정
				async saveUpdate(i) {
					// 수정된 댓글 서버로 전송 
					const resp = await axios.put("http://localhost:8080/rest/reply/fund/", 
													this.updateReplyObj);
					// 수정된 데이터 저장 
					this.replies[i].replyContent = this.updateReplyObj.replyContent;
					// 수정폼 닫기
					this.cancelUpdate();
				},
				cancelUpdate() {
					// 수정 폼 닫고 updatedReply 객체 초기화 
					this.updateReplyObj.index = -1;
					this.updateReplyObj.replyNo = "";
					this.updateReplyObj.replyContent = "";
				},
				// 대댓글 폼 보여주기 & 수정 폼 숨기기
				showRereplyForm(i) {
					this.reReplies[i] = true
					this.cancelUpdate();
				},
				// 수정 폼 보여주기 & 대댓글 폼 숨기기
				showUpdateForm(i) {
					this.updateReplyObj.index = i
					this.reReplies[i] = false;
				},
				// 태그 클릭시 
				tagLink(i){
					console.log(this.fundDetail.tagNames[i]);
					const url = ""
					window.location.href = url;
				},
				// 모달 열기&닫기
				showModal(i){
					this.replies[i].modal = true;
                },
                hideModal(i){
                	event.stopPropagation();
                	this.replies[i].modal = false;
                },
                
                
		      	
		    },
		    created() {
		    	  this.setPostNo();
		    	  this.loadFundPosts();
		    	  this.loadAttachNos();
		    	  this.loadFundVO();
		    	  this.loadReplies();
		    	  this.loadTagNames();
		    	},
		    mounted() {
		    	}
		  }).mount("#app");
		</script>

	
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	