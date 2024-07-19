<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Date" %>
<html>
<head>
    <title>Title</title>
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
            border-bottom: 2px solid rgba(255, 255, 255, 0.3);
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
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .content {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .content .box {
            background-color: white;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.4);
            text-align: center;
        }

        .content .box h1, .content .box h2 {
            color: #6e8efb; /* Jednolity kolor dla nagłówków */
        }

        .content .box h1 {
            font-size: 36px;
            margin-bottom: 20px;
        }

        .content .box h2 {
            font-size: 20px;
        }

        .footer {
            margin-top: 40px;
            color: black;
            text-align: center;
            padding: 10px 0;
            width: 100%;
            max-height: 50px;
            font-size: 12px;
            background-color: #f1f1f1;
            box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
<div class="header">
    <div class="logo">
        <img src="resources/wod.png" alt="Logo">
    </div>
    <div class="links">
        <a href="login">Zaloguj się</a>
        <a href="/">Strona główna</a>
        <a href="#">Pomoc</a>
    </div>
</div>

<div class="content">
    <div class="box">
        <h1>Witaj <c:out value="${firstName}" />!</h1>
        <h2>Dziękujemy za utworzenie konta. Gdy tylko potwierdzimy twoją tożsamość, uzyskasz możliwość zalogowania do witryny.</h2>
        <h2>W przypadku napatkania problemów z uzyskaniem autoyzacji zapraszamy do kontaktu.</h2>
    </div>
</div>

<div class="footer">
    <p>&copy; <%= new SimpleDateFormat("EEEE, d MMMM yyyy", new Locale("pl", "PL")).format(new Date()) %> - Wszystkie prawa zastrzeżone</p>
</div>
</body>
</html>
