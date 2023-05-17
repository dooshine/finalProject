<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>

<style>

</style>

<div class="container" id="app">
    <!-- # 회원조회 타이틀 -->
    <div class="row">
        <div class="col">
            <h1>신고 멤버 리스트</h1>
        </div>
    </div>

    <!-- # 회원리스트 검색도구 -->
    <div class="row">
        <div class="col">
            <!-- 검색타이틀 -->
            <div class="row">
                <div class="col">
                    <h3>검색설정</h3>
                </div>
            </div>
            <!-- 검색옵션 -->
            <div class="row">
                <div class="col">
                    <label>
                        회원아이디
                        <input type="text" v-model="memberSearchVO.memberId">
                    </label>
                </div>
                <div class="col">
                    <label>
                        회원닉네임
                        <input type="text" v-model="memberSearchVO.memberNick">
                    </label>
                </div>
                <div class="col">
                    <label>
                        회원이메일
                        <input type="text" v-model="memberSearchVO.memberEmail">
                    </label>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col">
                    <label>
                        최소포인트
                        <input type="text" v-model="memberSearchVO.minPoint">
                    </label>
                </div>
                <div class="col">
                    <label>
                        최대포인트
                        <input type="text" v-model="memberSearchVO.maxPoint">
                    </label>
                </div>
                <div class="col">
                    동의여부
                    <label>
                        <input type="checkbox" v-model="agree">
                        동의
                    </label>
                    <label>
                        <input type="checkbox" v-model="disagree">
                        비동의
                    </label>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col">
                    <label>
                        가입일자(이후)
                        <input type="date" v-model="memberSearchVO.beginJoinDate">
                    </label>
                </div>
                <div class="col">
                    <label>
                        가입일자(이전)
                        <input type="date" v-model="memberSearchVO.endJoinDate">
                    </label>
                </div>
                <div class="col">
                    <label>
                        최초로그인일자
                        <input type="date" v-model="memberSearchVO.searchLoginDays">
                    </label>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col">
                    회원레벨
                    <label>
                        <input type="checkbox" v-model="user">
                        일반회원
                    </label>
                    <label>
                        <input type="checkbox" v-model="adminUser">
                        관리자
                    </label>
                </div>
                <div class="col">
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
                    <label>
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
                    <button type="button" @click="searchMember">검색하기</button>
                </div>
            </div>
        </div>
    </div>
    

    <!-- # 회원리스트 목록-->
    <div class="row">
        <div class="col">
            <h3>목록</h3>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">회원아이디</th>
                        <th scope="col">회원닉네임</th>
                        <th scope="col">회원포인트</th>
                        <th scope="col">회원이메일</th>
                        <th scope="col">회원가입날짜</th>
                        <th scope="col">최근로그인날짜</th>
                        <th scope="col">관리도구</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(member, i) in memberList" :key="i">
                        <td>
                            {{member.memberId}}
                        </td>
                        <td>{{member.memberNick}}</td>
                        <td>{{member.memberPoint}}</td>
                        <td>{{member.memberEmail}}</td>
                        <td>{{member.memberJoin}}</td>
                        <td>{{member.memberLogin === null ? "미접속": member.memberLogin }}</td>
                        <td><i class="fa-solid fa-user-xmark" data-bs-toggle="modal" data-bs-target="#repotModal1" @click="setReportDto(member.memberId)"></i></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>


    <!-- <div class="row" v-for="(member, i) in memberList" :key="i">
        <div class="col">
            {{member}}
        </div>
        <div class="col">
            <i class="fa-solid fa-user-xmark" data-bs-toggle="modal" data-bs-target="#repotModal1" @click="setReportDto(member.memberId)"></i>
        </div>
        <hr>
    </div> -->

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
        async loadMember(){
            const url = "http://localhost:8080/rest/member/"
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
        }
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
      },
      created(){
            this.loadMember();
      },
      mounted(){
        // this.modal = new bootstrap.Modal(this.$refs.modal03);
      },
    }).mount('#app')
  </script>

<jsp:include page="/WEB-INF/views/admin/adminFooter.jsp"></jsp:include>
	
	