package com.resturant;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CheckRole
 */
@WebServlet("/CheckRole")
public class CheckRole extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session=request.getSession();
		Object userRole = session.getAttribute("Role");
		if(userRole==null)
		{
			  response.sendRedirect("Login.jsp");
			  return ;
		}
		String Role=userRole.toString();
		System.out.print(Role);
		
		if ("USER".equals(Role)) {
		    response.sendRedirect("UserMenu.jsp");
		} else if ("ADMIN".equals(Role)) {
		    response.sendRedirect("AdminMenu.jsp");
		} else {
		    // Remove session attributes
		    session.removeAttribute("name");
		    session.removeAttribute("email");
		    session.removeAttribute("phone");
		    session.removeAttribute("address");
		    session.removeAttribute("Role");
		    // Redirect to login page
		    response.sendRedirect("Login.jsp");
		}

	}

}
