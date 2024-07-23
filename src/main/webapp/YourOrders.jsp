<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Orders</title>
   <style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 20px;
        background-color: #f5f5f5;
    }
    .container {
        max-width: 800px;
        margin: 0 auto;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        padding: 20px;
    }
    h1 {
        text-align: center;
        color: #6a1b9a; /* Purple header color */
    }
    .order {
        border-bottom: 1px solid #ccc;
        padding: 20px 0;
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
    }
    .order p {
        margin: 5px 0;
        width: 50%;
        color: #333; /* Dark gray text color */
    }
    .order-title {
        font-size: 20px;
        color: #007bff; /* Dark blue title color */
        margin-bottom: 10px;
    }
    .cancel-form {
        margin-top: 10px;
    }
    .cancel-button {
        background-color: #6a1b9a; /* Red cancel button color */
        color: #fff;
        border: none;
        padding: 8px 16px;
        border-radius: 4px;
        cursor: pointer;
    }
    .btn {
        background-color: #6a1b9a; /* Dark blue button color */
        color: #fff;
        border: none;
        padding: 8px 16px;
        border-radius: 4px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .btn:hover {
        background-color: #6a1b9a; /* Darker blue on hover */
    }
    .lbtn {
        background-color: #6a1b9a; /* Dark purple logout button color */
        color: #fff;
        border: none;
        margin:20px;
        padding: 10px 20px;
        cursor: pointer;
        border-radius: 5px;
        font-size: 16px;
        display: inline-block;
    }
</style>

    <%@ page import="java.sql.*, com.connection.Dbconnection" %>
</head>
<body>
<%
response.setHeader("cache-control","no-cache,no-store,must-revalidate");
Object username =  session.getAttribute("name");
if (username == null) {
	
    response.sendRedirect("Login.jsp");
    return ;
}
%>
<form action="Logout" method="post"><input type="submit" value="Logout" class="lbtn"/></form>
    <div class="container">
        <h1>Your Orders</h1>
         <a href="UserMenu.jsp"><button class="btn">order more</button></a>
        
        <%
            try {
                int user_id = (int) session.getAttribute("user_id");
                Connection con = Dbconnection.createConnection();
                String query = "SELECT * FROM user JOIN `Order` ON user.user_id = `Order`.user_id JOIN menu ON menu.product_id = `Order`.product_id WHERE user.user_id = ?";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setInt(1, user_id);
                ResultSet rs = ps.executeQuery();
                
                while (rs.next()) {
        %>
                    <div class="order">
                        <div>
                            <p class="order-title">Order ID: <%= rs.getInt("order_id") %></p>
                            <p>Product Name: <%= rs.getString("product_name") %></p>
                            <p>Food Size: <%= rs.getInt("product_quantity") %></p>
                            <p>Product Description: <%= rs.getString("product_description") %></p>
                            <p>Quantity: <%= rs.getInt("quantity") %></p>
                            <p>Product Price: $<%= rs.getDouble("product_price") %></p>
                            <p>Total Cost: $<%= rs.getDouble("Totalcost") %></p>
                        </div>
                        <form class="cancel-form" method="post" action="DeleteOrder">
                            <input type="hidden" name="order_id" value="<%= rs.getInt("order_id") %>">
                            <input class="cancel-button" type="submit" value="Cancel Order">
                        </form>
                        
                    </div>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
    </div>
   
</body>
</html>
