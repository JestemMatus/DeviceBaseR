<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
  <title>Zmień hasło</title>
  <link href="<c:url value='/resources/css/scrollToTop.css' />" rel="stylesheet">
  <link href="<c:url value='/resources/css/goBack.css' />" rel="stylesheet">
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
      padding: 20px;
      color: #fff;
    }

    .header {
      width: 100%;
      background: rgba(0, 0, 0, 0.5);
      color: white;
      padding: 10px 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-size: 18px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      position: fixed;
      top: 0;
      left: 50%;
      transform: translateX(-50%);
      z-index: 1000;
      backdrop-filter: blur(10px);
      border-bottom: 2px solid rgba(255, 255, 255, 0.3);
    }

    .header .links {
      display: flex;
      gap: 10px;
      align-items: center;
    }

    .header .links a {
      color: white;
      text-decoration: none;
      padding: 5px 10px;
      border-radius: 5px;
      transition: background-color 0.3s ease, color 0.3s ease, box-shadow 0.3s ease;
      background: rgba(255, 255, 255, 0.1);
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

    .content {
      flex: 1;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      width: 80%;
      margin: 0 auto;
      margin-top: 100px;
      padding: 20px;
    }

    .box {
      background-color: #fff;
      padding: 30px;
      border-radius: 20px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
      width: 100%;
      max-width: 700px;
      color: #67105C;
    }

    .box h1 {
      font-size: 32px;
      color: #67105C;
      margin-bottom: 20px;
      text-align: center;
    }

    .box form {
      display: flex;
      flex-direction: column;
    }

    .box form .input-wrapper {
      position: relative;
      margin-bottom: 15px;
    }

    .box form input[type="password"] {
      width: 100%;
      padding: 10px;
      font-size: 16px;
      border: 1px solid #ddd;
      border-radius: 5px;
      padding-right: 40px; /* Space for the icon */
      transition: border-color 0.3s ease;
    }

    .box form input[type="text"] {
      width: 100%;
      padding: 10px;
      font-size: 16px;
      border: 1px solid #ddd;
      border-radius: 5px;
      padding-right: 40px; /* Space for the icon */
      transition: border-color 0.3s ease;
    }

    .box form .toggle-password {
      position: absolute;
      top: 50%;
      right: 10px;
      transform: translateY(-50%);
      cursor: pointer;
      width: 25px;
      height: 25px;
    }

    .box form button {
      padding: 10px;
      font-size: 16px;
      background-color: #67105C;
      color: #fff;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .box form button:hover {
      background-color: #5b0e4c;
    }

    .error-message {
      color: red;
      margin-bottom: 15px;
    }

    .footer {
      margin-top: 40px;
      color: white;
      text-align: center;
      padding: 10px 0;
      width: 100%;
      font-size: 12px;
    }

    .tooltip {
      position: absolute;
      background-color: rgba(0, 0, 0, 0.8);
      color: #fff;
      border: 1px solid #ccc;
      padding: 10px;
      border-radius: 6px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
      z-index: 1000;
      display: none;
      font-size: 14px;
      pointer-events: none;
      max-width: 300px;
      top: calc(100% + 5px); /* Odstęp od góry */
      left: 0;
    }

  </style>
  <script>
    document.addEventListener('DOMContentLoaded', function() {
      const passwordInput = document.getElementById('newPassword');
      const tooltip = document.getElementById('passwordTooltip');

      passwordInput.addEventListener('input', function() {
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
    });


    function togglePasswordVisibility(inputId, toggleId) {
      const passwordInput = document.getElementById(inputId);
      const togglePassword = document.getElementById(toggleId);
      const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
      passwordInput.setAttribute('type', type);
      togglePassword.src = type === 'password' ? '/resources/view_icon.png' : '/resources/hide_icon.png';
    }

    function formSubmit() {
      document.getElementById('logoutForm').submit();
    }
  </script>
</head>
<body>
<div class="header">
  <div class="logo">
    <img src="<c:url value='/resources/wod2.png' />" alt="Logo">
  </div>
  <div class="links">
    <a href="#">Zaloguj się</a>
    <a href="/home">Strona główna</a>
    <a href="/ComingSoon">Pomoc</a>
    <form action="/logout" method="post" id="logoutForm" style="display: none;">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </form>
    <a href="javascript:formSubmit()">Wyloguj</a>
  </div>
</div>

<div class="content">
  <div class="box">
    <h1>Zmień hasło</h1>
    <form action="<c:url value='/changePassword' />" method="post">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
      </c:if>
      <div class="input-wrapper">
        <input type="password" name="oldPassword" id="oldPassword" placeholder="Stare hasło" required />
        <img src="/resources/view_icon.png" alt="Show password" id="toggle-oldPassword" class="toggle-password" onclick="togglePasswordVisibility('oldPassword', 'toggle-oldPassword')" />
      </div>
      <div class="input-wrapper">
        <input type="password" name="newPassword" id="newPassword" placeholder="Nowe hasło" required />
        <img src="/resources/view_icon.png" alt="Show password" id="toggle-newPassword" class="toggle-password" onclick="togglePasswordVisibility('newPassword', 'toggle-newPassword')" />
        <div id="passwordTooltip" class="tooltip"></div>
      </div>
      <button type="submit">Zmień hasło</button>
    </form>
  </div>
</div>

<div class="footer">
  <p>&copy; <%= new SimpleDateFormat("EEEE, d MMMM yyyy", new Locale("pl", "PL")).format(new Date()) %> - Wszystkie prawa zastrzeżone</p>
</div>
<script>
  function formSubmit() {
    document.getElementById('logoutForm').submit();
  }
</script>
</body>
</html>


