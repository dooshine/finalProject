<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<!-- 카카오 api 키 등록 -->
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=047888df39ba653ff171c5d03dc23d6a&libraries=services"></script>
	<!-- 맵 관련 css -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/map.css">
	<!------- 카카오 지도 관련-------->



<!-- develope-css -->
<style>
   @media screen and (max-width:992px) {
		  	.col-6 {
		    width: 100%; 
		  }
    	}
    .mh-300{
        min-height: 300px;
    }
    .artist-profile-img {
        width: 130px;
        height: 130px;
    }
	.arti_name {
		font-weight: bold;
		font-size: 30px;
	}

	.arti_title {
		font-weight: bold;
		font-size: 20px;
	}
	
  .active-icon {
    color: #6A53FB;
  }
  #artist-header {
	width: 100%;
	height: 40px; 
  }
  #artist-header a {
	color: #7f7f7f;
    text-decoration: none;
  }
  #artist-header a.artist-header-tab-active {
  	color: black;
  }
  #artist-header a.artist-header-tab:not(.artist-header-tab-active):hover {
	cursor: pointer;
  	color: #404040
  }
  
  
	/*####################   펀딩 스타일	####################*/
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
		/*####################   펀딩 스타일 끝!	####################*/
  
</style>

<!-- 제어영역 설정 -->
<div id="artist-body">
	
	<%-- ######################## 본문 ######################## --%>
	<div class="custom-container pb-0">
	    <!-- # 대표페이지 프로필 -->
	    <div class="my-5 mx-5 d-flex">
	        <!-- 대표페이지 프로필 사진 -->
	        <div class="my-auto" >
	            <div class="border artist-profile-img rounded-circle overflow-hidden">
	                <img class="artist-profile-img " :src="artistObj.profileSrc">
	            </div>
	        </div>
	
	        <!-- 대표페이지 이름 및 팔로워 -->
	        <div class="col container my-auto" style="text-align:left; padding-left:2em;" >
	            <!-- 대표페이지 이름 -->
	            <div class="row arti_name">
					{{fullName(artistObj.artistName, artistObj.artistEngName)}}
	            </div>
	           
	            <!-- 대표페이지 팔로워 -->
	            <div class="row">
					팔로워 {{artistObj.followCnt ?? 0}}명
	            </div>
	        </div>
	
	        <!-- 버튼(팔로우하기, 글쓰기) -->
	        <div class="col container my-auto">
	            <div class="row mb-2 justify-content-end" >
	                <button class="custom-btn btn-round" style="width:150px;" 
	                :class="{'btn-purple1':!isFollowingArtist, 'btn-purple1-secondary': isFollowingArtist}"  v-text="isFollowingArtist?'팔로우취소':'팔로우하기'" @click="followPage">팔로우하기</button>
	            </div>
	            <div class="row justify-content-end">
	                <button class="custom-btn btn-round btn-gray" style="width:150px;">글쓰기</button>
	            </div>
	        </div>
	    </div>
	
	
	    <div class="custom-hr"></div>
	
		<%-- ######################## 대표페이지 헤더 ######################## --%>
		<div class="w-100" id="artist-header">
			<div class="d-flex justify-content-center">
				<a class="font-bold px-4 artist-header-tab" :href="makeHref('feed')">
					게시물
				</a>
				<a class="font-bold px-4 artist-header-tab" :href="makeHref('map')">
					지도
				</a>
				<a class="font-bold px-4 artist-header-tab artist-header-tab-active" :href="makeHref('fund')">
					후원
                </a>
			</div>
		</div>
		<%-- ######################## 대표페이지 헤더 끝######################## --%>
	</div>




	<%-- ######################## 펀딩 ######################## --%>
	<div class="custom-container mt-3">

		<!-- 펀딩 리스트 -->
                 <div class="funding-list justify-content-center mt-4">
                 
                   <div class="funding-item" v-for="(funding, index) in fundings" :key="index"
                                              @click="link(funding)" >
                     <div class="image-container">
                     	<img :src="getImageUrl(funding)" alt="Funding Image" style="height:200px;">
                     </div>
                     
                     <!-- 좋아요 -->
<!--                      <span class="heart-icon" v-if="postLikeIndexList.includes(index)"> -->
<!-- 					      <i class="fs-4 ti ti-heart-filled" @click="checkLike(funding.postNo, index); $event.stopPropagation()"></i>  -->
<!--                      </span> -->
<!--                      <span class="heart-icon" v-else> -->
<!-- 					      <i class="fs-4 ti ti-heart" @click="checkLike(funding.postNo, index); $event.stopPropagation()"></i>  -->
<!--                      </span> -->
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
	<%-- ######################## 펀딩 끝 ######################## --%>
</div>

<!-- 뷰 스크립트 작성 -->
<script>
    Vue.createApp({
      data() {
        return {
            artistObj: {},

			followPageObj: {
                memberId: memberId,
                followTargetType: "",
                followTargetPrimaryKey: "",
            },

            memberFollowObj: {},
            isFollowingArtist: false,




			// ######################## 후원 (lsh) ########################
			fundings: [],
			searchPage: 1,
			postLikeIndexList: [],



			// ######################## 후원 (lsh) 끝 ########################
			
        };
      },
      computed: {
      },
	  watch: {
	  },
      methods: {
		// ######################## 대표페이지 method ########################
		// 풀네임 생성
        fullName(name, engName){
          return name + "(" + engName + ")";
        },
		    	// # 사전 로드(대표페이지 정보, 로그인회원 팔로우 정보)
        // 1. 대표페이지(아티스트) 정보 조회
        async loadArtist(){
            // 대표페이지 이름
            const artistEngNameLower = window.location.pathname.split("/").at(-2);
			// url
            const url = "${contextPath}/rest/artist/";
			// 조회
            const resp = await axios.get(url, { params: { artistEngNameLower: artistEngNameLower } });
			// 조회 결과 없을 시 
			if(resp.data)
			this.artistObj = resp.data;
			
			this.tagName = this.artistObj.artistName; // 태그명 설정
		},
			
        // 2.로그인 회원 팔로우 정보 로드
        async loadMemberFollowInfo(){
            // 로그인X → 실행 X
            if(memberId==="") return;

            const url = "${contextPath}/rest/follow/memberFollowInfo/"

            const resp = await axios.get(url, {params:{memberId: memberId}});

            // 로그인 팔로우 정보 로드
            this.memberFollowObj = resp.data;
            // 팔로우 버튼 동기화
            this.isFollowingArtist = this.checkFollow();
        },

        // 대표페이지 팔로우확인
        checkFollow(){
            // 로그인 안했으면 return false
            if(memberId === "") return false;
            
            // 팔로우 대표페이지 목록
            const followPageList = this.memberFollowObj.followPageList;

            if(this.memberFollowObj.followPageList!==undefined){
                if(followPageList===null) {
                    return false;
                } else {
                    const isFollowing = followPageList.includes(this.artistObj.artistEngNameLower);
                    return isFollowing;
                }
            }
        },

        // 페이지 팔로우 버튼
        async followPage(){
            // 1. 회원 로그인 확인
            if(memberId === ""){
                if(confirm("로그인 한 회원만 사용할 수 있는 기능입니다. 로그인 하시겠습니까?")) {
                    window.location.href = contextPath + "/member/login";
                }
            }

            // 2. toggle 팔로우 삭제, 팔로우 생성
            if(this.isFollowingArtist){
                if(!confirm(this.fullName(this.artistObj.artistName, this.artistObj.artistEngName) + "님 팔로우를 취소하시겠습니까?")) return;
                this.setFollowPageObj();
                await this.deleteFollow();
            } else {
                this.setFollowPageObj();
                await this.createFollowPage();
            }

            this.loadArtist();
            this.loadMemberFollowInfo();
        },

        // 대표페이지 팔로우 생성
        async createFollowPage(){
            // 팔로우 생성 url
            const url = "${contextPath}/rest/follow/";
            await axios.post(url, this.followPageObj);
        },
        // 대표페이지 팔로우 취소
        async deleteFollow(){
            // 팔로우 생성 url
            const url = "${contextPath}/rest/follow/";
            await axios.delete(url, {
                data: this.followPageObj,
            });
        },
        // 팔로우 토글
        async toggleFollow(){
            // 1. 회원 로그인 확인
            if(memberId === ""){
                if(confirm("로그인 한 회원만 사용할 수 있는 기능입니다. 로그인 하시겠습니까?")) {
                    window.location.href = contextPath + "/member/login";
                }
            }
            // 팔로우 확인 url
        },
		// 대표페이지 팔로우 대상 설정
		setFollowPageObj (){
            // 아티스트 이름
            const artistName = window.location.pathname.split("/").at(-1);
            // 팔로우 대상 유형
            this.followPageObj.followTargetType = "대표페이지";
            // 팔로우 대상 PK
            this.followPageObj.followTargetPrimaryKey = artistName;
        },
        makeHref(target){
            const pathName = window.location.pathname;
			const pathArr = pathName.split('/').slice();
			return pathArr.slice(0, pathArr.length-1).join('/') + '/' + target;
        },
		// ######################## 대표페이지 method 끝 ########################




		// ######################## 후원(lsh) method ########################
		
		// 펀딩리스트 불러오기
        async fetchOrderedFundingList(){
    	   	if(this.finish) return;
    	   	  this.searchPage=1;
    	   	  
              const resp = await axios.get("${contextPath}/rest/fund/page/"+this.searchPage,
                    {
            	  params: {
            		  	// 검색어
                    	searchKeyword : this.artistObj.artistName,
                    	// 정렬 조건
                    	orderList : "",
                    	// 펀딩상태
                    	fundState: ""
                    },
                    paramsSerializer: params => {
                		return new URLSearchParams(params).toString();
                	}
                    });
              console.log(resp.data);
              this.fundings = [...resp.data];
              this.searchPage++;
              
              // 데이터가 12개 미만이면 더 읽을게 없다
                   if(resp.data.length < 12){
                       this.finish = true;
                      }
       },
       
	       // 이미지 주소 설정
	       getImageUrl(funding) {
	           const imageUrl = "/rest/attachment/download/" + funding.attachmentNo;
	           return imageUrl;
           },
           
        	// 상세페이지로 이동
           link(funding){
              window.location.href = "/fund/detail?postNo="+funding.postNo;;
           },
           
        	// 3자리 마다 ,
           formatCurrency(value) {
              return value.toLocaleString();
            },
        	 // 좋아요 체크
			async checkFundLike() {
				const postNo = this.fundDetail.postNo;
				const resp = await axios.get("${contextPath}/rest/post/like/check/"+postNo);
				this.fundings.isLiked = resp.data;
			},
			
			// 아이디 접속해 있고, 좋아요 클릭시에 실행
         	checkLike(postNo,index){
				// if not logged in
				if(!this.checkLogin()) return;
            	axios.get('${contextPath}/rest/post/like/'+postNo)
            		.then(response => {
            			console.log(response.data);
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
            
         // 남은 시간 설정
            getTimeDiff(funding) {
                  const startDate = new Date(funding.postStart);
                  const endDate = new Date(funding.postEnd);
//                   console.log(startDate);
//                   console.log(endDate);
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



		// ######################## 후원(lsh) method(끝) ########################
      },
      async mounted(){
		// 1. 아티스트 정보 로드
        await this.loadArtist();
        // 2. 로그인 한 사람 팔로우 정보 로드
        this.loadMemberFollowInfo();
        this.fetchOrderedFundingList();
      },

	  created(){
		
	  }
    }).mount('#artist-body')
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>