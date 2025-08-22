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
		    <div class="text-center mb-5">
		      <h2 class="fw-bold">🐾 동물 일시후원</h2>
		      <p class="text-muted">마음을 담아 원하는 금액을 입력해 후원해주세요.</p>
		    </div>
		
		    <div class="row justify-content-center">
		      <div class="col-md-6">
		        <div class="card shadow-sm p-4">
		          <div class="mb-3">
		            <label for="donationAmount" class="form-label fw-bold">후원 금액 (₩)</label>
		            <input type="number" id="donationAmount" class="form-control" min="10000" step="1000" placeholder="10000 이상 입력">
		            <div class="form-text">최소 10,000원 이상 입력 가능합니다.</div>
		          </div>
		          <!-- 결제 UI -->
			      <div id="payment-method"></div>
			      <!-- 이용약관 UI -->
			      <div id="agreement"></div>
		          <button class="btn btn-success w-100" id="btn_support" onclick="requestDonationInput()">후원하기</button>
		        </div>
		      </div>
		    </div>
		  </div>
		</section>
	<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
	<script>
	  main();
	  async function main() {
		  const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
		  const tossPayments = TossPayments(clientKey);
		  const customerKey = "4N3o-RtxDqtAT4f6pIuav";
	      const widgets = tossPayments.widgets({
	        customerKey,
	      });
	      const btnSupport = document.getElementById("btn_support");
// 	      if (amount < 10000) {
// 		      alert("최소 10,000원 이상 후원 가능합니다.");
// 		      return;
// 		  }
	  await widgets.setAmount({
          currency: "KRW",
          value: 0,
        });
	  await Promise.all([
          // ------  결제 UI 렌더링 ------
          widgets.renderPaymentMethods({
            selector: "#payment-method",
            variantKey: "DEFAULT",
          }),
          // ------  이용약관 UI 렌더링 ------
          widgets.renderAgreement({ selector: "#agreement", variantKey: "AGREEMENT" }),
        ]);
	  document.getElementById("donationAmount").addEventListener("change", async function () {
		  const amount = Number(document.getElementById("donationAmount").value);
          await widgets.setAmount({
            currency: "KRW",
            value: amount,
          });
        });
	  
	  btnSupport.addEventListener("click", async function () {
		  const orderId = "ORDER-" + Date.now();
		  
          await widgets.requestPayment({
            orderId: orderId,
            orderName: "일시 후원",
            successUrl: window.location.origin + "/support/toss/success",
            failUrl: window.location.origin + "/support/toss/fail",
            customerEmail: "customer123@gmail.com",
            customerName: "김토스",
            customerMobilePhone: "01012341234",
          });
        });
	  
	  }
	  
	</script>
</body>
</html>