package com.resturant;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.connection.Dbconnection;
import com.connection.User;

/**
 * Servlet implementation class LoginUser
 */
@WebServlet("/LoginUser")
public class LoginUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	        String email = request.getParameter("email");
	       
	      
	        String password = request.getParameter("password");
		Dbconnection user=new Dbconnection();
		  
		 User loggedinuser=user.login(email,password);
		System.out.println(loggedinuser);
		if(loggedinuser!=null)
		{
			HttpSession session=request.getSession();
	        session.setAttribute("name", loggedinuser.getName());
	        session.setAttribute("email", loggedinuser.getEmail());
	        session.setAttribute("phone", loggedinuser.getPhone());
	        session.setAttribute("address", loggedinuser.getAddress());
	        session.setAttribute("Role", loggedinuser.getRole());
	        session.setAttribute("user_id", loggedinuser.getId());
			response.sendRedirect("Welcome.jsp");
			
		}
		else
		{   response.sendRedirect("Signup.jsp");
			
		}
		
	}

}
