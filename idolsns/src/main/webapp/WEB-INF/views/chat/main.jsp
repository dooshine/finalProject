<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1>채팅 테스트</h1>

<p>아이디: ${sessionScope.memberId}</p>

<h3>채팅방 목록</h3>
<c:forEach var="chatRoom" items="${chatRoomList}">
	<p>
		<a href="chatRoomNo?chatRoomNo=${chatRoom.chatRoomNo}">${chatRoom.chatRoomNo}</a>
	</p>
</c:forEach>

<form action="chatRoom">
	<button type="submit">입장</button>
</form>
    