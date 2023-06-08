<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!--summernote cdn-->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<script type="text/javascript">
    $(function(){
        $('[name=postContent]').summernote({
            placeholder: '내용을 입력해주세요',
            tabsize: 4,
            height: 600,
            toolbar: [
                ['style', ['style']],
                ['font', ['bold', 'underline', 'clear']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['table', ['table']],
                ['insert', ['link', 'picture']]
            ],
            callbacks: {
				onImageUpload: function(files) {
					if(files.length != 1) return;
					
					const fd = new FormData();
					fd.append("attach", files[0]);
					
					$.ajax({
						url:"/rest/attachment/upload",
						method:"post",
						data:fd,
						processData:false,
						contentType:false,
						success:function(response){
							const input = $("<input>").attr("type", "hidden")
														.attr("name", "attachmentNo")
														.val(response.attachmentNo);
							$("form").prepend(input);

							var imgNode = $("<img>").attr("src", "http://localhost:8080/rest/attachment/download/"+response.attachmentNo);
							imgNode.attr('width','100%');
							$("[name=postContent]").summernote('insertNode', imgNode.get(0));
						},
						error:function(){}
					});
					
				}
			}
        });
        
    });
</script>

   <style>
   	     @media screen and (max-width:992px) {
		  	.col-6 {
		    width: 100%; 
		  }
    	}

		   	section {
			  font-family: "Noto Sans KR", sans-serif;
			}
			 
			.title {
	   			font-weight:bold;
		   	}
		   	
			/* 	summernote block url access */
		   	.note-group-image-url {
			  display: none;
			}
	
	</style>
	
<div id="app">

	<div id="d-flex justify-content-center">
	  <div class="container rounded p-3" style="background-color:white">
	    <h3 class="title mt-5 mb-5" style="padding-left: 0.5em">펀딩 게시글 작성</h3>
	    <div style="padding-left:1em; padding-right:1em;">


	<form action="write3" method="post" enctype="multipart/form-data"> <!--  -->

	<div class="input-group mb-3">
	    <span class="input-group-text" id="inputGroup-sizing-default">제목</span>
	  <input type="text" name="fundTitle" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default">
	</div>
	
	<div class="input-group mb-3">
	    <span class="input-group-text" id="inputGroup-sizing-default">한줄 소개</span>
	  <input type="text" name="fundShortTitle" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default">
	</div>
	
	<div class="input-group mb-3">
	    <span class="input-group-text" id="inputGroup-sizing-default">시작일</span>
	  <input type="date" name="postStart" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default" 
	  			:min="minDate" v-model="postStart">
	</div>
	
	<div class="input-group mb-3">
	    <span class="input-group-text" id="inputGroup-sizing-default">종료일</span>
	  <input type="date" name="postEnd" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default"
	  			:min="minDateEnd" v-model="postEnd">
	</div>
	
	<div class="input-group mb-3">
	    <span class="input-group-text" id="inputGroup-sizing-default">목표 금액</span>
	  <input type="text" name="fundGoal" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default">
	</div>
	
	
	<div class="input-group mb-3">
	  <textarea name="postContent" class="form-control" aria-label="With textarea"></textarea>
	</div>
	




	<div class="input-group mb-5 row">
	
	  <div class="input-group-prepend col-4 d-flex justify-content-center align-items-center">
	    <span class="input-group-text " @click="selectFile">대표 이미지(1개)</span>
	  </div>
	  
	  <div class="custom-file col-6">
	  	<img :src="previewURL" style="width:200px; height: 200px;"/>
	    <input type="file" name="attach" class="custom-file-input" id="inputGroupFile01"
	    			ref="fileInput" style="display:none;" @change="handleMainImagePreview">
	  </div>
	</div>
	<!-- 고정태그 입력 시 목록 불러오기 -->
	    <div class="row mt-3">
	        <div class="col">
	            태그 : <input type="text" @input="findFixedTagName = $event.target.value" v-model="findFixedTagName">
	        </div>
	    </div>
	    <div class="row">
	        <div v-for="(findFixedTag, i) in findFixedTagList" :key="i">
	            <button class="btn btn-secondary" @click="addNewFixedTag(findFixedTag)">{{ findFixedTag }}</button>
	        </div>
	    </div>
	    <div class="row mt-3">
	        <div class="col">
	            <button class="btn btn-primary" v-for="(newFixedTag, i) in newFixedTagList"
	            				@click="deleteTag(i)">{{ newFixedTag }}</button>
	        </div>
	    </div>


		<div class="row mt-3">
			<button type="submit" class="btn btn-primary mb-5" @click="insertFixedTagList">글쓰기</button>
			<input type="hidden" v-for="(newFixedTag, i) in newFixedTagList" 
						:key="i" v-model="newFixedTag" name="newFixedTagList">
		</div>

	</form>
	
	
	</div>
</div>
	</div>
</div>

		<script src="https://unpkg.com/vue@3.2.36"></script>
	    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
	    
		<script>
		 Vue.createApp({
	            //데이터 설정 영역
	            data(){
            	   return{
            		// 입력 시 고정태그 불러오기
   	          	      findFixedTagName: "",
         	          findFixedTagList: [],
         	          newFixedTagList: [],
         	          previewURL: "/static/image/profileDummy.png",
         	          el: '#app',
         	          minDate: "",
         	          minDateEnd: "",
         	          postStart: "",
         	          posrtEnd: "",
            	   }
	            	},
            	computed: {
            	},
            	methods: {
            		async loadFindFixedTagList(){
                        if(this.findFixedTagName.length == 0) return;

                        const resp = await axios.get("http://localhost:8080/rest/fixedTag/"+this.findFixedTagName);
                        this.findFixedTagList = resp.data;
                        console.log(this.findFixedTagList);
                        // console.log("조회 실행");
                    },
                    // 고정태그 추가
                    addNewFixedTag (newFixedTag){
                        this.newFixedTagList.push(newFixedTag);
                        this.findFixedTagName = "";
                        this.findFixedTagList = [];
                    },
                    deleteTag(i){
                    	this.newFixedTagList.splice(i, 1);
                    },
                    async insertFixedTagList() {
                    	const url = "/rest/fund/tag";
                    	const resp = axios.post(url, this.newFixedTagList)
                    },
                    selectFile() {
                    	this.$refs.fileInput.click();
                    },
                    // 대표사진 미리보기
                    handleMainImagePreview(){
                        // 업로드 파일
                        const file = event.target.files[0];

                        this.previewURL = URL.createObjectURL(file);
                    },
                    
                    // 종료일
                    updateEndDateMin() {
					    if (this.postStart) {
					      const minDateEnd = new Date(this.postStart);
					      minDateEnd.setDate(minDateEnd.getDate());
					      this.minDateEnd = minDateEnd.toISOString().split("T")[0];
					    }
					  }
                    
	           	},
	           	watch: {
	           		findFixedTagName:_.throttle(function(){
	                    //this == 뷰 인스턴스
	                    this.loadFindFixedTagList();
	        			}, 250),
	        			
	        		// 종료일 update
        			postStart(newDate) {
        			    this.updateEndDateMin();
        			  }
	        	
	            },
	            mounted() {
	            	const today = new Date().toISOString().split("T")[0];
	            	this.minDate = today;
	            	this.updateEndDateMin();
	            },
	           	created() {
	           	}
	  		}).mount("#app");

		</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
