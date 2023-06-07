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
  .cursor-pointer:hover {
    cursor: pointer;
  }
  .border-bottom {
    border-bottom: 1px solid gray;
  }
  .select {
    border-bottom: 2px solid black;
  }
  .custom-tab-list:not(.active) * {
  text-decoration: none;
  font-weight: normal;
  color: #333;
  }
  .custom-tab-list {
    padding: 12px 20px;
  }
</style>


<div class="container custom-container" id="search-body" style="padding: 0px;">
  <div class="row mx-0">
    <div class="col p-0" style="border-radius: 0px;">
      <%-- 검색 nav --%>
      <jsp:include page="/WEB-INF/views/search/searchNav.jsp"></jsp:include>
    </div>
  </div>
  <%-- ######################## 회원 검색결과 ######################## --%>
  <div class="row mt-5">
    <div class="col">
      <table class="table">
        <thead>
          <tr class="text-center">
            <th scope="col">프로필 사진</th>
            <th scope="col">회원 아이디</th>
            <th scope="col">팔로우하기</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(memberSearch, i) in memberSearchList" :key="i">
            <td class="cursor-pointer">
              <div class="search-table-col">
                <img :src="memberSearch.attachmentNo === 0 ? '/static/image/profileDummy.png' : '/download/?attachmentNo=' + memberSearch.attachmentNo" style="height: 50px; width: 50px;">
              </div>
            </td>
            <td class="cursor-pointer">
              <div class="search-table-col">
                {{fullName(memberSearch.memberId, memberSearch.memberNick)}}
              </div>
            </td>
            <td>
              <div class="search-table-col">
                <button class="btn rounded-pill" :class="{'btn-primary':!memberSearch.isFollowMember, 'btn-secondary': memberSearch.isFollowMember}"  v-text="memberSearch.isFollowMember?'팔로우취소':'팔로우하기'" @click="followMember(memberSearch)">팔로우하기</button>
              </div>
            </td>
          </tr>
          <tr v-if="memberSearchList.length === 0">
            <td colspan="3">
              <h3 class="m-3">검색 결과가 없습니다</h3>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
  <%-- ######################## 회원 검색결과 끝 ######################## --%>
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

          // 회원 검색목록
          memberSearchList: [],
          memberPage: 1,
          search: true,

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
          const url = "http://localhost:8080/rest/follow/memberFollowInfo/"
          // 팔로우 목록 load
          const resp = await axios.get(url, {params:{memberId: memberId}});
          // 로그인 팔로우 정보 로드
          this.memberFollowObj = resp.data;
        },

        // 대표페이지 팔로우 생성
        async createFollow(){
            // 팔로우 생성 url
            const url = "http://localhost:8080/rest/follow/";
            await axios.post(url, this.followObj);
            // [develope] 
        },
        // 대표페이지 팔로우 취소
        async deleteFollow(){
            // 팔로우 생성 url
            const url = "http://localhost:8080/rest/follow/";
            await axios.delete(url, {
                data: this.followObj,
            });
            // [develope]
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


        // (search) 회원 검색목록 조회
        async loadMemberSearchList(){
          // q
          const params = new URLSearchParams(window.location.search);
          const q = params.get("q")

          // url
          const url = "http://localhost:8080/rest/search/member";
          // 조회
          const resp = await axios.get(url, { params: {memberId: q}});
        
          // 데이터 반영
          this.memberSearchList = resp.data;


          // 회원팔로우 여부 저장
          for(let i = 0; i<this.memberSearchList.length; i++){
            const followMemberId = this.memberSearchList[i].memberId;
            this.memberSearchList[i].isFollowMember = this.memberFollowObj.followMemberList.includes(followMemberId);
          }
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
        // (search) 회원 검색목록 조회
        this.loadMemberSearchList();

      },
    }).mount('#search-body')
</script>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>


	
