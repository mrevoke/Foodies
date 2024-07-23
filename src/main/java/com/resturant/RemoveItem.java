package com.resturant;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.connection.Dbconnection;

/**
 * Servlet implementation class RemoveItem
 */
@WebServlet("/RemoveItem")
public class RemoveItem extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.print(request.getParameter("cart_id"));
		   int cart_id = Integer.parseInt(request.getParameter("cart_id"));
	        
//	        HttpSession session = request.getSession();
//	        int user_id = (int) session.getAttribute("user_id");
	        
	        Connection con = Dbconnection.createConnection();
	  
	        String query = "Delete from AddtoCart where cart_id=?";
	        try {
	            PreparedStatement pq = con.prepareStatement(query);
	            pq.setInt(1, cart_id);
	           
	            int result = pq.executeUpdate();
	            response.sendRedirect("UserMenu.jsp");
	        } catch (SQLException e) {
	            System.out.println(e.getMessage());
	        }
	}

}
