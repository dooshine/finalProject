<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- 제어영역 설정 -->
<div class="custom-container" style="padding: 24px;" id="app">
    <!-- # 신고조회 타이틀 -->
    <div class="row">
        <div class="col">
            <h1>신고 리스트</h1>
        </div>
    </div>

    <!-- 신고삭제 버튼 -->
    <div class="row text-end">
        <div class="col">
            <button class="custom-btn btn-purple1" @click="deleteReport"><i class="fa-solid fa-xmark me-2"></i>삭제</button>
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
                        <th scope="col">신고번호</th>
                        <th scope="col">신고한사람</th>
                        <th scope="col">신고대상타입</th>
                        <th scope="col">신고대상PK</th>
                        <th scope="col">신고이유</th>
                        <th scope="col">신고시간</th>
                        <th scope="col">관리도구</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(report, i) in reportList" :key="i">
                        <td>
                            <input type="checkbox" @change="checkReport($event, report.reportNo)">
                        </td>
                        <td>{{report.reportNo}}</td>
                        <td>{{report.memberId}}</td>
                        <td>{{report.reportTargetType}}</td>
                        <td>{{report.reportTargetPrimaryKey}}</td>
                        <td>{{report.reportFor}}</td>
                        <td>{{report.reportTime}}</td>
                        <td>
                            <i class="fa-solid fa-xmark" @click="deleteReport(report.reportNo)"></i>
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
          reportList: [],
          selectedReportList: {

          },
        };
      },
      computed: {
  
      },
      methods: {
        // Load 신고 리스트
        async loadReportList () {
            // 신고리스트 조회 URL
            const url = "http://localhost:8080/rest/report/list";
            // 비동기 신고리스트 조회 실행
            const resp = await axios.post(url, {});
            // vue.data.reportList에 resp.data 복사
            this.reportList = _.cloneDeep(resp.data);
        },
        // 신고 리스트 개별선택
        checkReport(e, reportNo){
            // console.log(e.target.checked);
            // console.log("reportNo: " + reportNo);
            if(e.target.checked){
                this.selectedReportList[reportNo] = true;
            } else {
                delete this.selectedReportList[reportNo];
            }
            console.log(this.selectedReportList);
        },
        // 신고 삭제
        async deleteReport(){
            
            const selectedReportList = Object.keys(this.selectedReportList);
            const selectedReportCnt = selectedReportList.length;

            // 선택된 항목 0개면 실행 X
            if(selectedReportCnt === 0) return;
            // 삭제확인
            if(!confirm(selectedReportCnt + "개의 신고 내역을 정말 삭제하시겠습니까?")) return;

            // 신고 api url
            const url = "http://localhost:8080/rest/report/"
            
            // 신고 삭제 호출
            const resp = await axios.delete(url, { 
                data: selectedReportList,
            });
            this.selectedReportList = {};

            // 신고목록 load
            this.loadReportList();

        },
      },
      watch: {
  
      },
      created(){
        this.loadReportList();
      },
    }).mount('#app')
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>	
	