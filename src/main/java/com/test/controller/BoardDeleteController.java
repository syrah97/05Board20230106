package com.test.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.dto.Criteria;
import com.test.service.BoardService;

public class BoardDeleteController implements SubController {

	private static String msg;
	private BoardService service = BoardService.getInstance();
	
	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) {
		
		 
		try 
		{	
			//1 파라미터 받기
			Map<String,String[]> params=req.getParameterMap();

			
			//2 Validation
			boolean isvalid=isValid(params);
			if(!isvalid) {
				//유효성 체크 오류 발생시 전달할 메시지 + 이동될 경로			
				req.setAttribute("msg", msg);
				req.getRequestDispatcher("/WEB-INF/view/main.jsp").forward(req, resp);
				return ;
			}
			
			//3 Service
			String bno = params.get("bno")[0];
			boolean result=service.RemoveBoard(req,resp);

			//4 View
			String pageno = params.get("pageno")[0];
			if(result) {		
				req.getRequestDispatcher("/board/list.do?pageno="+pageno).forward(req, resp);
			}
		
			
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
	
	private boolean isValid(Map<String, String[]> params) {
		return true;
	}
	
}
