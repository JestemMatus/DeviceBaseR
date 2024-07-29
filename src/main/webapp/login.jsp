<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap" rel="stylesheet">
    <style>
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
            background-color: white;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.4);
            text-align: center;
            width: 400px;
        }

        .box h1 {
            font-family: 'Roboto', sans-serif; /* Apply new font */

            font-size: 36px;
            background: linear-gradient(135deg, #67105C, #220039); /* Gradient header with matching color */
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            color: transparent;
        }

        .box .error {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
            color: #a94442;
            background-color: #f2dede;
            border-color: #ebccd1;
        }

        .box .msg {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
            color: #31708f;
            background-color: #d9edf7;
            border-color: #bce8f1;
        }

        .box .input-wrapper {
            position: relative;
            margin-bottom: 15px;
            text-align: left; /* Align labels and inputs to the left */
        }

        .box label {
            display: block;
            font-size: 14px;
            margin-bottom: 5px;
            font-family: 'Roboto', sans-serif; /* Apply new font */
            font-weight: 500; /* Slightly bolder weight for better readability */
            text-transform: uppercase; /* Uppercase for a modern look */
            letter-spacing: 0.5px; /* Slight spacing between letters */
            color: #4A4A4A; /* A darker shade of grey for better contrast */
            transition: color 0.3s ease; /* Smooth transition for color change */
        }

        .box label:hover {
            color: #67105C; /* Change color on hover for interactivity */
        }


        .box input[type="text"], .box input[type="password"] {
            width: 100%;
            padding: 12px;
            padding-left: 40px; /* Add padding to the left to make space for the icon */
            box-sizing: border-box;
            border-radius: 5px;
            border: 1px solid #ccc;
            margin-top: 5px;
            transition: border-color 0.3s ease, background-color 0.3s ease;
            background-color: #f9f9f9;
            outline: none;
        }

        .box input[type="text"]:focus, .box input[type="password"]:focus {
            outline: 2px solid #67105C;
        }

        .box input[type="submit"] {
            background: linear-gradient(135deg, #67105C, #220039);
            border: none;
            color: white;
            padding: 15px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 20px 0;
            cursor: pointer;
            border-radius: 12px;
            transition: background 0.3s ease, transform 0.3s ease;
            width: 100%;
        }

        .box input[type="submit"]:hover {
            background: linear-gradient(135deg, #5b79e4, #9561d2);
            transform: scale(1.05);
        }

        .footer {
            margin-top: 40px;
            color: white;
            text-align: center;
            padding: 1px 0;
            width: 100%;
            max-height: 50px;
            font-size: 12px;
        }

        .box a {
            display: block;
            margin: 20px 0;
            font-size: 20px;
            color: #67105C;
            text-decoration: none;
        }

        .box a:hover {
            text-decoration: underline;
        }

        .box #reload-td {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: auto;
        }

        .box .reload-image {
            margin: 0 10px;
            width: 35px;
            height: 35px;
            cursor: pointer;
            transition: transform 0.3s ease;
            margin-bottom: 10px;
            margin-top: -10px;
        }

        .box .reload-image:hover {
            transform: scale(1.1) rotate(90deg);
        }

        .box .reset-image {
            margin: 0 10px;
            width: 35px;
            height: 35px;
            cursor: pointer;
            transition: transform 0.3s ease;
            margin-bottom: 10px;
            margin-top: -10px;
        }

        .box .reset-image:hover {
            transform: scale(1.1);
        }

        .box h2 {
            font-family: 'Roboto', sans-serif; /* Apply new font */
            background: linear-gradient(135deg, #67105C, #220039); /* Gradient header with matching color */
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            color: transparent;
            text-align: center; /* Center the text */
            margin-top: 0;
            padding: 0;
        }

        .box table {
            margin: 0 auto;
        }

        .input-icon {
            position: absolute;
            left: 10px;
            top: 72%;
            transform: translateY(-50%);
            font-size: 20px;
            color: #555;
        }

        .box input[type="text"], .box input[type="password"] {
            padding-left: 45px; /* Add padding to the left to make space for the icon */
        }

        .input-icon img {
            width: 23px; /* Adjust the size of the icons */
            height: 23px;
            filter: grayscale(100%) brightness(180%);

        }

        .box .href_class{
            padding: 0px;
            margin: 0px;
        }

        .box .toggle-password{
            position: absolute;
            top: 52%;
            width: 25px; /* Adjust the size of the icons */
            height: 25px;
            right: 10px;
            cursor: pointer; /* Change cursor to pointer */

        }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            document.loginForm.login.focus();
        });

        function togglePasswordVisibility() {
            const passwordInput = document.getElementById('password');
            const togglePassword = document.getElementById('toggle-password');
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            togglePassword.src = type === 'password' ? 'resources/view_icon.png' : 'resources/hide_icon.png'; /* Change icon */
        }
    </script>
</head>
<body>
<div class="header">
    <div class="logo">
        <img src="resources/wod2.png" alt="Logo">
    </div>
    <div class="links">
        <a href="register">Zarejestruj się</a>
        <a href="/">Strona główna</a>
        <a href="/ComingSoon">Pomoc</a>
    </div>
</div>

<div class="content">
    <div class="box">
        <h1>Logowanie</h1>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        <c:if test="${not empty msg}">
            <div class="msg">${msg}</div>
        </c:if>

        <form name='loginForm' action="<c:url value='/login'/>" method='POST'>
            <div class="input-wrapper">
                <label for="login">Login:</label>
                <div class="input-icon">
                    <img src="resources/user.png" alt="Email Icon">
                </div>
                <input type='text' name='login' id='login' value='' placeholder="Wpisz swój login">
            </div>
            <div class="input-wrapper">
                <label for="password">Hasło:</label>
                <div class="input-icon">
                    <img src="resources/lock.png" alt="Password Icon">
                </div>
                <input type='password' name='password' id='password' placeholder="Wpisz swoje hasło">
                <div class="validation-icon-password">
                    <img src="resources/view_icon.png" alt="Show password" id="toggle-password" class="toggle-password" onclick="togglePasswordVisibility()"/>
                </div>
            </div>
            <input type="submit" value="Zaloguj">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        </form>

        <h2><a href="register" class="href_class">Nie masz jeszcze konta? Kliknij aby je utworzyć.</a></h2>
        <table>
            <tr>
                <td>
                    <div id="reload-td">
                        <img src="resources/reload1.png" class="reload-image" onclick="window.location.href='/login'">
                    </div>
                </td>
                <td>
                    <div id="reload-password">
                        <img src="resources/reset-password.png" class="reset-image" onclick="window.location.href='/login'">
                    </div>
                </td>
                <td>
                    <div id="help-td">
                        <img src="resources/mark.png" class="reset-image" onclick="window.location.href='/login'">
                    </div>
                </td>
            </tr>
        </table>
    </div>
</div>

<div class="footer">
    <p>&copy; <%= new SimpleDateFormat("EEEE, d MMMM yyyy", new Locale("pl", "PL")).format(new Date()) %> - Wszystkie prawa zastrzeżone</p>
</div>
</body>
</html>
