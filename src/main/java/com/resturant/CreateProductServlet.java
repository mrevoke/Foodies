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
 * Servlet implementation class CreateProductServlet
 */
@WebServlet("/CreateProductServlet")
public class CreateProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Connection con=Dbconnection.createConnection();
		String product_name=request.getParameter("product_name");
		double product_price=Double.parseDouble(request.getParameter("product_price"));
		int product_quantity=Integer.parseInt(request.getParameter("product_quantity"));
		String product_description=request.getParameter("product_description");
		String query="INSERT INTO Menu (product_name, product_quantity, product_description, product_price) VALUES(?,?,?,?)";
		
		try {
			PreparedStatement pq = con.prepareStatement(query);
			pq.setString(1, product_name);
			pq.setInt(2, product_quantity);
			pq.setString(3, product_description);
			pq.setDouble(4, product_price);
			
			int rs=pq.executeUpdate();
			response.sendRedirect("AdminMenu.jsp");
		}
		catch(SQLException e)
		{
			System.out.print(e.getMessage());
		}
		
		
	}

}
