<%@ page import="java.util.Locale" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.Map" %>

<html>
<head>
    <title>Użytkownicy</title>
    <link href="<c:url value='/resources/css/scrollToTop.css' />" rel="stylesheet">
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

        .content {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            width: 80%;
            margin: 0 auto;
            margin-top: 60px;
            background-color: rgba(255,255,255, 0.2);
            border-radius: 20px;

        }

        .box {
            background-color: white;
            padding: 30px 40px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.4);
            text-align: center;
            width: 100%;
            margin: 50px;
            border-radius: 20px;
        }

        .box h1 {
            font-size: 36px;
            color: #67105C;
            margin-bottom: 20px;
        }

        .filter-box {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            margin-bottom: 20px;
        }

        .filter-box table {
            width: 100%;
            border-spacing: 10px;
        }

        .filter-box th, .filter-box td {
            padding: 5px;
        }

        .filter-box label {
            color: #67105C;
            font-weight: bold;
        }

        .filter-box input[type="text"], .filter-box select, .filter-box button {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            width: 100%;
            box-sizing: border-box;
        }

        .filter-box button {
            margin-top: 30px;
            margin-bottom: 0;
            background: linear-gradient(135deg, #67105C, #220039);
            color: white;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.3s ease;
            border-radius: 10px;
            border: none;
            font-size: 16px;
            display: block;
            width: 100%;
            padding: 10px;
        }

        .filter-box button:hover {
            background: linear-gradient(135deg, #5b79e4, #9561d2);
            transform: scale(1.05);
        }

        .filter-box .reload-image {
            width: 35px;
            height: 35px;
            cursor: pointer;
            transition: transform 0.3s ease;
            vertical-align: middle;
            margin-top: 30px;
            margin-bottom: 0;
        }

        .filter-box .reload-image:hover {
            transform: scale(1.1) rotate(90deg);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            font-size: 14px;
            background: rgba(255, 255, 255, 0.9); /* Jasne tło dla tabeli */
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2); /* Lżejszy cień */
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
            user-select: none;
            text-align: center;
            text-decoration: none;
        }

        th a{
            cursor: pointer;
        }

        td {
            background: #ffffff; /* Jasne tło dla komórek */
            color: #333; /* Ciemniejszy tekst dla lepszej czytelności */
            max-width: 100px; /* Maksymalna szerokość komórki */
            overflow: hidden; /* Ukrywanie nadmiaru tekstu */
            text-overflow: ellipsis; /* Trzy kropki na końcu */
            white-space: nowrap; /* Nie zawijaj tekstu */
            text-align: center;
        }

        tr:nth-child(even) td {
            background: #f0f0f0; /* Kontrastujące, ale jasne tło dla co drugiego wiersza */
        }

        tr:hover td {
            background: #e0e0e0; /* Kolor tła wiersza po najechaniu */
        }

        .actions {
            min-width: 200px;
            font-size: 14px;
        }

        .actions .action-group {
            display: flex;
            justify-content: center;
            margin-bottom: 5px; /* Dodatkowy odstęp między grupami */
        }

        .actions .action-group:last-child {
            margin-bottom: 0; /* Usuń odstęp po ostatniej grupie */
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



        .footer {
            margin-top: 40px;
            color: white;
            text-align: center;
            padding: 10px 0;
            width: 100%;
            max-height: 50px;
            font-size: 12px;
        }

        .box #filter-table {
            padding: 15px;
            border: 0;
            background-color: #f9f9f9;
            box-shadow: none;
        }

        .box .filter-tr {
            margin: 5px;
            border: 0;
            background-color: #f9f9f9;

        }

        .box .filter-tr:hover {
            background-color: #f9f9f9;

        }

        .box .filter-td {
            margin: 5px;
            border: 0;
            background-color: #f9f9f9;

        }

        .box-fline {
            background-color: #f9f9f9;
            color: #67105C;
            padding: 35px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.4);
            margin-bottom: 20px;
            margin-top: 0;
            max-width: calc(1620px);
            width: 100%;
            flex: 1;
            position: relative;
            display: flex; /* Add this line */
            align-items: center; /* Add this line */
            justify-content: center; /* Optional: Add this line to center horizontally */
        }

        .box-fline h1 {
            color: #67105C;
            text-align: center;
            margin: 0; /* Remove margin */
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

        .icon-true {
            color: green;
        }

        .icon-false {
            color: red;
        }

        a {
            color: white;
            text-decoration: none;
        }


    </style>
    <script src="<c:url value='/resources/js/ScrollToTop.js' />"></script>
    <script>
        let sortDirection = {}; // To keep track of sorting direction for each column

        function back() {
            window.location.href = "/home";
        }

        function resetFilters() {
            document.querySelectorAll('.filter-box input[type="text"]').forEach(input => input.value = '');
            document.querySelector('form').submit();
        }

        function formSubmit() {
            document.getElementById("logoutForm").submit();
        }

        // Skrypt do przywracania scrolla po odświeżeniu strony
        document.addEventListener("DOMContentLoaded", function(event) {
            var scrollPosition = localStorage.getItem("scrollPosition");
            if (scrollPosition) {
                window.scrollTo(0, scrollPosition);
                localStorage.removeItem("scrollPosition");
            }
        });

        window.addEventListener("beforeunload", function(event) {
            localStorage.setItem("scrollPosition", window.scrollY);
        });

        // Funkcja do sortowania tabeli
        function sortTable(n, isNumeric = false) {
            const table = document.getElementById("userTable");
            const rows = Array.prototype.slice.call(table.rows, 1);
            const currentDir = sortDirection[n] || "asc";
            const newDir = currentDir === "asc" ? "desc" : "asc";

            rows.sort((a, b) => {
                const x = isNumeric ? parseFloat(a.cells[n].innerText) : a.cells[n].innerText.toLowerCase();
                const y = isNumeric ? parseFloat(b.cells[n].innerText) : b.cells[n].innerText.toLowerCase();

                if (newDir === "asc") {
                    return x > y ? 1 : x < y ? -1 : 0;
                } else {
                    return x < y ? 1 : x > y ? -1 : 0;
                }
            });

            rows.forEach(row => table.appendChild(row));
            sortDirection[n] = newDir; // Save the new sorting direction
        }

        function confirmAction(actionUrl, message) {
            if (confirm(message)) {
                window.location.href = actionUrl;
            }
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
    <div class="box">
        <div class="box-fline">
            <h1>Użytkownicy</h1>
            <div class="back-div">
                <button onclick="back()">Cofnij</button>
            </div>
        </div>
        <div class="filter-box">
            <form method="get" action="${pageContext.request.contextPath}/users" id="filterForm">
                <table id="filter-table">
                    <tr class="filter-tr">
                        <td class="filter-td"><label for="login">Login:</label></td>
                        <td class="filter-td"><input type="text" name="login" id="login" placeholder="Login" value="${param.login}"/></td>
                        <td class="filter-td"><label for="firstName">Imię:</label></td>
                        <td class="filter-td"><input type="text" name="firstName" id="firstName" placeholder="Imię" value="${param.firstName}"/></td>
                        <td class="filter-td"><label for="lastName">Nazwisko:</label></td>
                        <td class="filter-td"><input type="text" name="lastName" id="lastName" placeholder="Nazwisko" value="${param.lastName}"/></td>
                    </tr>
                    <tr class="filter-tr">
                        <td class="filter-td"><label for="email">Email:</label></td>
                        <td class="filter-td"><input type="text" name="email" id="email" placeholder="Email" value="${param.email}"/></td>
                        <td class="filter-td"><label for="telephoneNumber">Numer telefonu:</label></td>
                        <td class="filter-td"><input type="text" name="telephoneNumber" id="telephoneNumber" placeholder="Numer telefonu" value="${param.telephoneNumber}"/></td>
                        <td class="filter-td"><label for="department">Dział:</label></td>
                        <td class="filter-td"><input type="text" name="department" id="department" placeholder="Dział" value="${param.department}"/></td>
                    </tr>
                    <tr class="filter-tr">
                        <td class="filter-td"><label for="workplace">Stanowisko pracy:</label></td>
                        <td class="filter-td"><input type="text" name="workplace" id="workplace" placeholder="Stanowisko pracy" value="${param.workplace}"/></td>
                    </tr>
                    <tr class="filter-tr">
                        <td colspan="2" class="filter-td"></td>
                        <td class="filter-td" colspan="2">
                            <button type="submit">Filtruj</button>
                        </td>
                        <td class="filter-td">
                            <img src="resources/reload1.png" class="reload-image" onclick="resetFilters()">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <table id="userTable">
            <thead>
            <tr>
                <th><a href="javascript:sortTable(0)">Login</a></th>
                <th><a href="javascript:sortTable(1)">Imię</a></th>
                <th><a href="javascript:sortTable(2)">Nazwisko</a></th>
                <th><a href="javascript:sortTable(3)">Email</a></th>
                <th><a href="javascript:sortTable(4)">Numer telefonu</a></th>
                <th><a href="javascript:sortTable(5)">Dział</a></th>
                <th><a href="javascript:sortTable(6)">Stanowisko pracy</a></th>
                <th><a href="javascript:sortTable(7)">Aktywny</a></th>
                <th>Akcje</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="user" items="${users}">
                <tr>
                    <td><c:out value="${user.login}" /></td>
                    <td><c:out value="${user.firstName}" /></td>
                    <td><c:out value="${user.lastName}" /></td>
                    <td><c:out value="${user.email}" /></td>
                    <td><c:out value="${user.telephoneNumber}" /></td>
                    <td><c:out value="${user.department}" /></td>
                    <td><c:out value="${user.workplace}" /></td>
                    <td>
                        <c:choose>
                            <c:when test="${user.enabled}">
                                <span class="icon-true">✔️</span>
                            </c:when>
                            <c:otherwise>
                                <span class="icon-false">❌</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="actions">
                        <div class="action-group">
                            <a href="javascript:confirmAction('<c:url value='/delete/${user.id}' />', 'Czy na pewno chcesz usunąć tego użytkownika?')">Usuń</a> |
                            <a href="<c:url value='/edit/${user.id}' />">Edytuj</a> |
                            <a href="javascript:confirmAction('<c:url value='/approve/${user.id}' />', 'Czy na pewno chcesz aktywować tego użytkownika?')">Aktywuj</a>
                        </div>
                        <div class="action-group">
                            <a href="javascript:confirmAction('<c:url value='/deactivate/${user.id}' />', 'Czy na pewno chcesz dezaktywować tego użytkownika?')">Dezaktywuj</a> |
                            <a href="<c:url value='/usersRoles' />">Role</a> |
                            <a href="<c:url value='/assignRole/${user.id}' />">Więcej</a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
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
