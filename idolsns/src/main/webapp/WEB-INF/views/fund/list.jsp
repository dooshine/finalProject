<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> 

    <title>ㅇㅇㅇ</title>

	<script src="https://cdn.jsdelivr.net/npm/vue"></script>
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
    <script>
    	const contextPath = "${pageContext.request.contextPath}";
    </script>
    

    
    
	    <style>
	.funding-list {
	  display: flex;
	  flex-wrap: wrap;
	}
	
	.funding-preview {
	  width: 20%;
	  padding: 20px;
	  box-sizing: border-box;
	  text-align: center;
	}
	
	.funding-thumbnail {
	  width: 100%;
	  height: 200px;
	  object-fit: cover;
	  margin-bottom: 10px;
	}
	
	.funding-title {
	  font-size: 1.2rem;
	  margin-bottom: 10px;
	}
	
	.funding-description {
	  margin-bottom: 10px;
	}
	
	.funding-info {
	  display: flex;
	  justify-content: space-between;
	}
	</style>
			
			
	<script>
	new Vue({
	  el: '#fund',
	  data() {
	    return {
	      fundings: [
	        { 
	          title: "펀딩 제목",
	          description: "펀딩 설명",
	          imageUrl: "이미지 URL",
	          amount: 100000,
	          progress: 50
	        },
	        { 
	          title: "펀딩 제목",
	          description: "펀딩 설명",
	          imageUrl: "이미지 URL",
	          amount: 200000,
	          progress: 80
	        },
	        // 추가적인 펀딩 데이터
	      ]
	    };
	  },
	  
	  created() {
		    // 더미 데이터 추가
		    for (let i = 0; i < 25; i++) {
		      this.fundings.push({
		        title: `더미 펀딩 ${i+1}`,
		        description: "더미 설명",
		        imageUrl: "https://picsum.photos/400",
		        amount: Math.floor(Math.random() * 1000000) + 100000,
		        progress: Math.floor(Math.random() * 100)
		      });
		    }
		  }
		};

	</script>
		

			<section id="fund">
			  <div class="container-fluid">
			    <h3>펀딩 리스트</h3>
			    <div class="funding-list">
			      <div v-for="(funding, index) in fundings" :key="index" class="funding-preview" v-if="index % 5 === 0">
			        <img :src="funding.imageUrl" alt="funding thumbnail" class="funding-thumbnail">
			        <h3 class="funding-title">{{ funding.title }}</h3>
			        <p class="funding-description">{{ funding.description }}</p>
			        <div class="funding-info">
			          <p class="funding-amount">{{ funding.amount }} 원</p>
			          <p class="funding-progress">{{ funding.progress }}% 달성</p>
			        </div>
			      </div>
			    </div>
			  </div>
			</section>

      
      	
  