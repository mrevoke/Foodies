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
 * Servlet implementation class EditCart
 */
@WebServlet("/EditCart")
public class EditCart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 int quantity = Integer.parseInt(request.getParameter("quantity"));
	        double price=Double.parseDouble(request.getParameter("productprice"));
	        int id = Integer.parseInt(request.getParameter("cart_id"));
//	        HttpSession session = request.getSession();
//	        int user_id = (int) session.getAttribute("user_id");
//	        System.out.println(id + quantity + user_id+price);
	        Connection con = Dbconnection.createConnection();
	        double Totalcost=price*quantity;
	        String query = "update  AddtoCart set quantity=?, Totalcost=? where cart_id=?";
	        try {
	            PreparedStatement pq = con.prepareStatement(query);
	            pq.setInt(1, quantity);
	            pq.setDouble(2, Totalcost);
	            pq.setInt(3, id);
	            
	            int result = pq.executeUpdate();
	            response.sendRedirect("UserMenu.jsp");
	        } catch (SQLException e) {
	            System.out.println(e.getMessage());
	        }
	}

}
