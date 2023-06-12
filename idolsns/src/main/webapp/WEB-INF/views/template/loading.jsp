<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- favicon -->
	<link rel="icon" href="/static/image/favicon.ico">
	<title>스타링크</title>

	<style>
		.loading-screen {
			height: 100vh;
			width: 100vw;
			position: fixed;
			bottom: 0;
			left: 0;
			background-color: #f5f5f5;
			z-index: 99999999;
		}
		.loading {
	    	position: fixed;
			top: 50%;
			left: 50%;
			transform: translate(-50%, -50%);         
	    }
	    .loading-footer {
	    	position: fixed;
	      	bottom: 15px;
	      	left: 50%;
	      	transform: translate(-50%, 0%);
	      	font-size: 0.8em;
	      	color: #7f7f7f;
	    }
	</style>
</head>
	
<div class="loading-screen">
	<div>
        <img class="loading" src="${pageContext.request.contextPath}/static/image/loading.png"  width="100px;">
    </div>
    <div class="loading-footer">STARLINK © 2023</div>
</div>
