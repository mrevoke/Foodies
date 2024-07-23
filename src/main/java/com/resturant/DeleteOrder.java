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

import com.connection.Dbconnection;

/**
 * Servlet implementation class DeleteOrder
 */
@WebServlet("/DeleteOrder")
public class DeleteOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int order_id=Integer.parseInt(request.getParameter("order_id"));
		
		Connection con=Dbconnection.createConnection();
		String query = "DELETE FROM `Order` WHERE order_id = ?";

		try {
			PreparedStatement pq = con.prepareStatement(query);
			pq.setInt(1, order_id);
			int rs=pq.executeUpdate();
			response.sendRedirect("YourOrders.jsp");
		}
		catch(SQLException e)
		{
			System.out.print(e.getMessage());
		}
		
		
	}

}
