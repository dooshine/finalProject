<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<jsp:include page="/WEB-INF/views/template/header_member.jsp"></jsp:include>

	<br><br>
	<div class="container" id = app>
			<div class="col-6 custom-container" style="background-color:white; margin-left: 300px;">
			
			<div class="row page">
            <form action="join" method="post" autocomplete="off" @submit.prevent="submitForm">	
            
            <!-- 약관동의 페이지 -->
            <div v-show="page==1">
            	<h2 class="font-purple1">약관 동의</h2>
            	<div class="custom-hr"></div>
            	<input type="checkbox" v-model="agree"> 이용약관에 동의합니다.
            	<br>
            	<div style="text-align: center;">
            	<textarea class="textarea " readonly style="margin: 0 auto; min-width:400px;  min-height:400px; text-align: left; overflow: auto;" disabled>
개인정보처리방침
1. 개인정보처리방침의 의의
스타링크는 본 개인정보처리방침은 개인정보보호법을 기준으로 작성하되, 스타링크 내에서의 이용자 개인정보 처리 현황을 최대한 알기 쉽고 상세하게 설명하기 위해 노력하였습니다.
						
이는 쉬운 용어를 사용한 개인정보처리방침 작성 원칙인 ‘Plain Language Privacy Policy(쉬운 용어를 사용한 개인정보처리방침)’를 도입한 것입니다.
						
개인정보처리방침은 다음과 같은 중요한 의미를 가지고 있습니다.
스타링크가 어떤 정보를 수집하고, 수집한 정보를 어떻게 사용하며, 필요에 따라 누구와 이를 공유(‘위탁 또는 제공’)하며, 이용목적을 달성한 정보를 언제·어떻게 파기하는지 등 ‘개인정보의 한살이’와 관련한 정보를 투명하게 제공합니다.
정보주체로서 이용자는 자신의 개인정보에 대해 어떤 권리를 가지고 있으며, 이를 어떤 방법과 절차로 행사할 수 있는지를 알려드립니다.
개인정보 침해사고가 발생하는 경우, 추가적인 피해를 예방하고 이미 발생한 피해를 복구하기 위해 누구에게 연락하여 어떤 도움을 받을 수 있는지 알려드립니다.
그 무엇보다도, 개인정보와 관련하여 스타링크와 이용자간의 권리 및 의무 관계를 규정하여 이용자의 ‘개인정보자기결정권’을 보장하는 수단이 됩니다.
						
2. 수집하는 개인정보
이용자는 회원가입을 하지 않을 시 전체 서비스 이용이 불가능합니다.
스타링크는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.

서비스 이용 과정에서 이용자로부터 수집하는 개인정보는 아래와 같습니다.
스타링크 내의 개별 서비스 이용, 이벤트 응모 및 경품 신청 과정에서 해당 서비스의 이용자에 한해 추가 개인정보 수집이 발생할 수 있습니다. 추가로 개인정보를 수집할 경우에는 해당 개인정보 수집 시점에서 이용자에게 ‘수집하는 개인정보 항목, 개인정보의 수집 및 이용목적, 개인정보의 보관기간’에 대해 안내 드리고 동의를 받습니다.
이용자 동의 후 개인정보를 추가 수집하는 경우‘개인정보 이용내역(내 정보)’ 확인하기
서비스 이용 과정에서 IP 주소, 쿠키, 서비스 이용 기록, 위치정보가 생성되어 수집될 수 있습니다.
						
구체적으로 1) 서비스 이용 과정에서 이용자에 관한 정보를 자동화된 방법으로 생성하여 이를 저장(수집)하거나, 2) 이용자 기기의 고유한 정보를 원래의 값을 확인하지 못 하도록 안전하게 변환하여 수집합니다. 
서비스 이용 과정에서 위치정보가 수집될 수 있으며, 스타링크에서 제공하는 위치기반 서비스에 대해서는 '스타링크 위치정보 이용약관'에서 자세하게 규정하고 있습니다. 이와 같이 수집된 정보는 개인정보와의 연계 여부 등에 따라 개인정보에 해당할 수 있고, 개인정보에 해당하지 않을 수도 있습니다.
						
스타링크는 아래의 방법을 통해 개인정보를 수집합니다.
						
회원가입 및 서비스 이용 과정에서 이용자가 개인정보 수집에 대해 동의를 하고 직접 정보를 입력하는 경우, 해당 개인정보를 수집합니다.
고객센터를 통한 상담 과정에서 웹페이지, 메일, 팩스, 전화 등을 통해 이용자의 개인정보가 수집될 수 있습니다.
스타링크와 제휴한 외부 기업이나 단체로부터 개인정보를 제공받을 수 있으며, 이러한 경우에는 개인정보보호법에 따라 제휴사에서 이용자에게 개인정보 제공 동의 등을 받은 후에 스타링크에 제공합니다.
기기정보와 같은 생성정보는 PC웹, 모바일 웹/앱 이용 과정에서 자동으로 생성되어 수집될 수 있습니다.
3. 수집한 개인정보의 이용
스타링크 및 스타링크 관련 제반 서비스(모바일 웹/앱 포함)의 회원관리, 서비스 개발·제공 및 향상, 안전한 인터넷 이용환경 구축 등 아래의 목적으로만 개인정보를 이용합니다.
						
회원 가입 의사의 확인, 연령 확인 및 법정대리인 동의 진행, 이용자 및 법정대리인의 본인 확인, 이용자 식별, 회원탈퇴 의사의 확인 등 회원관리를 위하여 개인정보를 이용합니다.
콘텐츠 등 기존 서비스 제공(광고 포함)에 더하여, 인구통계학적 분석, 서비스 방문 및 이용기록의 분석, 개인정보 및 관심에 기반한 이용자간 관계의 형성, 지인 및 관심사 등에 기반한 맞춤형 서비스 제공 등 신규 서비스 요소의 발굴 및 기존 서비스 개선 등을 위하여 개인정보를 이용합니다.
법령 및 스타링크 이용약관을 위반하는 회원에 대한 이용 제한 조치, 부정 이용 행위를 포함하여 서비스의 원활한 운영에 지장을 주는 행위에 대한 방지 및 제재, 계정도용 및 부정거래 방지, 약관 개정 등의 고지사항 전달, 분쟁조정을 위한 기록 보존, 민원처리 등 이용자 보호 및 서비스 운영을 위하여 개인정보를 이용합니다.
유료 서비스 제공에 따르는 본인인증, 구매 및 요금 결제, 서비스의 이용을 위하여 개인정보를 이용합니다.
이벤트 정보 및 참여기회 제공, 광고성 정보 제공 등 마케팅 및 프로모션 목적으로 개인정보를 이용합니다.
서비스 이용기록과 접속 빈도 분석, 서비스 이용에 대한 통계, 서비스 분석 및 통계에 따른 맞춤 서비스 제공 및 광고 게재 등에 개인정보를 이용합니다.
보안, 프라이버시, 안전 측면에서 이용자가 안심하고 이용할 수 있는 서비스 이용환경 구축을 위해 개인정보를 이용합니다.
						
4. 개인정보의 제공 및 위탁
스타링크는 원칙적으로 이용자 동의 없이 개인정보를 외부에 제공하지 않습니다.
스타링크는 이용자의 사전 동의 없이 개인정보를 외부에 제공하지 않습니다.
단, 이용자가 외부 제휴사의 서비스를 이용하기 위하여 개인정보 제공에 직접 동의를 한 경우, 그리고 관련 법령에 의거해 스타링크에 개인정보 제출 의무가 발생한 경우, 이용자의 생명이나 안전에 급박한 위험이 확인되어 이를 해소하기 위한 경우에 한하여 개인정보를 제공하고 있습니다.
						
5. 개인정보의 파기
회사는 원칙적으로 이용자의 개인정보를 회원 탈퇴 시 지체없이 파기하고 있습니다.
단, 이용자에게 개인정보 보관기간에 대해 별도의 동의를 얻은 경우, 또는 법령에서 일정 기간 정보보관 의무를 부과하는 경우에는 해당 기간 동안 개인정보를 안전하게 보관합니다.
						
						
회원탈퇴, 서비스 종료, 이용자에게 동의받은 개인정보 보유기간의 도래와 같이 개인정보의 수집 및 이용목적이 달성된 개인정보는 재생이 불가능한 방법으로 파기하고 있습니다.
법령에서 보존의무를 부과한 정보에 대해서도 해당 기간 경과 후 지체없이 재생이 불가능한 방법으로 파기합니다."
            	</textarea>
            	</div>
            	<div class="custom-hr"></div>
            	<br>
            <div style="text-align: center;">
			    <button type="button" class="custom-btn btn-round btn-purple1" @click="pagePlus()" :disabled="!agree" style="width: 500px;">동의합니다.</button>
			</div>
				<br>
            </div>
            
            <!-- 회원정보입력 페이지 -->
			<div v-show="page==2">
                    <h2 class="font-purple1">회원정보입력</h2>
            <div class="custom-hr"></div>
            <div class="row mb-3 mx-2">
                    <input type="text" v-model="memberId" class="custom-input-rounded-container width: 100%;" 
                    	:class="{ 'is-valid': memberIdValid && !idDuplicated && !idDuplicated2, 'is-invalid': memberId !== '' && (!memberIdValid || idDuplicated || idDuplicated2)}" placeholder="아이디" 
                    	@blur="idDuplicatedCheck(memberId) &&  idDuplicatedCheck2(memberId)" name="memberId" id="memberId">
                    <div class="valid-feedback">{{memberIdMessage}}</div>
  					<div class="invalid-feedback">{{memberIdMessage}}</div>
            </div>

            <div class="row mb-3 mx-2">
                    <input type="password" v-model="memberPw" class="custom-input-rounded-container width: 100%;" 
                    	:class="{'is-valid' : memberPwValid, 'is-invalid' : memberPw !== '' && !memberPwValid}" placeholder="비밀번호" name="memberPw">
                    <div class="valid-feedback">{{memberPwMessage}}</div>
                    <div class="invalid-feedback">{{memberPwMessage}}</div>
            </div>

            <div class="row mb-3 mx-2">
                    <input type="password" v-model="memberPwRe" class="custom-input-rounded-container width: 100%;" 
                    	:class="{'is-valid':memberPwReValid, 'is-invalid':memberPwRe !== '' && (!memberPwReValid || memberPw.length==0)}" placeholder="비밀번호 확인" name="memberPwRe">
                    <div class="valid-feedback">{{memberPwReMessage}}</div>
                    <div class="invalid-feedback">{{memberPwReMessage}}</div>
            </div>

            <div class="row mb-3 mx-2">
                    <input type="text" v-model="memberNick" class="custom-input-rounded-container width: 100%;" placeholder="닉네임" 
                    	:class="{'is-valid':memberNickValid && !nickDuplicated, 'is-invalid':memberNick !== '' && (!memberNickValid || nickDuplicated)}" 
                    	@blur="nickDuplicatedCheck(memberNick)" name="memberNick">
                    <div class="valid-feedback">{{memberNickMessage}}</div>
                    <div class="invalid-feedback">{{memberNickMessage}}</div>
            </div>

            <div class="row mb-3 mx-2">
                    <input type="email" v-model="memberEmail" class="custom-input-rounded-container width: 100%;" placeholder="이메일" 
                    	:class="{'is-valid':memberEmailValid && !emailDuplicated, 'is-invalid':memberEmail !== '' && (!memberEmailValid || emailDuplicated)}" 
                    	@blur="emailDuplicatedCheck(memberEmail)" name="memberEmail">
                    <div class="valid-feedback">{{memberEmailMessage}}</div>
                    <div class="invalid-feedback">{{memberEmailMessage}}</div>
            </div>
            <br>
            
			
			 <div class="row mb-3 mx-2" >
                    <button type="button" class="custom-btn btn-round btn-purple1-secondary" @click="pageMinus()">이전단계</button>
            </div>
            <div class="row mb-3 mx-2" >
                    <button type="button" class="custom-btn btn-round btn-purple1" v-bind:disabled="!allValid" @click="pagePlus()">다음단계</button>
            </div>
            </div>
            
            <!-- 이메일 인증 페이지 -->
            <div v-show="page==3">
            		<h2 class="font-purple1">본인 인증</h2>
            		<h4 class="font-gray2">입력하신 이메일주소로 본인인증을 완료해주세요.</h4>
            	<div class="custom-hr"></div>
            	<div class="row mb-3 mx-1 ">
				    <input type="text" v-model="memberEmail" readonly class="custom-input-rounded-container" style="width: 73%; margin-left: 8px;" disabled >
				    <button type="button" class="custom-btn btn-round btn-purple1-secondary"  @click="sendEmail(memberEmail)" style="width: 23%; margin-left: 6px;" >전송</button>
				</div>

            	<div class="row mb-3 mx-2">
            		<input type="text" v-model.number="code" placeholder="인증번호입력" @blur="isKeyValid" class="custom-input-rounded-container width: 100%;" >
            	</div>
            	
            	<BR>
            	<div class="row mb-3 mx-2" >
            		<button type="button" class="custom-btn btn-round btn-purple1-secondary" @click = "pageMinus()">이전단계</button>
            	</div>
            	<div class="row mb-3 mx-2" >	
            		<button type="submit" :disabled="!keyValid" class="custom-btn btn-round btn-purple1">회원가입</button>
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
                    memberId:"",
                    memberPw:"",
                    memberPwRe:"",
                    memberNick:"",
                    memberEmail:"",
                    page:1,
                    agree:false,
                    idDuplicated:false,
                    idDuplicated2:false,
                    nickDuplicated:false,
                    emailDuplicated:false,
                    code:"",
                    key:"",
                    keyValid:false,
                    agree:false,
                };
            },
            methods:{
            	  async idDuplicatedCheck(memberId){

                      const resp = await axios.get("/member/idDuplicatedCheck",{
                          params :{
                           memberId : this.memberId
                          }
                      });
                      if(resp.data === "N"){
                          this.idDuplicated = true;
                      }else{
                          this.idDuplicated = false; 
                      }
                      // this.idDuplicated= resp.data ==="Y";
                  },
                  
                  async idDuplicatedCheck2(memberId) {
                	 const resp = await axios.get("/member/idDuplicatedCheck2",{
                		 params:{
                			 memberId : this.memberId
                		 }
                	 }); 
                	 if(resp.data === "N"){
                         this.idDuplicated2 = true;
                     }else{
                         this.idDuplicated2 = false; 
                     }
                  },

                  async nickDuplicatedCheck(memberNick) {

                    const resp = await axios.get("/member/nickDuplicatedCheck", {
                        params : {
                            memberNick : this.memberNick
                        }
                    });
                    if(resp.data === "N") {
                        this.nickDuplicated = true;
                    }
                    else {
                        this.nickDuplicated = false;
                    }
                  },

                  async emailDuplicatedCheck(memberEmail) {

                    const resp = await axios.get("/member/emailDuplicatedCheck", {
                        params : {
                            memberEmail : this.memberEmail
                        }
                    });

                    if(resp.data === "N") {
                        this.emailDuplicated = true;
                    }
                    else {
                        this.emailDuplicated = false;
                    }
                  },
                  
                  async sendEmail(memberEmail){
	                  	Toastify({
	                        text: "이메일 전송 완료",
	                        duration: 1000,
	                        newWindow: false,
	                        close: true,
	                        gravity: "bottom", // `top` or `bottom`
	                        position: "right", // `left`, `center` or `right`
	                        style: {
	                            background: "linear-gradient(to right, #84FAB0, #8FD3F4)",
	                        },
	                        // onClick: function(){} // Callback after click
	                    }).showToast();
                  	const response = await axios.get("/member/emailSend",{
                  		params : {
                  			memberEmail : this.memberEmail
                  		}
                  	});
                  	console.log("키:" + response.data);
                  	// 인증번호
                  	this.key = response.data;
                  	
                  },
                  isKeyValid(){
                	  if(this.key == this.code){
                		  this.keyValid=true;
                	  }else{
                		  this.keyValid=false;
                	  }
                  },
                  pagePlus(){
                	  this.page++;
                  },
                  pageMinus() {
                	 this.page--; 
                  },
				
                  submitForm() {
                      if (this.allValid() && this.keyValid) {
                          // 폼 제출 허용
                          return true;
                      } else {
                          // 폼 제출 막기
                          event.preventDefault();
                      }
                   },
            },
            computed:{
                memberIdValid(){
                    const regex = /^[a-z][a-z0-9]{8,20}$/;
                    return regex.test(this.memberId);
                },
                memberIdMessage(){
                    if(this.memberId.length == 0) {
                        return "";
                    }
                    if(this.memberIdValid && !this.idDuplicated && !this.idDuplicated2) {
                        return "사용 가능한 아이디입니다.";
                    }else if(this.idDuplicated && this.idDuplicated2) {
                        return "이미 사용중인 아이디입니다.";
                    }
                    else {
                        return "영소문자로 시작하여 숫자를 포함한 8~20자로 작성하세요.";
                    }
                },

              
                memberPwValid(){
                    const regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
                    return regex.test(this.memberPw);
                },
                memberPwMessage(){
                    if(this.memberPw.length == 0) {
                        return "";
                    }
                    else if(this.memberPwValid) {
                        return "올바른 비밀번호 형식입니다.";
                    }
                    else {
                        return "영문 대/소문자, 숫자, 특수문자를 반드시 포함하여 8~16자로 작성하세요.";
                    }
                },
                memberPwReValid(){
                	if(this.memberPwRe == '')
                	return false;
                    return this.memberPw == this.memberPwRe;
                },
                memberPwReMessage(){
                    if(this.memberPwRe.length == 0) {
                        return "";
                    }
                    else if(this.memberPw.length == 0) {
                        return "비밀번호를 먼저 입력하세요.";
                    }
                    else if(this.memberPwReValid) {
                        return "비밀번호가 일치합니다.";
                    }
                    else {
                        return "비밀번호가 일치하지 않습니다.";
                    }
                },
                memberNickValid(){
                    const regex = /^[가-힣0-9a-z!@#$.-_]{1,10}$/;
                    return regex.test(this.memberNick);
                },
                memberNickMessage(){
                    if(this.memberNick.length == 0) {
                        return "";
                    }
                    else if(this.memberNickValid && !this.nickDuplicated) {
                        return "사용 가능한 닉네임입니다.";
                    }
                    else if(this.nickDuplicated) {
                        return "이미 사용중인 닉네임입니다.";
                    }
                    else{
                        return "한글, 영문, 숫자, 특수문자 등을 사용하여 1~16자로 작성하세요.";
                    }
                },
                memberEmailValid(){
                    const regex = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
                    return regex.test(this.memberEmail);
                },
                memberEmailMessage(){
                    if(this.memberEmail.length == 0) {
                        return "";
                    }
                    else if(this.memberEmailValid && !this.emailDuplicated) {
                        return "사용 가능한 이메일입니다.";
                    }
                    else if(this.emailDuplicated) {
                        return "이미 사용중인 이메일입니다.";
                    }
                    else{
                        return "올바른 이메일 형식이 아닙니다.";
                    }
                },
                allValid(){
                    return this.memberIdValid
                                && this.memberPwValid
                                && this.memberPwReValid
                                && this.memberNickValid
                                && this.memberEmailValid
                                && !this.idDuplicated
                                && !this.nickDuplicated
                                && !this.emailDuplicated
                                && this.agree;
                },
                
             
            },
        }).mount("#app");
    </script>
