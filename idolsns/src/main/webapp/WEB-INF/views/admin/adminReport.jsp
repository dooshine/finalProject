<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>

<!-- 제어영역 설정 -->
<div class="container" id="app">
    <table>
        <thead>
            <tr>
                <th>체크박스</th>
                <th>신고번호</th>
                <th>신고시간</th>
                <th>신고한사람</th>
                <th>신고대상타입</th>
                <th>신고대상PK</th>
                <th>신고이유</th>
            </tr>
        </thead>
        <tbody>
            <tr style="text-align: center;">
                <td>
                    <input type="checkbox">
                </td>
                <td>1</td>
                <td>시간</td>
                <td>사람</td>
                <td>타입</td>
                <td>PK</td>
                <td>이유</td>
            </tr>
        </tbody>
    </table>
    <div class="row">
        <div class="col">
            <h1>신고 리스트 생성</h1>
        </div>
    </div>
    <div class="row" v-for="(report, i) in reportList" :key="i">
        <div class="col">
            {{report}}
        </div>
    </div>
</div>

<!-- 뷰 스크립트 작성 -->
<script>
    Vue.createApp({
      data() {
        return {
          reportList: [],
        };
      },
      computed: {
  
      },
      methods: {
        async loadReportList () {

            // 신고리스트 조회 URL
            const url = "http://localhost:8080/rest/report/list";

            // 비동기 신고리스트 조회 실행
            const resp = await axios.post(url, {});

            // vue.data.reportList에 resp.data 복사
            this.reportList = _.cloneDeep(resp.data);
        }
      },
      watch: {
  
      },
      created(){
        this.loadReportList();
      },
    }).mount('#app')
</script>

<jsp:include page="/WEB-INF/views/admin/adminFooter.jsp"></jsp:include>
	
	