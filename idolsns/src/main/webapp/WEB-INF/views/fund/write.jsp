<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!--summernote cdn-->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<script type="text/javascript">
$(function(){
    $('[name=postContent]').summernote({
        placeholder: '내용을 입력해주세요 (개당 20MB 이하의 이미지만 업로드할 수 있습니다)',
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
				
				const fileSizeLimit = 20961034; // 20MB
	
		         // Check file size before uploading
		         const file = files[0];
		         if (file.size > fileSizeLimit) {
		           alert("20MB 이하의 이미지만 업로드할 수 있습니다.");
		           return;
		         }
				
				$.ajax({
					url: contextPath + "/rest/attachment/upload",
					method:"post",
					data:fd,
					processData:false,
					contentType:false,
					success:function(response){
						const input = $("<input>").attr("type", "hidden")
													.attr("name", "attachmentNo")
													.val(response.attachmentNo);
						$("form").prepend(input);

						var imgNode = $("<img>").attr("src", contextPath + "/rest/attachment/download/"+response.attachmentNo);
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
		
		/* 파일 용량제한 모달 */
		.custom-modal-wrapper {
		   position: fixed;
		   top: 0;
		   left: 0;
		   width: 100%;
		   height: 100%;
		   display: flex;
		   align-items: center;
		   justify-content: center;
		   z-index: 9999;
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
	    <h3 class="font-bold mt-5 mb-5" style="padding-left: 0.5em">펀딩 프로젝트 올리기</h3>
	    <div style="padding-left:1em; padding-right:1em;">


	<form action="write" method="post" enctype="multipart/form-data"> 



		<div class="input-group mb-3">
		  <input type="file" ref="fileInput" name="attach" class="form-control picInput" id="inputGroupFile02" 
		  accept=".gif, .jpg, .png" @change="checkFileSize">
		  <label class="input-group-text" for="inputGroupFile02" @click="selectFile">대표 이미지(1개, 최적 해상도 450*400)</label>
		</div>
		
	
		<div class="input-group mb-3">
		    <span class="input-group-text" id="inputGroup-sizing-default">제목</span>
		  <input type="text" v-model="funding.fundTitle" name="fundTitle" placeholder="15글자 이내로 입력하세요"
		  class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default" 
		  oninput="checkTitleLength(this)" @blur="checkDuplicateTitle">
		</div>
		
		<div class="input-group mb-3">
		    <span class="input-group-text" id="inputGroup-sizing-default">한줄 소개</span>
		  <input type="text" v-model="funding.fundShortTitle" name="fundShortTitle" placeholder="20글자 이내로 입력하세요" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default"
		  			maxlength="20" oninput="limitInputLength(this)">
		</div>
		
		<div class="input-group mb-3">
	    <span class="input-group-text" id="inputGroup-sizing-default">시작일</span>
	  		<input type="date" name="postStart" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default" 
	  			:min="minDate" v-model="funding.postStart">
		</div>
		
		<div class="input-group mb-3">
		    <span class="input-group-text" id="inputGroup-sizing-default">종료일</span>
		  <input type="date" name="postEnd" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default"
		  			:min="minDateEnd" v-model="funding.postEnd">
		</div>
		
		<div class="input-group mb-3 funding-fundGoal">
		  <span class="input-group-text" id="inputGroup-sizing-default">목표 금액</span>
		  <input type="text" v-model="funding.fundGoal" name="fundGoal" class="form-control" 
		  aria-label="Default" aria-describedby="inputGroup-sizing-default" @blur="validateGoalAmount">
		</div>
		
		
		<div class="input-group mb-3" >
		  <textarea name="postContent" style="width:100%; display:block;"
		  class="form-control summernote" aria-label="With textarea" required></textarea>
		</div>
		



	<!-- 고정태그 입력 시 목록 불러오기 -->

	    <div class="input-group mb-3">
		  <span class="input-group-text" id="inputGroup-sizing-default">태그</span>
		  <input type="text" @input="findFixedTagName = $event.target.value" v-model="findFixedTagName"
		  	class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default">
		</div>
		
		
	    
	    <div class="row">
	        <div v-for="(findFixedTag, i) in findFixedTagList" :key="i">
	            <div class="fixed-tag" style="background-color:#7f7f7f;" @click="addNewFixedTag(findFixedTag)">{{ findFixedTag }}</div>
	        </div>
	    </div>
	    <div class="row">
	        <div class="col">
	            <span class="fixed-tag me-1" v-for="(newFixedTag, i) in newFixedTagList"
	            				@click="deleteTag(i)">{{ newFixedTag }}</div>
	        </span>
	    </div>


		<div class="mt-3">

			<button type="submit" class="custom-btn btn-purple1 mb-5 w-100" 
			@click="insertFixedTagList" :disabled="!funding.isAllValid" >프로젝트 올리기</button>
			<input type="hidden" v-for="(newFixedTag, i) in newFixedTagList" 
						:key="i" v-model="newFixedTag" name="newFixedTagList">
		</div>

	</form>
	
	
	</div>
	</div>
	</div>
	
	<!-- 20메가 이상인 이미지 업로드 금지 모달 -->
	<div v-if="fileSizeAlert == true" class="custom-modal-wrapper">
	    <div class="custom-modal">
	       <div class="custom-modal-body" style="width: 300px;">
	          <div class="text-center mb-3">
	             <i class="ti ti-alert-triangle"></i>
	          </div>
	          <div class="text-center">20MB 이하의 이미지만 업로드할 수 있습니다.</div>
	          <div class="d-flex justify-content-center mt-4">
	             <button type="button" class="custom-btn btn-round btn-purple1 w-100" @click="hideFileSizeAlert">확인</button>
	          </div>
	       </div>
	   </div>
	</div>
	
	<!-- 목표금액 검사 모달창 -->
	<div v-if="fundGoalAlert == true" class="custom-modal-wrapper">
	    <div class="custom-modal">
	       <div class="custom-modal-body" style="width: 300px;">
	          <div class="text-center mb-3">
	             <i class="ti ti-alert-triangle"></i>
	          </div>
	          <div class="text-center">목표 금액은 숫자로 입력해야 합니다.</div>
	          <div class="d-flex justify-content-center mt-4">
	             <button type="button" class="custom-btn btn-round btn-purple1 w-100" @click="fundGoalAlert = false">확인</button>
	          </div>
	       </div>
	   </div>
	</div>
	
	<!-- 중복제목 모달창 -->
	<div v-if="fundTitleAlert == true" class="custom-modal-wrapper">
	    <div class="custom-modal">
	       <div class="custom-modal-body" style="width: 300px;">
	          <div class="text-center mb-3">
	             <i class="ti ti-alert-triangle"></i>
	          </div>
	          <div class="text-center">중복된 펀딩 제목입니다.</div>
	          <div class="d-flex justify-content-center mt-4">
	             <button type="button" class="custom-btn btn-round btn-purple1 w-100" @click="fundTitleAlert = false">확인</button>
	          </div>
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
            		  el: '#app',
            		// 입력 시 고정태그 불러오기
   	          	      findFixedTagName: "",
         	          findFixedTagList: [],
         	          newFixedTagList: [],
         	          previewURL: "/static/image/profileDummy.png",
         	          el: '#app',
         	          minDate: "",
         	          minDateEnd: "",
         	          postStart: "",
         	          postEnd: "",
         	          fileSizeAlert: false,
         	          fundGoalAlert: false,
         	          fundTitleAlert: false,
         	          
         	          funding: {
	       	        	  fundTitle: "",
	       	        	  fundShortTitle: "",
	       	        	  postStart: "",
	       	        	  postEnd: "",
	       	        	  fundGoal: "",
	       	        	  isFileInputValid: false,
	       	        	  isFundGoalValid: false,
	       	        	  get isFundTitleValid(){
	       	        		  return this.fundTitle.trim() !== "";
	       	        	  },
	       	        	  get isFundShortTitleValid(){
	       	        		  return this.fundShortTitle.trim() !== "";
	       	        	  },
	       	        	  get isPostStartValid(){
	       	        		  return this.postStart.trim() !== "";
	       	        	  },
	       	        	  get isPostEndValid(){
	       	        		  return this.postEnd.trim() !== "";
	       	        	  },
	       	        	  get isAllValid() {
	                          return this.isFileInputValid && this.isFundTitleValid && this.isFundShortTitleValid &&
	                          			this.isPostStartValid && this.isPostEndValid && this.isFundGoalValid;
	                      },
         	        	  
         	          },
            	   
            	   }
	            	},
            	computed: {
            		
            	},
            	methods: {
            		async loadFindFixedTagList(){
						const target = this.findFixedTagName.replace(/[\/?&%# ]/g, "");
                        if(target.length == 0) return;

						const resp = await axios.get(contextPath + "/rest/fixedTag/"+target);
                        this.findFixedTagList = resp.data;
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
                    
                    // when submitted
                    async insertFixedTagList() {
                    	if (this.findFixedTagName === "") {
                            // findFixedTagName이 비어있는 경우 데이터 전송하지 않음
                            return;
                        }
                    	
                    	const url = contextPath + "/rest/fund/tag";
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
					  },
					  
				    // 사진 용량제한(20MB)
					async checkFileSize() {
					   this.fileLengthCheck();
					   const fileInput = document.querySelector('.picInput');
		               const file = fileInput.files[0];
		               let reader = new FileReader();
		               const isValid = await new Promise((resolve, reject) => {
		                  reader.onload = function(e) {
		                     const fileSize = e.target.result.length;
		                     const isValidSize = fileSize <= 20961034;
		                     resolve(isValidSize);
		                  };
		                  reader.onerror = function(error) {
		                     reject(error);
		                  };
		                  reader.readAsDataURL(file);
		               })
		               /*let isValid;
		               reader.onload = function(e) {
		                  let fileSize = e.target.result.length;
		                  isValid = fileSize <= 20961034;
		                  
		               }*/
		               if(!isValid) {
		                  this.fileSizeAlert = true;
		                  return;
		               }
				   	},
				 // 파일 검사
		            fileLengthCheck() {
		            	// 파일 업로드 처리
		                const fileInput = this.$refs.fileInput;
		            	//console.log("fileInput-----"+fileInput.files.length);
		            	// if not uploaded
		                if (fileInput.files.length === 0) {
		                  this.funding.isFileInputValid = false;
		                }
		                else {
	                	  this.funding.isFileInputValid = true;
		                }
		            },
				   	// 용량제한 모달 닫기
				   	hideFileSizeAlert() {
		               const fileInput = document.querySelector('.picInput');
		               fileInput.value = '';
		               this.fileSizeAlert = false;
		            },
		            
		            // 목표금액 검사
		            validateGoalAmount() {
				      if(isNaN(this.funding.fundGoal)) {
				    	this.fundGoalAlert = true;
				        this.funding.fundGoal = 0; // 유효하지 않은 값일 경우 0으로 초기화하거나 다른 처리를 수행할 수 있습니다.
				      }
				      else this.funding.isFundGoalValid = true;
				    },
				    
				    // 중복된 제목 검사
				    checkDuplicateTitle() {
				    	if(this.funding.fundTitle == "") return;
				    	const encodedTitle = encodeURIComponent(this.funding.fundTitle);
				    	axios.get(contextPath + '/rest/fund/duplicateTitleCheck/'+ encodedTitle)
				        .then(response => {
				          if (response.data) {
				        	  this.fundTitleAlert = true;
				        	  this.funding.fundTitle = "";
// 				        	  console.log("중복이야");
				          } 
				        })
				        .catch(error => {
				          console.error(error);
				          alert("중복 확인 중에 오류가 발생했습니다.");
				        });
				    },
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