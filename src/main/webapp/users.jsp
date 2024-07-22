<%@ page import="java.util.Locale" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Użytkownicy</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-image: url("/resources/back4.jpg");
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
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
            gap: 10px; /* Reduce gap between links */
        }

        .header .links a {
            color: white;
            text-decoration: none;
            padding: 8px 12px; /* Reduce padding */
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

        .content {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            width: 100%;
        }

        .box {
            background-color: white;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.4);
            text-align: center;
            width: 90%;
            max-width: 1400px;
            margin: 100px;
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
            background-color: #67105C;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .filter-box button:hover {
            background-color: #220039;
        }

        .filter-box .reload-image {
            width: 35px;
            height: 35px;
            cursor: pointer;
            transition: transform 0.3s ease;
            vertical-align: middle;
        }

        .filter-box .reload-image:hover {
            transform: scale(1.1) rotate(90deg);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 14px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #67105C;
            color: white;
            cursor: pointer;
            user-select: none;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .actions a {
            margin: 0 5px;
            color: #67105C;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .actions a:hover {
            color: #220039;
        }

        .footer {
            margin-top: 40px;
            color: white;
            text-align: center;
            padding: 10px 0;
            width: 100%;
            max-height: 50px;
            font-size: 12px;
            box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.1);
        }

        .box #filter-table {
            border-radius: 10px;
            padding: 15px;
            border: 0;
        }

        .box .filter-tr {
            margin: 5px;
            border: 0;
        }

        .box .filter-tr:hover {
            background-color: #f9f9f9;
        }

        .box .filter-td {
            margin: 5px;
            border: 0;
        }
    </style>
    <script>
        function resetFilters() {
            document.querySelectorAll('.filter-box input[type="text"]').forEach(input => input.value = '');
            document.querySelector('form').submit();
        }

        function sortTable(table, column, order) {
            const tbody = table.tBodies[0];
            const rows = Array.from(tbody.querySelectorAll('tr'));

            const sortedRows = rows.sort((a, b) => {
                const aText = a.querySelector(`td:nth-child(${column + 1})`).textContent.trim().toLowerCase();
                const bText = b.querySelector(`td:nth-child(${column + 1})`).textContent.trim().toLowerCase();

                return (aText > bText ? 1 : -1) * (order === 'asc' ? 1 : -1);
            });

            while (tbody.firstChild) {
                tbody.removeChild(tbody.firstChild);
            }

            tbody.append(...sortedRows);
        }

        document.addEventListener('DOMContentLoaded', () => {
            let sortOrder = 'asc';

            document.querySelectorAll('th').forEach((header, index) => {
                header.addEventListener('click', () => {
                    const table = header.closest('table');
                    sortTable(table, index, sortOrder);
                    sortOrder = sortOrder === 'asc' ? 'desc' : 'asc';
                });
            });
        });
        function formSubmit(){
            document.getElementById("logoutForm").submit();
        }
    </script>
</head>
<body>


<div class="header">
    <div class="logo">
        <img src="resources/wod.png" alt="Logo">
    </div>
    <div class="links">
        <a href="#">Zaloguj się</a>
        <a href="/home">Strona główna</a>
        <a href="#">Pomoc</a>
        <form action="/logout" method="post" id="logoutForm">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
        <a href="javascript:formSubmit()">Wyloguj</a>
    </div>
</div>
<div class="content">
    <div class="box">
        <h1>Użytkownicy</h1>
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
                <th>Login</th>
                <th>Imię</th>
                <th>Nazwisko</th>
                <th>Email</th>
                <th>Numer telefonu</th>
                <th>Dział</th>
                <th>Stanowisko pracy</th>
                <th>Actions</th>
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
                    <td class="actions">
                        <a href="<c:url value='/delete/${user.id}' />">Delete</a> |
                        <a href="<c:url value='/edit/${user.id}' />">Edit</a> |
                        <a href="<c:url value='/approve/${user.id}' />">Approve</a> |
                        <a href="<c:url value='/assignRole/${user.id}' />">Assign Role</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div class="footer">
    <p>&copy; <%= new SimpleDateFormat("EEEE, d MMMM yyyy", new Locale("pl", "PL")).format(new Date()) %> - Wszystkie prawa zastrzeżone</p>
</div>
</body>
</html>
