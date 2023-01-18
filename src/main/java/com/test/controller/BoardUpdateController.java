package com.test.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.test.dto.BoardDto;
import com.test.dto.PageDto;
import com.test.service.BoardService;

public class BoardUpdateController implements SubController {

	private static String msg;
	private BoardService service = BoardService.getInstance();
	
	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) {
		try {
			//0 Get구별
			String method=req.getMethod();
			if(method.equals("GET")) {
	
				System.out.println("[BUC] 요청 METHOD : " + method);
				req.getRequestDispatcher("/WEB-INF/view/board/update.jsp").forward(req, resp);
				return ;
			}
			
			//1 파라미터	
			Map<String,String[]> params=req.getParameterMap();

			//2 유효성검사
			boolean isvalid=isValid(params);
			if(!isvalid) {
				//유효성 체크 오류 발생시 전달할 메시지 + 이동될 경로			
				req.setAttribute("msg", msg);
				req.getRequestDispatcher("/WEB-INF/view/list.jsp").forward(req, resp);
				
				return ;
			}		
			
			//3 Service 실행
			service.boardUpdate(params,req);
			
			//4 View이동
			HttpSession session = req.getSession(false);
			BoardDto bdto = (BoardDto)session.getAttribute("boarddto");
			PageDto pdto = (PageDto)session.getAttribute("pagedto");
			String cpath = req.getContextPath();
			 
			resp.sendRedirect(cpath + "/board/read.do?bno="+bdto.getNo()+"&pageno="+pdto.getCriteria().getPageno());
			//req.getRequestDispatcher("/WEB-INF/view/board/read.jsp?bno="+bdto.getNo()+"&pageno="+pdto.getCriteria().getPageno()).forward(req, resp);
			return ;
		
		}catch(Exception e) {
			e.printStackTrace();
		}

	}

	
	private boolean isValid(Map<String, String[]> params) {
		//msg="유효성 체크 오류";
		return true;
	}
}
