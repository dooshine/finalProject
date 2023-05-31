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
							$("[name=postContent]").summernote('insertNode', imgNode.get(0));
						},
						error:function(){}
					});
					
				}
			}
        });
        
    });
</script>

<div id="app">
	<div style="width:600px">
	<h2>펀딩 게시글 작성</h2>
	<form action="write3" method="post" enctype="multipart/form-data"> 
		제목 : <input type="text" name="fundTitle"><br><br>
		짧은 제목 : <input type="text" name="fundShortTitle"><br><br>
		시작일 : <input type="date" name="postStart"><br><br>
		종료일 : <input type="date" name="postEnd"><br><br>
		목표 금액 : <input type="text" name="fundGoal"><br><br>
		내용 : <textarea name="postContent"></textarea><br><br>
<!-- 		이미지(여러 개) : <input type="file" name="attaches" multiple> -->
		대표 이미지(1개) : <input type="file" name="attach">
		<button type="submit" @click="insertFixedTagList">글쓰기</button>
		<input type="hidden" v-for="(newFixedTag, i) in newFixedTagList" 
					:key="i" v-model="newFixedTag" name="newFixedTagList">
	</form>
	
	
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
                    
	           	},
	           	watch: {
	           		findFixedTagName:_.throttle(function(){
	                    //this == 뷰 인스턴스
	                    this.loadFindFixedTagList();
	        }, 250),
	            },
	            mounted() {
	            },
	           	created() {
	           	}
	  		}).mount("#app");

		</script>
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
