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
            
            <i class="fa-solid fa-user-xmark" @click="setReportDto(member.memberId)"></i>
        </div>
        <hr>
    </div>
</div>

<!-- 뷰 스크립트 작성 -->
<script>
    console.log(memberId);
    console.log(memberLevel);
    Vue.createApp({
      data() {
        return {
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
          reportDto: {
            memberId: memberId,
            reportTargetType: "회원",
            reportTargetPrimaryKey: "",
            reportFor: "",
          },
          memberList: [],
        };
      },
      computed: {
  
      },
      methods: {
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
        // 신고 생성
        async reportMember(){
            const report
        },

      },
      watch: {
  
      },
      created(){
            this.loadMember();
      },
    }).mount('#app')
  </script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	
	