<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Odmowa dostępu</title>
    <!-- Import Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Roboto', sans-serif;
            background-image: url("/resources/back4.jpg");
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #4A4A4A;
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

        .header .links {
            display: flex;
            gap: 10px; /* Reduce gap between links */
            align-items: center; /* Center items vertically */
        }

        .header .links a {
            color: white;
            text-decoration: none;
            padding: 5px 10px; /* Reduce padding */
            border-radius: 5px;
            transition: background-color 0.3s ease, color 0.3s ease, box-shadow 0.3s ease;
            background: rgba(255, 255, 255, 0.1); /* Lighter semi-transparent background */
            font-size: 14px;
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

        .header .links a:hover {
            background-color: rgba(255, 255, 255, 0.3);
            color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .container {
            text-align: center;
            background-color: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            max-width: 500px;
            width: 100%;
        }

        h2 {
            font-size: 24px;
            color: #a94442; /* Slightly dark red to highlight the error */
            margin-bottom: 20px;
        }

        p {
            font-size: 16px;
            margin-bottom: 20px;
        }

        .check-permissions {
            display: inline-block;
            margin-top: 10px;
            padding: 12px 22px;
            font-size: 16px;
            color: white;
            background-color: #67105C; /* Gradient starting color */
            background-image: linear-gradient(135deg, #67105C, #220039); /* Gradient */
            border: none;
            border-radius: 15px;
            text-decoration: none;
            transition: background 0.3s ease, transform 0.3s ease;
            max-width: 200px;
            width: 100%;
        }

        .check-permissions:hover {
            background-color: #5b79e4; /* Slightly darker gradient on hover */
            transform: scale(1.05);
        }

    </style>
    <script>
        function goBack() {
            window.history.back();
        }
    </script>
</head>
<body>
<div class="header">
    <div class="logo">
        <img src="resources/wod2.png" alt="Logo">
    </div>
    <div class="links">
        <a href="#">Zaloguj się</a>
        <a href="/home">Strona główna</a>
        <a href="#">Pomoc</a>
        <form action="/logout" method="post" id="logoutForm" style="display: none;">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
        <a href="javascript:formSubmit()">Wyloguj</a>
    </div>
</div>
<div class="container">
    <h2>Odmowa dostępu</h2>
    <p>Nie masz uprawnień do tego zasobu. Aby uzyskać dostęp, upewnij się że masz do nich prawo, a następnie skontaktuj się z administratorem.</p>
    <a href="javascript:void(0);" onclick="goBack()" class="check-permissions">Wróć</a>
    <br>
    <a href="/profile" class="check-permissions">Sprawdź swoje uprawnienia</a>
</div>
</body>
</html>
