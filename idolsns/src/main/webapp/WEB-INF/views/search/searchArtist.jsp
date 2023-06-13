<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

  
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link href='https://cdn.jsdelivr.net/npm/@mdi/font@7.2.96/css/materialdesignicons.min.css' rel='stylesheet'>

<style>
  * {
    box-sizing: border-box !important;
  }
  .search-table-col {
    height: 50px; 
    width: 100%; 
    display: flex; 
    align-items: center; 
    justify-content: center;
  }
  .custom-tab-list:not(.active) * {
  text-decoration: none;
  font-weight: normal;
  color: #333;
  }
  .custom-tab-list {
    padding: 12px 20px;
  }
  .cursor-pointer {
    cursor: pointer;
  }
  .hover-back:hover {
    background-color: #f2f2f2;
  }
</style>


<div class="container custom-container" id="search-body" style="padding: 0px;">
  <div class="row mx-0">
    <div class="col p-0" style="border-radius: 0px;">
      <%-- 검색 nav --%>
      <jsp:include page="/WEB-INF/views/search/searchNav.jsp"></jsp:include>
    </div>
  </div>
  <%-- ######################## 대표페이지 검색결과 ######################## --%>
  <div class="row mt-5">
    <div class="col">
      <table class="table" v-if="artistSearchList.length > 0">
        <thead>
          <tr class="text-center">
            <th scope="col">프로필 사진</th>
            <th scope="col">대표페이지 이름</th>
            <th scope="col">팔로우수</th>
            <th scope="col">팔로우하기</th>
          </tr>
        </thead>
        <tbody>
          <tr class="hover-back" v-for="(artistSearch, i) in artistSearchList" :key="i">
            <td class="cursor-pointer" @click="goArtistPage(artistSearch)">
              <div class="search-table-col">
                <img :src="artistSearch.attachmentNo === 0 ? '/static/image/profileDummy.png' : '/download/?attachmentNo=' + artistSearch.attachmentNo" style="width: 50px; height: 50px;">
              </div>
            </td>
            <td class="cursor-pointer" @click="goArtistPage(artistSearch)">
              <div class="search-table-col">
                {{fullName(artistSearch.artistName, artistSearch.artistEngName)}}
              </div>
            </td>
            <td class="cursor-pointer" @click="goArtistPage(artistSearch)">
              <div class="search-table-col">
                {{artistSearch.followCnt ?? 0}}
              </div>
            </td>
            <td>
              <div class="search-table-col">
                <button class="btn rounded-pill" :class="{'btn-primary':!artistSearch.isFollowPage, 'btn-secondary': artistSearch.isFollowPage}"  v-text="artistSearch.isFollowPage?'팔로우취소':'팔로우하기'" @click="followPage(artistSearch)"></button>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
      <div v-if="artistSearchList.length === 0">
        <h3 class="pb-5 px-4">검색 결과가 없습니다</h3>
      </div>
    </div>
  </div>
  <%-- ######################## 대표페이지 검색결과 끝 ######################## --%>
    
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
          // 대표페이지 검색목록
          artistSearchList: [],
          artistSearchVO: {
            artistPage: 1,
            size: 15,
          },

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



        // [search] 대표페이지 검색목록 조회
        async loadArtistSearchList(){
          // q
          const params = new URLSearchParams(window.location.search);
          const q = params.get("q")

          // url
          const url = "${contextPath}/rest/artist/search";

          // 조회
          const resp = await axios.get(url, { params: {q: q, page: this.artistPage++}});

          this.artistSearchList = resp.data;

          // 팔로우 여부 저장
          for(let i = 0; i<this.artistSearchList.length; i++){
            const artistName = this.artistSearchList[i].artistEngNameLower;
            this.artistSearchList[i].isFollowPage = this.memberFollowObj.followPageList.includes(artistName);
          }
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


        // 대표페이지 팔로우 대상 설정
        setFollowPageObj (artistName){
            // 팔로우 대상 유형
            this.followObj.followTargetType = "대표페이지";
            // 팔로우 대상 PK
            this.followObj.followTargetPrimaryKey = artistName;
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


        // 풀네임 생성
        fullName(name, engName){
          return name + "(" + engName + ")";
        },


        goArtistPage(artistSearch){
          window.location.href="/artist/" + artistSearch.artistEngNameLower + "/feed";
        },

      },
      watch: {
  
      },
      async created(){
        // 1. 로그인 회원 팔로우 정보 로드
        await this.loadMemberFollowInfo();
        // (search) 대표페이지 검색목록 조회
        this.loadArtistSearchList();
      },
    }).mount('#search-body')
</script>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>


	
