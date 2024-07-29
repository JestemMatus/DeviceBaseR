<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zarządzaj rolami użytkowników</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap" rel="stylesheet">
    <link href="<c:url value='/resources/css/scrollToTop.css' />" rel="stylesheet">

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

        h1 {
            text-align: center;
            color: #fff;
            margin-top: 40px; /* Adjust margin to account for fixed header */
        }

        h2 {
            text-align: center;
            color: #67105C;
        }

        .content {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            width: 90%;
            margin: 0 auto;
            margin-top: 60px;
            background-color: rgba(255,255,255, 0.2);
            border-radius: 20px;
        }

        .box {
            background-color: white;
            color: #67105C;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.4);
            margin-bottom: 20px;
            margin-top: 0;
            padding-top: 0;
            width: 100%;
            max-width: 800px;
            flex: 1;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 14px;
            background: rgba(255, 255, 255, 0.9); /* Jasne tło dla tabeli */
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.4); /* Lżejszy cień */
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 15px; /* Zwiększenie paddingu dla lepszej czytelności */
            text-align: left;
        }

        th {
            background-color: #67105C; /* Użycie ciemniejszego koloru tła dla nagłówków */
            color: white;
            font-weight: 500;
            cursor: pointer;
            user-select: none;
        }

        td {
            background: #ffffff; /* Jasne tło dla komórek */
            color: #333; /* Ciemniejszy tekst dla lepszej czytelności */
        }

        tr:nth-child(even) td {
            background: #f0f0f0; /* Kontrastujące, ale jasne tło dla co drugiego wiersza */
        }

        tr:hover td {
            background: #e0e0e0; /* Kolor tła wiersza po najechaniu */
        }

        .actions a {
            margin: 0 5px;
            color: #5b79e4;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .actions a:hover {
            color: #9561d2;
        }


        a {
            color: #5b79e4; /* Kolor linków */
            text-decoration: none;
        }

        a:hover {
            color: #9561d2; /* Kolor linków po najechaniu */
            text-decoration: underline;
        }


        form {
            background: rgba(255, 255, 255, 0.2);
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.4);
            margin-bottom: 20px;
            color: #fff;
        }

        label, select, button {
            display: block;
            width: 100%;
            margin: 10px 0;
            padding: 10px;
        }

        label {
            color: #67105C;
        }

        select, button {
            border-radius: 10px;
            border: none;
            font-size: 16px;
        }

        select {
            width: 100%;
            padding: 12px;
            padding-left: 5px; /* Add padding to the left to make space for the icon */
            box-sizing: border-box;
            border-radius: 5px;
            border: 1px solid #ccc;
            transition: border-color 0.3s ease, background-color 0.3s ease;
            background-color: #f9f9f9;
            outline: none;
            margin-top: 0;
        }

        select:focus{
            outline: 2px solid #67105C;
        }

        .box input[type="text"], .box input[type="password"] {
            width: 100%;
            padding: 12px;
            padding-left: 5px; /* Add padding to the left to make space for the icon */
            box-sizing: border-box;
            border-radius: 5px;
            border: 1px solid #ccc;
            transition: border-color 0.3s ease, background-color 0.3s ease;
            background-color: #f9f9f9;
            outline: none;
            margin-top: 0;
        }

        .box input[type="text"]:focus {
            outline: 2px solid #67105C;
        }

        button {
            background: linear-gradient(135deg, #67105C, #220039);
            color: white;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.3s ease;
        }

        button:hover {
            background: linear-gradient(135deg, #5b79e4, #9561d2);
            transform: scale(1.05);
        }

        .footer {
            color: white;
            text-align: center;
            padding: 10px 0;
            width: 100%;
            font-size: 14px;
            bottom: 0;
            left: 0;
            z-index: 999;
        }

        /* Dodanie marginesu na dole treści strony */
        .content {
            padding-bottom: 1px; /* Dodanie miejsca dla stopki */
        }


        .form-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
            width: 100%;
        }

        .role-box {
            width: 100%; /* Szerokość, aby uwzględnić odstępy między boxami */
            max-width: calc(1620px); /* Maksymalna szerokość dla szerokości dwóch formularzy razem */
            flex: 1 1 100%;
            margin: 0 auto; /* Wyśrodkowanie */
            margin-bottom: 30px;
        }

        .box-fline {
            background-color: white;
            color: #67105C;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.4);
            margin-bottom: 20px;
            margin-top: 30px;
            padding-top: 0;
            max-width: calc(1620px);
            width: 100%;
            flex: 1;
            position: relative; /* Add this line */
        }

        .box-fline h1 {
            color: #67105C;
            text-align: center; /* Center the text */
        }

        .back-div {
            position: absolute;
            top: 50%; /* Center vertically */
            left: 20px; /* Adjust the right position as needed */
            transform: translateY(-50%); /* Center vertically */
            background-color: whitesmoke;
            padding: 10px 20px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.4);
            max-width: 180px;
            width: 100%;
        }

        .error-box {
            width: 97%;
            background-color: white;
            color: red;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.4);
            margin-bottom: 20px;
        }



    </style>

    <script>
        function ScrollToTop(){
            console.log("ScrollToTop function called");
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }

        function back(){
            window.location.href = "/home"
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
        <a href="/ComingSoon">Pomoc</a>
        <form action="/logout" method="post" id="logoutForm" style="display: none;">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
        <a href="javascript:formSubmit()">Wyloguj</a>
    </div>
</div>

<div class="content">
    <div class="box-fline">
        <h1>Zarządzaj rolami użytkowników</h1>
        <div class="back-div">
            <button onclick="back()">Cofnij</button>
        </div>
    </div>

    <div class="form-container">
        <div class="box">
            <h2>Dodaj nową rolę</h2>
            <form action="<c:url value='/addAppUserRole' />" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <label for="newRole">Nazwa roli:</label>
                <input type="text" id="newRole" name="role" />
                <button type="submit">Dodaj rolę</button>
            </form>
            <h3>Pamiętaj, aby nazwa roli zaczynała się od przedrostka "ROLE_" i była zapisana wielkimi literami.</h3>
        </div>

        <div class="box">
            <h2>Edytuj rolę</h2>
            <form action="<c:url value='/updateRole' />" method="post" id="editField">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <label for="roleDropdown">Wybierz rolę:</label>
                <select id="roleDropdown" name="role" onchange="showEditField()">
                    <option value="">--Wybierz rolę--</option>
                    <c:forEach var="role" items="${roles}">
                        <option value="${role.role}"><c:out value="${role.role}" /></option>
                    </c:forEach>
                </select>
                <label for="newRole">Nazwa roli:</label>
                <input type="text" id="newRole" name="newRole" />
                <button type="submit">Edytuj rolę</button>
            </form>
        </div>

    </div>

    <div class="box role-box">
        <h2>Istniejące role</h2>
        <table>
            <tr>
                <th>Nazwa roli</th>
                <th>Akcje</th>
            </tr>
            <c:forEach var="role" items="${roles}">
                <tr>
                    <td><c:out value="${role.role}" /></td>
                    <td>
                        <a href="<c:url value='/deleteRole/${role.id}' />">Usuń</a>
                        <a href="/ComingSoon">Szczegóły</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <c:if test="${not empty error}">
        <div class="error-box">
            <p><c:out value="${error}" /></p>
        </div>
    </c:if>
    <div class="top-class">
        <button onclick="ScrollToTop()">
            <img src="resources/up.png" alt="Top" class="top-image">
        </button>
    </div>
</div>

<div class="footer">
    <p>&copy; <%= new SimpleDateFormat("EEEE, d MMMM yyyy", new Locale("pl", "PL")).format(new Date()) %> - Wszystkie prawa zastrzeżone</p>
</div>
</body>
</html>
