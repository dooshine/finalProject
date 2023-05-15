
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.2.3/cosmo/bootstrap.min.css">

<div class="container-fluid mt-4" id="app">

    <div class="row">
        <div class="offset-md-2 col-md-8">

<!--                 문서 제목 (Jumbotron) -->
<!--                 <div class="row text-center"> -->
<!--                     <div class="col bg-dark text-light p-4 rounded"> -->
<!--                         <h1>모달(Modal)</h1> -->
<!--                         <p>브라우저에게 차단당하지 않는 새창</p> -->
<!--                     </div> -->
<!--                 </div> -->

            <!-- 작성하고자 하는 컨텐츠 내용 -->
            <div class="row mt-4">
                <div class="col">
                    <button type="button" class="btn btn-primary"
                        data-bs-target="#modal1" data-bs-toggle="modal">
                        글쓰기
                    </button>
                </div>
            </div>

        </div>
    </div>


</div>
      <!----------------------------------- 네개의 모달창 구성------------------------------------------------->
      <!-- 1. 카테고리 선택 -->
        <div class="modal" tabindex="-1" role="dialog" id="modal1"
                            data-bs-backdrop="static"> <!-- static이면 모달창 외부 클릭해도 안꺼짐 -->
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                
                   <!-- header -->
                    <div class="modal-header">
                        <h5 class="modal-title">글 카테고리 설정</h5>
                    </div>
                    
                    <!-- body -->
                    <div class="modal-body">
                        <!-- 태그 버튼 선택 -->
                        <p class="text-center">무엇에 대한 글인가요?(카테고리 설정)</p>
                        <div class="row ms-5 me-5">                     
                           <button type="button" class="col btn btn-primary modal2"
                              data-bs-target="#modal2" data-bs-toggle="modal">
                              자유
                           </button>
                           &nbsp; &nbsp;
                           <button type="button" class="col btn btn-primary modal2"
                              data-bs-target="#modal2" data-bs-toggle="modal">
                              행사일정
                           </button>
                        </div>
                        <br>
                        <div class="row ms-5 me-5">
                           <button type="button" class="col btn btn-primary modal2"
                              data-bs-target="#modal2" data-bs-toggle="modal">
                              같이가요
                           </button>
                           &nbsp; &nbsp;
                           <button type="button" class="col btn btn-primary modal2"
                              data-bs-target="#modal2" data-bs-toggle="modal">
                              펀딩
                           </button>
                        </div>
                    </div>
                   
                    <!-- footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary"
                                data-bs-dismiss="modal">닫기</button>
                    </div>
                    
                </div>      
            </div>
         </div>
       
   
         
      <!-- 2.  태그 창 (첫번 째 창에서 다음 버튼이 클릭 되었을 때, 비동기로 현존하는 이벤트 태그들을 가져옴)-->
        <div class="modal" tabindex="-1" role="dialog" id="modal2"
                            data-bs-backdrop="static">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                
                   <!-- header -->
                    <div class="modal-header">
                        <h5 class="modal-title">태그 연결</h5>
                    </div>
                    
                    <!-- body -->
                    <div class="modal-body">
                        <p class="text-center">글에 적용할 태그를 입력해주세요</p>
                        <div class="row text-center">
                            <div class="col-1"></div>
                           <input type="text" class="tag-input col-7" placeholder="태그를 입력하세요">
                           <div class="col-1"></div>
                           <button class="col-2 tag-btn">입력</button>
                        </div>
                        <div class="row">
                           <h6 class="all-tag"></h6>
                        </div>                         
                    </div>
                    
                    <!-- footer -->
                    <div class="modal-footer">
                          <button type="button" class="btn btn-primary"
                            data-bs-target="#modal3" data-bs-toggle="modal">
                           세번째모달로
                        </button>
                        <button type="button" class="btn btn-secondary"
                                data-bs-dismiss="modal">닫기</button>
                    </div>
                    
                </div>      
            </div>
         </div>
         
         
        <!-- 3. 글 및 업로드 창 (두 번째 창에서 다음 버튼이 클릭 되었을 때, 비동기로 현존하는 아이돌 태그들을 가져옴)-->
        <div class="modal" tabindex="-1" role="dialog" id="modal3"
                            data-bs-backdrop="static">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                
                   <!-- header -->
                    <div class="modal-header">
                        <h5 class="modal-title">글 작성</h5>
                    </div>
                    
                    <!-- body -->
                    <div class="modal-body">
                        <textarea class="col-12 post" style="height: 200px;" placeholder="글 작성란"></textarea>
                        <div id="preview" contenteditable="true"></div>
                        
                    </div>
                    
                    <!-- footer -->
                    <div class="modal-footer">
                       <input type="file" id="fileInput" multiple>
                       <button type="button" class="btn btn-primary write-finish"
                                data-bs-dismiss="modal">작성완료</button>
                    
                        <button type="button" class="btn btn-secondary"
                                data-bs-dismiss="modal">닫기</button>
                    </div>
                    
                </div>      
            </div>
         </div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>