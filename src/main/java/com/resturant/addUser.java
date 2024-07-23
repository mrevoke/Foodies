package com.resturant;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.connection.Dbconnection;

/**
 * Servlet implementation class addUser
 */
@WebServlet("/addUser")
public class addUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		  String name = request.getParameter("name");
	        String email = request.getParameter("email");
	        String phone = request.getParameter("phone");
	        String address = request.getParameter("address");
	        String password = request.getParameter("password");
		Dbconnection user=new Dbconnection();
		  
		boolean issignup=user.signin(name, email, phone, address, password);
		
		if(issignup)
		{
			response.sendRedirect("Login.jsp");
			
		}
		else
		{   response.setContentType("text/html");
			PrintWriter pw=response.getWriter();
			pw.println("<h1>unable to do login</h1>");
			
		}
		
		
	}

}
