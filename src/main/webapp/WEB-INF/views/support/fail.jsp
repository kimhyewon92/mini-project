<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<c:import url="/WEB-INF/views/include/head_css.jsp"></c:import>
</head>
<body>
<c:import url="/WEB-INF/views/include/topbar.jsp"></c:import>

        <section class="py-5 bg-light">
		  <div class="container px-4 px-lg-5 mt-5">
		     <h2> 결제 실패 </h2>
			 <p id="code"></p>
			 <p id="message"></p>
		  </div>
		</section>
	<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
	<script>
	  const urlParams = new URLSearchParams(window.location.search);

	  const codeElement = document.getElementById("code");
	  const messageElement = document.getElementById("message");

	  codeElement.textContent = "에러코드: " + urlParams.get("code");
	  messageElement.textContent = "실패 사유: " + urlParams.get("message");
	</script>
</body>
</html>