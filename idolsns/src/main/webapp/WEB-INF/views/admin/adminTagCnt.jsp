<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>

<!-- 제어영역 설정 -->
<div class="container" id="app">
    
    <!-- # 태그 사용량 타이틀 -->
    <div class="row">
        <div class="col">
            <h1>태그 사용량 목록</h1>
        </div>
    </div>

    <!-- # 태그 사용량 목록-->
    <div class="row">
        <div class="col">
            <h3>태그</h3>
        </div>
    </div>
    <!-- 태그삭제 버튼 -->
    <div class="row text-end">
        <div class="col">
            <button @click="deleteTag"><i class="fa-solid fa-xmark"></i>삭제</button>
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
                        <th scope="col">태그 이름</th>
                        <th scope="col">태그 타입</th>
                        <th scope="col">태그 사용량</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(tagCnt, i) in tagCntList" :key="i">
                        <td>
                            <input type="checkbox" @change="checkTag($event, tagCnt.tagName)">
                        </td>
                        <td>{{tagCnt.tagName}}</td>
                        <td>{{tagCnt.tagType}}</td>
                        <td>{{tagCnt.tagCnt}}</td>
                        <td>
                            <i class="fa-solid fa-xmark" @click="deleteTag(tag.tagName)"></i>
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
          tagCntList: [],
          selectedTagCntList: {
          },
        };
      },
      computed: {
  
      },
      methods: {
        // Load 신고 리스트
        async loadTagCntList () {
            // 신고리스트 조회 URL
            const url = "http://localhost:8080/rest/admin/tagCnt";
            // 비동기 신고리스트 조회 실행
            const resp = await axios.get(url);
            // vue.data.reportList에 resp.data 복사
            this.tagCntList = _.cloneDeep(resp.data);
        },
        
        // 제재 리스트 개별선택
        checkTag(e, tagName){
            if(e.target.checked){
                this.selectedTagCntList[tagName] = true;
            } else {
                delete this.selectedTagCntList[tagName];
            }
        },

        // 신고 삭제
        async deleteTag(){
            
            const selectedTagCntList = Object.keys(this.selectedTagCntList);
            const selectedTagCntLeng = selectedTagList.length;

            // 선택된 항목 0개면 실행 X
            if(selectedTagCntLeng === 0) return;
            // 삭제확인
            if(!confirm(selectedTagCntLeng + "개의 태그를 정말 삭제하시겠습니까?")) return;

            // 신고 api url
            const url = "http://localhost:8080/rest/admin/tagCnt"
            
            // 신고 삭제 호출
            const resp = await axios.delete(url, { 
                data: selectedTagCntList,
            });
            this.selectedTagCntList = {};

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


<jsp:include page="/WEB-INF/views/admin/adminFooter.jsp"></jsp:include>