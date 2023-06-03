<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- 제어영역 설정 -->
<div class="container custom-container" id="app">
    
    <!-- # 제재조회 타이틀 -->
    <div class="row">
        <div class="col">
            <h1>제재 리스트</h1>
        </div>
    </div>

    <!-- # 제재 목록-->
    <div class="row">
        <div class="col">
            <h3>목록</h3>
        </div>
    </div>
    <!-- 제재삭제 버튼 -->
    <div class="row text-end">
        <div class="col">
            <button @click="deleteSanction"><i class="fa-solid fa-xmark"></i>삭제</button>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">
                            <input type="checkbox">
                        </th>
                        <th scope="col">제재번호</th>
                        <th scope="col">제재대상타입</th>
                        <th scope="col">제재대상PK</th>
                        <th scope="col">제재이유</th>
                        <th scope="col">제재기간</th>
                        <th scope="col">제재시작일</th>
                        <th scope="col">제재종료일</th>
                        <th scope="col">관리도구</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(sanction, i) in sanctionList" :key="i">
                        <td>
                            <input type="checkbox" @change="checkSanction($event, sanction.sanctionNo)">
                        </td>
                        <td>{{sanction.sanctionNo}}</td>
                        <td>{{sanction.sanctionTargetType}}</td>
                        <td>{{sanction.sanctionTargetPrimaryKey}}</td>
                        <td>{{sanction.sanctionFor}}</td>
                        <td>{{sanction.sanctionTerm}}일</td>
                        <td>{{sanction.sanctionStart}}</td>
                        <td>{{sanction.sanctionEnd}}</td>
                        <td>
                            <i class="fa-solid fa-xmark" @click="deleteSanction(sanction.sanctionNo)"></i>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- 뷰 스크립트 작성 -->
<script>
    Vue.createApp({
      data() {
        return {
          sanctionList: [],
          selectedSanctionList: {
          },
        };
      },
      computed: {
  
      },
      methods: {
        // Load 신고 리스트
        async loadSanctionList () {
            // 신고리스트 조회 URL
            const url = "http://localhost:8080/rest/sanction/list";
            // 비동기 신고리스트 조회 실행
            const resp = await axios.post(url, {});
            // vue.data.reportList에 resp.data 복사
            this.sanctionList = _.cloneDeep(resp.data);
        },
        
        // 제재 리스트 개별선택
        checkSanction(e, sanctionNo){
            if(e.target.checked){
                this.selectedSanctionList[sanctionNo] = true;
            } else {
                delete this.selectedSanctionList[sanctionNo];
            }
        },

        // 신고 삭제
        async deleteSanction(){
            
            const selectedSanctionList = Object.keys(this.selectedSanctionList).map(item=>parseInt(item));
            const selectedSanctionCnt = selectedSanctionList.length;

            // 선택된 항목 0개면 실행 X
            if(selectedSanctionCnt === 0) return;
            // 삭제확인
            if(!confirm(selectedSanctionCnt + "개의 제재 내역을 정말 삭제하시겠습니까?")) return;

            // 신고 api url
            const url = "http://localhost:8080/rest/sanction/"
            
            // 신고 삭제 호출
            const resp = await axios.delete(url, { 
                data: selectedSanctionList,
            });
            this.selectedSanctionList = {};

            // 신고목록 load
            this.loadSanctionList();

        },
      },
      watch: {
  
      },
      created(){
        this.loadSanctionList();
      },
    }).mount('#app')
</script>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>