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

@WebServlet("/AddToCart")
public class AddToCart extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        double price=Double.parseDouble(request.getParameter("productprice"));
        int id = Integer.parseInt(request.getParameter("product_id"));
        HttpSession session = request.getSession();
        int user_id = (int) session.getAttribute("user_id");
        System.out.println(id + quantity + user_id+price);
        Connection con = Dbconnection.createConnection();
        double Totalcost=price*quantity;
        String query = "INSERT INTO AddtoCart(user_id, product_id, quantity,Totalcost) VALUES (?, ?, ?,?)";
        try {
            PreparedStatement pq = con.prepareStatement(query);
            pq.setInt(1, user_id);
            pq.setInt(2, id);
            pq.setInt(3, quantity);
            pq.setDouble(4, Totalcost);
            int result = pq.executeUpdate();
            response.sendRedirect("UserMenu.jsp");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}
