<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
    <!-- # 고정태그 -->
    <!-- 고정태그 생성 -->
    <div class="row mt-3">
        <div class="col">
            <h1>고정태그 생성</h1>
        </div>
    </div>
    <div class="row mt-3">
        <div class="col">
        	<div class="d-flex">
	            <div class="custom-input-container me-2" style="width: 40%;">
	                <input class="custom-input w-60" type="text" v-model="newFixedTagName" >
	            </div>
	            <button class="custom-btn btn-rounded btn-purple1" @click="createFixedTag(newFixedTagName)">고정태그 생성</button>
	        </div>
        </div>
    </div>


    <!-- ########################### 글쓰기 추가 ######################## -->
    <!-- 고정태그 입력 시 목록 불러오기 -->
    <!-- ########################### 글쓰기 추가 ######################## -->
    
    <!-- 태그삭제 버튼 -->
    <div class="row text-end mt-5">
        <div class="col">
            <button class="custom-btn btn-purple1" @click="deleteFixedTagByNo"><i class="fa-solid fa-xmark me-2"></i>삭제</button>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <table class="table">
                <thead>
                    <tr class="back-gray">
                        <th scope="col">번호</th>
                        <th scope="col">
                            <input type="checkbox" @change="checkAllFixedTag($event)"> 전체
                        </th>
                        <th scope="col">고정태그 이름</th>
                        <th scope="col">관리도구</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(fixedTag, i) in fixedTagList.slice(pageObj.begin - 1, pageObj.end)" :key="i">
                        <td scope="col">{{fixedTag.fixedTagNo}}</td>
                        <td>
                            <input type="checkbox" @change="checkFixedTag($event, fixedTag.fixedTagNo)" :checked="selectedFixedTagObj[fixedTag.fixedTagNo]">
                        </td>
                        <td>{{fixedTag.fixedTagName}}</td>
                        <td>관리</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- ######################## 제재 페이지네이션 시작 ########################-->
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
          // 태그이름별 사용 목록
          fixedTagList: [],
          // 선택된 태그 Object
          selectedFixedTagObj: {},
          // 선택된 태그 List
          selectedFixedTagList: [],
          // 새로운 고정태그 이름
          newFixedTagName: "",


          // ########################### 글쓰기 추가 ########################
          // 입력 시 고정태그 불러오기
          findFixedTagName: "",
          findFixedTagList: [],
          newFixedTagList: [],
           // ########################### 글쓰기 추가 ########################

          fixedTagSearchObj : {
            name: "",
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
       // ########################### 글쓰기 추가 ########################
      watch: {
        findFixedTagName:_.throttle(function(){
                    //this == 뷰 인스턴스
                    this.loadFindFixedTagList();
        }, 250),

        fixedTagList: {
          deep: true,
          handler(newVal, oldVal) {
            this.pageObj.total = this.fixedTagList.length;
          }
        },
      },
       // ########################### 글쓰기 추가 ########################

      methods: {
        // 고정태그 생성
        async createFixedTag(fixedTagName){
            // URL
            const url = "http://localhost:8080/rest/fixedTag/";
            // 고정태그 생성
            await axios.post(url, {fixedTagName: fixedTagName});

            this.loadFixedTagList();
            this.newFixedTagName = "";
        },
        // 고정태그 목록 조회
        async loadFixedTagList () {
            // URL
            const url = "http://localhost:8080/rest/fixedTag/";
            // 비동기 고정태그 목록 조회
            const resp = await axios.get(url);
            // 반영
            this.fixedTagList = resp.data;
            console.log("조회 실행");
        },
        // 고정태그 전체선택
        checkAllFixedTag(e){
            if(e.target.checked){
                for(let i = 0; i<this.fixedTagList.length; i++){
                    this.selectedFixedTagObj[this.fixedTagList[i].fixedTagNo] = true;
                    this.setSelectedFixedTagList();
                }
            } else {
                this.setSelectedFixedTagEmpty();
            }
        },
        // 고정태그 개별선택
        checkFixedTag(e, fixedTagNo){
            if(e.target.checked){
                this.selectedFixedTagObj[fixedTagNo] = true;
            } else {
                delete this.selectedFixedTagObj[fixedTagNo];
            }
        },
        // 선택된 태그 배열 생성
        setSelectedFixedTagList(){
            this.selectedFixedTagList = Object.keys(this.selectedFixedTagObj);
        },
        // 선택된 태그 존재여부 확인
        isSelectedFixedTagExist(){
            // 선택된 태그 갯수
            const selectedFixedTagLeng = this.selectedFixedTagList.length;
            // 선택된 태그 존재여부
            const selectedFixedTagExist = selectedFixedTagLeng !== 0;
            return selectedFixedTagExist;
        },
        // 태그변경(타입 수정-자유,고정, 삭제-태그이름) 전처리 함수
        preTagAccess(){
            // 1. 선택된 태그 이름 리스트 초기화
            this.setSelectedFixedTagList();
            // 2. 선택된 항목이 없다면 실행 X
           if(!this.isSelectedFixedTagExist()) return false;

            return true;
        },
        // 선택된 태그 초기화
        setSelectedFixedTagEmpty(){
            this.selectedFixedTagObj = {};
            this.selectedFixedTagList = [];
        },


        // # 고정태그 삭제(이름)
        async deleteFixedTagByNo(){
            // 태그변경 전처리 함수
            if(!this.preTagAccess()) return;

            // URL
            const url = "http://localhost:8080/rest/fixedTag/"
            // 고정태그 삭제
            const resp = await axios.delete(url, { 
                data: this.selectedFixedTagList,
            });

            // 선택항목 초기화
            this.setSelectedFixedTagEmpty();

            // 고정태그 목록 조회
            this.loadFixedTagList();
        },



         // ########################### 글쓰기 추가 ########################
        async loadFindFixedTagList(){
            if(this.findFixedTagName.length == 0) return;

            const resp = await axios.get("http://localhost:8080/rest/fixedTag/"+this.findFixedTagName);
            this.findFixedTagList = resp.data;
            console.log(this.findFixedTagList);
            // console.log("조회 실행");
        },
        // 고정태그 추가
        addNewFixedTag (newFixedTag){
            this.newFixedTagList.push(newFixedTag);
            this.findFixedTagName = "";
            this.findFixedTagList = [];
        },
         // ########################### 글쓰기 추가 ########################


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
      created(){
        this.loadFixedTagList();
      },
    }).mount('#app')
</script>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>