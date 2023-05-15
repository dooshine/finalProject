<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<div class="container" id="app">
    <div class="row">
        <article class="col">
            <h1>신고 멤버 리스트</h1>
        </article>
    </div>
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
    <div class="row" v-for="(member, i) in memberList" :key="i">
        <div class="col">
            {{member}}
        </div>
        <div class="col">
            
            <i class="fa-solid fa-user-xmark" @click="reportMember(member.memberId)"></i>
        </div>
        <hr>
    </div>

    <!-- 버튼 -->
    <button type="button" class="btn btn-primary" v-on:click="showModal">열기(VueJS)</button>
    <!-- 모달 -->
    <div class="modal" tabindex="-1" role="dialog" id="modal03" data-bs-backdrop="static" ref="modal03">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">신고</h5>
                </div>
                <div class="modal-body">
                    <!-- 모달에서 표시할 실질적인 내용 구성 -->
                    <p>본문 내용</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
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
            console.log(this.reportDto);
        },
        // 회원신고 생성
        async reportMember(target){
            // 신고 대상 설정
            this.setReportDto(target);
            console.log(this.reportDto);
            // const url = "http://localhost:8080/rest/report/"
            // await axios.post(url, this.reportDto);
        },
      },
      watch: {
  
      },
      created(){
            this.loadMember();
      },
      mounted(){
        this.modal = new bootstrap.Modal(this.$refs.modal03);
      },
    }).mount('#app')
  </script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	
	