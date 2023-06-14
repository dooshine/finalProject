<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- c태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container custom-container" id="app">
    <h1>테스트</h1>
    <button @click="restTest">레스트 테스트</button>
</div>

<script>
  Vue.createApp({
    data() {
      return {
        text: "안녕하세요",

        // 피드 로드
        posts: [],
        page: 1,
        memberId: memberId,
      };
    },
    computed: {

    },
    methods: {
        async restTest(){
            const url = "${contextPath}/dev/restInterceptor";

            // const resp = axios.get(url);
            // ↓

            axios.get(url)
                .then((response)=>{
                    //console.log(response.data);
                })
                .catch((error)=>{
                    if(error.response.status === 500){
                        //console.log("로그인이 안됐심더");
                        window.location.href="http://naver.com";
                    }
                });
        },

        async fetchPosts(){

        // 페이지가 1페이지고(10개의 게시물만 보이고), 최초 mounted가 실행된 이후에 새로 호출 되었을 경우,
        // 아예 페이지 새로 고침
        // if(this.page == 2 && this.firstMountFlag)
        // {
        //   location.reload();	
        // }
          
          
        //     if(this.loading == true) return;//로딩중이면
        //     if(this.finish == true) return;//다 불러왔으면
            
        //     this.loading = true;
            // 1페이지 부터 현재 페이지 까지 전부 가져옴 
            var likedPostData ={
                page: this.page,
                likedMemberId: this.memberId
            };
                                  
          const resp = await axios.post("${contextPath}/rest/post/pageReload/memberLikePost",likedPostData);
          this.posts = resp.data;
          //console.log(this.posts);
          // this.getLikePostIndex(this.posts);
          // this.getReplyAllList(this.posts);
          // this.page++;
          
          // this.loading=false;
          
          // if(resp.data.length < 10){
          //   this.finish = true;
          // }
          // this.firstMountFlag = true;
        },
    },
    watch: {

    },
    created(){
      this.fetchPosts();
    },
  }).mount('#app')
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>