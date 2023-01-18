package com.test.mail;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//[참고] https://yermi.tistory.com/entry/Library-%EC%9E%90%EB%B0%94Java%EC%97%90%EC%84%9C-SMTP-%EB%A9%94%EC%9D%BC-%EB%B0%9C%EC%86%A1%ED%95%98%EA%B8%B0-%EB%A9%94%EC%9D%BC-%EB%B0%9C%EC%86%A1-%EB%9D%BC%EC%9D%B4%EB%B8%8C%EB%9F%AC%EB%A6%AC-Javax-Mail-API
//[참고] https://hunit.tistory.com/306
//[참고] https://woo-yaa.tistory.com/19

//[오류해결] 자바 smtp.gmail.com 보안 수준이 낮은 앱 허용
//https://heodolf.tistory.com/99
//https://velog.io/@letthere/developic-535-5.7.8-Username-and-Password-not-accepted-%EC%97%90%EB%9F%AC


//@WebServlet("/mail/sendmail.do")
public class sndmailServlet extends HttpServlet{

	private String code;
	private String msg;
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		wjddnrbs0987@gmail.com
//		jjang8910!

	 	String step = req.getParameter("step");
		
		if(step.equals("1")) //이메일 발송 
		{
			String email = req.getParameter("email");
			
			Properties props = new Properties();
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.port", "587");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
			
			Session session = Session.getInstance(props, new Authenticator() {
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					//관리자 메일 , 구글 2단계인증 비밀번호
					return new PasswordAuthentication("wjddnrbs0987@gmail.com", "fjjgakdscqhyiwja");
				}
			});
			
			
			String receiver = email; // 메일 받을 주소
			String title = "[WEB-TEST]본인확인 인증코드";
			
			//코드 발급(난수 6자리)
			code = (int)(Math.random()*1000000) + "";
			
			String content = code;
			Message message = new MimeMessage(session);
			try {
				message.setFrom(new InternetAddress("wjddnrbs0987@gmail.com", "관리자", "utf-8"));
				message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
				message.setSubject(title);
				message.setContent(content, "text/html; charset=utf-8");

				Transport.send(message);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(step.equals("2")) // 인증 확인
		{
			String recvcode = req.getParameter("code");
			System.out.println("받은 코드 : " + recvcode);
			System.out.println("저장 코드 : " + code);
			if(code.equals(recvcode)) {
				
				//결과를 msg로 전달하기 
				PrintWriter out = resp.getWriter();
				out.println("Code Confirm your id : aaa pw : 1234");
				
				
				//DB로 임시패스워드 만들어서 저장
				//DB로 임시패스워드 만들어서 이메일 전송
				
			}else
			{
				PrintWriter out = resp.getWriter();
				out.println("fail....");
			}
			 
			
			
		}

		
	}
	
	
 
}


//1-1 maven javax.mail
//https://search.maven.org/artifact/com.sun.mail/javax.mail/1.6.2/jar

//1-2 maven javax.mail-api
//https://mvnrepository.com/artifact/javax.mail/javax.mail-api/1.6.2

//1-3 maven activation 검색



