package com.connection;

import java.sql.*;

public class Dbconnection {
    public static String url = "jdbc:mysql://localhost:3306/Resturant";
   public static String username = "root";
    public static String password = "Jeet@8980";
    public static Connection createConnection()
	{
		Connection con = null;
		try
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url,username,password);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return con;
	}

    public boolean signin(String name, String email, String phone, String address, String pass) {
        try {
            String query = "INSERT INTO user(name, email, password, address, phone) VALUES (?, ?, ?, ?, ?)";
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, username, password);
            System.out.println("connection sucessfull");
            
            System.out.println(name+email+phone+address+pass);
            PreparedStatement st = con.prepareStatement(query);
            st.setString(1, name);
            st.setString(2, email);
            st.setString(3, pass);
            st.setString(4, address);
            st.setString(5, phone);
            int rowsInserted = st.executeUpdate();
              con.close();
            // Check if insertion was successful
            return rowsInserted > 0;

        } catch (Exception e) {
            System.out.println(e.getMessage());
            return false;
        }
       
    }

    public User login(String email, String pass) {
        try {
            String query = "SELECT * FROM user WHERE email = ? AND password = ?";
            Class.forName("com.mysql.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(url, username, password);
                 PreparedStatement st = con.prepareStatement(query)) {
                st.setString(1, email);
                st.setString(2, pass);
                System.out.println(email+" "+pass);
                ResultSet rs = st.executeQuery();
                if(rs.next())
                {
                	User user = new User();
                    
                    user.setId(rs.getInt("user_id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setAddress(rs.getString("address"));
                    user.setRole(rs.getString("Role"));
                    // You can add more fields as needed
                    return user;
                }
                else
                {
                	return null;
                }
                
            }
        } catch (Exception e) {
            System.err.println("Error during login: " + e.getMessage());
            return null;
        }
    }

}
