<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<html>
<head>
    <title>Home</title>
    <link rel="icon" type="image/x-icon" href="resources/favicon.ico">
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-image: url("/resources/back4.jpg");
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .header {
            background: rgba(0, 0, 0, 0.5); /* Semi-transparent black background */
            color: white;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 18px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 40px;
            backdrop-filter: blur(10px);
            border-bottom: 2px solid rgba(255, 255, 255, 0.3);
        }

        .header .links a {
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 5px;
            transition: background-color 0.3s ease, color 0.3s ease, box-shadow 0.3s ease;
            background: rgba(255, 255, 255, 0.1); /* Lighter semi-transparent background */
            font-size: 14px;
        }

        .header .links a:hover {
            background-color: rgba(255, 255, 255, 0.3);
            color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .header .logo {
            display: flex;
            align-items: center;
            transition: transform 0.3s ease;
        }

        .header .logo img {
            width: 40px;
            height: 40px;
            margin-right: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        }

        .header .links {
            display: flex;
            gap: 20px;
        }

        .content {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .box {
            background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent white background */
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3); /* More pronounced shadow */
            text-align: center;
            width: 360px;
            transition: transform 0.3s ease, box-shadow 0.3s ease, background-color 0.3s ease;
        }

        .box:hover {
            transform: translateY(-10px); /* Lift the box more on hover */
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3); /* Deeper shadow on hover */
            background-color: rgba(255, 255, 255, 1); /* Fully opaque on hover */
        }

        .box form {
            margin: 10px 0; /* Consistent margin around form elements */
        }

        .box button {
            background: linear-gradient(135deg, #67105C, #220039); /* Modern gradient */
            border: none;
            color: white;
            padding: 20px 0; /* Uniform padding */
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            cursor: pointer;
            border-radius: 12px;
            transition: background 0.3s ease, transform 0.3s ease;
            width: 100%; /* Full width */
            max-width: 300px; /* Ensure same size */
        }

        .box button:hover {
            background: linear-gradient(135deg, #5b79e4, #9561d2); /* Darker gradient on hover */
            transform: scale(1.1); /* Slightly larger on hover */
        }

        .footer {
            color: white;
            text-align: center;
            padding: 1px 0;
            width: 100%; /* Full width */
            max-height: 50px; /* Minimal height */
            font-size: 12px;
        }
    </style>
</head>
<body>
<div class="header">
    <div class="logo">
        <img src="resources/wod2.png" alt="Logo">
    </div>
    <div class="links">
        <a href="login">Zaloguj się</a>
        <a href="register">Utwórz konto</a>
        <a href="#">Pomoc</a>
    </div>
</div>

<div class="content">
    <div class="box">
        <form action="login">
            <button type="submit">Zaloguj się</button>
        </form>
        <form action="register">
            <button type="submit">Utwórz konto</button>
        </form>
    </div>
</div>

<div class="footer">
    <p>&copy; <%= new SimpleDateFormat("EEEE, d MMMM yyyy", new Locale("pl", "PL")).format(new Date()) %> - Wszystkie prawa zastrzeżone</p>
</div>
</body>
</html>
