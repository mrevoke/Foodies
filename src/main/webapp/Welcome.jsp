<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome to Foodies</title>
    <style>
    body {
        font-family: Arial, sans-serif;
        background-color:  #e0d1ff;
        margin: 0;
        padding: 0;
    }

    .container {
        max-width: 600px;
        margin: 50px auto;
        padding: 20px;
        background-color: #fff; /* White container background */
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    h1 {
        text-align: center;
        color: #6a1b9a; /* Purple header color */
        margin-bottom: 20px;
    }

    p {
        text-align: center;
      
        margin-bottom: 30px;
    }

    form {
        text-align: center;
    }

    input[type="submit"] {
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        background-color: #6a1b9a; /* Green submit button background */
        color: white;
        cursor: pointer;
        font-size: 16px;
    }

    input[type="submit"]:hover {
        background-color: #6a1b9a; /* Darker green on hover */
    }
</style>

</head>
<body>
 
<%
response.setHeader("cache-control","no-cache,no-store,must-revalidate");
Object username =  session.getAttribute("name");
if (username == null) {
    response.sendRedirect("Login.jsp");
    return ;
}
String name = username.toString();
%>
   <div class="container">
       <h1>Welcome, <%= name %>!</h1>
       <p>We're thrilled to have you here at Foodies, where every dish tells a story.</p>
       <form action="CheckRole" method="post">
           <input type="submit" value="Enter"/>
       </form>
   </div>
</body>
</html>
