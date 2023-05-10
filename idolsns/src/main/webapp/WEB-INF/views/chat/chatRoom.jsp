<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	.message {
		border-bottom: 1px solid gray;
		padding: 10px;
	}
</style>

<h1>채팅 테스트</h1>
<p>${sessionScope.memberId}</p>

<hr>

<!-- 메세지 입력창 + 전송버튼 -->
<input type="text" class="user-input">
<button class="btn-send">전송</button>

<hr>

<!-- 메세지가 표시될 공간 -->
<div class="message-wrapper">
	
</div>

<!--
	jQuery로 웹소켓 처리 구현
	- javascript에 WebSocket API 있음
		- 웹소켓 연결주소는 별도의 라이브러리가 없는 경우 ws 또는 wss로 시작됨
		- 연결: window.socket = new WebSocket(접속주소)
		- 종료: window.socket.close();
-->
<!-- 
	SockJS
	- 주소를 http로 써도 됨(알아서 ws로 변환)
	- WebSocket을 지원하지 않는 브라우저는 풀링방식으로 자동 변환
	- 주기적으로 생존 여부 체크(heartbeat)
-->
<script type="text/template" id="message-template">
	<div class="message">
		<h3 class="memberId">보낸사람</h3>
		<p class="content">내용</p>
		<span class="time">HH:mm</span>
	</div>
</script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<!-- sockjs cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<!-- moment cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<!-- moment cdn 한국어 팩 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/locale/ko.min.js"></script>
<script>
	$(function(){
		// 시작하자마자 채팅방 메세지 불러오기
		// 메세지 불러오는 함수 호출
		loadMessage();
		
		// 메세지 불러오는 함수
		function loadMessage() {
			const chatRoomNo = new URLSearchParams(location.search).get("chatRoomNo");
			$.ajax({
				url:"${pageContext.request.contextPath}/chat/message/" + chatRoomNo,
				method:"get",
				success:function(resp) {
					// resp에 있는 목록의 모든 메세지를 화면에 추가
//					console.log(resp);
					// 메세지 리스트 불러오는 함수 호출
					displyMessageList(resp);
					// 웹소켓 연결하는 함수 호출
					connectWebSocket();
				},
			})
		}
		
		// 메세지 리스트 불러오는 함수
		function displyMessageList(resp) {
			for(let i=0; i<resp.length; i++) {
//				console.log(e.data);
				// 수신한 데이터(e.data)가 JSON 문자열 형태이므로 해석 후 처리
				const data = JSON.parse(resp[i].messageBody);
				// fromNow: n초 전(갱신은 따로 처리해줘야 함)
//				const time = moment(data.time).fromNow();
				const time = moment(data.time).format("HH:mm");
//				$("<p>").text(data.content + " / " + time).appendTo(".message-wrapper");
				
				// 템플릿 불러오기
				const template = $("#message-template").html();
				// 템플릿을 html로 해석
				const html = $.parseHTML(template);
				// html에 정보 담기
				$(html).find(".memberId").text(data.memberId);
				$(html).find(".content").text(data.content);
				$(html).find(".time").text(time);
				
				switch(data.memberLevel) {
					case "우수회원":
						$(html).find(".memberId").css("color", "blue");
						break;
					case "관리자":
						$(html).find(".memberId").css("color", "red");
						break;
				}
				
				// 템플릿 화면에 찍기
				$(".message-wrapper").append(html);
			}
		}
		
		// 웹소켓 연결하는 함수
		function connectWebSocket() {
			changeToDisconnect();
			
			// sockjs로 달라지는 부분(주소, 연결생성)
			// 주소 알아서 변환
			// 이렇게 줄여도 됨
//			const url = "/ws/sockjs";
			const url = "${pageContext.request.contextPath}/ws/server";
			window.socket = new SockJS(url);
			
			// 실제로 연결이 됐는지, 끊어졌는지 알 방법이 없음
			// - 웹소켓에서 이벤트 형태로 제공(callback) -> 함수에 괄호 쓰면 안됨
			// - 지금 현재 서버의 대기실에 위치하고 있으므로 방 번호를 알려줘서 이동 처리
//			window.socket.onopen = changeToConnect; -> 괄호 여부 헷갈리니까 아래처럼 써도 됨
			window.socket.onopen = function() {
				// 파라미터 중에서 room이라는 항목을 읽어서 첨부하여 전송
				// const data = { type:2, room:"${param.room}" }; -> jsp에만 할 수 있음
				const chatRoomNo = new URLSearchParams(location.search).get("chatRoomNo");
				const data = { type:2, chatRoomNo : chatRoomNo };	// js파일에서도 할 수 있음
//				console.log(chatRoomNo);
				window.socket.send(JSON.stringify(data));
				changeToConnect();
				$("<p>").text("서버에 연결되었습니다.").appendTo(".message-wrapper");
			};
			window.socket.onclose = function() {
				changeToDisconnect();
				$("<p>").text("서버와의 연결이 종료되었습니다.").appendTo(".message-wrapper");
			};
			window.socket.onerror = function() {
				changeToDisconnect();
				$("<p>").text("연결 중 오류가 발생했습니다.").appendTo(".message-wrapper");
			};
			// 메세지 수신 시 수신된 메세지로 태그를 만들어서 추가
			window.socket.onmessage = function(e) {
//				console.log(e.data);
				// 수신한 데이터(e.data)가 JSON 문자열 형태이므로 해석 후 처리
				const data = JSON.parse(e.data);
				// fromNow: n초 전(갱신은 따로 처리해줘야 함)
//				const time = moment(data.time).fromNow();
				const time = moment(data.time).format("HH:mm");
//				$("<p>").text(data.content + " / " + time).appendTo(".message-wrapper");
				
				// 템플릿 불러오기
				const template = $("#message-template").html();
				// 템플릿을 html로 해석
				const html = $.parseHTML(template);
				// html에 정보 담기
				$(html).find(".memberId").text(data.memberID);
				$(html).find(".content").text(data.content);
				$(html).find(".time").text(time);
				
				switch(data.memberLevel) {
					case "우수회원":
						$(html).find(".memberId").css("color", "blue");
						break;
					case "관리자":
						$(html).find(".memberId").css("color", "red");
						break;
				}
				
				// 템플릿 화면에 찍기
				$(".message-wrapper").append(html);
			};
			
			// 페이지 나가면 자동 연결 종료이므로 따로 작업 x
			
			// 전송 버튼을 누르면 서버에 메세지를 전송하도록 구현
			$(".btn-send").click(function() {
				const text = $(".user-input").val();
				if(text.lengh == 0) return;
				
//				window.socket.send(text); -> 일반 텍스트
				const data = { type : 1, content : text };
				
				// 자바스크립트에서 JSON을 처리하는 병령
				// JSON.stringify(객체) -> 객체를 JSON 문자열로 반환
				// JSON.parse(JSON 문자열) -> JSON 문자열을 객체로 변환
				window.socket.send(JSON.stringify(data));
				
				// 입력창 초기화
				$(".user-input").val("");
			});
			
			// 연결 상태일 때의 화면을 만드는 함수
			function changeToConnect() {
				$(".user-input").prop("disabled", false);
				$(".btn-send").prop("disabled", false);
			}
			
			// 종료 상태일 때의 화면을 만드는 함수
			function changeToDisconnect() {
				$(".user-input").prop("disabled", true);
				$(".btn-send").prop("disabled", true);
			}
		}
		
	});
</script>