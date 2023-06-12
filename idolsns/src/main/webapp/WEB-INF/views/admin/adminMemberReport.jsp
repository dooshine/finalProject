<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .back-gray {
        background: #f2f2f2;
    }
    .total-cnt {
        color: forestgreen;
    }
</style>

<div class="container" id="app">
    <!-- # 회원조회 타이틀 -->
    <div class="row mt-3">
        <div class="col">
            <h1>회원 목록</h1>
        </div>
    </div>

    <!-- # 회원리스트 검색도구 -->
    <div class="row mt-3">
        <div class="col back-gray border border-secondary-subtle p-4">
            <!-- 검색타이틀 -->
            <!-- <div class="row">
                <div class="col">
                    <h3>검색설정</h3>
                </div>
            </div> -->
            <!-- 검색옵션 -->
            <div class="row">
                <div class="col">
                    <label>
                        회원아이디
                        <input class="ms-3" type="text" v-model="memberSearchVO.memberId">
                    </label>
                </div>
                <div class="col">
                    <label>
                        회원닉네임
                        <input class="ms-3" type="text" v-model="memberSearchVO.memberNick">
                    </label>
                </div>
                <div class="col">
                    <label>
                        회원이메일
                        <input class="ms-3" type="text" v-model="memberSearchVO.memberEmail">
                    </label>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col">
                    <label>
                        최소포인트
                        <input class="ms-3" type="text" v-model="memberSearchVO.minPoint">
                    </label>
                </div>
                <div class="col">
                    <label>
                        최대포인트
                        <input class="ms-3" type="text" v-model="memberSearchVO.maxPoint">
                    </label>
                </div>
                <div class="col">
                    동의여부
                    <label class="ms-3">
                        <input type="checkbox" v-model="agree">
                        동의
                    </label>
                    <label class="ms-3">
                        <input type="checkbox" v-model="disagree">
                        비동의
                    </label>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col">
                    <label>
                        가입일자(이후)
                        <input class="ms-3" type="date" v-model="memberSearchVO.beginJoinDate">
                    </label>
                </div>
                <div class="col">
                    <label>
                        가입일자(이전)
                        <input class="ms-3" type="date" v-model="memberSearchVO.endJoinDate">
                    </label>
                </div>
                <div class="col">
                    <label>
                        최초로그인일자
                        <input class="ms-3" type="date" v-model="memberSearchVO.searchLoginDays">
                    </label>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-4">
                    회원레벨
                    <label class="ms-3">
                        <input type="checkbox" v-model="user">
                        일반회원
                    </label>
                    <label class="ms-3">
                        <input type="checkbox" v-model="adminUser">
                        관리자
                    </label>
                </div>
                <div class="col-8">
                    <label>
                        1차 정렬
                        <select v-model="memberSearchVO.orderList[0]">
                            <option value="">선택하세요</option>
                            <option value="memberId">아이디순</option>
                            <option value="memberJoin">최근가입순</option>
                            <option value="memberLogin">최근로그인순</option>
                            <option value="memberPoint">포인트순</option>
                        </select>
                    </label>
                    <label class="ms-3">
                        2차 정렬
                        <select v-model="memberSearchVO.orderList[1]">
                            <option value="">선택하세요</option>
                            <option value="memberId">아이디순</option>
                            <option value="memberJoin">최근가입순</option>
                            <option value="memberLogin">최근로그인순</option>
                            <option value="memberPoint">포인트순</option>
                        </select>
                    </label>
                </div>
            </div>
            <!-- 검색버튼 -->
            <div class="row mt-3 text-end">
                <div class="col">
                    <button class="btn-round btn-purple1" type="button" @click="searchMember">검색하기</button>
                </div>
            </div>
        </div>
    </div>
    

    <!-- # 회원리스트 목록-->
    <div class="row mt-5">
        <div class="col-4">
            전체 <span class="total-cnt">{{memberList.length}}</span>건
            <span class="ms-4">페이지<input class="ms-2" v-model.number="pageObj.page"></span>
            <button @click="checkPageObj">확인</button>
        </div>
        <div class="offset-7 col-1">
            <button @click="changeMember"><i class="fa-solid fa-xmark"></i>삭제</button>
        </div>
    </div>
    <div class="row">
        <div class="col p-0">
            <table class="table">
                <thead>
                    <tr class="back-gray">
                        <th scope="col">번호</th>
                        <th scope="col">전체<br><input type="checkbox"  @change="checkAllMember($event)"></th>
                        <th scope="col">회원프로필</th>
                        <th scope="col">회원아이디(닉네임)/회원이메일</th>
                        <th scope="col">팔로우/팔로워</th>
                        <th scope="col">회원포인트</th>
                        <th scope="col">가입일/최종로그인</th>
                        <th scope="col">관리도구</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(member, i) in memberList.slice(pageObj.begin - 1, pageObj.end)" :key="i">
                        <td>{{pageObj.begin + i}}</td>
                        <td><input type="checkbox" @change="checkMember($event, member.memberId)" :checked="selectedMemberObj[member.memberId]"></td>
                        <td><img :src="member.profileSrc" style="height: 50px; width: 50px;"></td>
                        <td>
                            {{fullName(member.memberId, member.memberNick)}}<br>
                            {{member.memberEmail}}
                        </td>
                        <td>{{member.memberFollowCnt}}/{{member.memberFollowerCnt}}</td>
                        <td>{{member.memberPoint}}</td>
                        <td>
                            {{member.memberJoin}}<br>
                            {{member.memberLogin === null ? "미접속": member.memberLogin }}
                        </td>
                        <!-- <td>{{member.memberLogin === null ? "미접속": member.memberLogin }}</td> -->
                        <td><i class="fa-solid fa-user-xmark" data-bs-toggle="modal" data-bs-target="#repotModal1" @click="setReportDto(member.memberId)"></i>
                    <button class="btn btn-primary" @click="followMember(member.memberId)">팔로우하기</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col text-center">
            <nav aria-label="...">
                <ul class="pagination justify-content-center">
                  <li v-for="i in pageObj.end-pageObj.begin+1" :key="i">
                    {{i}}
                  </li>
                  <!-- <li class="page-item disabled">
                    <span class="page-link">Previous</span>
                  </li>
                  <li class="page-item"><a class="page-link" href="#">1</a></li>
                  <li class="page-item active" aria-current="page">
                    <span class="page-link">2</span>
                  </li>
                  <li class="page-item"><a class="page-link" href="#">3</a></li>
                  <li class="page-item">
                    <a class="page-link" href="#">Next</a>
                  </li> -->
                </ul>
            </nav>
        </div>
    </div>

    <style>
        .modal-border {
            border: 1px solid #dee2e6;
        }
        .no-border {
            border: 1px solid transparent !important;
        }
    </style>
    <!-- 신고 모달1 -->
    <div class="modal" tabindex="-1" role="dialog" id="repotModal1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content position-relative">
                <div class="modal-header">
                    <h4 class="modal-title mx-auto" style="color: #ff4757;">신고</h4>
                </div>
                <!-- 닫기 버튼 -->
                <div style="position: absolute !important; top: 1.5em !important; right: 1.5em !important;">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body p-0">
                    <!-- 모달에서 표시할 실질적인 내용 구성 -->
                    <div class="w-100 modal-border" style="border-bottom: 1px solid #dee2e6; padding: 0.5em;">
                        <button class="modal-content align-items-center" style="border: 1px solid transparent; font-weight: bold;">({{reportDto.reportTargetPrimaryKey}}) 신고 사유를 선택해주세요</button>
                    </div>
                    
                    <div v-for="(reportFor, i) in reportForList" :key="i" class="w-100 modal-border" style="border-bottom: 1px solid #dee2e6; padding: 0.5em;">
                        <button v-text="reportFor" class="modal-content align-items-center" style="border: 1px solid transparent;" data-bs-target="#repotModal2" data-bs-toggle="modal" @click="setReportFor(reportFor)"></button>
                    </div>
                    
                    <div class="w-100 modal-content" style="border: 1px solid transparent; padding: 0.5em;">
                        <button class="modal-content align-items-center" style="border: 1px solid transparent;" data-bs-target="#repotModal2" data-bs-toggle="modal" @click="setReportFor('기타')">기타</button>
                    </div>
                </div>
            </div>      
        </div>
    </div>
    <!-- 신고 모달2 -->
    <div class="modal" tabindex="-1" role="dialog" id="repotModal2">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content position-relative">
                <div class="modal-header">
                    <h4 class="modal-title mx-auto">선택한 항목</h4>
                </div>

                <!-- 이전버튼 -->
                <div class="carousel carousel-dark" style="position: absolute !important; top: 1.5em !important; left: 1.5em !important; width: 1.5em; height: 1.5em;">
                    <button class="carousel-control-prev w-100 h-100" type="button" data-bs-target="#repotModal1" data-bs-toggle="modal">
                        <span class="carousel-control-prev-icon" aria-hidden="true" style="padding: 4px;"></span>
                    </button>
                </div>

                <!-- 닫기 버튼 -->
                <div style="position: absolute !important; top: 1.5em !important; right: 1.5em !important;">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>


                <!-- 모달에서 표시할 실질적인 내용 구성 -->
                <div class="modal-body align-items-center">
                    <p style="text-align: center;">{{reportDto.reportFor}}</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger w-100" data-bs-dismiss="modal" @click="reportMember">신고하기</button>
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
          // 관리자 회원검색 조건 VO
          memberSearchVO: {
            memberId: "",
            memberNick: "",
            minPoint: "",
            maxPoint: "",
            memberEmail: "",
            memberAgreeList: [],
            beginJoinDate: "",
            endJoinDate: "",
            memberLevelList: [],
            searchLoginDays: "",
            orderList: [],
          },
          // 신고 리스트
          reportForList: [ "부적절한 컨텐츠 게시", "선정/폭력성", "스팸/광고", "거짓 또는 사기", "테스트리폿사유" ],
          // 회원신고 생성 시 신고 내용을 담은 object   
          reportDto: {
            memberId: memberId,
            reportTargetType: "회원",
            reportTargetPrimaryKey: "",
            reportFor: "",
          },
          // 회원리스트  
          memberList: [],
          // 선택된 회원 Object
          selectedMemberObj: {},
          // 선택된 회원 List
          selectedMemberList: [],


          // 페이지 Obj
          pageObj: {
            page: 1,
            size: 10,
            get begin(){
                return (this.page - 1) * this.size + 1;
            }, 
            // get end(){
            //     return ;
            // },
          },
        // end: this.page * this.size < memberList.length ? this.page * this.size : memberList.length,


          modal: null,

          // 체크리스트
          // 동의/비동의
          agree: false,
          disagree: false,
          // 회원/관리자
          user: false,
          adminUser: false,
          // 1차정렬/2차정렬
        };
      },
      computed: {
  
      },
      methods: {
        showModal(){
            if(this.modal == null) return;
            this.modal.show();
        },
        hideModal(){
            if(this.modal == null) return;
            this.modal.hide();
        },
        // 멤버 불러오기
        async loadMemberList(){
            const url = "http://localhost:8080/rest/admin/member"
            const response = await axios.post(url, this.memberSearchVO);
            this.memberList = _.cloneDeep(response.data);
        },
        // 신고 대상 설정
        setReportDto(target){
            this.reportDto.reportTargetPrimaryKey = target;
        },
        // 신고 이유 설정
        setReportFor(reportFor){
            this.reportDto.reportFor = reportFor;
            console.log(this.reportDto.reportFor);
        },
        // 회원신고 생성
        async reportMember(target){
            console.log(this.reportDto);
            const url = "http://localhost:8080/rest/report/"
            const resp = await axios.post(url, this.reportDto);
        },
        // 회원 비동기 검색
        async searchMember(){
            const url = "http://localhost:8080/rest/report/test/";
            const resp = await axios.post(url, this.memberSearchVO);
            this.memberList = _.cloneDeep(resp.data);
            // console.table(this.memberSearchVO);
        },
        // 회원 팔로우 생성
        async followMember(followTargetId){
            const url = "http://localhost:8080/rest/follow/member";
            const resp = await axios.post(url, { followTargetPrimaryKey: followTargetId });
        },
        // 팔로우 목록(회원) 불러오기
        async loadMemberFollow(){
            // 로그인한 상태가 아니라면 실행X
            if(memberId==="") return;
            const url = "http://localhost:8080/rest/follow/member";
            const resp = await axios.get(url, { param: {memberId: memberId} });
            console.log(resp.data);
        },



        // 회원 개별선택
        checkMember(e, memberId){
            if(e.target.checked){
                this.selectedMemberObj[memberId] = true;
            } else {
                delete this.selectedMemberObj[memberId];
            }
        },

        // # 선택회원 일괄처리(회원아이디)
        async changeMember(){
            // 아티스트 선택 전처리 함수
            if(!this.preMemberAccess()) return;

            // 사용자 확인
            const selectedCnt = this.selectedMemberList.length;
            if(selectedCnt===0 && !confirm(selectedCnt + "개의 회원을 변경하시겠습니까?")) return;

            console.table(this.selectedMemberList)

            // URL
            // const url = "http://localhost:8080/rest/artist/"
            // 아티스트 삭제

            // const resp = await axios.delete(url, { 
                // data: this.selectedMemberList,
            // });

            // 선택항목 초기화
            this.setSelectedMemberEmpty();

            // 아티스트 목록 조회
            this.loadMemberList();

            alert(selectedCnt + "개의 회원의 정보가 변경되었습니다.")
        },

        // 선택회원 일괄처리 (회원 수정-자유,고정, 삭제-태그이름) 전처리 함수
        preMemberAccess(){
            // 1. 선택된 태그 이름 리스트 초기화
            this.setSelectedMemberList();
            
            // 2. 선택된 항목이 없다면 실행 X
           if(!this.isSelectedMemberExist()) return false;

            return true;
        },
        // 선택된 태그 존재여부 확인
        isSelectedMemberExist(){
            // 선택된 태그 갯수
            const selectedMemberLeng = this.selectedMemberList.length;
            // 선택된 태그 존재여부
            const selectedMemberExist = selectedMemberLeng !== 0;
            return selectedMemberExist;
        },




        
        // 선택된 회원 배열 생성
        setSelectedMemberList(){
            this.selectedMemberList = Object.keys(this.selectedMemberObj);
        },
        // 선택된 태그 초기화
        setSelectedMemberEmpty(){
            this.selectedMemberObj = {};
            this.selectedMemberList = [];
        },
        // 회원 전체선택
        checkAllMember(e){
            if(e.target.checked){
                for(let i = 0; i<this.memberList.length; i++){
                    this.selectedMemberObj[this.memberList[i].memberId] = true;
                    this.setSelectedMemberList();
                }
            } else {
                this.setSelectedMemberEmpty();
            }
        },

        checkPageObj(){
            console.table(this.pageObj);
        },


        // 풀네임 생성
        fullName(name, engName){
          return name + "(" + engName + ")";
        },
      },
      watch: {
        "agree": function(){
            if(this.agree){
                this.memberSearchVO.memberAgreeList.push("동의");
            } else {
                this.memberSearchVO.memberAgreeList = this.memberSearchVO.memberAgreeList.filter(item=>item!=="동의");
            }
        },
        "disagree": function(){
            if(this.disagree){
                this.memberSearchVO.memberAgreeList.push("비동의");
            } else {
                this.memberSearchVO.memberAgreeList = this.memberSearchVO.memberAgreeList.filter(item=>item!=="비동의");
            }
        },
        "user": function(){
            if(this.user){
                this.memberSearchVO.memberLevelList.push("일반회원");
            } else {
                this.memberSearchVO.memberLevelList = this.memberSearchVO.memberLevelList.filter(item=>item!=="일반회원");
            }
        },
        "adminUser": function(){
            if(this.adminUser){
                this.memberSearchVO.memberLevelList.push("관리자");
            } else {
                this.memberSearchVO.memberLevelList = this.memberSearchVO.memberLevelList.filter(item=>item!=="관리자");
            }
        },
        memberList: {
          deep: true,
          handler(newVal, oldVal) {
            this.pageObj.end = Math.min(this.pageObj.page * this.pageObj.size, this.memberList.length);
            // this.pageObj.end = this.pageObj.page * this.pageObj.size < this.memberList.length ? this.pageObj.page * this.pageObj.size : this.memberList.length;
          }
        },
      },
      created(){
            this.loadMemberList();
            this.loadMemberFollow();
      },
      mounted(){
        // this.modal = new bootstrap.Modal(this.$refs.modal03);
      },
    }).mount('#app')
  </script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>	
	