<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    
    <section>
	  <div id="app">
	    <div class="container-fluid d-flex justify-content-center">
	      <div class="container rounded p-3 col-6" style="background-color:white">
	        <p>{{ memberId }}님의 충전이 취소되었습니다.</p>
	        <p>취소 후 잔여 포인트: {{ amount }}</p>
	      </div>
	    </div>
	  </div>
	</section>
	
		
	<script>
		Vue.createApp({
		  // 데이터 설정 영역
		  data() {
		    return {
		      memberId: '',
		      amount: ''
		    }
		  },
		  methods: {
	            charge(event) {
	                if (!this.selectedAmount) {
	                	event.preventDefault();
	                    alert("충전할 금액을 선택해주세요.");
	                    return;
	                }
	                var chargeForm = document.getElementById("chargeForm");
	               
	                chargeForm.submit();
	                
	            },
			
	           	 async loadMemberPoint() {
	                     const url = "http://localhost:8080/rest/member/"+memberId;
	                     const data = {
	                         memberId: this.memberId // 로그인된 멤버 아이디 사용
	                     };
	                     const resp = await axios.get(url);

	                     this.amount = resp.data.memberPoint;
	            	// MemberRestController(rest/member)에 getMapping method 추가 후
	        		// Axios로 method 호출(await 사용, 전달 data-> 멤버아이디), 로 멤버DTO 정보 불러와서
	        		// 멤버 DTO의 point를 this.amount 대입
	        	}
	            
	        },
	        created(){
	        	this.loadMemberPoint();
	        }
	    
		}).mount("#app");
	</script>