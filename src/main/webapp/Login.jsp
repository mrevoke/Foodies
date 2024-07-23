<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
    body {
        font-family: Arial, sans-serif;
        background-color: #6a1b9a; /* Purple background */
        margin: 0;
        padding: 0;
    }
    .container {
        max-width: 400px;
        margin: 50px auto;
        padding: 20px;
        background-color: #fff; /* White container background */
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    h2 {
        text-align: center;
        color: #6a1b9a; /* Purple heading color */
    }
    label {
        display: block;
        margin-bottom: 5px;
        color: #6a1b9a; /* Purple label color */
    }
    input[type="email"],
    input[type="password"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #6a1b9a; /* Purple border */
        border-radius: 5px;
        box-sizing: border-box;
    }
    input[type="submit"] {
        width: 100%;
        padding: 10px;
        border: none;
        border-radius: 5px;
        background-color: #6a1b9a; /* Purple button background */
        color: white; /* White button text color */
        cursor: pointer;
        font-size: 16px;
    }
    input[type="submit"]:hover {
        background-color: #4a148c; /* Darker purple on hover */
    }
</style>

</head>
<body>

<div class="container">
    <h2>Login</h2>
    <form action="LoginUser" method="post">
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br>
        
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br><br>
        
        <input type="submit" value="Login">
    </form>
</div>

</body>
</html>
