<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edytuj użytkownika</title>
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

        .form-table {
            width: 100%;
            margin: 0 auto;
        }

        .form-table td {
            padding: 10px;
        }

        .form-table td:first-child {
            text-align: left;
            padding-right: 20px;
            color: #67105C;
        }

        .form-table input, .form-table select {
            width: 100%;
            padding: 10px;
            border-radius: 10px;
            border: none;
            outline: 1px solid mediumpurple;
            font-size: 16px;
        }

        .form-table input:focus, .form-table select:focus {
            border: none;
            outline: 2px solid #67105C;
        }

        .submit-button {
            width: 100%;
            margin: 0 auto;
            display: block;
            padding: 15px 20px;
            background-color: #67105C;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .submit-button:hover {
            background: linear-gradient(135deg, #5b79e4, #9561d2);
        }

        .error {
            color: red;
            font-size: 12px;
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

        .footer {
            margin-top: 40px;
            color: white;
            text-align: center;
            padding: 10px 0;
            width: 100%;
            font-size: 12px;
        }

        .link-all {
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

        .link-all:hover {
            background-color: #67105C;
            color: white;
        }

        .link-password {
            display: block;
            text-align: center;
            font-size: 16px;
            color: #67105C;
            text-decoration: none;
            border: 1px solid #67105C;
            padding: 10px 20px;
            border-radius: 5px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .link-password:hover {
            background-color: #67105C;
            color: white;
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
        <h1>Edytuj użytkownika</h1>
        <form:form modelAttribute="userForm" method="post" action="${saveUrl}">
            <fieldset class="groupbox">
                <legend>Dane osobowe</legend>
                <table class="form-table">
                    <tr>
                        <td><strong>Imię: </strong></td>
                        <td>
                            <form:input path="firstName" autocomplete="given-name" />
                            <form:errors path="firstName" cssClass="error"/>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>Nazwisko: </strong></td>
                        <td>
                            <form:input path="lastName" autocomplete="family-name" />
                            <form:errors path="lastName" cssClass="error"/>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>Email: </strong></td>
                        <td>
                            <form:input path="email" autocomplete="email" />
                            <form:errors path="email" cssClass="error"/>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>Login: </strong></td>
                        <td>
                            <form:input path="login" autocomplete="username" />
                            <form:errors path="login" cssClass="error"/>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>Numer telefonu:</strong></td>
                        <td style="display: flex; gap: 10px;">
                            <form:select path="phonePrefix" style="width: auto;">
                                <form:option value="+42">+42</form:option>
                                <form:option value="+48">+48</form:option>
                            </form:select>
                            <form:input path="phoneNumber" autocomplete="tel-local" placeholder="Number" />
                            <form:errors path="telephoneNumber" cssClass="error"/>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <fieldset class="groupbox">
                <legend>Dane pracownika</legend>
                <table class="form-table">
                    <tr>
                        <td><strong>Dział:</strong></td>
                        <td>
                            <form:select path="department">
                                <form:options items="${departments}" itemValue="departmentName" itemLabel="departmentName"/>
                            </form:select>
                            <form:errors path="department" cssClass="error"/>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>Stanowisko:</strong></td>
                        <td>
                            <form:input path="workplace" autocomplete="organization-title" />
                            <form:errors path="workplace" cssClass="error"/>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <fieldset class="groupbox">
                <legend>Bezpieczeństwo</legend>
                <table class="form-table">
                    <tr>
                        <td><strong>Hasło:</strong></td>
                        <td><a href="<c:url value='/changeUserPassword/${userForm.id}'/>" class="link-password">Zmień hasło</a></td>
                    </tr>
                </table>
            </fieldset>
            <input type="submit" value="Zapisz" class="submit-button" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form:form>
        <a href="<c:url value='/users'/>" class="link-all">Powrót do listy użytkowników</a>
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
