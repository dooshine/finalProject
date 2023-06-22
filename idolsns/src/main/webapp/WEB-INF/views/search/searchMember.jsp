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
      <table class="table" v-if="memberSearchList.length > 0">
        <thead>
          <tr class="text-center">
            <th scope="col">프로필 사진</th>
            <th scope="col">회원 아이디</th>
            <th scope="col">팔로우하기</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(memberSearch, i) in memberSearchList" :key="i" style="height: 300px;">
            <td class="cursor-pointer" @click="moveToMemberPage(memberSearch.memberId)">
              <div class="search-table-col">
                <img :src="memberSearch.attachmentNo === 0 ? '/static/image/profileDummy.png' : '/download/?attachmentNo=' + memberSearch.attachmentNo" style="height: 50px; width: 50px;">
              </div>
            </td>
            <td class="cursor-pointer" @click="moveToMemberPage(memberSearch.memberId)">
              <div class="search-table-col">
                {{fullName(memberSearch.memberId, memberSearch.memberNick)}}
              </div>
            </td>
            <td>
              <div class="search-table-col">
                <%-- 팔로우 버튼(비로그인-로그인모달 at footer) --%>
                <button v-if="memberId===''" data-bs-toggle="modal" data-bs-target="#loginModal" class="custom-btn btn-sm" :class="{'btn-purple1-secondary':!memberSearch.isFollowMember, 'btn-purple1': memberSearch.isFollowMember}"   v-text="memberSearch.isFollowMember?'팔로우취소':'팔로우하기'"></button>
                <%-- 팔로우 버튼(로그인) --%>
                <button v-else class="custom-btn btn-sm" :class="{'btn-purple1-secondary':!memberSearch.isFollowMember, 'btn-purple1': memberSearch.isFollowMember}"  v-text="memberSearch.isFollowMember?'팔로우취소':'팔로우하기'" @click="followMember(i)"></button>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
      <div v-if="memberSearchList.length === 0">
        <h3 class="pb-5 px-4">검색 결과가 없습니다</h3>
      </div>
    </div>
  </div>
  <%-- ######################## 회원 검색결과 끝 ######################## --%>
</div>


<script>
    Vue.createApp({
      data() {
        return {
          memberId: memberId,

          // 로그인 회원 팔로우 목록 조회
          memberFollowObj: {
            memberId: "",
            followMemberList: [],
            followPageList: [],
          },

          // 회원 검색목록
          memberSearchList: [],
          memberSearchObj: {
            memberPage: 1,
            memberId: null,
          },
          search: true,

          followObj: {
            memberId: memberId,
            followTargetType: "",
            followTargetPrimaryKey: "",
          },

          // 무한 스크롤
          percent: 0,

          // 목록을 위한 데이터
          page: 1,
          pocketmonList: [],
          finish: false,

          // 안전장치
          loading: false,
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
        // 회원 팔로우 버튼
        async followMember(index){
            const memberSearch = this.memberSearchList[index];
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
            this.memberSearchList[index].isFollowMember = !this.memberSearchList[index].isFollowMember;
            // this.loadMemberSearchList();
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
          if(this.loading == true) return; //로딩중이면
          if(this.finish == true) return; // 다 불러왔으면
          this.loading = true;

          // q
          const params = new URLSearchParams(window.location.search);
          const q = params.get("q")

          // url
          const url = "${contextPath}/rest/search/member";
          // 조회
          const resp = await axios.get(url, { params: {memberId: q, page: this.page}});

          // 기존 회원 팔로우 수
          const prevFollowCnt  = this.memberSearchList.length;
          // 데이터 반영
          this.memberSearchList.push(...resp.data);
          this.page++;

          this.loading = false;

          if(resp.data.length < 5){
              this.finish = true;
          }

          // 회원팔로우 여부 저장
          for(let i = 0; i<resp.data.length; i++){
            const followMemberId = resp.data[i].memberId;
            this.memberSearchList[prevFollowCnt + i].isFollowMember = this.memberFollowObj.followMemberList.includes(followMemberId);
          }

          // 스크롤이 생기지 않은경우 로드
          if (!this.finish && !(document.body.scrollHeight > window.innerHeight)) {
            // 본문에 스크롤이 필요하지 않은 경우
            this.loadMemberSearchList()
          }
        },

        // 풀네임 생성
        fullName(name, engName){
          return name + "(" + engName + ")";
        },

        // 회원페이지로 이동
        moveToMemberPage(targetId){
          window.location.href = contextPath + "/member/mypage2/" + targetId;
        },
      },
      watch: {
        // percent가 변하면 percent의 값을 읽어와서 80% 이상인지 판정
        percent(){
          if(this.percent >= 80){
            this.loadMemberSearchList();
          }
        }
      },
      async created(){
        // 1. 로그인 회원 팔로우 정보 로드
        await this.loadMemberFollowInfo();
        // (search) 회원 검색목록 조회
        this.loadMemberSearchList();

      },
      mounted(){
        window.addEventListener("scroll", _.throttle(()=>{
          const height = document.body.clientHeight - window.innerHeight;
          const current = window.scrollY;
          const percent = (current / height) * 100;

          // data의 percent를 계산된 값으로 갱신
          this.percent = Math.round(percent);
        }, 250));
      }
    }).mount('#search-body')
</script>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>


	
