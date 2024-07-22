<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
    <title>Rejestracja</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: "Roboto", sans-serif;
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
            outline: 2px solid #67105C; /* Added to remove default focus border */
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
            background: linear-gradient(135deg, #67105C, #220039); /* Modern gradient */
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
            color: white;
            text-align: center;
            padding: 1px 0;
            width: 100%; /* Full width */
            max-height: 50px; /* Minimal height */
            font-size: 12px;
        }

        .box h1 {
            font-family: 'Roboto', sans-serif; /* Apply new font */
            font-size: 36px;
            background: linear-gradient(135deg, #67105C, #8B008B); /* Gradient header with matching color */
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            color: transparent;
        }

        .box h2 {
            font-family: 'Roboto', sans-serif; /* Apply new font */
            font-size: 20px;
            background: linear-gradient(135deg, #67105C, #8B008B); /* Gradient header with matching color */
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            color: transparent;
            text-align: center; /* Center the text */
            margin-top: 5px;
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
            font-size: 12px;
            padding-top: 0;
            margin-top: 0;

        }

        .box .validation-td.active {
            height: auto;
            padding-top: 10px;
            margin-top: 10px; /* Dodaj odstęp */
            text-align: center;
            font-size: 13px;
            color: red;
        }

        .box input.error {
            outline: 2px solid red;
        }


        .box input.default-outline {
            outline: none;
        }

        .tooltip {
            position: absolute;
            background-color: rgba(0, 0, 0, 0.8);
            color: #fff; /* Biały tekst */
            border: 1px solid #ccc;
            padding: 10px; /* Większe odstępy */
            border-radius: 6px; /* Zaokrąglone rogi */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Lekki cień */
            z-index: 1000; /* Upewnij się, że tooltip jest na wierzchu */
            display: none;
            font-size: 14px; /* Większy rozmiar czcionki */
            transform: translateY(10px); /* Początkowe przesunięcie dla animacji */
            pointer-events: none; /* Wyłącz interakcje z tooltipem */
            max-width: 300px; /* Maksymalna szerokość */
        }


        .box select {
            width: 100%;
            box-shadow: none;
            padding: 12px; /* Increased padding for better spacing */
            box-sizing: border-box;
            border-radius: 5px;
            border: 1px solid #ccc;
            margin-top: 5px; /* Added margin between label and input */
            transition: border-color 0.3s ease, background-color 0.3s ease, color 0.3s ease;
            background-color: #f9f9f9; /* Default background color */
            outline: none;
            appearance: none; /* Removes default arrow in some browsers */
            -webkit-appearance: none; /* Removes default arrow in Webkit browsers */
            -moz-appearance: none; /* Removes default arrow in Firefox */
            background-image: url('resources/down.png'); /* Custom arrow icon */
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 25px;
            color: black; /* Default color for placeholder */
        }

        .box select:not(:placeholder-shown) {
            background-color: #E8EFFD; /* Color when input has valid content */
        }

        .box select.error {
            outline: 2px solid red;
        }


        .box select.default-outline {
            outline: none;
        }

        .box .input-phone input.error {
            outline: 2px solid red;
        }


        .box select:focus {
            outline: 2px solid #67105C; /* Added to remove default focus border */
        }

        .box select:not([value=""]) {
            background-color: #f9f9f9; /* Color when input has valid content */
        }

        .box select option[value=""] {
            color: black; /* Style for placeholder option */
        }

        .box .href_class{
            padding: 0px;
            margin: 0px;
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

            const inputs = document.querySelectorAll('.box input, .box textarea, .box select, .box .input-phone input');
            const form = document.getElementById('registration-form');
            const phoneNumberInput = document.querySelector('input[name="phoneNumber"]');
            const phonePrefixInput = document.querySelector('select[name="phonePrefix"]');

            form.addEventListener('submit', function(event) {
                updateValidationClasses();
            });

            phoneNumberInput.addEventListener('input', function() {
                let phoneNumber = phoneNumberInput.value.replace(/\D/g, ''); // Usuwamy wszystkie znaki nie będące cyframi
                let formattedPhoneNumber = '';

                // Formatowanie numeru: dodajemy spację po 3. i 6. cyfrze (jeśli jest to konieczne)
                for (let i = 0; i < phoneNumber.length; i++) {
                    if (i === 3 || i === 6) {
                        formattedPhoneNumber += ' ';
                    }
                    formattedPhoneNumber += phoneNumber.charAt(i);

                    // Zatrzymujemy dodawanie cyfr, jeśli osiągnęliśmy limit 9 cyfr
                    if (formattedPhoneNumber.replace(/\D/g, '').length >= 9) {
                        break;
                    }
                }

                phoneNumberInput.value = formattedPhoneNumber.trim(); // Ustawiamy sformatowany numer w polu input
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

            const passwordInput = document.getElementById('password');
            const tooltip = document.createElement('div');
            tooltip.className = 'tooltip';
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

                let tooltipContent = '<b>Wymagania hasła:</b><br>';
                let allValid = true;

                requirements.forEach(function(req) {
                    if (req.regex.test(value)) {
                        tooltipContent += '<span style="color: green;">✔️ ' + req.message + '</span><br>';
                    } else {
                        tooltipContent += '<span style="color: red;">❌ ' + req.message + '</span><br>';
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

            // Dodatkowe dla selectów
            const selects = document.querySelectorAll('.box select');
            selects.forEach(select => {
                select.addEventListener('change', function() {
                    if (select.value === "") {
                        select.style.backgroundColor = '#f9f9f9';
                        select.style.color = 'black';
                    } else {
                        select.style.backgroundColor = '#E8EFFD';
                        select.style.color = 'black';
                    }
                });
            });
        });

        function updateValidationClasses() {
            const phonePrefixInput = document.querySelector('select[name="phonePrefix"]');
            const phoneNumberInput = document.querySelector('input[name="phoneNumber"]');
            const validationFields = document.querySelectorAll('.validation-td');

            validationFields.forEach(field => {
                const input = field.closest('tr').previousElementSibling.querySelector('input, textarea, select');
                const validationIcon = input.closest('.input-wrapper').querySelector('.validation-icon');
                const validationIconPassword = input.closest('.input-wrapper').querySelector('.validation-icon-password');

                if (field.textContent.trim() !== '') {
                    if (input.name === 'phonePrefix' || input.name === 'phoneNumber') {
                        phonePrefixInput.classList.add('error');
                        phonePrefixInput.classList.remove('valid');
                        phoneNumberInput.classList.add('error');
                        phoneNumberInput.classList.remove('valid');
                    } else {
                        input.classList.add('error');
                        input.classList.remove('valid');
                    }
                    field.classList.add('active');
                    if (validationIcon) {
                        validationIcon.style.backgroundImage = 'url(resources/error.png)';
                        validationIcon.style.display = 'inline-block';
                    }
                    if (validationIconPassword) {
                        validationIconPassword.style.backgroundImage = 'url(resources/error.png)';
                        validationIconPassword.style.display = 'inline-block';
                    }
                } else {
                    if (input.name === 'phonePrefix' || input.name === 'phoneNumber') {
                        if (phonePrefixInput.value.trim() !== '' && phoneNumberInput.value.trim() !== '') {
                            phonePrefixInput.classList.remove('error');
                            phonePrefixInput.classList.add('valid');
                            phoneNumberInput.classList.remove('error');
                            phoneNumberInput.classList.add('valid');
                        } else {
                            phonePrefixInput.classList.remove('error', 'valid');
                            phonePrefixInput.classList.add('default-outline');
                            phoneNumberInput.classList.remove('error', 'valid');
                            phoneNumberInput.classList.add('default-outline');
                        }
                    } else {
                        input.classList.remove('error', 'valid');
                        input.classList.add('default-outline');
                    }
                    field.classList.remove('active');
                    if (validationIcon) {
                        validationIcon.style.backgroundImage = '';
                        validationIcon.style.display = 'none';
                    }
                    if (validationIconPassword) {
                        validationIconPassword.style.backgroundImage = '';
                        validationIconPassword.style.display = 'none';
                    }
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


    </script>
</head>
<body>
<div class="header">
    <div class="logo">
        <img src="resources/wod2.png" alt="Logo">
    </div>
    <div class="links">
        <a href="login">Zaloguj się</a>
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
                            <form:select path="department" class="box select">
                                <form:option value="" label="Wybierz dział" />
                                <form:option value="Dział 1" label="Dział 1" />
                                <form:option value="Dział 2" label="Dział 2" />
                                <form:option value="Dział 3" label="Dział 3" />
                                <form:option value="Dział 4" label="Dział 4" />
                            </form:select>
                            <span class="validation-icon-password"></span>
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
                        <form:label path="phonePrefix">Numer telefonu:</form:label>
                        <div class="input-wrapper" style="display: flex; align-items: center;">
                            <div style="flex: 1; margin-right: 1em;">
                                <form:select path="phonePrefix" style="width: 100%;">
                                    <form:option value="#" label=""/>
                                    <form:option value="+48" label="+48"/>
                                    <form:option value="+42" label="+42"/>
                                </form:select>
                                <span class="validation-icon"></span>
                            </div>
                            <div class="input-phone" style="flex: 4; position: relative;">
                                <form:input path="phoneNumber" type="text" placeholder="Numer Telefonu (123 123 123)" style="width: 100%;"/>
                                <span class="validation-icon-password" style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%);"></span>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="validation-td"><form:errors path="phonePrefix"/><form:errors path="phoneNumber"/></td

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
                        <h2><a href="#" class="href_class">Masz już konto? Kliknij aby się zalogować.</a></h2>
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
