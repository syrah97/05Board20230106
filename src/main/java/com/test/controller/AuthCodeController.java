//package com.test.controller;
//
//import java.io.PrintWriter;
//import java.util.Map;
//import java.util.Properties;
//
//import javax.mail.Authenticator;
//import javax.mail.Message;
//import javax.mail.PasswordAuthentication;
//import javax.mail.Session;
//import javax.mail.Transport;
//import javax.mail.internet.InternetAddress;
//import javax.mail.internet.MimeMessage;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import com.test.dto.Criteria;
//import com.test.service.AuthService;
//
//public class AuthCodeController implements SubController {
//
//	private static String msg;
//	private AuthService service = AuthService.getInstance();
//	
//	private String code;
// 
//	
//	@Override
//	public void execute(HttpServletRequest req, HttpServletResponse resp) {
//		//System.out.println("[MJC] Start-");
//				try 
//				{
//					
//					//1 파라미터 받기
//					Map<String,String[]> params=req.getParameterMap();
//
//					
//					//2 Validation
//					boolean isvalid=isValid(params);
//					if(!isvalid) {
//						//유효성 체크 오류 발생시 전달할 메시지 + 이동될 경로			
//						req.setAttribute("msg", msg);
//						req.getRequestDispatcher("/WEB-INF/view/auth/login.jsp").forward(req, resp);
//						return ;
//					}
//					
//					//3 Service
//					 
//
//
//				
//					
//				} catch (Exception e) {
//					e.printStackTrace();
//				}	
//	}
//
//	private boolean isValid(Map<String, String[]> params) {
//		return true;
//	}
//	
//	private void AuthStep1(HttpServletRequest req,HttpServletResponse resp)
//	{
//	 	String step = req.getParameter("step");
//		
//		if(step.equals("1")) //이메일 발송 
//		{
//			String email = req.getParameter("email");
//			
//			Properties props = new Properties();
//			props.put("mail.smtp.host", "smtp.gmail.com");
//			props.put("mail.smtp.port", "587");
//			props.put("mail.smtp.auth", "true");
//			props.put("mail.smtp.starttls.enable", "true");
//			props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
//			
//			Session session = Session.getInstance(props, new Authenticator() {
//				@Override
//				protected PasswordAuthentication getPasswordAuthentication() {
//					//관리자 메일 , 구글 2단계인증 비밀번호
//					return new PasswordAuthentication("wjddnrbs0987@gmail.com", "fjjgakdscqhyiwja");
//				}
//			});
//			
//			
//			String receiver = email; // 메일 받을 주소
//			String title = "[WEB-TEST]본인확인 인증코드";
//			
//			//코드 발급(난수 6자리)
//			code = (int)(Math.random()*1000000) + "";
//			
//			String content = code;
//			Message message = new MimeMessage(session);
//			try {
//				message.setFrom(new InternetAddress("wjddnrbs0987@gmail.com", "관리자", "utf-8"));
//				message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
//				message.setSubject(title);
//				message.setContent(content, "text/html; charset=utf-8");
//
//				Transport.send(message);
//				
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		}
//		else if(step.equals("2")) // 인증 확인
//		{
//			String recvcode = req.getParameter("code");
//			System.out.println("받은 코드 : " + recvcode);
//			System.out.println("저장 코드 : " + code);
//			if(code.equals(recvcode)) {
//				
//				//결과를 msg로 전달하기 
//				PrintWriter out = resp.getWriter();
//				out.println("Code Confirm your id : aaa pw : 1234");
//				
//				
//				//DB로 임시패스워드 만들어서 저장
//				//DB로 임시패스워드 만들어서 이메일 전송
//				
//			}else
//			{
//				PrintWriter out = resp.getWriter();
//				out.println("fail....");
//			}
//			 
//			
//			
//		}	
//	}
//
//	
//	
//}
