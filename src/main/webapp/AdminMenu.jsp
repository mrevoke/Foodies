<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Menu</title>
  <style>
    /* Global styles */
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f8f8f8; /* Light gray background */
        color: #444; /* Dark gray text color */
    }

    /* Header styles */
    .header {
        background-color: #6a1b9a; /* Purple header */
        color: #fff; /* White text */
        padding: 20px;
        text-align: center;
    }

    .header-title {
        margin: 0;
    }

    /* Main content styles */
    .main-content {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        padding: 20px;
    }

    /* Section styles */
    .section {
        margin: 20px;
        flex: 1 1 45%; /* Adjust width as needed */
        max-width: 45%; /* Adjust max-width as needed */
    }

    .section1 {
        margin: 20px;
        flex: 1 1 100%; /* Adjust width as needed */
        max-width: 100%; /* Adjust max-width as needed */
    }

    .section-title {
        text-align: center;
        margin-top: 0;
        margin-bottom: 20px;
        color: #6a1b9a; /* Purple section title */
    }

    /* Form styles */
    .form {
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .form-group {
        margin-bottom: 20px;
    }

    .form-group label {
        font-weight: bold;
        display: block;
    }

    .form-group input {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
    }

    /* Button styles */
    .btn {
        background-color: #6a1b9a; /* Purple button */
        color: #fff;
        border: none;
        padding: 10px 20px;
        cursor: pointer;
        border-radius: 5px;
        font-size: 16px;
        display: inline-block;
    }

    .btn:hover {
        background-color: #4a148c; /* Darker purple on hover */
    }
     .lbtn {
        background-color: #333; /* Dark gray button */
        color: #fff;
        border: none;
        margin:20px;
        padding: 10px 20px;
        cursor: pointer;
        border-radius: 5px;
        font-size: 16px;
        display: inline-block;
    }

    /* Orders container */
    .orders-container {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
    }

    /* Order styles */
    .order {
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        flex: 1 1 100%;
    }

    /* Menu list styles */
    .menu-list {
        list-style-type: none;
        padding: 0;
        max-height: 400px; /* Adjust max-height as needed */
        overflow-y: auto;
    }

    /* Menu item styles */
    .menu-item {
        background-color: #6a1b9a; /* Purple menu item */
        color: #fff; /* White text */
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
    }
</style>

    <%@ page import="java.sql.*, com.connection.Dbconnection" %>
</head>
<body>
<%     response.setHeader("cache-control","no-cache,no-store,must-revalidate");
     Object userrole = session.getAttribute("Role");
    if (userrole == null ) {
        // Redirect only if the role is not set or if it's "USER"
        response.sendRedirect("Login.jsp");
        return; // Add return to stop further processing of the page
    }
    String role=userrole.toString();
    if(role.equals("USER"))
    {
    	 response.sendRedirect("Login.jsp");
         return;
    }
    // Other code if needed after redirection
%>

    <header class="header">
        <h1 class="header-title">Admin Menu</h1>
    </header>
    <form action="Logout" method="post"><input type="submit" value="Logout" class="lbtn"/></form>
    <main class="main-content">
        <!-- Section for Creating a Product -->
        <section class="section">
            <h2 class="section-title">Create Product</h2>
            <form action="CreateProductServlet" method="post" class="form">
                <div class="form-group">
                    <label for="productName">Product Name:</label>
                    <input type="text" id="productName" name="product_name" required>
                </div>
                <div class="form-group">
                    <label for="productQuantity">Product Quantity:</label>
                    <input type="number" id="productQuantity" name="product_quantity" min="1" required>
                </div>
                <div class="form-group">
                    <label for="productDescription">Product Description:</label>
                    <input type="text" id="productDescription" name="product_description" required>
                </div>
                <div class="form-group">
                    <label for="productPrice">Product Price:</label>
                    <input type="text" id="productPrice" name="product_price" required>
                </div>
                <button type="submit" class="btn btn-primary">Create Product</button>
            </form>
        </section>
        
        <!-- Section for Restaurant Menu -->
        <section class="section">
            <h2 class="section-title">Restaurant Menu</h2>
            <ul class="menu-list">
                <% 
                    try {
                        Connection con = Dbconnection.createConnection();    
                        String query = "SELECT * FROM Menu";
                        PreparedStatement ps = con.prepareStatement(query);
                        ResultSet rs = ps.executeQuery();
                        
                        while (rs.next()) {
                %>
                <li class="menu-item">
                    <!-- Menu item details -->
                    <span class="product-name"><%= rs.getString("product_name") %></span><br>
                    <span class="product-details">ID: <%= rs.getInt("product_id") %></span><br>
                    <span class="product-details">Quantity: <%= rs.getString("product_quantity") %></span><br>
                    <span class="product-details">Description: <%= rs.getString("product_description") %></span><br>
                    <span class="product-details">Price: $<%= rs.getDouble("product_price") %></span>
                </li>
                <% 
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
            </ul>
        </section>
        
        <!-- Section for Viewing Received Orders -->
        <section class="section1">
            <h2 class="section-title">Received Orders</h2>
            <div class="orders-container">
                <% try {
                        Connection con = Dbconnection.createConnection();
                        String query = "SELECT * FROM user JOIN `Order` ON user.user_id = `Order`.user_id JOIN menu ON menu.product_id = `Order`.product_id ";
                        PreparedStatement ps = con.prepareStatement(query);
                        ResultSet rs = ps.executeQuery();
                        
                        while (rs.next()) {
                %>
                    <div class="order">
                        <!-- Order details -->
                        <p class="order-title">Order ID: <%= rs.getInt("order_id") %></p>
                        <p>Product Name: <%= rs.getString("product_name") %></p>
                        <p>Food Size: <%= rs.getInt("product_quantity") %></p>
                        <p>Product Description: <%= rs.getString("product_description") %></p>
                        <p>Quantity: <%= rs.getInt("quantity") %></p>
                        <p>Product Price: $<%= rs.getDouble("product_price") %></p>
                        <p>Total Cost: $<%= rs.getDouble("Totalcost") %></p>
                        <div class="user-details">
                            <p>User Name: <%= rs.getString("name") %></p>
                            <p>User ID: <%= rs.getString("user_id") %></p>
                            <p>User Email: <%= rs.getString("email") %></p>
                            <p>User Phone: <%= rs.getString("phone") %></p>
                            <p>Delivery Address: <%= rs.getString("address") %></p>
                        </div>
                    </div>
                <%      }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
            </div>
        </section>
    </main>
</body>
</html>
