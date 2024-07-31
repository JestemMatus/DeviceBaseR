<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <title>Profil Użytkownika</title>
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

        .profile-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
        }

        .profile-item:last-child {
            border-bottom: none;
        }

        .profile-item strong {
            color: #67105C;
            min-width: 150px;
            display: inline-block;
            font-size: 16px;
        }

        .profile-item span {
            font-size: 16px;
            flex: 1;
            text-align: left;
        }

        .profile-item .edit-icon {
            width: 20px;
            height: 20px;
            cursor: pointer;
            margin-left: 10px;
            transition: transform 0.3s ease;
        }

        .profile-item .edit-icon:hover {
            transform: scale(1.2);
        }

        .roles {
            margin-top: 20px;
        }

        .roles ul {
            list-style: none;
            padding: 0;
        }

        .roles li {
            background: #f3f3f3;
            padding: 5px 10px;
            border-radius: 5px;
            margin: 5px 0;
        }

        .change-password-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            font-size: 16px;
            color: #67105C;
            text-decoration: none;
            border: 1px solid #67105C;
            padding: 10px 20px;
            border-radius: 5px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .change-password-link:hover {
            background-color: #67105C;
            color: white;
        }

        .footer {
            margin-top: 40px;
            color: white;
            text-align: center;
            padding: 10px 0;
            width: 100%;
            font-size: 12px;
        }
    </style>
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
        <h1>Profil Użytkownika</h1>
        <div class="profile-item">
            <strong>Imię:</strong>
            <span><c:out value="${user.firstName}"/> <img src="<c:url value='/resources/edit-icon.png' />" alt="Edytuj" class="edit-icon" /></span>
        </div>
        <div class="profile-item">
            <strong>Nazwisko:</strong>
            <span><c:out value="${user.lastName}"/> <img src="<c:url value='/resources/edit-icon.png' />" alt="Edytuj" class="edit-icon" /></span>
        </div>
        <div class="profile-item">
            <strong>Email:</strong>
            <span><c:out value="${user.email}"/> <img src="<c:url value='/resources/edit-icon.png' />" alt="Edytuj" class="edit-icon" /></span>
        </div>
        <div class="profile-item">
            <strong>Login:</strong>
            <span><c:out value="${user.login}"/> <img src="<c:url value='/resources/edit-icon.png' />" alt="Edytuj" class="edit-icon" /></span>
        </div>
        <div class="profile-item">
            <strong>Dział:</strong>
            <span><c:out value="${user.department}"/> <img src="<c:url value='/resources/edit-icon.png' />" alt="Edytuj" class="edit-icon" /></span>
        </div>
        <div class="profile-item">
            <strong>Miejsce pracy:</strong>
            <span><c:out value="${user.workplace}"/> <img src="<c:url value='/resources/edit-icon.png' />" alt="Edytuj" class="edit-icon" /></span>
        </div>
        <div class="profile-item">
            <strong>Numer telefonu:</strong>
            <span><c:out value="${user.telephoneNumber}"/> <img src="<c:url value='/resources/edit-icon.png' />" alt="Edytuj" class="edit-icon" /></span>
        </div>
        <div class="profile-item">
            <strong>Aktywny:</strong>
            <span>
                <c:choose>
                    <c:when test="${user.enabled}">
                        <span class="icon-true">✔️</span>
                    </c:when>
                    <c:otherwise>
                        <span class="icon-false">❌</span>
                    </c:otherwise>
                </c:choose>
            </span>
        </div>
        <div class="roles">
            <strong>Uprawnienia:</strong>
            <ul>
                <c:forEach var="role" items="${userRoles}">
                    <li><c:out value="${role.role}"/></li>
                </c:forEach>
            </ul>
        </div>
        <a href="/changePassword" class="change-password-link">Zmień hasło</a>
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
