<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/admin/adminHeader.jsp"></jsp:include>

<style>
    .back-gray {
        background: #f2f2f2;
    }
    .total-cnt {
        color: forestgreen;
    }
    .cursor-pointer:hover {
    cursor: pointer;
    }
</style>

<div class="container mt-5" id="app">
    <!-- # 회원조회 타이틀 -->
    <div class="row mt-3">
        <div class="col">
            <h1>회원 목록</h1>
        </div>
    </div>

    <!-- ######################## 회원리스트 검색도구 시작 ########################-->
    <div class="row mt-3">
        <div class="col back-gray border border-secondary-subtle p-4">
            <div class="row">
                <div class="col">
                    <label>
                        회원아이디
                        <input class="ms-3" type="text" v-model="memberSearchVO.memberId">
                    </label>
                </div>
                <div class="col">
                    <label>
                        회원닉네임
                        <input class="ms-3" type="text" v-model="memberSearchVO.memberNick">
                    </label>
                </div>
                <div class="col">
                    <label>
                        회원이메일
                        <input class="ms-3" type="text" v-model="memberSearchVO.memberEmail">
                    </label>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col">
                    <label>
                        최소포인트
                        <input class="ms-3" type="text" v-model="memberSearchVO.minPoint">
                    </label>
                </div>
                <div class="col">
                    <label>
                        최대포인트
                        <input class="ms-3" type="text" v-model="memberSearchVO.maxPoint">
                    </label>
                </div>
                <div class="col">
                    동의여부
                    <label class="ms-3">
                        <input type="checkbox" v-model="agree">
                        동의
                    </label>
                    <label class="ms-3">
                        <input type="checkbox" v-model="disagree">
                        비동의
                    </label>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col">
                    <label>
                        가입일자(이후)
                        <input class="ms-3" type="date" v-model="memberSearchVO.beginJoinDate">
                    </label>
                </div>
                <div class="col">
                    <label>
                        가입일자(이전)
                        <input class="ms-3" type="date" v-model="memberSearchVO.endJoinDate">
                    </label>
                </div>
                <div class="col">
                    <label>
                        최초로그인일자
                        <input class="ms-3" type="date" v-model="memberSearchVO.searchLoginDays">
                    </label>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-4">
                    회원레벨
                    <label class="ms-3">
                        <input type="checkbox" v-model="user">
                        일반회원
                    </label>
                    <label class="ms-3">
                        <input type="checkbox" v-model="adminUser">
                        관리자
                    </label>
                </div>
                <div class="col-8">
                    <label>
                        1차 정렬
                        <select v-model="memberSearchVO.orderList[0]">
                            <option value="">선택하세요</option>
                            <option value="member.member_id asc">아이디순</option>
                            <option value="member.member_join desc">최근가입순</option>
                            <option value="member.member_login desc">최근로그인순</option>
                            <option value="member.member_point desc">포인트순</option>
                        </select>
                    </label>
                    <label class="ms-3">
                        2차 정렬
                        <select v-model="memberSearchVO.orderList[1]">
                            <option value="">선택하세요</option>
                            <option value="member.member_id asc">아이디순</option>
                            <option value="member.member_join desc">최근가입순</option>
                            <option value="member.member_login desc">최근로그인순</option>
                            <option value="member.member_point desc">포인트순</option>
                        </select>
                    </label>
                </div>
            </div>
            <!-- 검색버튼 -->
            <div class="row mt-3 text-end">
                <div class="col">
                    <button class="btn btn-success" type="button" @click="loadMemberList">검색하기</button>
                </div>
            </div>
        </div>
    </div>
    <!-- ######################## 회원리스트 검색도구 끝 ########################-->




    <!-- ######################## 회원리스트 목록 시작 ########################-->
    <div class="row mt-5">
        <div class="col-4">
            전체 <b class="total-cnt">{{memberList.length}}</b>건
        </div>
        <div class="offset-7 col-1">
            <button @click="changeMember"><i class="fa-solid fa-xmark"></i>삭제</button>
        </div>
    </div>
    <div class="row">
        <div class="col p-0">
            <table class="table">
                <thead>
                    <tr class="back-gray">
                        <th scope="col">번호</th>
                        <th scope="col">전체<br><input type="checkbox"  @change="checkAllMember($event)"></th>
                        <th scope="col">회원프로필</th>
                        <th scope="col">회원아이디(닉네임)/회원이메일</th>
                        <th scope="col">팔로우/팔로워</th>
                        <th scope="col">회원포인트</th>
                        <th scope="col">가입일/최종로그인</th>
                        <th scope="col">관리도구</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-if="memberList.length===0">
                        <td colspan="8">
                            <h3 class="m-3">검색 결과가 없습니다</h3>
                        </td>
                    </tr>
                    <tr v-for="(member, i) in memberList.slice(pageObj.begin - 1, pageObj.end)" :key="i">
                        <td>{{pageObj.begin + i}}</td>
                        <td><input type="checkbox" @change="checkMember($event, member.memberId)" :checked="selectedMemberObj[member.memberId]"></td>
                        <td><img :src="member.profileSrc" style="height: 50px; width: 50px;"></td>
                        <td>
                            {{fullName(member.memberId, member.memberNick)}}<br>
                            {{member.memberEmail}}
                        </td>
                        <td>{{member.memberFollowCnt}}/{{member.memberFollowerCnt}}</td>
                        <td>{{member.memberPoint}}</td>
                        <td>
                            {{member.memberJoin}}<br>
                            {{member.memberLogin === null ? "미접속": member.memberLogin }}
                        </td>
                        <td>
                            <button class="btn btn-primary" @click="followMember(member.memberId)">수정하기</button>
                            <button class="btn btn-danger" @click="followMember(member.memberId)">제재
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!-- ######################## 회원리스트 목록 끝 ########################-->




    <!-- ######################## 회원리스트 페이지네이션 시작 ########################-->
    <div class="row my-5">
        <div class="col text-center">
            <nav aria-label="...">
                <ul class="pagination justify-content-center">
                  <!-- 첫 페이지로 이동 -->
                  <li class="page-item" :class="{disabled: pageObj.isFirst}"><span class="page-link cursor-pointer" @click="showFirstPage">&laquo;</span></li>
                  <!-- 이전 블럭으로 이동 -->
                  <li class="page-item" :class="{disabled: !pageObj.hasPrev}"><span class="page-link cursor-pointer" @click="showPrevBlock">&lt;</span></li>
                  <!-- 페이지번호 이동 -->
                  <li class="page-item" :class="{active: pageObj.startBlock + i - 1 === pageObj.page}" :aria-current="{page: pageObj.startBlock + i - 1 === pageObj.page}" v-for="i in pageObj.finishBlock-pageObj.startBlock+1" :key="i">
                    <span href="#" class="page-link" :class="{'cursor-pointer': pageObj.startBlock + i - 1 !== pageObj.page}" @click="showTargetPage(pageObj.startBlock + i - 1)">{{pageObj.startBlock + i - 1}}</span>
                  </li>
                  <!-- 다음 블럭으로 이동 -->
                  <li class="page-item" :class="{disabled: !pageObj.hasNext}"><span class="page-link cursor-pointer" @click="showNextBlock">&gt;</span></li>
                  <!-- 마지막 페이지로 이동 -->
                  <li class="page-item" :class="{disabled: pageObj.isLast}"><span class="page-link cursor-pointer" @click="showLastPage">&raquo;</span></li>
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
          // 관리자 회원검색 조건 VO
          memberSearchVO: {
            memberId: "",
            memberNick: "",
            minPoint: "",
            maxPoint: "",
            memberEmail: "",
            memberAgreeList: [],
            beginJoinDate: "",
            endJoinDate: "",
            memberLevelList: [],
            searchLoginDays: "",
            orderList: [],
          },
          // 체크리스트
          // 동의/비동의
          agree: false,
          disagree: false,
          // 회원/관리자
          user: false,
          adminUser: false,
          // 1차정렬/2차정렬

          // 회원리스트  
          memberList: [],


          // 선택된 회원 Object
          selectedMemberObj: {},
          // 선택된 회원 List
          selectedMemberList: [],


          // 페이지네이션 Obj
          pageObj: {
            page: 1,
            size: 10,
            blocksize: 10,
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
        // 멤버 불러오기
        async loadMemberList(){
            const url = "http://localhost:8080/rest/admin/member"
            const response = await axios.post(url, this.memberSearchVO);
            console.log(response.data);
            this.memberList = response.data;
        },
        // 회원 비동기 검색
        // async searchMember(){
            // const url = "http://localhost:8080/rest/report/test/";
            // const resp = await axios.post(url, this.memberSearchVO);
            // this.memberList = _.cloneDeep(resp.data);
            // console.table(this.memberSearchVO);
        // },

        // 회원 개별선택
        checkMember(e, memberId){
            if(e.target.checked){
                this.selectedMemberObj[memberId] = true;
            } else {
                delete this.selectedMemberObj[memberId];
            }
        },

        // # 선택회원 일괄처리(회원아이디)
        async changeMember(){
            // 아티스트 선택 전처리 함수
            if(!this.preMemberAccess()) return;

            // 사용자 확인
            const selectedCnt = this.selectedMemberList.length;
            if(selectedCnt===0 && !confirm(selectedCnt + "개의 회원을 변경하시겠습니까?")) return;

            console.table(this.selectedMemberList)

            // URL
            // const url = "http://localhost:8080/rest/artist/"
            // 아티스트 삭제

            // const resp = await axios.delete(url, { 
                // data: this.selectedMemberList,
            // });

            // 선택항목 초기화
            this.setSelectedMemberEmpty();

            // 아티스트 목록 조회
            this.loadMemberList();

            alert(selectedCnt + "개의 회원의 정보가 변경되었습니다.")
        },

        // 선택회원 일괄처리 (회원 수정-자유,고정, 삭제-회원이름) 전처리 함수
        preMemberAccess(){
            // 1. 선택된 회원 이름 리스트 초기화
            this.setSelectedMemberList();
            
            // 2. 선택된 항목이 없다면 실행 X
           if(!this.isSelectedMemberExist()) return false;

            return true;
        },
        // 선택된 회원 존재여부 확인
        isSelectedMemberExist(){
            // 선택된 회원 갯수
            const selectedMemberLeng = this.selectedMemberList.length;
            // 선택된 회원 존재여부
            const selectedMemberExist = selectedMemberLeng !== 0;
            return selectedMemberExist;
        },

        
        // 선택된 회원 배열 생성
        setSelectedMemberList(){
            this.selectedMemberList = Object.keys(this.selectedMemberObj);
        },
        // 선택된 회원 초기화
        setSelectedMemberEmpty(){
            this.selectedMemberObj = {};
            this.selectedMemberList = [];
        },
        // 회원 전체선택
        checkAllMember(e){
            if(e.target.checked){
                for(let i = 0; i<this.memberList.length; i++){
                    this.selectedMemberObj[this.memberList[i].memberId] = true;
                    this.setSelectedMemberList();
                }
            } else {
                this.setSelectedMemberEmpty();
            }
        },

        // 풀네임 생성
        fullName(name, engName){
          return name + "(" + engName + ")";
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
        "agree": function(){
            if(this.agree){
                this.memberSearchVO.memberAgreeList.push("Y");
            } else {
                this.memberSearchVO.memberAgreeList = this.memberSearchVO.memberAgreeList.filter(item=>item!=="Y");
            }
        },
        "disagree": function(){
            if(this.disagree){
                this.memberSearchVO.memberAgreeList.push("N");
            } else {
                this.memberSearchVO.memberAgreeList = this.memberSearchVO.memberAgreeList.filter(item=>item!=="N");
            }
        },
        "user": function(){
            if(this.user){
                this.memberSearchVO.memberLevelList.push("일반회원");
            } else {
                this.memberSearchVO.memberLevelList = this.memberSearchVO.memberLevelList.filter(item=>item!=="일반회원");
            }
        },
        "adminUser": function(){
            if(this.adminUser){
                this.memberSearchVO.memberLevelList.push("관리자");
            } else {
                this.memberSearchVO.memberLevelList = this.memberSearchVO.memberLevelList.filter(item=>item!=="관리자");
            }
        },
        memberList: {
          deep: true,
          handler(newVal, oldVal) {
            this.pageObj.total = this.memberList.length;
          }
        },
      },
      created(){
            this.loadMemberList();
      },
      mounted(){
      },
    }).mount('#app')
  </script>

<jsp:include page="/WEB-INF/views/admin/adminFooter.jsp"></jsp:include>
	
	