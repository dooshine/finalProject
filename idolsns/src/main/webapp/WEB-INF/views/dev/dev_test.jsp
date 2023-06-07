<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- c태그 라이브러리 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container custom-container" id="app">
    <h1>테스트</h1>
    <button @click="restTest">레스트 테스트</button>
</div>

<script>
  Vue.createApp({
    data() {
      return {
        text: "안녕하세요",
      };
    },
    computed: {

    },
    methods: {
        async restTest(){
            const url = "http://localhost:8080/rest/follow/test";

            const resp = await axios.get(url);

            console.log(resp);
        }
    },
    watch: {

    },
    created(){
          
    },
  }).mount('#app')
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>