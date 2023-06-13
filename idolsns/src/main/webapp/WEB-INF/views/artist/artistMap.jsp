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
	                <img class="artist-profile-img" :src="artistObj.profileSrc">
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
				<a class="font-bold px-4 artist-header-tab artist-header-tab-active" :href="makeHref('map')">
					지도
				</a>
				<a class="font-bold px-4 artist-header-tab" :href="makeHref('fund')">
					후원
                </a>
			</div>
		</div>
		<%-- ######################## 대표페이지 헤더 끝######################## --%>
	</div>

	<div class="custom-container mt-3 row mx-0">
		<!-- [Component] 지도 -->
		<div class="col border custom-container mh-300 me-3 p-4">
			<div class="arti_title">🗺️지도</div>
			<div class="row">
				<div class="col container pt-3 px-4">
					<div id="mapShow" class="border" style="width: 100%; height: 300px;"></div>
				</div>  
			</div>	
		</div>
		<!-- [Component] 성지순례 목록글 -->
		<div class="col border custom-container mh-300 p-4">
			<div class="row">
				<div class="col">
					<div class="arti_title">📍성지순례</div>
				</div>
			</div>
			<div class="row">
				<div class="col container pt-3 px-4">
					<div v-for="post in postShowDto" :key="post.tagName">
						<template v-if="post.mapName !== null">
							<div @click="showMap(post.mapName,post.mapPlace)" data-bs-target="#showMap" data-bs-toggle="modal">
								<i class="fa-solid fa-location-dot me-1" :class="{'active-icon': selectedIcon === post.mapName}"></i>
								{{ post.mapName }}
							</div>
						</template>
					</div>
				</div>
			</div>
		</div>
	</div>
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

			postShowDto: [],
			positions:[],

			map:null,

			// 지도에 주소 표시하는 문자열
			showMapName: '',
			showMapPlace: '',

			isFollowingArtist: false,
        };
      },
      computed: {
      },
	  watch: {
		artistTab(curVal){
			if(curVal==='map'){
				this.loadPositions();
			}
		}
	  },
      methods: {
		// ######################## 대표페이지 method ########################

		// 대표페이지 헤더 탭 변경
		changeArtistPage(tab){
			this.artistTab = tab;

			if(tab === "map"){

				this.loadTags();

				// 카카오맵 API 로드
				const script = document.createElement('script');
				script.type = 'text/javascript';
				script.src = 'https://dapi.kakao.com/v2/maps/sdk.js?appkey=047888df39ba653ff171c5d03dc23d6a&autoload=false';
				script.onload = () => {
					kakao.maps.load(() => {
					this.loadArtist();
					this.loadMemberFollowInfo();
					});
				};
    	  		document.head.appendChild(script);
				
				// this.showMap(this.postShowDto[0].mapName,this.postShowDto[0].mapPlace);

			}
			
		},

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
            const url = "http://localhost:8080/rest/artist/";
			// 조회
            const resp = await axios.get(url, { params: { artistEngNameLower: artistEngNameLower } });
			// 조회 결과 없을 시 
			if(resp.data)
			this.artistObj = resp.data;
			
			await this.loadTags();
			this.showMap(this.postShowDto[0].mapName,this.postShowDto[0].mapPlace);
			
			this.tagName = this.artistObj.artistName; // 태그명 설정
		},
			
        // 2.로그인 회원 팔로우 정보 로드
        async loadMemberFollowInfo(){
            // 로그인X → 실행 X
            if(memberId==="") return;

            const url = "http://localhost:8080/rest/follow/memberFollowInfo/"

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
            const url = "http://localhost:8080/rest/follow/";
            await axios.post(url, this.followPageObj);
        },
        // 대표페이지 팔로우 취소
        async deleteFollow(){
            // 팔로우 생성 url
            const url = "http://localhost:8080/rest/follow/";
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
		// ######################## 대표페이지 헤더 끝########################


    	  
    	
		// ######################## 맵 method ########################
    	async loadTags() {
			const tagName = this.artistObj.artistName;
			const url = "/rest/post/" + tagName;
		
			const resp = await axios.get(url);
			this.postShowDto = resp.data;
		
			await this.loadPositions();
		},

		// 키워드 검색 완료 시 호출되는 콜백함수 입니다
    	showMapPlacesSearchCB (data, status, pagination) {
			if (status === kakao.maps.services.Status.OK) {

				// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
				// LatLngBounds 객체에 좌표를 추가합니다
				var bounds = new kakao.maps.LatLngBounds();

				for (var i=0; i<data.length; i++) {
					bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
					if(i==0) break;      		          
				}       

				// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
				this.map.setBounds(bounds);
			} 
		},
		// positions 불러오기
		loadPositions() {
	   		for(let i=0; i<this.postShowDto.length; i++) {
	   			this.positions[i] = this.postShowDto[i].mapPlace;
	   		}  
	   		
	   		
			var mapContainer = document.getElementById('mapShow'), // 지도를 표시할 div 
				mapOption = {
					center: new kakao.maps.LatLng(37.606826, 126.8956567), // 지도의 중심좌표
					level: 3 // 지도의 확대 레벨
				};  

			// 지도를 생성합니다    
			this.map = new kakao.maps.Map(mapContainer, mapOption); 
			
			// 장소 검색 객체를 생성합니다
			var ps = new kakao.maps.services.Places();
			
			const filterArray = this.postShowDto.map(dto=>dto.mapName).filter(data=>data!==null);
			
			ps.keywordSearch(filterArray,(data, status, pagination)=>{
				if(status === kakao.maps.services.Status.OK) {
					this.displayMarker({x:data.x, y:data.y});
				}
			});
					
			
		},
    	 
    	// 클릭 시 지도 정보 불러오기-------------------------
      	showMap(keyword1,keyword2){
			//아이콘  색넣기
			this.selectedIcon = keyword1;
				
            this.showMapName = keyword1;
            this.showMapPlace = keyword2;
            
            
            // 마커를 담을 배열입니다
            var markers = [];
            keyword2 = keyword2.replace(/\s+\d+$/, '');
         	var keyword = keyword1;
            // 지도 정보를 담을 변수
            let mapPlace = "기본";

            
      		// 장소 검색 객체를 생성합니다
      		var ps = new kakao.maps.services.Places();  
	
      		ps.keywordSearch(keyword,(data, status, pagination)=>{
      			this.showMapPlacesSearchCB(data, status, pagination);
      		});
      	},
     
      	// 지도에 마커를 표시하는 함수입니다
  		displayMarker(place) {
  		    // 마커를 생성하고 지도에 표시합니다
  		    var marker = new kakao.maps.Marker({
  		        map: this.map,
  		        position: new kakao.maps.LatLng(place.y, place.x) 
  		    });

  		    // 마커에 클릭이벤트를 등록합니다
  		    kakao.maps.event.addListener(marker, 'click', function() {
  		        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
  		        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
  		        infowindow.open(this.map, marker);
  		    });
  		},
		// ######################## 맵 method 끝 ########################
      },
      mounted(){  

		// 카카오맵 API 로드
		const script = document.createElement('script');
		script.type = 'text/javascript';
		script.src = 'https://dapi.kakao.com/v2/maps/sdk.js?appkey=047888df39ba653ff171c5d03dc23d6a&autoload=false';
		script.onload = () => {
			kakao.maps.load(() => {
				this.loadArtist();
				this.loadMemberFollowInfo();
			});
		};

		document.head.appendChild(script);
        // 1. 아티스트 정보 로드
        this.loadArtist();
        // 2. 로그인 한 사람 팔로우 정보 로드
        this.loadMemberFollowInfo();
      },
	  created(){
		
	  }
    }).mount('#artist-body');
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>