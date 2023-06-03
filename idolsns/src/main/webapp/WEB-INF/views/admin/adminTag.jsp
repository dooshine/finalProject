<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- 제어영역 설정 -->
<div class="container custom-container" id="app">
    
    <!-- # 제재조회 타이틀 -->
    <div class="row">
        <div class="col">
            <h1>태그 리스트</h1>
        </div>
    </div>

    <!-- # 제재 목록-->
    <div class="row">
        <div class="col">
            <h3>태그</h3>
        </div>
    </div>
    <!-- 태그삭제 버튼 -->
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
                        <th scope="col">태그번호</th>
                        <th scope="col">게시물번호(Origin)</th>
                        <th scope="col">태그타입(고정, 자유)</th>
                        <th scope="col">태그이름</th>
                        <th scope="col">관리도구</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(tag, i) in tagList" :key="i">
                        <td>
                            <input type="checkbox" @change="checkTag($event, tag.tagNo)">
                        </td>
                        <td>{{tag.tagNo}}</td>
                        <td>{{tag.postNo}}</td>
                        <td>{{tag.tagType}}</td>
                        <td>{{tag.tagName}}</td>
                        <td>
                            <i class="fa-solid fa-xmark" @click="deleteTag(tag.tagNo)"></i>
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
          tagList: [],
          selectedTagList: {
          },
        };
      },
      computed: {
  
      },
      methods: {
        // Load 신고 리스트
        async loadTagList () {
            // 신고리스트 조회 URL
            const url = "http://localhost:8080/rest/admin/tag";
            // 비동기 신고리스트 조회 실행
            const resp = await axios.get(url);
            // vue.data.reportList에 resp.data 복사
            this.tagList = _.cloneDeep(resp.data);
        },
        
        // 제재 리스트 개별선택
        checkTag(e, tagNo){
            if(e.target.checked){
                this.selectedTagList[tagNo] = true;
            } else {
                delete this.selectedTagList[tagNo];
            }
        },

        // 신고 삭제
        async deleteTag(){
            
            const selectedTagList = Object.keys(this.selectedTagList);
            const selectedTagCnt = selectedTagList.length;

            // 선택된 항목 0개면 실행 X
            if(selectedTagCnt === 0) return;
            // 삭제확인
            if(!confirm(selectedTagCnt + "개의 태그를 정말 삭제하시겠습니까?")) return;

            // 신고 api url
            const url = "http://localhost:8080/rest/admin/tag"
            
            // 신고 삭제 호출
            const resp = await axios.delete(url, { 
                data: selectedTagList,
            });
            this.selectedTagList = {};

            // 신고목록 load
            this.loadTagList();

        },
      },
      watch: {
  
      },
      created(){
        this.loadTagList();
      },
    }).mount('#app')
</script>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>