<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<div class="container" id="app">
    <div class="row">
        <div class="col">
            <h1>신고 멤버 리스트</h1>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <select v-model="reportDto.reportFor">
                    <option value="">
                        선택하세요
                    </option>
                    <option>
                        부적절한 컨텐츠 게시
                    </option>
                    <option>
                        선정/폭력성
                    </option>
                    <option>
                        스팸/광고
                    </option>
                    <option>
                        거짓 또는 사기
                    </option>
            </select>
        </div>
    </div>
    <div class="row" v-for="(member, i) in memberList" :key="i">
        <div class="col">
            {{member}}
        </div>
        <div class="col">
            <i class="fa-solid fa-user-xmark" data-bs-toggle="modal" data-bs-target="#repotModal1" @click="setReportDto(member.memberId)"></i>
        </div>
        <hr>
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
                <div class="carousel carousel-dark slide" style="position: absolute !important; top: 1.5em !important; right: 1.5em !important;">
                    <button type="button" class="btn-close carousel-control-prev" data-bs-dismiss="modal" aria-label="Close">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    </button>
                </div>
                <div class="modal-body p-0">
                    <!-- 모달에서 표시할 실질적인 내용 구성 -->
                    <div class="w-100 modal-border" style="border-bottom: 1px solid #dee2e6; padding: 0.5em;">
                        <button class="modal-content align-items-center" style="border: 1px solid transparent; font-weight: bold;">신고 사유를 선택해주세요</button>
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
          // 복잡한 검색 시 검색 조건들을 담은 object
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
      },
      watch: {
  
      },
      created(){
            this.loadMember();
      },
      mounted(){
        // this.modal = new bootstrap.Modal(this.$refs.modal03);
      },
    }).mount('#app')
  </script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	
	