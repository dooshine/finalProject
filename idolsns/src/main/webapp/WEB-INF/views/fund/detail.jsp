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
    	.author-badge {
		  display: inline-block;
		  background-color: #a294f9;
		  padding: 2px 5px;
		  border-radius: 10px;
		  color: white;
		  font-size: 13px;
		}
	    .reply-form {
        margin-top: 20px;
        background-color: #f9f9f9;
        padding: 20px;
        border-radius: 5px;
        position: relative;
	    }
	
	    .reply-form textarea {
	        width: calc(100% - 40px);
	        height: 100px;
	        border: none;
	        border-radius: 5px;
	        padding: 10px;
	        resize: none;
	        font-size: 16px;
	    }
	
	    .reply-form .submit-icon {
	        position: absolute;
	        bottom: 10px;
	        right: 10px;
	        color: #007bff;
	        font-size: 24px;
	        cursor: pointer;
	    }
		/* form 안에 버튼의 기본 스타일 제거 */
	    form button {
		  border: none;
		  background: none;
		  padding: 0;
		  margin: 0;
		  font: inherit;
		  color: inherit;
		  outline: none;
		  cursor: pointer;
		}
		/* textarea setting */
		textarea {
			resize: none;
			height: 100px;
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
			    <button class="btn btn-primary like-btn" @click="checkLike">
			      <i v-if="isLiked" class="fs-4 ti ti-heart-filled"></i> 
			      <i v-else class="fs-4 ti ti-heart"></i> 
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
		
	<!-- ------------------------ 댓글 ------------------------------- -->
	  <hr>
	  <div v-if="replies.length == 0">댓글이 없습니다.</div>
	  <!-- 댓글이 있으면 -->
	  <div v-else>
	      <div v-for="(reply, i) in replies" :key="reply.replyNo">
	         
	        <!-- 최상위 댓글이면 -->
	        <div v-if="reply.replyNo == reply.replyGroupNo" class="row">
	        	<!-- 프로필 이미지 -->
          		<div class="col-1">
       				<img class="img-fluid rounded-circle" src="/static/image/profileDummy.png">
          		</div>
          		
          		<div class="col-10 align-items-center">
          			<!-- 작성자면 작성자 표시 -->
	        		<div v-if="reply.replyId == fundDetail.memberId">
	        			<div class="d-flex">
						    <div>{{ reply.replyId }}</div>
	        				<div class="author-badge font-purple2">
							    <div class="">작성자</div>
						  	</div>
	        			</div>
	        		</div>
	        		<!-- 작성자가 아니면 -->
	        		<div v-else>
	        			{{ reply.replyId }}
	        		</div>
	        		
	        		<!-- 수정 폼 -->
		        	<div v-if="updateReplyObj.index == i" class="ms-3">
				    	<textarea @blur="setUpdateReplyObj($event, i)" class="row grey-f5f5f5 rounded-3 font-gray2 col-10" 
		       				placeholder="수정 내용">{{ reply.replyContent }}</textarea>
					    <button class="btn-purple2" @click="saveUpdate(i)">수정</button>
					    <button class="btn-purple2" @click="cancelUpdate()">취소</button>
					</div>
					<!-- 댓글 내용 -->
		        	<div v-else class="grey-f5f5f5 rounded-3 font-gray2 p-1 ps-3">
		        		{{ reply.replyContent }}
		        	</div>
        		</div>
        		
        		<div class="col-1">
        		
		        	<!-- 버튼 모달-->
		        	<div class="d-flex">
		        		<i class="fs-5 text-secondary ti ti-dots-vertical ms-auto me-3"
		        				@click="showModal(i)" style="position: relative;">
		   					<div class="custom-modal" v-if="replies[i].modal" style="position: absolute; top: 0px; right: 0px; width:100px; ">
						        <div class="custom-modal-header">
						            <button type="button" @click="hideModal(i)" class="btn-close" style="position: absolute; top: 5px; right: 5px; height: 5px; width: 5px;"></button>
						        </div>
						        <div @click="hideModal(i)" class="custom-modal-body p-0" style="font-size: 16px;">
						        	<!-- 대댓글 버튼 -->
						        	<div v-if="reply.replyNo == reply.replyGroupNo" class="p-2" style=" border-bottom: 0.3px solid #dee2e6;" @click="showRereplyForm(i)">댓글달기</div>
						        	<!-- 수정 버튼 -->
						        	<div v-if="reply.replyId == replyObj.replyId" class="p-2" style=" border-bottom: 0.3px solid #dee2e6;" @click="showUpdateForm(i)">수정</div>
						        	<!-- 삭제 버튼 -->
						        	<div v-if="reply.replyId == replyObj.replyId" class="p-2" style=" border-bottom: 0.3px solid #dee2e6;" @click="deleteReply(i)">삭제</div>
						        </div>
					    	</div>
		        		</i>
	        		</div>
        		
        		</div>
		        	
	        	
	        	
	        </div>
	        
	        <!-- 대댓글이면 -->
	        <div v-else class="ms-4 row">
	        	<!-- 프로필 이미지 -->
          		<div class="col-1">
       				<img class="img-fluid rounded-circle" src="/static/image/profileDummy.png">
          		</div>
          		
          		<div class="col-10 align-items-center">
          			
          			<!-- 작성자면 작성자 표시 -->
	        		<div v-if="reply.replyId == fundDetail.memberId">
	        			<div class="d-flex">
						    <div>{{ reply.replyId }}</div>
	        				<div class="author-badge font-purple2">
							    <div class="">작성자</div>
						  	</div>
	        			</div>
	        		</div>
	        		<!-- 작성자가 아니면 -->
	        		<div v-else>
	        			{{ reply.replyId }}
	        		</div>
	        		
          			<!-- 수정 폼 -->
		        	<div v-if="updateReplyObj.index == i">
				    	<textarea @blur="setUpdateReplyObj($event, i)" class="row grey-f5f5f5 rounded-3 font-gray2 mx-0 ps-3 col-10" 
		       				placeholder="수정 내용">{{ reply.replyContent }}</textarea>
					    <button class="btn-purple2" @click="saveUpdate(i)">저장</button>
					    <button class="btn-purple2" @click="cancelUpdate()">취소</button>
					</div>
					<!-- 대댓글 내용 -->
					<div v-else class="col-10 grey-f5f5f5 rounded-3 font-gray2 p-1 ps-3">
							{{ reply.replyContent }}
					</div>
          		</div>
          		
          		<div class="col-1">
          		
		        	<!-- 버튼 모달 -->
		        	<div v-if="reply.replyId == replyObj.replyId" class="d-flex">
	        		<i class="fs-5 text-secondary ti ti-dots-vertical ms-auto me-3"
	        				@click="showModal(i)" style="position: relative;">
	   					<div class="custom-modal" v-if="replies[i].modal" style="position: absolute; top: 0px; right: 0px; width:100px; ">
					        <div class="custom-modal-header">
					            <button type="button" @click="hideModal(i)" class="btn-close" style="position: absolute; top: 5px; right: 5px; height: 5px; width: 5px;"></button>
					        </div>
					        <div @click="hideModal(i)" class="custom-modal-body p-0" style="font-size: 16px;">
					        	<!-- 대댓글 버튼 -->
					        	<div v-if="reply.replyNo == reply.replyGroupNo" class="p-2" style=" border-bottom: 0.3px solid #dee2e6;" @click="showRereplyForm(i)">댓글달기</div>
					        	<!-- 대댓글 수정 버튼 -->
					        	<div v-if="reply.replyId == replyObj.replyId" class="p-2" style=" border-bottom: 0.3px solid #dee2e6;" @click="showUpdateForm(i)">수정</div>
					        	<!-- 대댓글 삭제 버튼 -->
					        	<div v-if="reply.replyId == replyObj.replyId" class="p-2" style=" border-bottom: 0.3px solid #dee2e6;" @click="deleteReply(i)">삭제</div>
					        </div>
				    	</div>
	        		</i>
	        		</div>
          		</div>
        		
	        	
	        </div>
	        
	        <!-- 대댓글 폼 -->
	        <div v-if="reReplies[i] == true" class="ms-5">
	        	<textarea @blur="setReReplyObj($event, i)" placeholder="댓글을 작성해주세요" 
	        	class="row grey-f5f5f5 rounded-3 font-gray2 mx-0 ps-3"></textarea>
	        	<button class="btn-purple2" @click="addReReply(i)">작성</button>
	        	<button class="btn-purple2" @click="reReplies[i] = false">취소</button>
	        </div>
	        
	      </div>
 	 </div>
 	 
 	 <hr>
 	 
	  	<!-- 새댓글 폼 -->
	<form @submit.prevent="addReply" class="reply-form">
	    <div>
	        <input type="hidden" v-model="replyObj.replyId" required>
	        <input type="hidden" v-model="replyObj.postNo" required>
	    </div>
	    <div>
	        <textarea type="text" v-model="replyObj.replyContent" placeholder="글을 작성해주세요" required></textarea>
	    </div>
	    <div class="submit-icon">
	    	<button type="submit" style="none;">
		        <i class="fa-sharp fa-solid fa-pen font-purple1"></i>
	    	</button>
	    </div>
	</form>
    	
	</div>
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
			   	
			   	// 좋아요 유무
			   	isLiked : false,
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
	               	console.log(resp.data);
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
					reReplyObj.replyContent = event.target.value;
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
					this.reReplies[i] = false // 켜져있는 대댓글 작성폼 닫기
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
				
				// 좋아요 체크 후 추가&삭제
				async checkLike() {
					const postNo = this.fundDetail.postNo;
					axios.get('http://localhost:8080/rest/post/like/'+postNo)
            		.then(response => {
            			console.log(response.data);
            			this.checkFundLike();
            			
            				
            		})
            		.catch(error => {
            			console.error(error);
            		})
					
				},
				
				// 좋아요 체크
				async checkFundLike() {
					const postNo = this.fundDetail.postNo;
					const resp = await axios.get("http://localhost:8080/rest/post/like/check/"+postNo);
					this.isLiked = resp.data;
// 					console.log(resp.data);
				
					
				}
		      	
		    },
		    created() {
		    	  this.setPostNo();
		    	  this.loadFundPosts();
		    	  this.loadAttachNos();
		    	  this.loadFundVO();
		    	  this.loadReplies();
		    	  this.loadTagNames();
		    	  this.checkFundLike();
		    	},
		    mounted() {
		    	}
		  }).mount("#app");
		</script>

	
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>