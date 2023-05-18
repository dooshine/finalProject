<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
	
	
	<div class="container-fluid" id="app">
		
		<!----------- 글쓰기 구간 ------------>
	    <div class="bg-white p-3 rounded-4">
	        <div class="row mt-1">
	            <div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">
	               <img class="rounded-circle img-fluid" src="static/image/profileDummy.png">
	            </div>
	            <div class="col-11 col-md-11 col-lg-11 d-flex align-items-center justify-content-center">
	                <button type="button" class="btn btn-white btn-outline-dark rounded-pill col-12 ">무슨 생각을 하고 계신가요?</button>
<!-- 	                <button type="button" class="btn btn-white btn-outline-dark rounded-pill col-12 " v-on:click="showModal">무슨 생각을 하고 계신가요?</button> -->
	            </div>
	        </div>	        
	    </div>
	    <br><br>
	    <!----------- 글쓰기 구간 ------------>
	    
	    
	    <!--------------- 게시물들 반복구간 ------------->
	    <div v-for="(post, index) in posts" :key="index">
	    
	    		<!-- 글 박스 루프 1개-->
                <div class="bg-white p-2 rounded-4">
                
                	<!-- 프로필 사진과 아이디 -->
                	<div class="row mt-1">
			            <div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">
			               <img class="rounded-circle img-fluid" src="static/image/profileDummy.png">
			            </div>
<!-- 			            	<p>{{ post.postNo }}</p> -->
			            <div class="col-11 col-md-11 col-lg-11 d-flex align-items-center justify-content-start">
							<p>{{ post.memberId }}</p>            
			            </div>
	       			</div>	
					<!-- 프로필 사진과 아이디 -->
					
					
					
					<!-- 태그와 글 태그들 -->
	                <div class="row">
	                	<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">
			               
			            </div>
			            <div class="col-10 col-md-10 col-lg-10 d-flex align-items-center justify-content-start">
							<div class="row bg-info rounded-pill align-items-center justify-content-center">
								<p >{{ post.postType }}</p>
							</div>							       
			            </div>
						<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center"> 
			            </div>	                
	                </div>
	                <!-- 태그와 글 태그들 -->
	                
	                
	                
	                <!-- 글 내용 -->
	                <div class="row">
	                	<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center">
			               
			            </div>
			            <div class="col-10 col-md-10 col-lg-10 d-flex align-items-center justify-content-start">
							<!-- 	                <p>{{ post.postTime }}</p> -->
	                	<p>{{ post.postContent }}</p>	  
			            </div>
						<div class="col-1 col-md-1 col-lg-1 d-flex align-items-center justify-content-center"> 
			            </div>                
	                </div>
	                <!-- 글 내용 -->
	                

                </div>
                <!-- 글 박스 루프 1개-->
                
                <br><br>
       	 </div>
       	 <!--------------- 게시물들 반복구간 ------------->	   
	</div>

    
    <script>
        Vue.createApp({
            data(){
                return {
                	posts: [],
                	tags: [], 
                	
                	
                    //modal을	 제어할 수 있는 리모컨을 구비
					// modal:null,
                };
            },
            methods:{
//                 showModal(){
//                     if(this.modal == null) return;
//                     this.modal.show();
//                 },
//                 hideModal(){
//                     if(this.modal == null) return;
//                     this.modal.hide();
//                 },
				
				// 모든 게시글 불러오기 
                fetchPosts: function() {
                axios.get('http://localhost:8080/rest/post/all')
                    .then(response => {
                        this.posts = response.data; // 데이터를 할당
                    })
                    .catch(error => {
                        console.error(error);                           
                    });
                
            }
            },
            mounted(){
                //[1] Vue Ref를 이용한 모달 생성
				// this.modal = new bootstrap.Modal(this.$refs.modal01);
                
               
                this.fetchPosts();
                
                // 
                this.posts.forEach(post => {
                    axios.get('http://localhost:8080/rest/post/tag')
                      .then(response => {                       
                        this.tags = console.log(response.data);
                      })
                      .catch(error => {
                        console.error(error);
                      });
                  });
            },
        }).mount("#app");
    </script>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>