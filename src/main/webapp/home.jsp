<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Strona Główna</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Roboto', sans-serif;
            background-image: url("/resources/back4.jpg");
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            align-items: center;
            justify-content: center; /* Centering the content vertically */
            padding: 20px;
        }

        .header {
            width: 100%;
            background: rgba(0, 0, 0, 0.5); /* Semi-transparent black background */
            color: white;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 18px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            position: fixed;
            top: 0;
            left: 50%; /* Center the header */
            transform: translateX(-50%); /* Center the header */
            z-index: 1000;
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
            gap: 10px; /* Reduce gap between links */
        }

        .header .links a {
            color: white;
            text-decoration: none;
            padding: 8px 12px; /* Reduce padding */
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



        .content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px; /* Gap of 20px between both rows and columns */
            justify-content: center; /* Center the content horizontally */
            flex: 1;
            width: 100%;
            max-width: 860px; /* Adjust the max-width to center the content */
            max-height: 520px;
            align-items: center;
            padding: 24px;
            border-radius: 15px;
            background-color: rgba(255,255,255, 0.2);
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.4);
        }


        .box {
            background-color: white;
            padding: 20px;
            border-radius: 20px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.4);
            text-align: center;
            margin: 0; /* Remove default margin */
        }

        .box h2 {
            font-size: 24px;
            background: linear-gradient(135deg, #67105C, #220039);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            color: transparent;
            margin-bottom: 10px;
        }

        .box .btn {
            display: block;
            width: 100%;
            padding: 12px;
            font-size: 16px;
            color: white;
            background: linear-gradient(135deg, #67105C, #220039);
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: transform 0.3s ease, background 0.3s ease;
            margin: 5px;
        }

        .box .btn:hover {
            background: linear-gradient(135deg, #5b79e4, #9561d2);
            transform: scale(1.05);
        }

        .footer {
            color: white;
            text-align: center;
            padding: 10px 0;
            width: 100%;
            font-size: 14px;
            position: fixed; /* Make the footer fixed */
            bottom: 0;
        }

        @media (max-width: 768px) {
            .content {
                grid-template-columns: 1fr;
                gap: 10px; /* Reduce gap on smaller screens */
            }
        }
    </style>
    <script>
        function formSubmit(){
            document.getElementById("logoutForm").submit();
        }
    </script>
</head>
<body>
<div class="header">
    <div class="logo">
        <img src="resources/wod2.png" alt="Logo">
    </div>
    <div class="links">
        <a href="#">Profil</a>
        <a href="#">Ustawienia</a>
        <form action="/logout" method="post" id="logoutForm" style="display: none;">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
        <a href="javascript:formSubmit()">Wyloguj</a>    </div>
</div>

<div class="content">
    <div class="box">
        <h2>Urządzenia</h2>
        <button class="btn">Zarządzaj urządzeniami</button>
    </div>
    <div class="box">
        <h2>Użytkownicy</h2>
        <button class="btn" onclick="window.location.href='/users'">Zarządzaj użytkownikami</button>
        <button class="btn" onclick="window.location.href='/appUserRole'">Zarządzaj rolami</button>
        <button class="btn" onclick="window.location.href='/permission-management'">Zarządzaj dostępem</button>
        <button class="btn" onclick="window.location.href='/usersRoles'">Przydziel role</button>
    </div>
    <div class="box">
        <h2>Moje konto</h2>
        <button class="btn">Zarządzaj kontem</button>
    </div>
    <div class="box">
        <h2>Test</h2>
        <button class="btn">Testuj</button>
    </div>
</div>

<div class="footer">
    <p>&copy; <%= new SimpleDateFormat("EEEE, d MMMM yyyy", new Locale("pl", "PL")).format(new Date()) %> - Wszystkie prawa zastrzeżone</p>
</div>
</body>
</html>
