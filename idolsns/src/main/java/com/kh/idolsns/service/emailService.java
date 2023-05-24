package com.kh.idolsns.service;

public interface emailService {
	
	//이메일 인증번호 발급
	String createKey() throws Exception;
	String sendEmail(String recipientEmail,String key) throws Exception;
	
	//임시비밀번호 발급
	String CreatePassword();
	String sendEmailPassword(String Email, String newPassword) throws Exception;
}
