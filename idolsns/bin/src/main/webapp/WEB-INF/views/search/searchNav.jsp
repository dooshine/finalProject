<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



<ul class="custom-tab-header mx-0 d-flex">
    <li class="${requestScope['javax.servlet.forward.servlet_path'].startsWith('/search/post') ? 'custom-tab-list active' : 'custom-tab-list'}">
      <a href="/search/post/?q=${param.q}">
        <span class="mdi mdi-star-four-points-circle fw-bold">
          <span class="ms-2">
            게시물
          </span>
        </span>
      </a>
    </li>
    <li class="${requestScope['javax.servlet.forward.servlet_path'].startsWith('/search/artist') ? 'custom-tab-list active' : 'custom-tab-list'}">
      <a href="/search/artist/?q=${param.q}">
        <i class="fa-solid fa-star">
          <span class="ms-2">
            아이돌
          </span>
        </i>
      </a>
    </li>
    <li class="${requestScope['javax.servlet.forward.servlet_path'].startsWith('/search/member') ? 'custom-tab-list active' : 'custom-tab-list'}">
      <a href="/search/member/?q=${param.q}">
        <i class="fa-solid fa-user">
          <span class="ms-2">
            회원
          </span>
        </i>
      </a>
    </li>
</ul>