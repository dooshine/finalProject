<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 

    <title>ㅇㅇㅇ</title>

	
    <script>
    	const contextPath = "${pageContext.request.contextPath}";
    </script>

		<template>
		  <div class="funding-list">
		    <div class="funding-item" v-for="funding in fundings" :key="funding.id">
		      <img :src="funding.imageUrl" alt="Funding Image">
		      <h3 class="title">{{ funding.title }}</h3>
		      <p class="description">{{ funding.description }}</p>
		      <div class="progress-bar">
		        <div class="progress" :style="{ width: funding.progress + '%' }"></div>
		      </div>
		      <div class="info">
		        <div class="col">
		          <span class="value">{{ funding.amount }}원</span>
		          <span class="label">목표금액</span>
		        </div>
		        <div class="col">
		          <span class="value">{{ funding.daysLeft }}일</span>
		          <span class="label">남은 일수</span>
		        </div>
		        <div class="col">
		          <span class="value">{{ funding.supporters }}명</span>
		          <span class="label">서포터</span>
		        </div>
		      </div>
		    </div>
		  </div>
		</template>

		<script>
			new Vue({
				  el: '#app',
				  data: {
			      fundings: [
			        {
			          id: 1,
			          title: 'Vue.js 프로젝트 템플릿',
			          description: 'Vue.js를 사용하여 프로젝트를 시작하는 데 필요한 템플릿을 제작합니다.',
			          imageUrl: 'https://dummyimage.com/400x300/000/fff.png&text=Funding+1',
			          amount: 1000000,
			          progress: 75,
			          daysLeft: 10,
			          supporters: 20,
			        },
			        {
			          id: 2,
			          title: 'Vue.js 강의 만들기',
			          description: 'Vue.js를 사용하는 웹 개발자들을 위한 강의를 만듭니다.',
			          imageUrl: 'https://dummyimage.com/400x300/000/fff.png&text=Funding+2',
			          amount: 2000000,
			          progress: 50,
			          daysLeft: 20,
			          supporters: 30,
			        },
			        {
			          id: 3,
			          title: 'Vue.js 웹앱 제작',
			          description: 'Vue.js를 사용하여 웹앱을 제작합니다.',
			          imageUrl: 'https://dummyimage.com/400x300/000/fff.png&text=Funding+3',
			          amount: 5000000,
			          progress: 30,
			          daysLeft: 30,
			          supporters: 40,
			        },
			      ],
			    };
			  },
			};
		</script>
				
		<style scoped>
			.funding-list {
			  display: flex;
			  flex-wrap: wrap;
			  gap: 20px;
			}
			
			.funding-item {
			  width: calc(33.33% - 20px);
			  box-sizing: border-box;
			  padding: 20px;
			  border: 1px solid #ccc;
			  border-radius: 5px;
			}
			
			.funding-item img {
			  width: 100%;
			  border-radius: 5px;
			  
			  }
			
			.funding-item .title {
			margin: 10px 0;
			font-size: 1.2em;
			font-weight: bold;
			}
			
			.funding-item .description {
			margin: 10px 0;
			font-size: 0.9em;
			color: #666;
			}
			
			.progress-bar {
			height: 10px;
			background-color: #eee;
			border-radius: 5px;
			overflow: hidden;
			margin: 10px 0;
			}
			
			.progress {
			height: 100%;
			background-color: #2ecc71;
			}
			
			.info {
			display: flex;
			justify-content: space-between;
			}
			
			.info .col {
			text-align: center;
			color: #888;
			}
			
			.info .col .value {
			font-size: 1.2em;
			font-weight: bold;
			}
			
			.info .col .label {
			font-size: 0.9em;
			}
		</style>
