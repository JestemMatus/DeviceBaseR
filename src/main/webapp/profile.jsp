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

        .groupbox {
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 20px;
            background-color: #f9f9f9;
            color: #333;
        }

        .groupbox legend {
            padding: 0 10px;
            font-size: 18px;
            color: #67105C;
            font-weight: bold;
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
            padding-left: 10px;

        }

        .profile-item span {
            font-size: 16px;
            flex: 1;
            text-align: left;
            padding-left: 10px;
        }

        .profile-item .edit-icon {
            width: 16px;
            height: 16px;
            cursor: pointer;
            margin-left: 10px;
            transition: transform 0.3s ease;
        }

        .profile-item .edit-icon:hover {
            transform: scale(1.2);
        }

        .roles {
            margin-top: 20px;
            color: #67105C;
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

        .toogle-form {
            text-align: left;
            margin-top: 15px;
            padding: 0;
        }

        .toogle-form input{
            max-width: 250px;
            width: 100%;
            padding: 10px;
            border-radius: 10px;
            border: none;
            outline: 1px solid mediumpurple;
            font-size: 16px;
        }

        .toogle-form select{
            max-width: 250px;
            width: 100%;
            padding: 10px;
            border-radius: 10px;
            border: none;
            outline: 1px solid mediumpurple;
            font-size: 16px;
        }

        .toogle-form select:focus{
            border: none;
            outline: 2px solid #67105C;
        }

        .toogle-form .submit-button {
            width: 100%;
            max-width: 250px;
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

        <fieldset class="groupbox">
            <legend>Dane konta</legend>
            <div class="profile-item">
                <strong>Imię:</strong>
                <span><c:out value="${user.firstName}"/></span>
            </div>
            <div class="profile-item">
                <strong>Nazwisko:</strong>
                <span><c:out value="${user.lastName}"/> </span>
            </div>
            <div class="profile-item">
                <strong>Email:</strong>
                <span>
                    <c:out value="${user.email}"/>
                    <img src="<c:url value='/resources/edit-icon.png' />" alt="Edytuj" class="edit-icon" onclick="toggleEdit('email')" />
                    <form:form modelAttribute="emailForm" method="post" action="/editEmail" class="toogle-form" style="display: none;" id="email-form">
                        <form:input path="email" type="email" value="${user.email}" />
                        <button type="submit" class="submit-button" >Zapisz</button>
                    </form:form>
                </span>
            </div>
            <div class="profile-item">
                <strong>Login:</strong>
                <span>
                    <c:out value="${user.login}"/>
                    <img src="<c:url value='/resources/edit-icon.png' />" alt="Edytuj" class="edit-icon" onclick="toggleEdit('login')" />
                    <form:form modelAttribute="loginForm" method="post" action="/editLogin" class="toogle-form" style="display: none;" id="login-form">
                        <form:input path="login" type="text" value="${user.login}" />
                        <button type="submit" class="submit-button">Zapisz</button>
                    </form:form>
                </span>
            </div>
            <div class="profile-item">
                <strong>Numer telefonu:</strong>
                <span>
                    <c:out value="${user.telephoneNumber}"/>
                    <img src="<c:url value='/resources/edit-icon.png' />" alt="Edytuj" class="edit-icon" onclick="toggleEdit('phoneNumber')" />
                    <form:form modelAttribute="phoneForm" method="post" action="/editPhoneNumber" class="toogle-form" style="display: none;" id="phoneNumber-form">
                        <form:input path="phonePrefix" type="text" class="toogle-form" value="${user.phonePrefix}" placeholder="Prefix" />
                        <form:input path="phoneNumber" type="text" class="toogle-form" value="${user.phoneNumber}" placeholder="Numer" />
                        <button type="submit" class="submit-button">Zapisz</button>
                    </form:form>
                </span>
            </div>
        </fieldset>

        <!-- Dane Pracownicze -->
        <fieldset class="groupbox">
            <legend>Dane pracownika</legend>
            <div class="profile-item">
                <strong>Dział:</strong>
                <span>
                    <c:out value="${user.department}"/>
                    <img src="<c:url value='/resources/edit-icon.png' />" alt="Edytuj" class="edit-icon" onclick="toggleEdit('department')" />
                    <form:form method="post" action="/editDepartment" class="toogle-form" style="display: none;" id="department-form">
                        <select name="department">
                            <option value="IT">IT</option>
                            <option value="HR">HR</option>
                            <option value="Marketing">Marketing</option>
                            <option value="Sales">Sales</option>
                        </select>
                        <button type="submit" class="submit-button">Zapisz</button>
                    </form:form>
                </span>
            </div>
            <div class="profile-item">
                <strong>Stanowisko pracy:</strong>
                <span>
                    <c:out value="${user.workplace}"/>
                    <img src="<c:url value='/resources/edit-icon.png' />" alt="Edytuj" class="edit-icon" onclick="toggleEdit('workplace')" />
                    <form:form modelAttribute="workplaceForm" method="post" action="/editWorkplace" class="toogle-form" style="display: none;" id="workplace-form">
                        <form:input path="workplace" type="text" value="${user.workplace}" />
                        <button type="submit" class="submit-button">Zapisz</button>
                    </form:form>
                </span>
            </div>
        </fieldset>

        <!-- Role -->
        <fieldset class="groupbox">
            <legend>Uprawnienia</legend>
            <div class="profile-item">
                <strong>Uwierzytelnione:</strong>
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
                        <li><strong>- <c:out value="${role.role}"/></strong></li>
                    </c:forEach>
                </ul>
            </div>
        </fieldset>
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

    function toggleEdit(field) {
        var form = document.getElementById(field + '-form');
        var display = form.style.display;
        form.style.display = display === 'none' ? 'block' : 'none';
    }
</script>
</body>
</html>
