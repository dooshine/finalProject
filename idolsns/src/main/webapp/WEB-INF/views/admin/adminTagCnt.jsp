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
    <!-- # 태그 사용량 타이틀 -->
    <div class="row mt-3 mx-0">
        <div class="col">
            <h1>태그 사용량 목록</h1>
        </div>
    </div>

    <!-- # 태그 사용량 목록-->
    <div class="row mt-5 mx-0">
        <div class="col container-fluid">
            <div class="row mx-0">
                <div class="col">
                    <h3>태그 검색 옵션</h3>
                </div>
            </div>
            <div class="row mt-3 mx-0">
                <div class="col">
                    <b class="me-4">태그 종류</b>
                    <label class="me-3">
                        <input type="checkbox" value="자유" @change="setTagTypeOption($event)"> 자유
                    </label>
                    <label>
                        <input type="checkbox" value="고정" @change="setTagTypeOption($event)"> 고정
                    </label>
                </div>
            </div>
            <div class="row mt-3 mx-0 ">
                <div class="d-flex">
                    <button class="ms-auto custom-btn btn-round btn-purple1" @click="loadTagCntList">검색</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 태그삭제 버튼 -->
    <div class="row text-end mt-5 mx-0">
        <div class="col">
            <!-- <button @click="updateTagFree"><i class="fa-solid fa-pen-to-square"></i>자유 태그로</button> -->
            <!-- <button @click="updateTagFix"><i class="fa-solid fa-pen-to-square"></i>고정 태그로</button> -->
            <button class="custom-btn btn-purple1" @click="deleteTagByName"><i class="fa-solid fa-xmark me-2"></i>삭제</button>
        </div>
    </div>
    <div class="row mx-0">
        <div class="col">
            <table class="table">
                <thead>
                    <tr class="back-gray">
                        <th scope="col">번호</th>
                        <th scope="col">
                            <input type="checkbox" @change="checkAllTag($event)"> 전체
                        </th>
                        <th scope="col">태그 이름</th>
                        <th scope="col">태그 타입</th>
                        <th scope="col">태그 사용량</th>
                        <th scope="col">고정태그여부</th>
                        <th scope="col">관리도구</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(tagCnt, i) in tagCntList.slice(pageObj.begin - 1, pageObj.end)" :key="i">
                        <td scope="col">{{i+1}}</td>
                        <td>
                            <input type="checkbox" @change="checkTag($event, tagCnt.tagName)" :checked="selectedTagNameObj[tagCnt.tagName]">
                        </td>
                        <td>{{tagCnt.tagName}}</td>
                        <td>{{tagCnt.tagType}}</td>
                        <td>{{tagCnt.tagCnt}}</td>
                        <td>{{isFixedTagList[i]}}</td>
                        <td>{{tagCnt.tagCnt}}</td>
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
          tagCntList: [],
          // 고정태그 여부 목록
          isFixedTagList: [], 


          // 선택된 태그 Object
          selectedTagNameObj: {},
          // 선택된 태그 List
          selectedTagNameList: [],
          tagCntSearchObj : {
            tagTypeList: [],
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
        // 검색옵션설정-태그타입
        setTagTypeOption (e) {
            if(e.target.checked){
                this.tagCntSearchObj.tagTypeList.push(e.target.value);
            } else {
                this.tagCntSearchObj.tagTypeList = this.tagCntSearchObj.tagTypeList.filter(item=>item!==e.target.value);
            }
        },



        
        // Load 태그사용량 목록
        async loadTagCntList () {
            // 신고리스트 조회 URL
            const url = "${contextPath}/rest/admin/tagName";
            // 비동기 신고리스트 조회 실행
            const resp = await axios.get(url, { 
                params: this.tagCntSearchObj, 
                paramsSerializer: params => {
		            return new URLSearchParams(params).toString();
	            }
            });
            // vue.data.reportList에 resp.data 복사
            this.tagCntList = _.cloneDeep(resp.data);
            this.setSelectedTagNameEmpty();

            for(let i = 0; i<this.tagCntList.length; i++){
                const tagName = this.tagCntList[i].tagName;
                const url = "${contextPath}/rest/fixedTag/check";

                const resp = await axios.get(url, {params: {fixedTagName: tagName}});
                // this.isFixedTagList[i] = true;
                this.isFixedTagList[i] = resp.data;
            }
        },
        // 태그사용량 전체선택
        checkAllTag(e){
            if(e.target.checked){
                for(let i = 0; i<this.tagCntList.length; i++){
                    this.selectedTagNameObj[this.tagCntList[i].tagName] = true;
                    this.setSelectedTagNameList();
                }
            } else {
                this.setSelectedTagNameEmpty();
            }
        },
        // 태그사용량 개별선택
        checkTag(e, tagName){
            if(e.target.checked){
                this.selectedTagNameObj[tagName] = true;
            } else {
                delete this.selectedTagNameObj[tagName];
            }
        },
        // 선택된 태그 배열 생성
        setSelectedTagNameList(){
            this.selectedTagNameList = Object.keys(this.selectedTagNameObj);
        },
        // 선택된 태그 존재여부 확인
        isSelectedTagNameExist(){
            // 선택된 태그 갯수
            const selectedTagNameLeng = this.selectedTagNameList.length;
            // 선택된 태그 존재여부
            const selectedTagNameExist = selectedTagNameLeng !== 0;
            return selectedTagNameExist;
        },
        // 태그변경(타입 수정-자유,고정, 삭제-태그이름) 전처리 함수
        preTagAccess(parentFunction){
            // 1. 선택된 태그 이름 리스트 초기화
            this.setSelectedTagNameList();

            // 2. 선택된 항목이 없다면 실행 X
            if(!this.isSelectedTagNameExist()) return false;

            // 3. 사용자 confirm
            let conditionalStr = "";
            if(parentFunction === "updateTagFree"){
                conditionalStr = "자유 태그로 변경";
            } else if(parentFunction === "updateTagFix"){
                conditionalStr = "고정 태그로 변경";
            } else if(parentFunction === "deleteTagByName"){
                conditionalStr = "정말 삭제";
            }
            if(!confirm(this.selectedTagNameList.length + "개의 태그를 " + conditionalStr + "하시겠습니까?")) return false;

            return true;
        },
        // 선택된 태그 초기화
        setSelectedTagNameEmpty(){
            this.selectedTagNameObj = {};
            this.selectedTagNameList = [];
        },




        // # 자유 태그로 변경
        async updateTagFree(){
            // 태그변경 전처리 함수
            if(!this.preTagAccess("updateTagFree")) return;

            // 태그수정(자유) api url
            const url = "${contextPath}/rest/admin/tagName"
            // 태그수정(자유) 호출
            const resp = await axios.put(url, {
                tagType: "자유",
                tagNameList: this.selectedTagNameList,
            });
            this.loadTagCntList();
        },

        // # 고정 태그로 변경
        async updateTagFix(){
            // 태그변경 전처리 함수
            if(!this.preTagAccess("updateTagFix")) return;

            // 태그수정(고정) api url
            const url = "${contextPath}/rest/admin/tagName"
            // 태그수정(고정) 호출
            const resp = await axios.put(url, {
                tagType: "고정",
                tagNameList: this.selectedTagNameList,
            });
            this.loadTagCntList();
        },

        // # 태그 이름으로 삭제
        async deleteTagByName(){
            // 태그변경 전처리 함수
            if(!this.preTagAccess("deleteTagByName")) return;

            // 태그삭제 api url
            const url = "${contextPath}/rest/admin/tagName"
            // 태그삭제 호출
            const resp = await axios.delete(url, { 
                data: this.selectedTagNameList,
            });

            // 선택항목 초기화
            this.setSelectedTagNameEmpty();

            // 신고목록 load
            this.loadTagCntList();

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
        tagCntList: {
          deep: true,
          handler(newVal, oldVal) {
            this.pageObj.total = this.tagCntList.length;
          }
        },
      },
      created(){
        this.loadTagCntList();
      },
    }).mount('#app')
</script>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>