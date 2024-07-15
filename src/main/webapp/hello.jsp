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
            background-color: #F1F0FF;
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .header {
            background: linear-gradient(135deg, #6e8efb, #a777e3);
            color: white;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 18px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 40px;
            backdrop-filter: blur(10px);
            border-bottom: 2px solid rgba(255, 255, 255, 0.3); /* Added border at the bottom */
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

        .header .links a {
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 5px;
            transition: background-color 0.3s ease, color 0.3s ease, box-shadow 0.3s ease;
        }

        .header .links a:hover {
            background-color: rgba(255, 255, 255, 0.2);
            color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Enhanced hover effect */
        }

        .content {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .box {
            background-color: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.4);
            text-align: center;
            width: 320px; /* Slightly increased width */
        }

        .box button {
            background: linear-gradient(135deg, #6e8efb, #a777e3); /* Modern gradient */
            border: none;
            color: white;
            padding: 15px 0; /* Uniform padding */
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 10px 0; /* Uniform margin */
            cursor: pointer;
            border-radius: 12px;
            transition: background 0.3s ease, transform 0.3s ease;
            width: 100%; /* Full width */
            max-width: 250px; /* Ensure same size */
        }

        .box button:hover {
            background: linear-gradient(135deg, #5b79e4, #9561d2); /* Darker gradient on hover */
            transform: scale(1.05); /* Slightly larger on hover */
        }

        .footer {
            color: black;
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
        <img src="resources/wod.png" alt="Logo">
    </div>
    <div class="links">
        <a href="#">Zaloguj się</a>
        <a href="register">Utwórz konto</a>
        <a href="#">Pomoc</a>
    </div>
</div>

<div class="content">
    <div class="box">
        <button>Zaloguj się</button>
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
