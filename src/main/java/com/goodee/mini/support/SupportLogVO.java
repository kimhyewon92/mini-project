package com.goodee.mini.support;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class SupportLogVO {

	private Long logNo;
	private Long supportNo;
	private String logMessage;
	private LocalDateTime logTime;
	
}
