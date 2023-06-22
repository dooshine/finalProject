package com.kh.idolsns.service;

import java.security.SecureRandom;
import java.util.Random;
import java.util.Scanner;

import javax.mail.internet.MimeMessage;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class emailServiceImpl implements emailService{
	
	@Autowired
	private JavaMailSender sender;

	
	//이메일 인증번호 발급
	@Override
	public String createKey() throws Exception {
		String key = "";
		Random rd = new Random();
		
		for (int i = 0; i < 6; i++) {
			key += rd.nextInt(10);
		}
		return key;
	}

	@Override
	public String sendEmail(String recipientEmail,String key) throws Exception {
		
		 //key = createKey();
		
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = 
				new MimeMessageHelper(message, false, "UTF-8");
		
		helper.setTo(recipientEmail);
		helper.setSubject("STARLINK 회원가입 인증번호입니다.");
		
				ClassPathResource resource = 
				new ClassPathResource("templates/email.html");
				Scanner sc = new Scanner(resource.getFile());
				StringBuffer buffer = new StringBuffer();
				
				while(sc.hasNextLine()) {//읽을 줄이 남았다면
					buffer.append(sc.nextLine());//한 줄을 읽어서 buffer에 추가해라
				}
				String text = buffer.toString();
				Document doc = Jsoup.parse(text);
				
				Element target = doc.getElementById("custom-email-target");
				target.text(key);
				
				helper.setText(doc.toString(), true);//불러온 내용을 첨부
				
				sender.send(message);//전송
				
				return key;
	}
	
	
	//임시비밀번호 발급
	@Override
	public String CreatePassword() {
		String upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		String lowerCase =  "abcdefghijklmnopqrstuvwxyz";
		String numbers = "0123456789";
		String specialChars = "!@#$";
		String allChars = upperCase + lowerCase + numbers + specialChars;
		
		StringBuilder randomPassword = new StringBuilder();
		
		randomPassword.append(upperCase.charAt(getRandomIndex(upperCase)));
		randomPassword.append(upperCase.charAt(getRandomIndex(upperCase)));
	    randomPassword.append(numbers.charAt(getRandomIndex(numbers)));
	    randomPassword.append(specialChars.charAt(getRandomIndex(specialChars)));
		
	    SecureRandom random = new SecureRandom();
	    
		while(randomPassword.length() < 8) {
			int index = random.nextInt(allChars.length());
			randomPassword.append(allChars.charAt(index));
		}
		
		String newPassword = randomPassword.toString();
		return newPassword;
	}

	private int getRandomIndex(String str) {
		SecureRandom random = new SecureRandom();
		int index = random.nextInt(str.length());
		return 0;
	}

	@Override
	public String sendEmailPassword(String Email, String newPassword) throws Exception {
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = 
				new MimeMessageHelper(message, false, "UTF-8");
		
		helper.setTo(Email);
		helper.setSubject("STARLINK 요청하신 임시비밀번호입니다.");
		
		ClassPathResource resource = 
				new ClassPathResource("templates/emailPW.html");
		Scanner sc = new Scanner(resource.getFile());
		StringBuffer buffer = new StringBuffer();
		
		while(sc.hasNextLine()) {
			buffer.append(sc.nextLine());
		}
		String text = buffer.toString();
		
		Document doc = Jsoup.parse(text);
		
		Element target = doc.getElementById("custom-email-target");
		target.text(newPassword);
		
		Element link = doc.getElementById("custom-email-link");
		link.text("STARLINK LOGIN");
		link.attr("href", "${pageContext.request.contextPath}/member/login");
		
		helper.setText(doc.toString(), true);
		
		sender.send(message);
		
		return newPassword;
	}

}



