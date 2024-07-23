package com.resturant;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.connection.Dbconnection;

@WebServlet("/PlaceOrder")
public class PlaceOrder extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int user_id = (int) session.getAttribute("user_id");
        
        Connection con = Dbconnection.createConnection();
       
        String query = "SELECT * FROM AddToCart JOIN Menu ON AddToCart.product_id = Menu.product_id WHERE AddToCart.user_id = ?";
       
        try {
            PreparedStatement pq = con.prepareStatement(query);
            pq.setInt(1, user_id);
            ResultSet rs = pq.executeQuery();
            
            String query1 = "INSERT INTO `Order` (user_id, product_id, quantity, Totalcost) VALUES (?, ?, ?, ?)";
           
            	
            
            while(rs.next()) { 
            	System.out.println("hello");
                PreparedStatement rq = con.prepareStatement(query1);
                rq.setInt(1, user_id);
                rq.setInt(2, rs.getInt("product_id"));
                rq.setInt(3, rs.getInt("quantity"));
                rq.setDouble(4, rs.getDouble("Totalcost")); // Corrected index here
                System.out.print("hello");
                int res = rq.executeUpdate();
                // Delete the corresponding record from AddToCart
                String deleteQuery = "DELETE FROM AddToCart WHERE cart_id=?";
                PreparedStatement deleteStatement = con.prepareStatement(deleteQuery);
                deleteStatement.setInt(1, rs.getInt("cart_id"));
                int deleteResult = deleteStatement.executeUpdate();
            }
            
          
            	response.sendRedirect("YourOrders.jsp");
           
           
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}
