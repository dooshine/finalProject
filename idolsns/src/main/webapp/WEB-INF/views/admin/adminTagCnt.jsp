<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- 제어영역 설정 -->
<div class="container" id="app">
    <!-- # 고정태그 -->
    <!-- 고정태그 등록 -->
    <div class="row mt-3">
        <div class="col">
            <h1></h1>
        </div>
    </div>
    <!-- # 태그 사용량 타이틀 -->
    <div class="row mt-3">
        <div class="col">
            <h1>태그 사용량 목록</h1>
        </div>
    </div>

    <!-- # 태그 사용량 목록-->
    <div class="row mt-5">
        <div class="col container-fluid">
            <div class="row">
                <div class="col">
                    <h3>태그 검색 옵션</h3>
                </div>
            </div>
            <div class="row mt-3">
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
            <div class="row mt-3">
                <div class="offset-11 col-1">
                    <button class="btn btn-primary" @click="loadTagCntList">검색</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 태그삭제 버튼 -->
    <div class="row text-end mt-5">
        <div class="col">
            <!-- <button @click="updateTagFree"><i class="fa-solid fa-pen-to-square"></i>자유 태그로</button> -->
            <!-- <button @click="updateTagFix"><i class="fa-solid fa-pen-to-square"></i>고정 태그로</button> -->
            <button @click="deleteTagByName"><i class="fa-solid fa-xmark"></i>삭제</button>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <table class="table">
                <thead>
                    <tr>
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
                    <tr v-for="(tagCnt, i) in tagCntList" :key="i">
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
          }
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
            const url = "http://localhost:8080/rest/admin/tagName";
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
                const url = "http://localhost:8080/rest/fixedTag/check";

                const resp = await axios.get(url, {params: {fixedTagName: tagName}});
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
            const url = "http://localhost:8080/rest/admin/tagName"
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
            const url = "http://localhost:8080/rest/admin/tagName"
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
            const url = "http://localhost:8080/rest/admin/tagName"
            // 태그삭제 호출
            const resp = await axios.delete(url, { 
                data: this.selectedTagNameList,
            });

            // 선택항목 초기화
            this.setSelectedTagNameEmpty();

            // 신고목록 load
            this.loadTagCntList();

        },
      },
      watch: {
  
      },
      created(){
        this.loadTagCntList();
      },
    }).mount('#app')
</script>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>