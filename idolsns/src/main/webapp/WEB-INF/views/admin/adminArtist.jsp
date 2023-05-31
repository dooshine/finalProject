<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>

<!-- 제어영역 설정 -->
<div class="container" id="app">
    <!-- # 아티스트 -->
    <!-- 아티스트 생성 -->
    <div class="row mt-3">
        <div class="col">
            <h1>아티스트 생성</h1>
        </div>
    </div>
    <div class="row mt-3">
        <div class="col">
            <input type="text" v-model="newArtistName">
            <button class="btn btn-primary" @click="createArtist">아티스트 생성</button>
        </div>
    </div>

    <!-- 아티스트 목록 -->
    <div class="row mt-5">
        <div class="col">
            <h1>아티스트 목록</h1>
        </div>
    </div>
    
    <!-- 태그삭제 버튼 -->
    <div class="row text-end mt-5">
        <div class="col">
            <button @click="deleteArtistByNo"><i class="fa-solid fa-xmark"></i>삭제</button>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">번호</th>
                        <th scope="col">
                            <input type="checkbox" @change="checkAllArtist($event)"> 전체
                        </th>
                        <th scope="col">첨부사진</th>
                        <th scope="col">아티스트 이름</th>
                        <th scope="col">팔로워 수</th>
                        <th scope="col">관리도구</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(artistView, i) in artistViewList" :key="i">
                        <td scope="col">{{artistView.artistNo}}</td>
                        <td>
                            <input type="checkbox" @change="checkArtist($event, artistView.artistNo)" :checked="selectedArtistObj[artistView.artistNo]">
                        </td>
                        <td>
                            <img :src="previewURLList[i]===null ? artistView.profileSrc : previewURLList[i]" style="height: 50px; width: 50px;">
                            <!-- <img v-if="previewURLList[i]!==null" :src="previewURLList[i]" style="height: 50px; width: 50px;"> -->
                        </td>
                        <td>{{fullName(artistView.artistName, artistView.artistEngName)}}</td>
                        <td>{{artistView.followCnt ?? 0}}</td>
                        <td>
                            <input type="file" @change="handleFileUpload(i)">
                            <button @click="uploadFile(i)">프로필사진 수정</button>
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
          // 태그이름별 사용 목록
          artistViewList: [],
          // 선택된 태그 Object
          selectedArtistObj: {},
          // 선택된 태그 List
          selectedArtistList: [],
          // 새로운 아티스트 이름
          newArtistName: "",

          artistSearchObj : {
            name: "",
          },
          // 아티스트 프로필사진 목록   
          attachmentList: [],
          previewURLList: [],
        };
      },
      computed: {
      },
      watch: {

      },
      methods: {
        // 파일 업로드 시 프로필 사진 변경
        handleFileUpload(index){
            // 업로드 파일
            const file = event.target.files[0];
            // 첨부사진 임시보관
            this.attachmentList[index] = file;
            // 사진 미리보기 구현
            if (file) {
                this.previewURLList[index] = URL.createObjectURL(file);
            }
        },

        // 대표페이지 프로필 사진 설정
        async uploadFile(index){
            // URL
            const url = "http://localhost:8080/rest/admin/artistProfile";
            
            // 폼데이터 생성
            const formData = new FormData();
            formData.append('attachment', this.attachmentList[index]);
            formData.append('artistNo', this.artistViewList[index].artistNo);

            // 대표페이지 프로필사진 설정
            const resp = await axios.post(url, formData);

            // 새로고침
            this.loadArtistViewList();
            
            alert("대표페이지 프로필사진 설정완료!");
        },


        // 아티스트 생성
        async createArtist(){
            // URL
            const url = "http://localhost:8080/rest/admin/artist";
            // 아티스트 생성
            await axios.post(url, {artistName: this.newArtistName});

            this.loadArtistViewList();
            this.newArtistName = "";
        },
        // 아티스트 목록 조회
        async loadArtistViewList () {
            // URL
            const url = "http://localhost:8080/rest/admin/artistView";
            // 비동기 아티스트 목록 조회
            const resp = await axios.get(url);
            // 반영
            this.artistViewList = resp.data;
            this.attachmentList = new Array(this.artistViewList.length).fill(null);
            this.previewURLList = new Array(this.artistViewList.length).fill(null);
            console.log("조회 실행");
        },
        // 아티스트 전체선택
        checkAllArtist(e){
            if(e.target.checked){
                for(let i = 0; i<this.artistViewList.length; i++){
                    this.selectedArtistObj[this.artistViewList[i].artistNo] = true;
                    this.setSelectedArtistList();
                }
            } else {
                this.setSelectedArtistEmpty();
            }
        },
        // 아티스트 개별선택
        checkArtist(e, artistNo){
            if(e.target.checked){
                this.selectedArtistObj[artistNo] = true;
            } else {
                delete this.selectedArtistObj[artistNo];
            }
        },
        // 선택된 태그 배열 생성
        setSelectedArtistList(){
            this.selectedArtistList = Object.keys(this.selectedArtistObj);
        },
        // 선택된 태그 존재여부 확인
        isSelectedArtistExist(){
            // 선택된 태그 갯수
            const selectedArtistLeng = this.selectedArtistList.length;
            // 선택된 태그 존재여부
            const selectedArtistExist = selectedArtistLeng !== 0;
            return selectedArtistExist;
        },
        // 태그변경(타입 수정-자유,고정, 삭제-태그이름) 전처리 함수
        preArtistAccess(){
            // 1. 선택된 태그 이름 리스트 초기화
            this.setSelectedArtistList();
            // 2. 선택된 항목이 없다면 실행 X
           if(!this.isSelectedArtistExist()) return false;

            return true;
        },
        // 선택된 태그 초기화
        setSelectedArtistEmpty(){
            this.selectedArtistObj = {};
            this.selectedArtistList = [];
        },


        // # 아티스트 삭제(이름)
        async deleteArtistByNo(){
            // 태그변경 전처리 함수
            if(!this.preArtistAccess()) return;

            // URL
            const url = "http://localhost:8080/rest/artist/"
            // 아티스트 삭제
            const resp = await axios.delete(url, { 
                data: this.selectedArtistList,
            });

            // 선택항목 초기화
            this.setSelectedArtistEmpty();

            // 아티스트 목록 조회
            this.loadArtistList();
        },


        // 아티스트 이름
        fullName(name, engName){
          return name + "(" + engName + ")";
        },
      },
      created(){
        this.loadArtistViewList();
      },
    }).mount('#app')
</script>


<jsp:include page="/WEB-INF/views/admin/adminFooter.jsp"></jsp:include>