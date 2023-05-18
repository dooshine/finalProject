<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="app">
	<h1>채팅 테스트 메인</h1>
	
	<p>아이디: {{ memberId }}</p>
	
	<h3>채팅방 목록</h3>
	<c:forEach var="chatRoom" items="${chatRoomList}">
		<p>
			<a href="chatRoomNo?chatRoomNo=${chatRoom.chatRoomNo}">${chatRoom.chatRoomNo}</a>
		</p>
	</c:forEach>
</div>

<!-- Vue cdn -->
<script src="https://unpkg.com/vue@3.2.36"></script>
<!-- sockjs cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<!-- moment cdn -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<!-- moment cdn 한국어 팩 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/locale/ko.min.js"></script>
<!-- axios cdn -->
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<!-- lodash cdn -->
<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.21/lodash.min.js"></script>
<script>
	Vue.createApp({
		data() {
			return {
				memberId: "${sessionScope.memberId}",
				chatRoomList: [],
				memberList: [],
			};
		},
		methods: {
			async loadRoomList() {
				
			},
			async loadMemberList() {
				
			}
		},
		computed: {

		},
		created() {
			
		},
		mounted() {

		}
	}).mount("#app");
</script>
    