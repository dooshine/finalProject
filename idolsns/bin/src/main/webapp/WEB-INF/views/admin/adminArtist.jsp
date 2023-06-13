<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- 제어영역 설정 -->
<div class="container custom-container" id="app">
    <!-- # 아티스트 -->
    <!-- 아티스트 생성 -->
    <div class="row mt-3">
        <div class="col">
            <h1>아티스트 생성</h1>
        </div>
    </div>
    <div class="row mt-3">
        <div class="col-2">
            <img :src="newArtistObj.previewURL" style="width: 100%; ">
        </div>
        <div class="col-10 container-fluid">
            <div class="row">
                <div class="col-4"><label>새 아티스트 이름</label></div>
                <div class="col-8"><input class="w-50" type="text" v-model="newArtistObj.artistName"></div>
            </div>
            <div class="row mt-3">
                <div class="col-4"><label>새 아티스트 영어이름</label></div>
                <div class="col-8"><input class="w-50" type="text" v-model="newArtistObj.artistEngName"></div>
            </div>
            <div class="row mt-3">
                <div class="col-4"><label>새 아티스트 영어이름(소문자, 띄어쓰기 X)</label></div>
                <div class="col-8"><input class="w-50" type="text" v-model="newArtistObj.artistEngNameLower"></div>
            </div>
            <div class="row">
                <div class="offset-10 col-2">
                    <button class="btn btn-primary ms-auto" @click="createArtist">아티스트 생성</button>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <input type="file" @change="handleNewArtistFileUpload" ref="attach">
                </div>
            </div>
        </div>
    </div>

    <!-- # 회원리스트 검색도구 -->
    <div class="row mt-3">
        <div class="col back-gray border border-secondary-subtle p-4">
            <!-- 검색타이틀 -->
            <!-- <div class="row">
                <div class="col">
                    <h3>검색설정</h3>
                </div>
            </div> -->
            <!-- 검색옵션 -->
            <div class="row">
                <div class="col">
                    <label>
                        아티스트번호
                        <input class="ms-3" type="text">
                        <%-- <input class="ms-3" type="text" v-model="memberSearchVO.memberId"> --%>
                    </label>
                </div>
                <div class="col">
                    <label>
                        아티스트이름
                        <%-- <input class="ms-3" type="text" v-model="memberSearchVO.memberNick"> --%>
                    </label>
                </div>
                <div class="col">
                    프로필사진 설정 여부
                    <label class="ms-3">
                        <%-- <input type="checkbox" v-model="profileExist"> --%>
                        설정
                    </label>
                    <label class="ms-3">
                        <%-- <input type="checkbox" v-model="noProfile"> --%>
                        미설정
                    </label>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-8">
                    <%-- <label>
                        1차 정렬
                        <select v-model="memberSearchVO.orderList[0]">
                            <option value="">선택하세요</option>
                            <option value="memberId">아이디순</option>
                            <option value="memberJoin">최근가입순</option>
                            <option value="memberLogin">최근로그인순</option>
                            <option value="memberPoint">포인트순</option>
                        </select>
                    </label>
                    <label class="ms-3">
                        2차 정렬
                        <select v-model="memberSearchVO.orderList[1]">
                            <option value="">선택하세요</option>
                            <option value="memberId">아이디순</option>
                            <option value="memberJoin">최근가입순</option>
                            <option value="memberLogin">최근로그인순</option>
                            <option value="memberPoint">포인트순</option>
                        </select>
                    </label> --%>
                </div>
            </div>
            <!-- 검색버튼 -->
            <div class="row mt-3 text-end">
                <div class="col">
                    <%-- <button class="btn btn-success" type="button" @click="searchMember">검색하기</button> --%>
                </div>
            </div>
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
                            <button class="btn btn-primary" @click="setArtistProfile(i)">프로필사진 수정</button>
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
          // 새로운 아티스트 Obj
          newArtistObj: {
            artistName: "",
            artistEngName: "",
            artistEngNameLower: "",
            attachment: null,
            previewURL: "/static/image/profileDummy.png",
          },

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
        async setArtistProfile(index){
            // 비어있을경우 실행X
            if(this.attachmentList[index] === null) return;

            // URL
            const url = "${contextPath}/rest/admin/artistProfile";
            
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

        
        // # 아티스트 생성
        
        // 새 아티스트 사진 미리보기
        handleNewArtistFileUpload(){
            // 업로드 파일
            const file = event.target.files[0];

            // 미선택 처리
            if(file === undefined){
                this.newArtistObj.attachment = null;
                this.newArtistObj.previewURL = "/static/image/profileDummy.png";
                return;
            }

            this.newArtistObj.attachment = file;
            this.newArtistObj.previewURL = URL.createObjectURL(file);
        },


        async createArtist(){
            // 1. 유효형 검사
            const artistNameRegex = /^[가-힣]{2,10}$/;            
            const artistNameEngRegex = /^[\sa-zA-Z]{2,30}$/;            
            const artistNameEngLowerRegex = /^[a-z]{2,30}$/;            

            if(!artistNameRegex.test(this.newArtistObj.artistName)){
                alert("아티스트의 이름을 다시 입력해주세요");
                return;
            }
            if(!artistNameEngRegex.test(this.newArtistObj.artistEngName)){
                alert("아티스트의 영어이름을 다시 입력해주세요");
                return;
            }
            if(!artistNameEngLowerRegex.test(this.newArtistObj.artistEngNameLower)){
                alert("아티스트의 영어 소문자이름을 다시 입력해주세요");
                return;
            }

            // 2. 중복 검사
            // URL
            const isArtistExistUrl = "${contextPath}/rest/artist/check";
            // 아티스트 중복검사

            console.log(this.newArtistObj.artistEngNameLower);
            const isArtistExist = await axios.get(isArtistExistUrl, {params: {artistEngNameLower: this.newArtistObj.artistEngNameLower}});
            if(isArtistExist.data){
                alert("아티스트의 영어 소문자 이름이 중복되므로 다시 입력해주세요");
                return;
            }
            
            // 3. 아티스트 생성
            
            // URL
            const createArtisturl = "${contextPath}/rest/artist/";
            
            // 폼데이터 생성
            const formData = new FormData();
            formData.append('attachment', this.newArtistObj.attachment);
            formData.append('artistName', this.newArtistObj.artistName);
            formData.append('artistEngName', this.newArtistObj.artistEngName);
            formData.append('artistEngNameLower', this.newArtistObj.artistEngNameLower);
            
            // 아티스트 생성
            await axios.post(createArtisturl, formData);

            this.loadArtistViewList();

            // 새 아티스트 입력창 초기화
            this.newArtistObj.artistName = "";
            this.newArtistObj.artistEngName = "";
            this.newArtistObj.artistEngNameLower = "";
            this.newArtistObj.attachment = null;
            this.newArtistObj.previewURL= "/static/image/profileDummy.png";

            // 파일인풋 초기화
            this.$refs.attach.value="";
        },
        // 아티스트 목록 조회
        async loadArtistViewList () {
            // URL
            const url = "${contextPath}/rest/admin/artistView";
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
            // 아티스트 선택 전처리 함수
            if(!this.preArtistAccess()) return;

            // 사용자 확인
            const selectedCnt = this.selectedArtistList.length;
            if(selectedCnt===0 && !confirm(selectedCnt + "개의 대표페이지를 삭제하시겠습니까?")) return;

            // URL
            const url = "${contextPath}/rest/artist/"
            // 아티스트 삭제

            const resp = await axios.delete(url, { 
                data: this.selectedArtistList,
            });

            // 선택항목 초기화
            this.setSelectedArtistEmpty();

            // 아티스트 목록 조회
            this.loadArtistViewList();

            alert(selectedCnt + "개의 대표페이지가 삭제되었습니다.")
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


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>