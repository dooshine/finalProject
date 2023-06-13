<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


 <style>
    
          /*조건부 스타일 - 태블릿*/
        @media screen and (max-width:992px) {
    
    	 .col-6 {
		    width: 100%;
		  }
          
    	}
    
        label {
        	color: gray;
			width:100%;
			font-size: 80%;
		}
		
		.fund_span {
			font-size: 30px;
		}
		
		td {
		color: gray;	
		font-size: 90%;
		}
		
      .like-btn {
   
      }
      
      .like-count {
        font-size: 5px;
        color: #777;
        
      }
      .grey-f5f5f5{
       background-color:    #f5f5f5;
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
        background-color: #f5f5f5;
        padding: 20px;
        border-radius: 5px;
        position: relative;
       }
       .reply-form2 {
       	 margin-top: 20px;
        background-color: #f5f5f5;
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
         border: none;
         outline: none;
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
	
	.fund-sponsor:hover {
		cursor: pointer;
	}
	.custom-hr {
    border-color: blue; /* 원하는 색상으로 변경 */
  	}
    </style>
    
   	<div id="app">
		<div class="custom-container">
			  
		<div>
			<h2 class="font-bold text-center mt-5 mb-5">{{ fundDetail.fundTitle }}</h2>
		</div>
			
			
			<!-- 구역 -->
			<div class="d-flex mt-5 px-3" style="background-color: #f5f5f5; border-radius:5px;">
				<div class="col py-3">
				  <div  style="width: 100%; height: 100%; position: relative;">
				    <img :src="fundDetail.imageURL" alt="예시사진" style="width: 100%; height: 100%; object-fit: cover;">
				  </div>
				</div>

			
				<div class="col py-3" style="padding-left:2em;">
		
					<label>모인 금액</label>
					<span class="fund_span">{{ formatCurrency(fundDetail.fundTotal) }}</span>원
					<span style="font-weight:bold">{{ (fundDetail.fundTotal / fundDetail.fundGoal * 100).toFixed(1) }}</span>%
			
					<label class="mt-3">남은 시간</label>
					<span v-if="getTimeDiff().includes('펀')" class="fund_span">{{ getTimeDiff() }}</span>
					<span v-else-if="getTimeDiff().includes('-')" class="fund_span">{{ getTimeDiff() }}</span>
					<span v-else>
						<span class="fund_span">{{ getTimeDiff() }}</span>일
					</span>
<!-- 					<span class="fund_span">{{ getTimeDiff() }}</span>일 -->
					
					<div @click="sponsorModal = true">
						<label class="mt-3">후원자</label>
						<span class="fund_span fund-sponsor">{{ fundDetail.fundSponsorCount }}</span>명
					</div>

		
	
		<!--
				 <button class="btn btn-primary share-btn">
			      <i class="fa fa-share"></i>
			       {{ likeCount }} 
			    </button> -->
			    
			 
			<hr class="mt-3 mb-3" style="height: 0.3px;">
				
			
			
			
			<table>
				<tr>
					<th style="padding-right:3em;">목표금액</th> 
					<td >{{ formatCurrency(fundDetail.fundGoal) }}원</td>
				</tr>
				
				<tr>
					<th>펀딩 기간</th> 
					<td>{{ fundDetail.postStart }} ~ {{ fundDetail.postEnd }}</td>
				</tr>
				
				<tr>
					<th>결제</th> 
					<td>{{ fundDetail.postEnd }} 결제 진행</td>
			
			</table>
			
			
			
			<!-- 좋아요, 후원버튼 -->
				<div class="mt-3 d-flex">
					<div class="col-12">
					    <button class="custom-btn btn-purple1-secondary col-3" style="vertical-align:middle; margin-right:0.5em;" @click="checkLike">
					      	<i v-if="isLiked" class="ti ti-heart-filled" ></i> 
					      	<i v-else class="ti ti-heart"></i> 
						      	<div class="like-count">
						      		{{ likeCount }} 
						    	</div>
					    </button>
					
						<button type="submit" class="btn-purple1 custom-btn col-8"  style="font-size:23px; vertical-align:middle;"  @click="order">
						후원하기</button>
					</div>	
				</div>			
			</div>
			
		</div>
		
			
			<hr>
					
					
		<!-- 펀딩 하단 (내용) -->			
	<div>			
			<div class="row mt-3" style="padding-left: 1em">
				<div v-html="fundDetail.postContent"></div>
			</div>
					
	</div>
		
	<!-- 태그 출력 -->
	<div class="row mt-3">
		<div class="col d-flex ms-4">
			<div class="fixed-tag ms-1" v-for="(tag, i) in fundDetail.tagNames"
						@click="tagLink(i)">
			{{ tag }}
			</div>
		</div>
	</div>
		
		
	<!-- ------------------------ 댓글 ------------------------------- -->
	  <hr class="mt-4 mb-4">
	  
	  <div v-if="replies.length == 0">
	  	<span class="ms-3">댓글이 없습니다.</span>
	  </div>
	  <!-- 댓글이 있으면 -->
	  <div v-else>
	      <div v-for="(reply, i) in replies" :key="reply.replyNo">
	         
	        <!-- 최상위 댓글이면 -->
	        <div v-if="reply.replyNo == reply.replyGroupNo" class="row mb-1">
	        	<!-- 프로필 이미지 -->
          		<div class="col-1">
          			<img v-if="reply.attachmentNo && reply.attachmentNo !=null" class="img-fluid rounded-circle" 
          			:src="getAttachmentUrl(reply.attachmentNo)" @click="linkToMypage(reply.replyId)"> 
       				<img v-else class="img-fluid rounded-circle" src="/static/image/profileDummy.png">
          		</div>
          		
          		<div class="col-10 align-items-center">
          			<!-- 작성자면 작성자 표시 -->
	        		<div v-if="reply.replyId == fundDetail.memberId">
	        			<div class="d-flex">
						    <div>{{ reply.memberNick }}</div>
	        				<div class="author-badge font-purple2 ms-1">
							    <div class="">작성자</div>
						  	</div>
	        			</div>
	        		</div>
	        		<!-- 작성자가 아니면 -->
	        		<div v-else>
	        			{{ reply.memberNick }}
	        		</div>
	        		
	        		<!-- 수정 폼 -->
		        	<div v-if="updateReplyObj.index == i" class="ms-3 grey-f5f5f5 rounded-4">
				    	<textarea @blur="setUpdateReplyObj($event, i)" class="row grey-f5f5f5 rounded-3 font-gray2 col-10 p-3" 
		       				placeholder="수정 내용">{{ reply.replyContent }}</textarea>
		       			<div class="d-flex">
			        		<div class="col text-start ps-2">
				       		 	<i class="ti ti-x fx-12px font-purple1" @click="cancelUpdate()"></i>
			        		</div>
			        		<div class="col text-end pe-2">
					        	<i class="fs-5 font-purple1 ti ti-arrow-badge-right-filled" @click="saveUpdate(i)"></i>
			        		</div>
			        	</div>
					</div>
					
					<!-- 댓글 내용 -->
		        	<div v-else class="col-12 grey-f5f5f5 rounded-4 font-gray2 p-1 ps-3 mt-1">
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
	        <div v-else class="row ms-4">
	        	<!-- 프로필 이미지 -->
          		<div class="col-1">
          			<img v-if="reply.attachmentNo && reply.attachmentNo !=null" class="img-fluid rounded-circle" 
          			:src="getAttachmentUrl(reply.attachmentNo)" @click="linkToMypage(reply.replyId)"> 
       				<img v-else class="img-fluid rounded-circle" src="/static/image/profileDummy.png">
          		</div>
          		
          		<div class="col-10 align-items-center">
          			
          			<!-- 작성자면 작성자 표시 -->
	        		<div v-if="reply.replyId == fundDetail.memberId">
	        			<div class="d-flex">
						    <div>{{ reply.memberNick }}</div>
	        				<div class="author-badge font-purple2 ms-1">
							    <div class="">작성자</div>
						  	</div>
	        			</div>
	        		</div>
	        		<!-- 작성자가 아니면 -->
	        		<div v-else>
	        			{{ reply.memberNick }}
	        		</div>
	        		
          			<!-- 수정 폼 -->
		        	<div v-if="updateReplyObj.index == i" class="grey-f5f5f5 rounded-4">
				    	<textarea @blur="setUpdateReplyObj($event, i)" class="row grey-f5f5f5 rounded-3 font-gray2 mx-0 p-3 col-12" 
		       				placeholder="수정 내용">{{ reply.replyContent }}</textarea>
		       			<div class="d-flex">
			        		<div class="col text-start ps-2">
				       		 	<i class="ti ti-x fx-12px font-purple1" @click="cancelUpdate()"></i>
			        		</div>
			        		<div class="col text-end pe-2">
					        	<i class="fs-5 font-purple1 ti ti-arrow-badge-right-filled" @click="saveUpdate(i)"></i>
			        		</div>
			        	</div>
					</div>
					<!-- 대댓글 내용 -->
					<div v-else class="col-12 grey-f5f5f5 rounded-4 font-gray2 p-1 ps-3 mt-1">
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
					            <button type="button" @click="hideModal(i)" class="btn-close" 
					            style="position: absolute; top: 5px; right: 5px; height: 5px; width: 5px;"></button>
					        </div>
					        <div @click="hideModal(i)" class="custom-modal-body p-0" style="font-size: 16px;">
					        	<!-- 대댓글 버튼 -->
					        	<div v-if="reply.replyNo == reply.replyGroupNo" class="p-2" style=" border-bottom: 0.3px solid #dee2e6;" 
					        	@click="showRereplyForm(i)">댓글달기</div>
					        	<!-- 대댓글 수정 버튼 -->
					        	<div v-if="reply.replyId == replyObj.replyId" class="p-2" style=" border-bottom: 0.3px solid #dee2e6;" 
					        	@click="showUpdateForm(i)">수정</div>
					        	<!-- 대댓글 삭제 버튼 -->
					        	<div v-if="reply.replyId == replyObj.replyId" class="p-2" style=" border-bottom: 0.3px solid #dee2e6;" 
					        	@click="deleteReply(i)">삭제</div>
					        </div>
					        
				    	</div>
	        		</i>
	        		</div>
          		</div>
        		
	        	
	        </div>
	        		<!-- 대댓글 폼 -->
	        		<div class="row mb-2" v-if="reReplies[i] == true">
	        			<!-- 프로필 이미지 -->
		          		<div class="col-1">
		          			<img v-if="reply.attachmentNo && reply.attachmentNo !=null" class="img-fluid rounded-circle" 
		          			:src="getAttachmentUrl(sessionMemberAttachmentNo)"> 
		       				<img v-else class="img-fluid rounded-circle" src="/static/image/profileDummy.png">
		          		</div>
	        			<div class="col-10">
	        				<div  class="pt-2 ps-2 pe-2 w-100 rounded-4 grey-f5f5f5">
				        	<textarea @blur="setReReplyObj($event, i)" placeholder="댓글을 입력해주세요" 
				        	class="w-100 rounded-4 grey-f5f5f5"></textarea>
				        	<div class="d-flex">
				        		<div class="col text-start">
					       		 	<i class="ti ti-x fx-12px font-purple1" @click="reReplies[i] = false"></i>
				        		</div>
				        		<div class="col text-end">
						        	<i class="fs-5 font-purple1 ti ti-arrow-badge-right-filled" @click="addReReply(i)"></i>
				        		</div>
				        	</div>
				        </div>
	        			</div>
	        			<div class="col-1"></div>
	        		</div>
			        
	        
	        
	      </div>
 	 </div>
 	 
 	 <hr>
 	 
 	 <!-- 로그인이 되어있으면 -->
 	<div v-if="memberId != ''">
	  	<!-- 새댓글 폼 -->
		<form @submit.prevent="addReply" class="reply-form rounded-4">
		    <div>
		        <input type="hidden" v-model="replyObj.replyId" required>
		        <input type="hidden" v-model="replyObj.postNo" required>
		    </div>
		    <div>
		        <textarea type="text" class="w-100 rounded-4 grey-f5f5f5" v-model="replyObj.replyContent" placeholder="글을 작성해주세요" required></textarea>
		    </div>
		    <div class="submit-icon">
		    	<button type="submit">
			        <i class="fs-2 font-purple1 ti ti-arrow-badge-right-filled"></i>
		    	</button>
		    </div>
		</form>
 	</div>
 	
 	<!-- 로그인이 안되어있으면 -->
	<div v-else>
		<div class="reply-form2">
			<div class="text-center">로그인 후 이용해주세요.</div>
			<div class="text-center m-1">
				<button class="custom-btn btn-round btn-purple1 me-2 w-30" @click="linkToLogin">로그인</button>
			</div>
		</div>
	</div>
	
	<!-- ------------------------------------------------------------모달창 시작-------------------------------------------------------------- -->
	
	 <!-- 로그인 모달창 -->
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
    <!-- 로그인 모달창 끝! -->
     
    <!-- 후원자 모달창 -->
    <div v-if="sponsorModal" class="custom-modal-wrapper">
	   	<div class="custom-modal">
	       <div class="custom-modal-body" style="width: 400px;">
	          <div class="text-center mb-2" style="font-size: 30px;">후원자 랭킹</div>
	          	<div v-if="fundVO.length == 0" class="row text-center">
	          		<span>아직 후원자가 없어요ㅠㅠ</span>
	          	</div>
	          	<div v-else v-for="(fund, index) in fundVO">
		          	<div class="row w-100">
		          		<div class="col-2">
							{{ fund.rank }}위        			
		          		</div>
		          		<div class="col-6">
							{{ fund.memberNick }} ({{ fund.memberId }})	          			
		          		</div>
		          		<div class="col-3 d-flex justify-content-end">
							{{ formatCurrency(fund.fundTotal) }}원         			
		          		</div>
		          		<div v-if="fund.rank < 4" class="col-1">
		          			🎉
		          		</div>
		          	</div>
	          </div>
	          <div class="d-flex justify-content-center mt-4">
	             <button class="custom-btn btn-round btn-purple1 w-50" @click="sponsorModal = false">확인</button>
	          </div>
	       </div>
    	</div>
    </div>
    <!-- 후원자 모달창 끝! -->
    
    <!-- 후원자 모달창 -->
     <div v-if="fundCheckModal" class="custom-modal-wrapper">
     	<div class="custom-modal">
        <div class="custom-modal-body" style="width: 300px;">
           <div class="text-center mb-3">
              <i class="ti ti-alert-triangle"></i>
           </div>
           <div class="text-center">이미 종료된 펀딩입니다.</div>
           <div class="d-flex justify-content-center mt-4">
              <button class="custom-btn btn-round btn-purple1 w-100" @click="fundCheckModal = false">취소</button>
           </div>
        </div>
     	</div>
    </div>
    <!-- 후원자 모달창 끝! -->
     
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
		        // 후원자 랭킹 데이터 배열
		        fundVO: [],
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
			   	
			   	// 좋아요 수
			   	likeCount: "",
			   	
			   	// 로그인 모달
			   	loginModal: false,
			   	
			   	// 후원자 모달
			   	sponsorModal: false,
			   	
			   	// 후원 확인
			   	fundCheckModal: false,
			   	
			   	// 세션 memberId
			   	memberId: memberId,
			   	
			   	// 세션 프로필 이미지 첨부파일 번호 
			   	sessionMemberAttachmentNo: null,
		      };
		    },
		    computed: {
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
					const resp = await axios.get("http://localhost:8080/rest/fund/"+postNo);
					this.fundDetail = { ...this.fundDetail, ...resp.data };
        		},
        		// postNo의 attachmentNo list 불러오기 
        		async loadAttachNos(){
        			const postNo = this.fundDetail.postNo;
					const resp = await axios.get("http://localhost:8080/rest/fund/attaches/"+postNo);	  
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
					const resp = await axios.get("http://localhost:8080/rest/fund/fundlist/"+postNo);	  
					console.log("FundVO====="+resp.data.fundWithNickDtos);
					this.fundVO = resp.data.fundWithNickDtos;
					this.fundDetail.fundTotal = resp.data.fundTotal;
					this.fundDetail.fundSponsorCount = resp.data.fundSponsorCount;
        		},
        		
                // 데이터 중 fund를 서버로 전송
		      	order() {
        		  // 로그인이 안되어 있으면
				  if(!this.checkLogin()) return;
        		  // 후원이 종료됐으면
        		  if(this.fundDetail.fundState != "진행중"){
        			  this.fundCheckModal = true;
        			  return;
        		  }
        			
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
// 	               	console.log(resp.data);
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
					// 로그인이 안되어 있으면
					if(!this.checkLogin()) return;
					this.reReplies[i] = true
					console.log("i = "+ reReplies[i]);
					this.cancelUpdate();
				},
				// 수정 폼 보여주기 & 대댓글 폼 숨기기
				showUpdateForm(i) {
					this.updateReplyObj.index = i
					this.reReplies[i] = false;
				},
				// 태그 클릭시 
// 				tagLink(i){
// 					console.log(this.fundDetail.tagNames[i]);
// 					const url = ""
// 					window.location.href = url;
// 				},
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
					// 로그인이 안되어 있으면
					if(!this.checkLogin()) return;
					
					const postNo = this.fundDetail.postNo;
					axios.get('http://localhost:8080/rest/post/like/'+postNo)
            		.then(response => {
//             			console.log("checkLike = " +response.data);
            			// 응답이 좋아요면 좋아요 +1
            			if(response.data== 'Like'){
            				this.likeCount = this.likeCount + 1; 
            				this.isLiked = true;
            			}
            			// 응답이 좋아요 취소면 좋아요 -1
            			else if(response.data=='disLike'){
            				this.likeCount = this.likeCount - 1;
            				this.isLiked = false;
            			}
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
				},
				
				// 좋아요 수
				async loadLikeCount() {
					const postNo = this.fundDetail.postNo;
					const resp = await axios.get("http://localhost:8080/rest/fund/likeCount/"+postNo);
					this.likeCount = resp.data;
				},
				
				// 남은 시간 설정
                getTimeDiff() {
                      const startDate = new Date(this.fundDetail.postStart);
                      const endDate = new Date(this.fundDetail.postEnd);
//                       console.log(this.fundDetail);
                      const currentDate = new Date();
                      const fundState = this.fundDetail.fundState;
                      const timeDiff = endDate.getTime() - currentDate.getTime();
                      const timeDiff2 = startDate.getTime() - currentDate.getTime();
                      
                   // 시작날짜가 오늘보다 뒤인경우
                      if(timeDiff2 >= 0) {
                    	  const diffInDays = Math.ceil(timeDiff2 / (24 * 60 * 60 * 1000));
                    	    return "D-" + diffInDays.toString();
                      }
                      // 마간기간이 남은 경우
                      if(timeDiff >= 0){
                          // 1일 이상인 경우
                          if (timeDiff >= 24 * 60 * 60 * 1000) {
                            return Math.ceil(timeDiff / (24 * 60 * 60 * 1000));
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
                
                // 이미지 불러오기 
                getAttachmentUrl(attachmentNo) {      
                    return "http://localhost:8080/rest/attachment/download/"+attachmentNo;
                },
                
                // 세션 아이디의 프로필 이미지 불러오기 메소드에 추가
                async getSessionMemberAttachmentNo(){
                   if(this.memberId !=null)
                   {
                      const resp = await axios.get("http://localhost:8080/rest/post/sessionAttachmentNo/");   
                      this.sessionMemberAttachmentNo = resp.data;
                      return this.sessionMemberAttachmentNo; 
                   }
                },
                
                // 멤버 프로필 이미지 불러오기
                async fetchMemberImage() {
                	const resp = await axios.get("http://localhost:8080/rest")
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
					window.location.href="/member/login";
				},
				
				// 프사 클릭시 마이페이지로
				linkToMypage(id) {
					window.location.href="/member/mypage2/"+id;
				},
		    },
		    created() {
		    	  this.setPostNo();
		    	  this.loadFundPosts();
		    	  this.loadAttachNos();
		    	  this.loadFundVO();
		    	  this.loadReplies();
		    	  this.loadTagNames();
	              this.loadLikeCount();
		    	  this.checkFundLike();
	              this.getSessionMemberAttachmentNo();
		    	},
		    mounted() {
		    	}
		  }).mount("#app");
		</script>

	
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>