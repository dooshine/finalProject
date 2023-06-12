<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>



<!------- 카카오 지도 관련-------->
<!-- 카카오 api 키 등록 -->
<script
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=047888df39ba653ff171c5d03dc23d6a&libraries=services"></script>
<!-- 맵 관련 css -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/css/map.css">
<!------- 카카오 지도 관련-------->

<!-- tabler 아이콘 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">

<div id="app">
	키키
</div>
	
	
<script>
    const app = Vue.createApp({
      data() {
        return {
          isModalOpen: false
        }
      },
      methods: {
		fetchPosts(){
			
		},
		
		
      }
    });

    app.mount('#app');
</script>


<!-- 이미지 스와이핑 창 -->
<script src="${pageContext.request.contextPath}/static/js/swiping-image.js"></script>
<!-- 게시글 작성 ajax -->
<script src="${pageContext.request.contextPath}/static/js/async-post.js"></script>
<!-- 카카오 API구현 JS -->
<script src="${pageContext.request.contextPath}/static/js/post-map.js"></script>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>