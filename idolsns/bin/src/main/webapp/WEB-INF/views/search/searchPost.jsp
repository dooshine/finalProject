<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

  
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link href='https://cdn.jsdelivr.net/npm/@mdi/font@7.2.96/css/materialdesignicons.min.css' rel='stylesheet'>

<style>
  * {
    box-sizing: border-box !important;
  }

  .custom-tab-header .custom-tab-list:not(.active) * {
    text-decoration: none;
    font-weight: normal;
    color: #333;
  }
  .custom-tab-list {
    padding: 12px 20px;
  }
  .custom-tab-list:hover {
    background-color: #f2f2f2;    
  }
  .fs-7{
    font-size: 10px;
  }
  .h-20{
    height: 20px;
  }
  /* .custom-container {
    border: none;
    box-shadow: none;
  } */
</style>


<div class="container custom-container" id="search-body" style="padding: 0px;">
  <div class="row mx-0">
    <div class="col p-0" style="border-radius: 0px;">
      <%-- 검색 nav --%>
      <jsp:include page="/WEB-INF/views/search/searchNav.jsp"></jsp:include>
    </div>
  </div>
  <%-- ######################## 게시물 검색결과 ######################## --%>
  <div class="row mt-5">
    <div class="col">
      <!-- <div class="p-4" v-for="(post, index) in fixedTagSearchList" :key="index"> -->
      <div class="p-4 custom-border-box-angle m-0" v-for="(post, index) in fixedTagSearchList" :key="index">
        <!-- 글 박스 루프 1개-->
        <div class="my-2">
          <!-- 프로필 사진과 아이디 -->
          <div class="row mt-1">
            <div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">
              <img class="rounded-circle img-fluid" src="static/image/profileDummy.png">
            </div>
            <div class="col-10 col-md-10 col-lg-10 align-items-center justify-content-start">
              <div class="row">
                <h4>{{ post.memberId }}</h4>   
              </div>
              <div class="row">
                <p class="text-secondary">@{{post.memberNick }} </p>
              </div>
            </div>
            <div class="col-1 col-md-1 col-lg-1 d-flex align-items-start justify-content-end">
              <i class="fs-3 text-secondary ti ti-dots-vertical" data-toggle="dropdown"></i>
              <i class="ti ti-x" @click="deletePost(post.postNo)"></i>
            </div>
        </div>	
        <!-- 고정 태그와 글 타입들 -->
        <div class="row mb-3 ">
          <div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">
          </div>
          <div class="col-10 col-md-10 col-lg-10 d-flex align-items-center justify-content-start">
            <div class="mx-1 px-2 h-20 bg-primary rounded-4 align-items-center justify-content-center">
              <p class="fs-7 text-light">{{ post.postType }}</p>										 
            </div>
            <a :href="'/search/post/?q=' + fixedTag" v-for="fixedTag in post.fixedTagList" :key="fixedTag" class="mx-1 px-2 h-20 bg-primary rounded-pill align-items-center justify-content-center" style="text-decoration: none;">
              <p class="fs-7 text-light">{{ fixedTag }}</p>
            </a>
          </div>
          <div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center"></div>	                
        </div>
        <!-- 지도 맵이 있는 경우에만 지도 정보 표기 -->						
        <div class="row my-2" v-if="post.mapPlace !== '' && post.mapPlace !== null && post.mapPlace !== undefined">	                	
          <div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">			            
          </div>
          <div class="col-10 col-md-10 col-lg-10 d-flex align-items-center justify-content-start fs-6 text-secondary " @click="showMap(post.mapPlace)" data-bs-target="#showMap" data-bs-toggle="modal">
            <i class="fa-solid fa-location-dot"></i>&nbsp;{{ post.mapPlace}}
          </div>
          <div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center"> 
          </div>            
        </div>
        <!-- 글 내용 -->
        <div class="row my-2">
          <div class="col-1 col-md-1 col-lg-1 align-items-center justify-content-center">
          </div>
        <div class="col-10 col-md-10 col-lg-10 align-items-center">							
          <!-- 글 -->
          <div class="row">
            <p>{{ post.postContent }}</p>
            <div class="d-flex">
              <p v-for="freeTag in post.freeTagList" :key="freeTag" class="fs-6 text-primary">\#{{ freeTag }} &nbsp;</p>	
            </div>
          </div>
          <!-- 이미지 표시 -->
          <div class="row">
            <div v-if="post.attachmentList && post.attachmentList.length > 0"  class="d-flex">
              <!-- 단일 이미지인 경우 -->
              <div v-if="post.attachmentList.length == 1" class="row text-center" >
                <div v-for="(attachmentNo, attachmentIndex) in post.attachmentList" :key="attachmentIndex" class="col-6">
                  <img :src="getAttachmentUrl(attachmentNo)" @click="setModalImageUrl(attachmentNo)" class="img-fluid" style="max-width:100%;aspect-ratio:1/1;" alt="Attachment" data-bs-target="#image-modal" data-bs-toggle="modal">
                </div>                	        	
              </div>
              <!-- 두 개 이상의 이미지인 경우 -->
              <div v-else-if="post.attachmentList.length > 1" class="row text-center">
                <div v-for="(attachmentNo, attachmentIndex) in post.attachmentList" :key="attachmentIndex" class="col-6">
                  <img :src="getAttachmentUrl(attachmentNo)"  @click="setModalImageUrl(attachmentNo)" class="img-fluid mb-3" style="max-width:100%;aspect-ratio:1/1;" alt="Attachment" data-bs-target="#image-modal" data-bs-toggle="modal">
                </div>
              </div>
              <!-- 이미지 출력 모달창 -->
              <div class="modal" tabindex="-1" role="dialog" id="image-modal" data-bs-backdrop="true">
                <div class="modal-dialog modal-lg" role="image">
                  <div class="modal-content">
                    <img :src="modalImageUrl">
                  </div>                           					 	
                </div>
              </div>
              <div v-for="(attachmentNo, attachmentIndex) in post.attachmentList" :key="attachmentIndex">
              </div>
              <br>
            </div>
            <div v-else>
            </div>
          </div>

          <!-- 구분선 -->
          <div class="row">
            <hr style="width:100%;">
          </div>
            
          <!-- 좋아요, 댓글, 공유하기 -->
          <div class="row">
            
          <!-- 좋아요 -->		                		
          <div class="col-4 text-start text-primary">
            <div class="row" v-if="postLikeIndexList.includes(index)">
              <div class="col-2">
                <i class="fs-4 ti ti-heart-filled" @click="checkLike(post.postNo,index)"></i>
              </div>
              <div class="col-4 ">
                <h6 class="postlikeCount">{{post.likeCount}}</h6>
              </div>		                						                				
            </div>
            <div class="row" v-else>
              <div class="col-2">
                <i class="fs-4 ti ti-heart" @click="checkLike(post.postNo,index)"></i>
              </div>
              <div class="col-4 ">
                <h6 class="postlikeCount">{{post.likeCount}}</h6>
              </div>
            </div>
          </div>
          <!-- 좋아요 끝 -->
              
          <!-- 댓글 작성버튼 -->
          <div class="col-4 text-center text-secondary">				
            <i class="fs-4 ti ti-message" @click="showReplyInput(index)"></i>					    
          </div>
          <!-- 댓글 작성버튼 -->
        
          <!-- 공유하기 버튼 -->
          <div class="col-4 text-end text-secondary"><i class="fs-4 ti ti-share"></i></div>
          <!-- 공유하기 버튼 -->
        </div>
            
        <!-- 구분선 -->
        <div class="row">
          <hr class="mt-2" style="width:100%;">		                
        </div>
            
        <!-- 댓글, 대댓글 보여주는 창 -->
        <div v-if="post.replyList.length >= 1">
          <div v-for="(reply,replyIdx) in post.replyList" :key="replyIdx">
            <div class="row" v-if="reply.replyNo == reply.replyGroupNo">
            <!-- 프로필 이미지 -->
              <div class="col-1">
                <div class="row mt-2 text-center">
                  <img class="img-fluid rounded-circle " src="static/image/profileDummy.png">
                </div>
              </div>
                  
              <!-- 댓글 상자 -->
              <div class="col-10 align-items-center">
                <div class="mt-1"></div>
                <div class="mx-2"></div>
                <div v-if="reply.replyContent.length < reply.replyId.length" class="row grey-f5f5f5 rounded-3 text-left" :style="{ width: reply.replyId.length * 11 + 'px' }">
                  <div class="row mt-2"></div>
                  <h6 class="mr-1 fs-12px fw-bold">{{reply.replyId}}</h6>
                  <h6 class="mr-1 fs-11px lh-lg" >{{reply.replyContent}}</h6>
                  <div class="row mb-1"></div>
                </div>
                <div v-else class="row grey-f5f5f5 rounded-3 text-left" :style="{ width: reply.replyContent.length * 11 + 'px' }">
                  <div class="row mt-2"></div>
                  <h6 class="mr-1 fs-12px fw-bold">{{reply.replyId}}</h6>
                  <h6 class="mr-1 fs-11px lh-lg" >{{reply.replyContent}}</h6>
                  <div class="row mb-1"></div>
                </div>
                <div class="row d-flex flex-nowrap">
                  <h6 class="col-1 mt-1 text-start reply-text text-secondary" @click="showRereplyInput(post.postNo,reply.replyNo),hideReplyInput()" style="white-space: nowrap;">댓글 달기</h6>	
                </div>
                <div class="mb-1"></div>			                			
              </div>
              <!-- 댓글 상자 -->
                    
                    
                  <!--  -->
                  <div class="col-1" v-if="memberId === reply.replyId">
                    <i class="ti ti-x" @click="deleteReply(reply.replyNo)"></i>
                  </div>
                </div>
                <!-- 댓글 표시 -->
                
                <!-- 대댓글 표시 -->
                <div v-for="(rereply,rereplyIdx) in post.replyList.slice(replyIdx+1)" :key='rereplyIdx'>			                							                				             				
                    <!-- 대댓글이 들어갈 조건 -->
                    <div v-if="reply.replyNo === rereply.replyGroupNo"><!-- 특정 댓글의 그룹번호가 특정 댓글번호와 일치할 때, -->				                				
                      <!-- 대댓글 들 -->
                      <div class="row ">
                        <div class="col-2">
                        </div>
                        <div class="col-2 text-center">
                          <div class="row w-50 h-50 text-center m-auto">
                            <img class="img-fluid rounded-circle " src="static/image/profileDummy.png">
                          </div>
                          <div class="row w-50 h-50 text-center m-auto">
                            <h6 class="fs-7">{{rereply.replyId}}</h6>
                          </div>
                        </div>
                        <div class="col-6">
                          <h6>{{rereply.replyContent}}</h6>
                        </div>
                        <div class="col-1">				                						
                          <i class="ti ti-x" @click="deleteRereply(rereply.replyNo)" v-if="rereply.replyId == memberId"></i>
                        </div>
                      </div>
                      <!-- 대댓글 들 -->
                    </div>
                    <!-- 대댓글이 들어갈 조건 -->
                </div>
                
                <!-- 대댓글 작성 창 -->
                <div v-if=" post.postNo === tempPostNo && reply.replyNo === tempReplyNo">
                  <div class="row">
                    <div class="col-2">
                    </div>
                    <div class="col-2 text-center">
                      <div class="row w-50 h-50 text-center m-auto">
                        <img class="img-fluid rounded-circle " src="static/image/profileDummy.png">
                      </div>
                      <div class="row w-50 h-50 text-center m-auto">
                        <h6 class="fs-7">${memberId }</h6>
                      </div>
                    </div>
                    <div class="col-7">
                      <input type="text" v-model="rereplyContent" class="w-100 rounded-4 border border-secondary ">
                    </div>
                    <div class="col-1">
                      <i class="fs-2 text-primary ti ti-arrow-badge-right-filled" @click="rereplySending(post.postNo,reply.replyNo,index)"></i>
                    </div>
                  </div>
                </div>
                        <!-- 대댓글 작성 창 -->
                        
                        <!-- 대댓글 표시 -->
                </div> 								             		
                    </div>
                    <!-- 댓글, 대댓글 보여주는 창 -->
                    
                    <!-- 댓글 작성창  -->
            <!-- 댓글 작성버튼 눌렸을 때만 나오게됨 -->
                    <div class="row" v-if="replyFlagList[index]"> 
                      <div class="col-1">
                        <img class="rounded-circle img-fluid" src="static/image/profileDummy.png">
                      </div>
                      <div class="col-10 mt-1">
                        <input type="text" placeholder=" 댓글을 입력하세요." v-model="replyContent" class="w-100 rounded-4 border border-secondary "> 
                      </div>
                      <div class="col-1">
                        <i class="fs-2 text-primary ti ti-arrow-badge-right-filled" @click="replySending(post.postNo,index)"></i>
                      </div>		                		
                    </div>
                    
                </div>
                <div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center"> 
                </div>       
                </div>


              </div>
        </div>
      </div>
    </div>
    <div v-if="fixedTagSearchList.length === 0">
      <h3 class="pb-5 px-4">검색 결과가 없습니다</h3>
    </div>
  <%-- ######################## 게시물 검색결과 끝 ######################## --%>
</div>




<script>
    Vue.createApp({
      data() {
        return {

          // 로그인 회원 팔로우 목록 조회
          memberFollowObj: {
            memberId: "",
            followMemberList: [],
            followPageList: [],
          },

          // 태그 검색목록
          fixedTagSearchList: [],
          postSearchList: [],
          postPage: 1,

          // ######################## 게시물 ########################
          // 좋아요 게시글 인덱스 배열
          postLikeIndexList: [],
          // 댓글 작성 여부 체크용 배열
          replyFlagList: [],
          // 댓글 작성 글자 
          replyContent: '',
          // 대댓글 위치 특정용 임시 postNo, replyNo
          tempPostNo:null ,
          tempReplyNo:null ,
          // 대댓글 작성 글자
          rereplyContent: '',
          // 무한 페이징 영역
          percent:0,
          finish:false,
          loading:false,
          // 모달 이미지 URL
          modalImageUrl:null,
          // ######################## 게시물 끝 ########################

          followObj: {
            memberId: memberId,
            followTargetType: "",
            followTargetPrimaryKey: "",
          },
        };
      },
      computed: {
        
      },
      methods: {
        // 좋아요 관련 비동기 처리-----------------------------------
        // 아이디 접속해 있고, 좋아요 클릭시에 실행
        checkLike(postNo,index){
          axios.get('${contextPath}/rest/post/like/'+postNo)
            .then(response => {
              // 응답이 좋아요면 좋아요 +1
              if(response.data== 'Like'){
                this.posts[index].likeCount = this.posts[index].likeCount + 1; 
                this.postLikeIndexList.push(index);                			
              }
              // 응답이 좋아요 취소면 좋아요 -1
              else if(response.data=='disLike'){
                this.posts[index].likeCount = this.posts[index].likeCount - 1;
                this.postLikeIndexList.splice(this.postLikeIndexList.indexOf(index),1);
              }
              
                
            })
            .catch(error => {
              console.error(error);
            })
        },

        // postNo를 List로 송신하고 좋아요 되있는 index 번호를 수신
        getLikePostIndex(posts){
          postNoList = [];
          posts.forEach(function(post){
            postNoList.push(post.postNo); 
          })
          
          axios.get('${contextPath}/rest/post/like/index/'+postNoList)
            .then(response => {               			
            this.postLikeIndexList = response.data;                			
          })
          .catch(error => {
            console.error(error);
          })
                            
        },

        // 댓글 창 관련 클릭 함수 -------------------------------              
        // 전송 버튼 클릭 시
        async replySending(postNo,index){
          try{
            const replyDto = {postNo: postNo, replyContent:this.replyContent};
              const response = await axios.post('${contextPath}/rest/post/reply/',replyDto);
              this.fetchPosts();
            }
          catch (error){
            console.error(error);
          }
          
          this.hideReplyInput(index)
        },
        // 댓글 쓰기 창 띄우기 (다른 창들은 모두 닫음) 
        showReplyInput(index){
          this.replyContent = '';                 	
          this.replyFlagList = this.replyFlagList.map(() => false); 
          this.replyFlagList[index] = true;
        },
        // 댓글 쓰기 창 숨기기
        hideReplyInput(index){
          this.replyFlagList[index] = false;
        },

        // 대댓글 전송 버튼 클릭 시 
        async rereplySending(postNo,replyNo,index){
          try{
            const replyDto = {postNo: postNo, replyContent:this.rereplyContent, replyGroupNo: replyNo};
              const response = await axios.post('${contextPath}/rest/post/rereply/',replyDto);
              this.fetchPosts();
            }
          catch (error){
            console.error(error);
          }
          this.hideRereplyInput();
        },
              
        // 대댓글 쓰기 창 띄우기 (다른 창들은 모두 닫음)
        showRereplyInput(postNo,replyNo){
          this.rereplyContent = ''; 
          this.tempPostNo = postNo;
          this.tempReplyNo = replyNo;
        },
              
        hideRereplyInput(){
          this.rereplyContent = '';
          this.tempPostNo = null;
          this.tempReplyNo = null;
        },
        // 댓글 삭제
        async deleteReply(replyNo){
          try{
            await axios.delete('${contextPath}/rest/post/reply/delete/'+replyNo);
            this.fetchPosts();
          }
          catch (error){
            console.error(error);
          }
        
        },
        // 대댓글 삭제
        async deleteRereply(replyNo){
          try{
            await axios.delete('${contextPath}/rest/post/reply/reDelete/'+replyNo);
            this.fetchPosts();
          }
          catch(error){
            console.error(error);
          }
        },




        // [전처리] 로그인 회원 팔로우 정보 로드
        async loadMemberFollowInfo(){
          // 로그인X → 실행 X
          if(memberId==="") return;
          // url
          const url = "${contextPath}/rest/follow/memberFollowInfo/"
          // 팔로우 목록 load
          const resp = await axios.get(url, {params:{memberId: memberId}});
          // 로그인 팔로우 정보 로드
          this.memberFollowObj = resp.data;
        },


        // 페이지 팔로우 버튼
        async followPage(artistSearch){
            // 1. 회원 로그인 확인
            if(memberId === ""){
                if(confirm("로그인 한 회원만 사용할 수 있는 기능입니다. 로그인 하시겠습니까?")) {
                    window.location.href = contextPath + "/member/login";
                }
            }

            // artistEngNameLower
            // 2. toggle 팔로우 삭제, 팔로우 생성
            const isFollowingArtist = artistSearch.isFollowPage;
            if(isFollowingArtist){
                if(!confirm(this.fullName(artistSearch.artistName, artistSearch.artistEngName) + "님 팔로우를 취소하시겠습니까?")) return;
                this.setFollowPageObj(artistSearch.artistEngNameLower);
                await this.deleteFollow();
            } else {
                this.setFollowPageObj(artistSearch.artistEngNameLower);
                await this.createFollow();
            }

            await this.loadMemberFollowInfo();
            this.loadArtistSearchList();
        },
        // 회원 팔로우 버튼
        async followMember(memberSearch){
            // 1. 회원 로그인 확인
            if(memberId === ""){
                if(confirm("로그인 한 회원만 사용할 수 있는 기능입니다. 로그인 하시겠습니까?")) {
                    window.location.href = contextPath + "/member/login";
                }
            }

            // artistEngNameLower
            // 2. toggle 팔로우 삭제, 팔로우 생성
            const isFollowingMember = memberSearch.isFollowMember;
            if(isFollowingMember){
                if(!confirm(this.fullName(memberSearch.memberId, memberSearch.memberNick) + "님 팔로우를 취소하시겠습니까?")) return;
                this.setFollowMemberObj(memberSearch.memberId);
                await this.deleteFollow();
            } else {
                this.setFollowMemberObj(memberSearch.memberId);
                await this.createFollow();
            }

            await this.loadMemberFollowInfo();
            this.loadMemberSearchList();
        },

        // 회원 팔로우 대상 설정
        setFollowMemberObj (followMemberId){
            // 팔로우 대상 유형
            this.followObj.followTargetType = "회원";
            // 팔로우 대상 PK
            this.followObj.followTargetPrimaryKey = followMemberId;
        },
        // 회원 팔로우 대상 설정
        setFollowMemberObj (followMemberId){
            // 팔로우 대상 유형
            this.followObj.followTargetType = "회원";
            // 팔로우 대상 PK
            this.followObj.followTargetPrimaryKey = followMemberId;
        },

        // 대표페이지 팔로우 생성
        async createFollow(){
            // 팔로우 생성 url
            const url = "${contextPath}/rest/follow/";
            await axios.post(url, this.followObj);
            // [develope] 
        },
        // 대표페이지 팔로우 취소
        async deleteFollow(){
            // 팔로우 생성 url
            const url = "${contextPath}/rest/follow/";
            await axios.delete(url, {
                data: this.followObj,
            });
            // [develope]
        },


        // (search) 고정태그 검색목록 조회
        async loadFixedTagsSearchList(){
          // q
          const params = new URLSearchParams(window.location.search);
          const q = params.get("q");

          // url
          const url = "${contextPath}/rest/post/pageReload/fixedTagPost";

          // 조회
          const resp = await axios.post(url, { page: this.postPage, fixedTagName: q } );

          this.postPage++;
          this.fixedTagSearchList = resp.data;
          this.getLikePostIndex(this.fixedTagSearchList);
        },
        getAttachmentUrl(attachmentNo) {		
          return "${contextPath}/rest/attachment/download/"+attachmentNo;
        },

        // 풀네임 생성
        fullName(name, engName){
          return name + "(" + engName + ")";
        },

      },
      watch: {
  
      },
      async created(){
        // 1. 로그인 회원 팔로우 정보 로드
        await this.loadMemberFollowInfo();
        // (search) 고정태그 검색목록 조회
        this.loadFixedTagsSearchList();
      },
    }).mount('#search-body')
</script>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>