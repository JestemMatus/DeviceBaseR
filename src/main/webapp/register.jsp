<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
    <title>Rejestracja</title>
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
            padding: 30px 40px; /* Increased padding for better spacing */
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.4);
            text-align: center;
            width: 500px; /* Slightly increased width */
        }

        .box table {
            width: 100%;
            border-collapse: collapse;
            margin: 0 auto; /* Center the table horizontally */
        }

        .box td {
            padding: 20px 10px 0 10px; /* Added padding to top */
            position: relative; /* For the label positioning */
        }

        .box input[type="text"], .box input[type="password"], .box input[type="email"] {
            width: 100%;
            padding: 12px; /* Increased padding for better spacing */
            box-sizing: border-box;
            border-radius: 5px;
            border: 1px solid #ccc;
            margin-top: 5px; /* Added margin between label and input */
            transition: border-color 0.3s ease, background-color 0.3s ease;
            background-color: #f9f9f9; /* Default background color */
            outline: none;
        }

        .box input[type="text"]:focus, .box input[type="password"]:focus, .box input[type="email"]:focus {
            outline: 2px solid mediumpurple; /* Added to remove default focus border */
        }

        .box input[type="text"]:not(:placeholder-shown),
        .box input[type="password"]:not(:placeholder-shown),
        .box input[type="email"]:not(:placeholder-shown) {
            background-color: #E8EFFD; /* Color when input has valid content */
        }

        .box .input-wrapper {
            position: relative;
        }

        .box .validation-icon, .box .toggle-password, .box .validation-icon-password {
            position: absolute;
            top: 55%;
            transform: translateY(-50%);
            width: 24px;
            height: 24px;
            background-size: cover;
            background-repeat: no-repeat;
            cursor: pointer;
            transition: filter 0.3s ease;
        }

        .box .validation-icon {
            right: 10px;
            display: none; /* Ukrywamy ikonę domyślnie */
        }

        .box .validation-icon-password {
            right: 40px;
            display: none;
            top: 55%; /* Ensure both icons are vertically centered */
        }

        .box .toggle-password {
            right: 10px;
            top: 55%; /* Ensure both icons are vertically centered */
        }

        .box input.error + .validation-icon {
            display: inline-block;
            background-image: url('resources/error.png');
        }

        .box input.valid + .validation-icon {
            display: inline-block;
            background-image: url('resources/check.png');
        }

        .box input.default-outline + .validation-icon {
            display: none;
        }

        .box input.error ~ .validation-icon-password {
            display: inline-block;
            background-image: url('resources/error.png');
        }

        .box input.valid ~ .validation-icon-password {
            display: inline-block;
            background-image: url('resources/check.png');
        }

        .box input.default-outline ~ .validation-icon-password {
            display: none;
        }

        .box input[type="submit"] {
            background: linear-gradient(135deg, #6e8efb, #a777e3); /* Modern gradient */
            border: none;
            color: white;
            padding: 15px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 0 0; /* Uniform margin */
            cursor: pointer;
            border-radius: 12px;
            transition: background 0.3s ease, transform 0.3s ease;
            width: 100%;
        }

        .box input[type="submit"]:hover {
            background: linear-gradient(135deg, #5b79e4, #9561d2); /* Darker gradient on hover */
            transform: scale(1.05); /* Slightly larger on hover */
        }

        .footer {
            margin-top: 40px;
            color: black;
            text-align: center;
            padding: 1px 0;
            width: 100%; /* Full width */
            max-height: 50px; /* Minimal height */
            font-size: 12px;
        }

        .box h1 {
            font-size: 36px;
            background: linear-gradient(135deg, #6e8efb, #8B008B); /* Gradient header with matching color */
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            color: transparent;
        }

        .box h2 {
            font-size: 20px;
            background: linear-gradient(135deg, #6e8efb, #8B008B); /* Gradient header with matching color */
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            color: transparent;
            text-align: center; /* Center the text */
            margin-top: 5px;
        }

        .box label {
            display: block; /* Display label as block for better spacing */
            font-size: 12px; /* Adjust font size */
            color: mediumpurple;
            font-weight: bold;
        }

        .box #reload-td {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: auto;
        }

        .box .reload-image {
            width: 35px;
            height: 35px;
            cursor: pointer;
            transition: transform 0.3s ease;
            margin-bottom: 10px;
            margin-top: -10px;
        }

        .box .reload-image:hover {
            transform: scale(1.1) rotate(90deg); /* Slightly larger and rotate 90 degrees on hover */
        }

        .box #submit-td {
            padding: 10px;
            padding-top: 40px;
            margin: 5px;
        }

        .box .validation-td {
            color: red;
            height: 0;
            overflow: hidden;
            padding: 0;
            margin: 0;
            font-size: 12px;
            margin-top: 10px; /* Dodaj odstęp */

        }

        .box .validation-td.active {
            height: auto;
            padding: 2px 0; /* Adjust padding as necessary */
            margin-top: 10px; /* Dodaj odstęp */

        }

        .box input.error {
            outline: 2px solid red;
        }

        .box input.valid {
            outline: 2px solid green;
        }

        .box input.default-outline {
            outline: none;
        }



    </style>
    <script>
        function togglePasswordVisibility() {
            const passwordInput = document.getElementById('password');
            const togglePassword = document.getElementById('toggle-password');
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            togglePassword.style.backgroundImage = type === 'password' ? 'url(resources/view_icon.png)' : 'url(resources/hide_icon.png)';
        }

        document.addEventListener('DOMContentLoaded', function() {
            updateValidationClasses();

            const inputs = document.querySelectorAll('.box input, .box textarea, .box select');
            const form = document.getElementById('registration-form');

            form.addEventListener('submit', function(event) {
                updateValidationClasses();
            });

            inputs.forEach(input => {
                input.addEventListener('input', function() {
                    resetOutline(input);
                    const validationIcon = input.closest('.input-wrapper').querySelector('.validation-icon');
                    const validationIconPassword = input.closest('.input-wrapper').querySelector('.validation-icon-password');
                    if (validationIcon) validationIcon.style.display = 'none';
                    if (validationIconPassword) validationIconPassword.style.display = 'none';
                });

                input.addEventListener('focus', function() {
                    resetOutline(input);
                    const validationIcon = input.closest('.input-wrapper').querySelector('.validation-icon');
                    const validationIconPassword = input.closest('.input-wrapper').querySelector('.validation-icon-password');
                    if (validationIcon) validationIcon.style.display = 'none';
                    if (validationIconPassword) validationIconPassword.style.display = 'none';
                });

                input.addEventListener('blur', function() {
                    updateValidationClasses();
                });
            });

            document.querySelector('.reload-image').addEventListener('click', function() {
                window.location.href = '/register';
            });

            // Skrypt do sprawdzania hasła
            const passwordInput = document.getElementById('password');
            const tooltip = document.createElement('div');
            tooltip.style.position = 'absolute';
            tooltip.style.backgroundColor = 'white';
            tooltip.style.border = '1px solid #ccc';
            tooltip.style.padding = '5px';
            tooltip.style.borderRadius = '5px';
            tooltip.style.boxShadow = '0 0 5px rgba(0, 0, 0, 0.1)';
            tooltip.style.display = 'none';
            tooltip.style.fontSize = '12px';
            document.body.appendChild(tooltip);

            passwordInput.addEventListener('input', function() {
                const rect = passwordInput.getBoundingClientRect();
                tooltip.style.left = rect.left + window.scrollX + 'px';
                tooltip.style.top = rect.bottom + window.scrollY + 'px';

                const value = passwordInput.value;
                const requirements = [
                    { regex: /.{8,}/, message: 'Minimum 8 znaków' },
                    { regex: /[A-Z]/, message: 'Jedna wielka litera' },
                    { regex: /[a-z]/, message: 'Jedna mała litera' },
                    { regex: /\d/, message: 'Jedna cyfra' },
                    { regex: /[!@#\$%\^&\*]/, message: 'Jeden znak specjalny (!@#$%^&*)' }
                ];

                let tooltipContent = 'Wymagania hasła:<br>';
                let allValid = true;

                requirements.forEach(req => {
                    if (req.regex.test(value)) {
                        tooltipContent += `<span style="color: green;">✔️ ${req.message}</span><br>`;
                    } else {
                        tooltipContent += `<span style="color: red;">❌ ${req.message}</span><br>`;
                        allValid = false;
                    }
                });

                if (allValid) {
                    passwordInput.classList.add('valid');
                    passwordInput.classList.remove('error');
                } else {
                    passwordInput.classList.add('error');
                    passwordInput.classList.remove('valid');
                }

                tooltip.innerHTML = tooltipContent;
                tooltip.style.display = 'block';
            });

            passwordInput.addEventListener('blur', function() {
                tooltip.style.display = 'none';
            });
        });

        function updateValidationClasses() {
            const validationFields = document.querySelectorAll('.validation-td');
            validationFields.forEach(field => {
                const input = field.closest('tr').previousElementSibling.querySelector('input, textarea, select');
                const validationIcon = input.closest('.input-wrapper').querySelector('.validation-icon');
                const validationIconPassword = input.closest('.input-wrapper').querySelector('.validation-icon-password');
                if (field.textContent.trim() !== '') {
                    field.classList.add('active');
                    if (input) {
                        input.classList.add('error');
                        input.classList.remove('valid');
                        if (validationIcon) {
                            validationIcon.style.backgroundImage = 'url(resources/error.png)';
                            validationIcon.style.display = 'inline-block';
                        }
                        if (validationIconPassword) {
                            validationIconPassword.style.backgroundImage = 'url(resources/error.png)';
                            validationIconPassword.style.display = 'inline-block';
                        }
                    }
                } else {
                    field.classList.remove('active');
                    if (input && input.value.trim() !== '') {
                        input.classList.remove('error');
                        input.classList.add('valid');
                        if (validationIcon) {
                            validationIcon.style.backgroundImage = 'url(resources/check.png)';
                            validationIcon.style.display = 'inline-block';
                        }
                        if (validationIconPassword) {
                            validationIconPassword.style.backgroundImage = 'url(resources/check.png)';
                            validationIconPassword.style.display = 'inline-block';
                        }
                    } else {
                        input.classList.remove('error', 'valid');
                        input.classList.add('default-outline');
                        if (validationIcon) {
                            validationIcon.style.backgroundImage = '';
                            validationIcon.style.display = 'none';
                        }
                        if (validationIconPassword) {
                            validationIconPassword.style.backgroundImage = '';
                            validationIconPassword.style.display = 'none';
                        }
                    }
                }
            });
        }

        function resetValidationErrors() {
            const validationFields = document.querySelectorAll('.validation-td');
            validationFields.forEach(field => {
                field.classList.remove('active');
                field.innerHTML = '';
                const input = field.closest('tr').previousElementSibling.querySelector('input, textarea, select');
                const validationIcon = input.closest('.input-wrapper').querySelector('.validation-icon');
                const validationIconPassword = input.closest('.input-wrapper').querySelector('.validation-icon-password');
                if (input) {
                    input.classList.remove('error', 'valid');
                    input.classList.add('default-outline');
                    validationIcon.style.backgroundImage = '';
                    validationIcon.style.display = 'none';
                    validationIconPassword.style.backgroundImage = '';
                    validationIconPassword.style.display = 'none';
                }
            });
        }

        function resetOutline(input) {
            input.classList.remove('error', 'valid');
            input.classList.add('default-outline');
            const validationIcon = input.closest('.input-wrapper').querySelector('.validation-icon');
            const validationIconPassword = input.closest('.input-wrapper').querySelector('.validation-icon-password');
            if (validationIcon) validationIcon.style.backgroundImage = '';
            if (validationIconPassword) validationIconPassword.style.backgroundImage = '';
            if (validationIcon) validationIcon.style.display = 'none';
            if (validationIconPassword) validationIconPassword.style.display = 'none';
        }
    </script></head>
<body>
<div class="header">
    <div class="logo">
        <img src="resources/wod.png" alt="Logo">
    </div>
    <div class="links">
        <a href="#">Zaloguj się</a>
        <a href="/">Strona główna</a>
        <a href="#">Pomoc</a>
    </div>
</div>

<div class="content">
    <div class="box">
        <h1><b>Rejestracja</b></h1>
        <form:form id="registration-form" method="post" action="addAppUser" modelAttribute="register">
            <table>
                <tr>
                    <td colspan="10">
                        <form:label path="firstName">Imię:</form:label>
                        <div class="input-wrapper">
                            <form:input path="firstName" type="text" placeholder="Imię"/>
                            <span class="validation-icon"></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="validation-td"><form:errors path="firstName"/></td>
                </tr>
                <tr>
                    <td colspan="10">
                        <form:label path="lastName">Nazwisko:</form:label>
                        <div class="input-wrapper">
                            <form:input path="lastName" type="text" placeholder="Nazwisko"/>
                            <span class="validation-icon"></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="validation-td"><form:errors path="lastName"/></td>
                </tr>
                <tr>
                    <td colspan="10">
                        <form:label path="login">Login:</form:label>
                        <div class="input-wrapper">
                            <form:input path="login" type="text" placeholder="Login"/>
                            <span class="validation-icon"></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="validation-td"><form:errors path="login"/></td>
                </tr>
                <tr>
                    <td colspan="10">
                        <form:label path="email">Adres email:</form:label>
                        <div class="input-wrapper">
                            <form:input path="email" type="email" placeholder="Adres email"/>
                            <span class="validation-icon"></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="validation-td"><form:errors path="email"/></td>
                </tr>
                <tr>
                    <td colspan="10">
                        <form:label path="department">Dział:</form:label>
                        <div class="input-wrapper">
                            <form:input path="department" type="text" placeholder="Dział"/>
                            <span class="validation-icon"></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="validation-td"><form:errors path="department"/></td>
                </tr>
                <tr>
                    <td colspan="10">
                        <form:label path="workplace">Stanowisko pracy:</form:label>
                        <div class="input-wrapper">
                            <form:input path="workplace" type="text" placeholder="Stanowisko pracy"/>
                            <span class="validation-icon"></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="validation-td"><form:errors path="workplace"/></td>
                </tr>
                <tr>
                    <td colspan="10">
                        <form:label path="telephoneNumber">Numer telefonu:</form:label>
                        <div class="input-wrapper">
                            <form:input path="telephoneNumber" type="text" placeholder="Numer Telefonu"/>
                            <span class="validation-icon"></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="validation-td"><form:errors path="telephoneNumber"/></td>
                </tr>
                <tr>
                    <td colspan="10">
                        <form:label path="password">Hasło:</form:label>
                        <div class="password-wrapper input-wrapper">
                            <form:input path="password" id="password" type="password" placeholder="Hasło"/>
                            <span class="validation-icon-password"></span>
                            <span id="toggle-password" class="toggle-password" onclick="togglePasswordVisibility()" style="background-image: url('resources/view_icon.png');"></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="validation-td"><form:errors path="password"/></td>
                </tr>
                <tr>
                    <td colspan="10" id="submit-td">
                        <input type="submit" value="Zarejestruj się"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="10">
                        <h2><a href="#">Masz już konto? Kliknij aby się zalogować.</a></h2>
                    </td>
                </tr>
                <tr>
                    <td id="reload-td" colspan="1">
                        <img src="resources/reload1.png" class="reload-image" onclick="window.location.href='/register'">
                    </td>
                </tr>
            </table>
        </form:form>
    </div>
</div>

<div class="footer">
    <p>&copy; <%= new SimpleDateFormat("EEEE, d MMMM yyyy", new Locale("pl", "PL")).format(new Date()) %> - Wszystkie prawa zastrzeżone</p>
</div>
</body>
</html>
