<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Bootstrap demo</title>
    <!-- <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"> -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.2.3/cosmo/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
  </head>
  <body>

    <!--
        container - 화면이 배치될 기본 위치

        1. container : 기본 컨테이너이며 폭에 반응하여 자동 조정(뚝뚝끊김)
        2. container-fluid : 폭의 변화에 부드럽게 반응하는 컨테이너(100%)

        row - 한 줄 영역 , col - 한 칸 영역

        사이즈 - sm, md, lg, xl
    -->
    <div class="container-fluid mt-4" id="app">

        <div class="row">
            <div class="offset-md-2 col-md-8">


                <!-- 작성하고자 하는 컨텐츠 내용 -->
                <div class="row mt-4">
                    <div class="col">
                        <button type="button" class="btn btn-primary" v-on:click="showModal">열기(VueJS)</button>
                    </div>
                </div>

            </div>
        </div>

        <!-- 
            모달은 디자인에 영향이 없으므로 아무데나 만들면 된다 
            일반적으로 화면 마지막에 만든다(처음부터 표시되지 않으니까)

            tabindex="-1"이면 탭키를 눌러서 선택이 불가능

            부트스트랩에서는 버튼등에 옵션을 지정하여 모달을 제어할 수 있다
            (프로그래밍 코드 없이도 표시/숨김 등을 설정할 수 있다)

            모달창에 아이디나 클래스같은 식별자를 표시하고 버튼에 설정으로 연결
            data-bs-target은 참조할 대상 모달창을 지정할 수 있다
            data-bs-toggle로 토글 효과를 지정할 수 있다
            data-bs-dismiss로 제거할 효과를 지정할 수 있다

            data-bs-backdrop="static"으로 배경 클릭 시 모달이 사라지지 않도록 설정
        -->
        <div class="modal" tabindex="-1" role="dialog" id="modal01"
                            data-bs-backdrop="static"
                            ref="modal01">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">제목</h5>
                    </div>
                    <div class="modal-body">
                        <!-- 모달에서 표시할 실질적인 내용 구성 -->
                        <p>본문 내용</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary"
                                data-bs-dismiss="modal">닫기</button>
                    </div>
                </div>      
            </div>
        </div>
        
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  
    <!--[3] VueJS로 모달창을 열기-->
    <script src="https://unpkg.com/vue@next"></script>
    <script>
        Vue.createApp({
            data(){
                return {
                    //modal을 제어할 수 있는 리모컨을 구비
                    modal:null,
                };
            },
            methods:{
                showModal(){
                    if(this.modal == null) return;
                    this.modal.show();
                },
                hideModal(){
                    if(this.modal == null) return;
                    this.modal.hide();
                },
            },
            mounted(){
                //[1] Javascript 선택 도구를 이용한 생성
                // this.modal = new bootstrap.Modal(
                //     document.querySelector("#modal03")
                // );

                //[2] Vue Ref를 이용한 생성
                this.modal = new bootstrap.Modal(this.$refs.modal01);
            },
        }).mount("#app");
    </script>

  </body>
</html>