package com.goodee.mini.support;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.goodee.mini.member.MemberVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/support/*")
@RequiredArgsConstructor
public class SupportController {
	
	@Value("${toss.secret.key}")
	private String gck;
	
	@Autowired
	private SupportService supportService;
	
	@GetMapping("info")
	public String info() throws Exception {
		
		return "support/info";
	}
	
    //Toss 결제 성공 콜백
	@GetMapping("/toss/success")
    public String success(@RequestParam String paymentKey, @RequestParam String orderId, @RequestParam Long amount, Model model, HttpSession session) throws Exception {
		MemberVO memberVO = (MemberVO)session.getAttribute("member");
		
		SupportVO supportVO = new SupportVO();
		supportVO.setPaymentKey(paymentKey);
		supportVO.setOrderId(orderId);
		supportVO.setAmount(amount);
		supportVO.setMemNo(memberVO.getMemNo());
		supportVO.setStatus("PENDING");
		supportService.savePayRequest(supportVO);
		
		return "support/success";
    }
	
	@PostMapping("confirm")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> confirm(@RequestBody Map<String, Object> requestData) throws Exception {
	    String paymentKey = (String) requestData.get("paymentKey");
	    String orderId = (String) requestData.get("orderId");
	    Long amount = Long.valueOf(requestData.get("amount").toString());

	    String secretKey = gck; 
	    String url = "https://api.tosspayments.com/v1/payments/confirm";

	    // 1. Base64 인코딩
	    String encodedAuth = Base64.getEncoder()
	        .encodeToString((secretKey + ":").getBytes(StandardCharsets.UTF_8));

	    HttpHeaders headers = new HttpHeaders();
	    headers.set("Authorization", "Basic " + encodedAuth);
	    headers.setContentType(MediaType.APPLICATION_JSON);

	    // 2. 바디
	    Map<String, Object> body = new HashMap<>();
	    body.put("paymentKey", paymentKey);
	    body.put("orderId", orderId);
	    body.put("amount", amount);

	    HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);

	    // 3. 요청 및 인코딩 설정
	    RestTemplate restTemplate = new RestTemplate();
	    restTemplate.getMessageConverters()
	        .removeIf(converter -> converter instanceof StringHttpMessageConverter);
	    restTemplate.getMessageConverters()
	        .add(0, new StringHttpMessageConverter(StandardCharsets.UTF_8));
	    
	    ResponseEntity<String> response = restTemplate.postForEntity(url, entity, String.class);

	    // 4. 응답 파싱
	    ObjectMapper objectMapper = new ObjectMapper();
	    JsonNode jsonNode = objectMapper.readTree(response.getBody());

	    String status = jsonNode.get("status").asText();
	    String method = jsonNode.get("method").asText();
	    System.out.println("===========method ============ : " + method);
	    
	    // 5. DB 업데이트
	    SupportVO supportVO = new SupportVO();
	    supportVO.setOrderId(orderId);
	    supportVO.setPaymentKey(paymentKey);
	    supportVO.setStatus(status);
	    supportVO.setPaymentMethod(method);
	    supportService.updatePayRequest(supportVO);

	    // 6. 결과 리턴
	    Map<String, Object> result = new HashMap<>();
	    result.put("status", status);
	    result.put("paymentKey", paymentKey);
	    result.put("orderId", orderId);
	    result.put("amount", amount);
	    result.put("method", method);

	    return ResponseEntity.ok(result);
	}
	 	
	//Toss 결제 실패 콜백
	@GetMapping("/toss/fail")
	public String fail(@RequestParam String code, @RequestParam String message, @RequestParam String orderId, Model model) {
		model.addAttribute("msg", "후원 결제가 실패했습니다. 사유: " + message);
		model.addAttribute("url", "/support/info");
		
		return "commons/result";
	}
}
