package com.kh.idolsns.service;

public interface emailService {
	String createKey() throws Exception;
	String sendEmail(String recipientEmail,String key) throws Exception;
}
