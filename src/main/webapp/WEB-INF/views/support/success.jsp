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
			<h2>결제 성공</h2>
		    <p id="paymentKey"></p>
		    <p id="orderId"></p>
		    <p id="amount"></p>
		  </div>
		</section>
		
	<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
	<script>
		const urlParams = new URLSearchParams(window.location.search);
	    const paymentKey = urlParams.get("paymentKey");
	    const orderId = urlParams.get("orderId");
	    const amount = urlParams.get("amount");
	    
	    async function confirm() {
	        const requestData = {
	          paymentKey: paymentKey,
	          orderId: orderId,
	          amount: amount,
	        };

	        const response = await fetch("/support/confirm", {
	          method: "POST",
	          headers: {
	            "Content-Type": "application/json",
	          },
	          body: JSON.stringify(requestData),
	        });

	        const json = await response.json();

	        if (!response.ok) {
	          // 결제 실패 비즈니스 로직을 구현하세요.
	          console.log(json);
	          window.location.href = `/toss/fail?message=${json.message}&code=${json.code}`;
	        }

	        // 결제 성공 비즈니스 로직을 구현하세요.
	        console.log(json);
	        alert("결제가 완료되었습니다");
	        location.href="/";
	    }
	    
	    confirm();
	    
	    const paymentKeyElement = document.getElementById("paymentKey");
        const orderIdElement = document.getElementById("orderId");
        const amountElement = document.getElementById("amount");
        
        orderIdElement.textContent = "주문번호: " + orderId;
        amountElement.textContent = "결제 금액: " + amount;
        paymentKeyElement.textContent = "paymentKey: " + paymentKey;
	</script>
</body>
</html>