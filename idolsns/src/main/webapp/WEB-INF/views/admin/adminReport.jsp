<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .back-gray {
        background: #f2f2f2;
    }
    .total-cnt {
        color: #6a53fb;
    }
    .cursor-pointer:hover {
    cursor: pointer;
    }

    .pagination {
        color: #6a53fb;
    }
    .pagination {
        --bs-pagination-focus-box-shadow: 0px;
    }
    .form-check-input {
        -webkit-appearance: none;
        appearance: none;
    }
        /* 페이지네이션 스타일 */
    .pagination .page-link {
        color: gray;
        background-color: none;
        border: none; /* 테두리 제거 */
    }

    .pagination .page-link:hover {
        color: #ffffff;
        background-color: #a294f9;
        border: none; /* 테두리 제거 */
    }

    .pagination .page-item.disabled .page-link {
        color: #6c757d;
        background-color: #f8f9fa;
        border: none; /* 테두리 제거 */
    }

    .pagination .page-item.active .page-link {
        color: #a294f9;
        background-color: white;
        border: none; /* 테두리 제거 */
    }
    
    td {
    	vertical-align:middle;
    }
</style>

<!-- 제어영역 설정 -->
<div class="custom-container" style="padding: 24px;" id="app">
    <!-- # 신고조회 타이틀 -->
    <div class="row mt-3">
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
                    <tr class="back-gray">
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
                    <tr v-for="(report, i) in reportList.slice(pageObj.begin - 1, pageObj.end)" :key="i">
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

    <!-- ######################## 회원리스트 페이지네이션 시작 ########################-->
   <div class="row my-5">
        <div class="col text-center">
            <nav aria-label="...">
                <ul class="pagination justify-content-center">
                    <!-- 첫 페이지로 이동 -->
                    <li class="page-item" :class="{disabled: pageObj.isFirst}">
                        <span class="page-link cursor-pointer" @click="showFirstPage">&laquo;</span>
                    </li>
                    <!-- 이전 블럭으로 이동 -->
                    <li class="page-item" :class="{disabled: !pageObj.hasPrev}">
                        <span class="page-link cursor-pointer" @click="showPrevBlock">&lt;</span>
                    </li>
                    <!-- 페이지번호 이동 -->
                    <li class="page-item"
                        :class="{active: pageObj.startBlock + i - 1 === pageObj.page}"
                        :aria-current="{page: pageObj.startBlock + i - 1 === pageObj.page}"
                        v-for="i in pageObj.finishBlock-pageObj.startBlock+1" :key="i">
                        <span href="#" class="page-link"
                            :class="{'cursor-pointer': pageObj.startBlock + i - 1 !== pageObj.page}"
                            @click="showTargetPage(pageObj.startBlock + i - 1)">
                            {{pageObj.startBlock + i - 1}}
                        </span>
                    </li>
                    <!-- 다음 블럭으로 이동 -->
                    <li class="page-item" :class="{disabled: !pageObj.hasNext}">
                        <span class="page-link cursor-pointer" @click="showNextBlock">&gt;</span>
                    </li>
                    <!-- 마지막 페이지로 이동 -->
                    <li class="page-item" :class="{disabled: pageObj.isLast}">
                        <span class="page-link cursor-pointer" @click="showLastPage">&raquo;</span>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
    <!-- ######################## 회원리스트 페이지네이션 끝 ########################-->
</div>

<!-- 뷰 스크립트 작성 -->
<script>
    Vue.createApp({
      data() {
        return {
          reportList: [],
          selectedReportList: {

          },


            // 페이지네이션 Obj
            pageObj: {
                page: 1,
                size: 15,
                blocksize: 5,
                total: 0, 

                // 블럭에서 뜨는 첫번째 게시물
                get begin(){
                    return (this.page - 1) * this.size + 1;
                },
                // 블럭에서 뜨는 마지막 게시물
                get end(){
                    return Math.min(this.page * this.size, this.total);
                },

                // 페이지 총 수
                get totalPage(){
                    return Math.floor((this.total + this.size - 1) / this.size);
                },
                // 시작 블럭
                get startBlock(){
                    
                    return Math.floor((this.page - 1)/this.blocksize) * this.blocksize + 1
                },
                // 마지막 블럭
                get finishBlock(){
                    return Math.min(this.startBlock + this.blocksize - 1, this.totalPage);
                },


                // 처음블럭 판별
                get isFirst(){
                    return this.page === 1;
                },
                // 마지막블럭 판별
                get isLast(){
                    return this.page >= this.totalPage;
                },
                // 이전블럭 존재판별
                get hasPrev(){
                    return this.startBlock > 1;
                },
                // 다음블럭 존재판별
                get hasNext(){
                    return this.finishBlock < this.totalPage;
                },
                // 이전블럭 페이지번호
                get getPrevPage(){
                    return this.startBlock - 1 ;
                },
                // 다음블럭 페이지번호
                get getNextPage(){
                    return this.finishBlock + 1 ;
                },

            },
        };
      },
      computed: {
  
      },
      methods: {
        // Load 신고 리스트
        async loadReportList () {
            // 신고리스트 조회 URL
            const url = contextPath + "/rest/report/list";
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
            //console.log(this.selectedReportList);
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
            const url = contextPath + "/rest/report/"
            
            // 신고 삭제 호출
            const resp = await axios.delete(url, { 
                data: selectedReportList,
            });
            this.selectedReportList = {};

            // 신고목록 load
            this.loadReportList();

        },

        // ################################# 페이지네이션 method 시작 #################################
        showFirstPage(){
            this.pageObj.page = 1;
        },
        showPrevBlock(){
            this.pageObj.page = this.pageObj.getPrevPage;
        },
        showNextBlock(){
            this.pageObj.page = this.pageObj.getNextPage;
        },
        showLastPage(){
            this.pageObj.page = this.pageObj.totalPage;
        },
        showTargetPage(page){
            this.pageObj.page = page;
        },
        // ################################# 페이지네이션 method 끝 #################################
      },
      watch: {
        reportList: {
          deep: true,
          handler(newVal, oldVal) {
            this.pageObj.total = this.reportList.length;
          }
        },
  
      },
      created(){
        this.loadReportList();
      },
    }).mount('#app')
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>	
	