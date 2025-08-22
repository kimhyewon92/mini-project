<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<div class="container px-4 px-lg-5">
		<a class="navbar-brand" href="/"><img src="/img/logo.png" alt="로고" style="height : 60px;"> </a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"	data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
				<li class="nav-item"><a class="nav-link" href="/pet/list">입양</a></li>
				<li class="nav-item"><a class="nav-link" href="/support/info">서포트</a></li>
				<li class="nav-item"><a class="nav-link" href="/donation/info">후원</a></li>
				<li class="nav-item"><a class="nav-link" href="/notice/list">공지사항</a></li>
				<li class="nav-item"><a class="nav-link" href="/question/list">질의응답</a></li>
			</ul>
			<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
				<c:choose>
					<c:when test="${not empty member}">
						<!-- 세션에 member가 있으면 로그아웃 버튼 보여주기 -->
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">${member.memId}&nbsp;</a>
							<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
								<li><a href="/member/logout" class="dropdown-item">로그아웃</a></li>
								<li><hr class="dropdown-divider" /></li>
								<li><a class="dropdown-item" href="/member/mypage">나의 정보</a></li>
								<li><a class="dropdown-item" href="#!">찜</a></li>
								<li><a class="dropdown-item" href="#!">입양신청</a></li>
								<li><a class="dropdown-item" href="/donation/detail">후원</a></li>
							</ul>
						</li>
					</c:when>
					<c:otherwise>
						<!-- 세션에 member가 없으면 로그인, 회원가입 버튼 보여주기 -->
						<li>
							<a href="/member/login" class="btn btn-outline-dark" type="button">로그인</a>
							<a href="/member/join" class="btn btn-outline-dark ml-2" type="button">회원가입</a>
						</li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</div>
</nav>