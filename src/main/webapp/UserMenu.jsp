<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Menu</title>
    <style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #6a1b9a; /* Purple background */
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
    }

    .container {
        width: 80%;
        display: flex;
        justify-content: space-between;
    }

    .left-section, .right-section {
        width: 48%;
        padding: 20px;
        background-color: #fff; /* White container background */
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .left-section h1, .right-section h1 {
        text-align: center;
        color: #6a1b9a; /* Purple heading color */
        margin-bottom: 20px;
    }

    .left-section ul, .right-section ul {
        list-style-type: none;
        padding: 0;
        margin: 0;
    }

    .left-section li, .right-section li {
        margin-bottom: 20px;
        padding: 10px;
        border-radius: 8px;
        background-color: #f9f9f9; /* Light gray background for list items */
        border: 1px solid #ddd; /* Gray border */
        transition: all 0.3s ease;
    }

    .left-section li:hover, .right-section li:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }

    .product-name {
        font-weight: bold;
        color: #6a1b9a; /* Purple product name color */
    }

    .product-details {
        margin-top: 5px;
        color: #666; /* Gray product details color */
    }

    .quantity-input {
        width: 60px;
    }

    .btn {
        background-color: #6a1b9a; /* Purple button background */
        color: #fff; /* White button text color */
        border: none;
        padding: 8px 16px;
        border-radius: 4px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .lbtn {
        background-color: #6a1b9a; 
        color: #fff; /* White button text color */
        border: none;
        margin: 20px;
        padding: 10px 20px;
        cursor: pointer;
        border-radius: 5px;
        font-size: 16px;
        display: inline-block;
    }
    .Rbtn {
        background-color: #FF0000; /* Red button background */
        color: #fff; /* White button text color */
        border: none;
        padding: 8px 16px;
        border-radius: 4px;
        cursor: pointer;
        margin-top: 20px;
        transition: background-color 0.3s ease;
    }

    .btn:hover {
        background-color: #4a148c; /* Darker purple on hover */
    }

    .bill {
        border: 1px solid #ccc;
        padding: 10px;
        background-color: #fff; /* White bill background */
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        margin-top: 20px;
    }

    .bill h2 {
        margin-bottom: 10px;
        color: #6a1b9a; /* Purple bill heading color */
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
    <div class="container">
        <div class="left-section">
            <h1>User Menu</h1>
            <form action="Logout" method="post"><input type="submit" value="Logout" class="lbtn"/></form>
            <ul>
                <% 
                    try {
                        Connection con = Dbconnection.createConnection();    
                        String query = "SELECT * FROM Menu";
                        PreparedStatement ps = con.prepareStatement(query);
                        ResultSet rs = ps.executeQuery();
                        
                        while (rs.next()) {
                %>
                <li>
                    <form action="AddToCart" method="post">
                        <span class="product-name"><%= rs.getString("product_name") %></span><br>
                        <span class="product-details">ID: <%= rs.getInt("product_id") %></span><br>
                        <span class="product-details">Quantity: <%= rs.getString("product_quantity") %></span><br>
                        <span class="product-details">Description: <%= rs.getString("product_description") %></span><br>
                        <span class="product-details">Price: $<%= rs.getDouble("product_price") %></span>
                        <input type="hidden" name="productprice" value="<%= rs.getDouble("product_price") %>">
                        <input type="hidden" name="product_id" value="<%= rs.getInt("product_id") %>">
                        <input type="number" class="quantity-input" name="quantity" min="1" max="20" value="1">
                        <button type="submit" class="btn">Add to Cart</button>
                    </form>
                </li>
                <% 
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
            </ul>
        </div>
<%
   
Object userId = session.getAttribute("user_id");
if (userId == null) {
    // Redirect to the login page if "user_id" attribute is null
    response.sendRedirect("Login.jsp");
    return ;
}
    double totalBill=0.0;
%>

 <div style="width: 40px;"></div> 
<div class="right-section">
    <h1>Add to Cart</h1>
    <ul>
        <%
            try {
                Object userIdObj = session.getAttribute("user_id");
                if (userIdObj == null) {
                    // Redirect to the login page if "user_id" attribute is null
                    response.sendRedirect("Login.jsp");
                } else {
                    int user_id = ((Integer) userIdObj).intValue();
                    // Proceed with the rest of your code
                   
                    Connection con = Dbconnection.createConnection();
                    String query = "SELECT * FROM AddToCart JOIN Menu ON AddToCart.product_id = Menu.product_id WHERE AddToCart.user_id = ?";
                    PreparedStatement ps = con.prepareStatement(query);
                    ps.setInt(1, user_id);
                    ResultSet rs = ps.executeQuery();
                    
                    while (rs.next()) {
                        double productPrice = rs.getDouble("product_price");
                        int quantity = rs.getInt("quantity");
                        double subtotal = productPrice * quantity;
                        totalBill += subtotal;
        %>
                        <li>
                            <span class="product-name"><%= rs.getString("product_name") %></span><br>
                            <span class="product-details">Quantity: <%= rs.getInt("quantity") %></span><br>
                            <span class="product-details">Price: $<%= rs.getDouble("product_price") %></span><br>
                            <span class="product-details">Subtotal: $<%= subtotal %></span>
                            <form action="EditCart" method="post">
                                <input type="hidden" name="productprice" value="<%= rs.getDouble("product_price") %>">
                                <input type="hidden" name="cart_id" value="<%= rs.getInt("cart_id") %>">
                                <input type="number" class="quantity-input" name="quantity" min="1" max="20" value="<%= quantity %>">
                                <button type="submit" class="btn">Edit Cart</button>
                            </form>
                            <form action="RemoveItem" method="post">
                                <input type="hidden" name="cart_id" value="<%= rs.getInt("cart_id") %>">
                                <button type="submit" class="Rbtn">Remove from Cart</button>
                            </form>
                        </li>
        <%
                }

               
            }
        %>
    </ul>
    <div class="bill">
        <h2>Bill Summary</h2>
        <p>Total Bill: $<%= totalBill %></p>
        <form action="PlaceOrder" method="post">
        <input type="submit" class="btn" value="order now"/>
        </form>
        
    </div>
        <% 
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
</div>

    </div>
</body>
</html>
