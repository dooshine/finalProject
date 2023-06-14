<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- 제어영역 설정 -->
<div class="container custom-container" id="app">
    <!-- # 고정태그 -->
    <!-- 고정태그 생성 -->
    <div class="row mt-3">
        <div class="col">
            <h1>고정태그 생성</h1>
        </div>
    </div>
    <div class="row mt-3">
        <div class="col">
            <input type="text" v-model="newFixedTagName">
            <button class="btn btn-primary" @click="createFixedTag(newFixedTagName)">고정태그 생성</button>
        </div>
    </div>


    <!-- ########################### 글쓰기 추가 ######################## -->
    <!-- 고정태그 입력 시 목록 불러오기 -->
    <div class="row mt-3">
        <div class="col">
            <h1>글쓰기 시 고정태그 목록 조회</h1>
        </div>
    </div>
    <div class="row mt-3">
        <div class="col">
            <input type="text" @input="findFixedTagName = $event.target.value" v-model="findFixedTagName">
        </div>
    </div>
    <div class="row">
        <div v-for="(findFixedTag, i) in findFixedTagList" :key="i">
            <button class="btn btn-secondary" @click="addNewFixedTag(findFixedTag)">{{ findFixedTag }}</button>
        </div>
    </div>
    <div class="row mt-3">
        <div class="col">
            <button class="btn btn-primary" v-for="(newFixedTag, i) in newFixedTagList">{{ newFixedTag }}</button>
        </div>
    </div>
    <!-- ########################### 글쓰기 추가 ######################## -->


    <!-- 고정태그 목록 -->
    <div class="row mt-3">
        <div class="col">
            <h1>고정태그 목록</h1>
        </div>
    </div>
    
    <!-- 태그삭제 버튼 -->
    <div class="row text-end mt-5">
        <div class="col">
            <button @click="deleteFixedTagByNo"><i class="fa-solid fa-xmark"></i>삭제</button>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">번호</th>
                        <th scope="col">
                            <input type="checkbox" @change="checkAllFixedTag($event)"> 전체
                        </th>
                        <th scope="col">고정태그 이름</th>
                        <th scope="col">관리도구</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(fixedTag, i) in fixedTagList" :key="i">
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
          }
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
      },
       // ########################### 글쓰기 추가 ########################

      methods: {
        // 고정태그 생성
        async createFixedTag(fixedTagName){
            // URL
            const url = "${contextPath}/rest/fixedTag/";
            // 고정태그 생성
            await axios.post(url, {fixedTagName: fixedTagName});

            this.loadFixedTagList();
            this.newFixedTagName = "";
        },
        // 고정태그 목록 조회
        async loadFixedTagList () {
            // URL
            const url = "${contextPath}/rest/fixedTag/";
            // 비동기 고정태그 목록 조회
            const resp = await axios.get(url);
            // 반영
            this.fixedTagList = resp.data;
            //console.log("조회 실행");
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
            const url = "${contextPath}/rest/fixedTag/"
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

            const resp = await axios.get("${contextPath}/rest/fixedTag/"+this.findFixedTagName);
            this.findFixedTagList = resp.data;
            //console.log(this.findFixedTagList);
            // console.log("조회 실행");
        },
        // 고정태그 추가
        addNewFixedTag (newFixedTag){
            this.newFixedTagList.push(newFixedTag);
            this.findFixedTagName = "";
            this.findFixedTagList = [];
        },
         // ########################### 글쓰기 추가 ########################
      },
      created(){
        this.loadFixedTagList();
      },
    }).mount('#app')
</script>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>