<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<jsp:include page="/WEB-INF/views/template/header_member.jsp"></jsp:include> 
	<br><br>
	<div class="container" id=app>
		<div class="col-6 custom-container" style="background-color:white; margin-left: 300px;">
		
		<!-- 페이지 생성 -->
		<div class="row page">
			<form 	action="exit" method="post" autocomplete="off" id="exitForm" @submit="submitForm">
			
			<!-- 회원탈퇴 약관 동의 페이지-->
			<div v-show="page==1">
				<h2 class="font-purple1">회원 탈퇴</h2>
				<div class="custom-hr"></div>
				<div style="text-align: center;">
            	<textarea class="textarea " readonly style="margin: 0 auto; min-width:500px;  min-height:300px; text-align: left; overflow: auto;" disabled>
개인정보처리방침
회원탈퇴 시 개인 정보 및 STRALINK에서 만들어진 모든 데이터는 삭제됩니다.
(단, 아래 항목은 표기된 법률에 따라 특정 기간 동안 보관됩니다.)

1. 계약 또는 청약 철회 등에 관한 기록 보존 이유 : 전자상거래 등에서의 소비자보호에 관한 법률 / 보존기간 : 5년
2. 대금결제 및 재화 등의 공급에 관한 기록 보존 이유 : 전자상거래 등에서의 소비자보호에 관한 법률 / 보존기간 : 5년
3. 전자금융 거래에 관한 기록 보존 이유 : 전자금융거래법 보존기간 / 5년
4. 소비자의 불만 또는 분쟁처리에 관한 기록 보존 이유 : 전자 상거래 등에서의 소비자보호에 관한 법률 / 보존기간 : 3년
5. 신용정보의 수집/처리 및 이용 등에 관한 기록 보존 이유 : 신용정보의 이용 및 보호에 관한 법률 / 보존기간 : 3년
6. 전자(세금)계산서 시스템 구축 운영하는 사업자가 지켜야 할 사항 고시(국세청 고시 제 2016-3호) (전자세금계산서 사용자에 한함) : 5년
(단, (세금)계산서 내 개인식별번호는 3년 경과 후 파기)
            	</textarea>
				<div style="text-align: center;">
            	<textarea class="textarea " readonly style="margin: 0 auto; min-width:500px;  min-height:100px; text-align: left; overflow: auto;" disabled>
유의사항
- 회원 탈퇴는 14일 후에 처리되며, 기간 내 재로그인 시 회원정보가 복원됩니다.
- 회원 탈퇴 처리 후에는 회원님의 개인정보를 복원할 수 없으며, 회원탈퇴 진행시 해당 아이디는 영구적으로 삭제되어 재가입이 불가합니다.
            	</textarea>
            	</div>
            	<input type="checkbox" v-model="agree" > 해당 내용을 모두 확인하였으며, 회원탈퇴에 동의합니다.
				<div class="custom-hr"></div>
				<div style="text-align: center;">
				    <button type="button" class="custom-btn btn-round btn-purple1" @click="pagePlus()" :disabled="!agree" style="width: 500px;">동의합니다.</button>
				</div>
			</div>	
			</div>
			<!-- 비밀번호 확인 페이지-->			
			<div v-show="page==2">
			    <h2 class="font-purple1">비밀번호 확인</h2>
			    <div class="custom-hr"></div>
			    <br>
			    <!-- 비밀번호 입력 -->
			    <div class="row mx-5 mb-1 justify-content-center">
			        <input type="password" v-model="password" class="custom-input-rounded-container" name="memberPw" 
			        placeholder="비밀번호" style="width:500px;" @keyup="exitPw();">
			    </div>
			    <div v-if="password !== '' && !pwCheck" class="row">
			        <h6 class="font-purple1 text-center">잘못된 비밀번호입니다. 다시 입력하세요.</h6>
			    </div>
			    
			    <div class="row my-3 mx-5">
			        <button type="submit"   class="custom-btn btn-round btn-purple1">탈퇴</button>
			    </div>
			</div>
			
			</form>
		</div>
		
		</div>
	</div>
	<script>
		Vue.createApp({
			data(){				
				return{
					page:1,
					agree:false,
					password : '',
					pwCheck:false,
				};
			},
			
			methods:{
				 pagePlus(){
               		  this.page++;
                 },
                 pageMinus() {
              	 	 this.page--; 
                 },
                 
                 async exitPw() {
                	 const response = await axios.get("/member/exitPw",{
                		 params :{
                			 memberPw : this.password
                		 }
                	 });
                	 if(response.data == "Y") {
                		 this.pwCheck = true;
                	 }
                 },
                 
                 submitForm() {
                     if (this.password !== '' && this.pwCheck) {
                         // 폼 제출 허용
                         return true;
                     } else {
                         // 폼 제출 막기
                         event.preventDefault();
                     }
                  },
			},
		}).mount("#app");
		
	</script>
