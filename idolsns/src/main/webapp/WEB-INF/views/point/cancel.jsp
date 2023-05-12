<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    
    <section>
	  <div id="app">
	    <div class="container-fluid d-flex justify-content-center">
	      <div class="container rounded p-3 col-6" style="background-color:white">
	        <p>{{ memberId }}님의 충전이 취소되었습니다.</p>
	        <p>취소 후 잔여 포인트: {{ point }}</p>
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
		      point: 0
		    }
		  },
		  mounted() {
		    // 세션에서 memberId와 point 정보를 가져옵니다.
		    this.memberId = sessionStorage.getItem("memberId");
		    this.point = sessionStorage.getItem("point");
		  }
		}).mount("#app");
	</script>