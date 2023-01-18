package com.test.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.service.AuthService;

public class KakaoLoginController implements SubController {
	private static String msg;
	private AuthService service = AuthService.getInstance();
	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) {

		try {
		
			//01 파라미터 받기
			Map<String,String[]> params=req.getParameterMap();
			
			//2 유효성 검사
			boolean isvalid=isValid(params);
			if(!isvalid) {
				//유효성 체크 오류 발생시 전달할 메시지 + 이동될 경로
				req.setAttribute("msg", msg);
				req.getRequestDispatcher("/WEB-INF/view/auth/login.jsp").forward(req, resp);
				return ;
			}
			
			//03 서비스
			boolean flag = service.KakaoLoginCheck(params, req);
			
		
			req.getRequestDispatcher("/WEB-INF/view/auth/kakaoprofile.jsp").forward(req, resp);
			
			
			return ;
	

				
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	
	private boolean isValid(Map<String, String[]> params) {

		return true;
	}
	
	
}
