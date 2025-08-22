package com.goodee.mini.support;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SupportVO {

	private Long supportNo;
	private Long memNo;
	private Long amount;
	private String status;
	private String paymentMethod;
	private String orderId;
	private String paymentKey;
	private LocalDateTime createdAt;
	private LocalDateTime updatedAt;
	
}
