<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<script type="text/javascript">
  $(function () {
    $("[name=boardContent]").summernote({
      placeholder: "내용 작성",
      tabsize: 4, // tab키를 누르면 띄어쓰기 몇 번 할지
      height: 250, // 최초 표시될 높이(px)
      toolbar: [
        // 메뉴 설정
        ["style", ["style"]],
        ["font", ["bold", "underline", "clear"]],
        ["color", ["color"]],
        ["para", ["ul", "ol", "paragraph"]],
        ["table", ["table"]],
        ["insert", ["link", "picture"]],
        // ["view", ["fullscreen", "codeview", "help"]],
      ],
      callbacks: {
        onImageUpload: function (files) {
            if(files.length != 1) return;
            // console.log("비동기 파일 업로드 시작")

            // [1] FormData [2] processData [3] contentType
            const fd = new FormData();
            fd.append("attach", files[0]);

            $.ajax({
              url:"/rest/attachment/upload",
              method: "post",
              data: fd,
              processData: false,
              contentType: false,
              success: function(response){
                // console.log(response);

                // 서버로 전송할 이미지 번호 정보 생성
                const input = $("<input>").attr("type", "hidden").attr("name", "attachmentNo").val(response.attachmentNo);
                $("form").prepend(input);
                
                // 에디터에 추가할 이미지 생성
                const imgNode = $("<img>").attr("src", "/rest/attachment/download/"+response.attachmentNo).get(0);
                // const imgNode = $("<img>").attr("src", "/rest/attachment/download?attachmentNo="+response.attachmentNo);
                $("[name=boardContent]").summernote('insertNode', imgNode);
              },
              error: function(){

              }
            })
        },
      },
    });
  });
</script>

<c:choose>
  <c:when test="${parentBoardNo==null}">
    <h1>새글 작성</h1>
  </c:when>
  <c:otherwise>
    <h1>답글 작성</h1>
  </c:otherwise>
</c:choose>

<form action="write" method="post">
  <%-- 이미지를 첨부하면 첨부한 이미지의 번호를 hidden으로 추가 --%>
  <c:if test="${parentBoardNo!=null}">
        <input type="hidden" name="parentBoardNo" value="${parentBoardNo}">
  </c:if>
  <label for="boardTitle">제목: </label>
  <c:choose>
    <c:when test="${parentBoardNo==null}">
        <input id="boardTitle" type="text" name="boardTitle" required>
    </c:when>
    <c:otherwise>
        <input id="boardTitle" type="text" name="boardTitle" value="RE: " required>
    </c:otherwise>
  </c:choose>
  <br /><br />

  <label for="boardContent">내용: </label>
  <!-- <textarea id="boardContent" rows="10" cols="60" name="boardContent" required></textarea> -->
  <textarea id="boardContent" rows="10" cols="60" name="boardContent" required></textarea>
  <br /><br />

  <label for="boardHead">말머리: </label>
  <select name="boardHead">
    <!-- 없음을 선택하면 값이 비어서 전송되므로 DB에 null로 들어감 -->
    <option value="">없음</option>
    <c:if test="${userLevel == '관리자'}">
      <option>공지</option>
    </c:if>
    <option>유머</option>
    <option>정보</option>
  </select>
  <br /><br />
  <button>작성</button>
  <br /><br />
  <a href="${pageContext.request.contextPath}/list">목록</a>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
