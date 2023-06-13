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

						var imgNode = $("<img>").attr("src", "${contextPath}/rest/attachment/download/"+response.attachmentNo);
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

		
			.note-editor {
			
			 width:100%;
			}

		
			/* 	summernote block url access */
		   	.note-group-image-url {
			  display: none;
			}
	
	</style>
	
	<script>
		function checkTitleLength(input) {
		  if (input.value.length > 15) {
		    input.value = input.value.slice(0, 15); // 입력된 제목을 15글자까지로 잘라냄
		  }
		}
		
		function limitInputLength(input) {
			  if (input.value.length > 20) {
			    input.value = input.value.slice(0, 20); // 입력된 값을 20자로 자릅니다.
			  }
			}
	</script>
	
	
<div id="app">

	<div id="d-flex justify-content-center">
	  <div class="custom-container p-3">
	    <h3 class="font-bold mt-5 mb-5" style="padding-left: 0.5em">펀딩 게시글 작성</h3>
	    <div style="padding-left:1em; padding-right:1em;">


	<form action="write" method="post" enctype="multipart/form-data"> 



		<div class="input-group mb-3">
		  <input type="file" name="attach" class="form-control" id="inputGroupFile02" accept=".gif, .jpg, .png">
		  <label class="input-group-text" for="inputGroupFile02" @click="selectFile">대표 이미지(1개, 최적 해상도 450*400)</label>
		</div>
		
	
		<div class="input-group mb-3">
		    <span class="input-group-text" id="inputGroup-sizing-default">제목</span>
		  <input type="text" name="fundTitle" placeholder="15글자 이내로 입력하세요"
		  class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default"  oninput="checkTitleLength(this)">
		</div>
		
		<div class="input-group mb-3">
		    <span class="input-group-text" id="inputGroup-sizing-default">한줄 소개</span>
		  <input type="text" name="fundShortTitle" placeholder="20글자 이내로 입력하세요" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default"
		  			maxlength="20" oninput="limitInputLength(this)">
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
		
		
		<div class="input-group mb-3" >
		  <textarea name="postContent"  style="width:100%" class="form-control" aria-label="With textarea"  style="width:100%"></textarea>
		</div>
		



	<!-- 고정태그 입력 시 목록 불러오기 -->

	    <div class="input-group mb-3">
		    <span class="input-group-text" id="inputGroup-sizing-default">태그</span>
		  <input type="text" @input="findFixedTagName = $event.target.value" v-model="findFixedTagName"
		  	name="fundGoal" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default">
		</div>
		
		
	    
	    <div class="row">
	        <div v-for="(findFixedTag, i) in findFixedTagList" :key="i">
	            <div class="fixed-tag" style="background-color:#7f7f7f;" @click="addNewFixedTag(findFixedTag)">{{ findFixedTag }}</div>
	        </div>
	    </div>
	    <div class="row">
	        <div class="col">
	            <div class="fixed-tag" v-for="(newFixedTag, i) in newFixedTagList"
	            				@click="deleteTag(i)">{{ newFixedTag }}</div>
	        </div>
	    </div>


		<div class="mt-3">

			<button type="submit" class="custom-btn btn-purple1 mb-5 w-100" @click="insertFixedTagList">프로젝트 올리기</button>
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

                        const resp = await axios.get("${contextPath}/rest/fixedTag/"+this.findFixedTagName);
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
                    	if (this.findFixedTagName === "") {
                            // findFixedTagName이 비어있는 경우 데이터 전송하지 않음
                            return;
                        }
                    	
                    	const url = "/rest/fund/tag";
                    	const resp = axios.post(url, this.newFixedTagList)
                    },
                    selectFile() {
                    	this.$refs.fileInput.click();
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
