package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * servlet class가 지정한 요청이 최초에 요청을 받게 되면 
 * servlet 생성 -> init(); 호출(최초에 한번)
 * 
 * 그 다음 요청이 들어올떄마다
 * service -> doGet or doPost 호출
 */
public class RedirectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	// 아무것도 지정하지 않으면 service에서 끝남
	// jsp는 get/post 방식 둘다 처리 가능 
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Redirect Service 호출");
		// super.service(request, response);
		String method = request.getMethod();
		System.out.println("요청 전송 방식 : " + method);
		if(method.equalsIgnoreCase("POST")) {
			response.sendError(405," 처리 할 수 없는 요청 방식 임다");
			return;
		}
		doGet(request, response);
	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Redirect doGET 호출");
		String id = request.getParameter("id");
		System.out.println("param id : " + id);
		request.setAttribute("attrID", id);
		// response.sendRedirect("response.jsp");
		response.setStatus(302);
		response.setHeader("Location", "response.jsp");
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Redirect doPOST 호출");
	}

}
