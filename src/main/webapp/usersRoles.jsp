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
    <title>Przydziel role</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap" rel="stylesheet">
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
            width: 80%;
            margin: 0 auto;
            margin-top: 60px;
            background-color: rgba(255,255,255, 0.2);
            border-radius: 20px;
        }

        .box {
            background-color: whitesmoke;
            color: #67105C;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.4);
            margin-bottom: 20px;
            margin-top: 0;
            padding-top: 0;
            width: 100%;
            max-width: 930px;
            flex: 1;
        }

        .box-1{
            background-color: whitesmoke;
            color: #67105C;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.4);
            margin-bottom: 20px;
            margin-top: 0;
            padding-top: 0;
            width: 100%;
            max-width: 400px;
            flex: 1;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 14px;
            background: rgba(255, 255, 255, 0.9); /* Jasne tło dla tabeli */
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.4); /* Lżejszy cień */
            border-radius: 10px; /* Dodaj border-radius bezpośrednio do tabeli */
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
            color: #fff;
        }

        label, select, button {
            display: block;
            width: 100%;
            margin: 5px 0;
            padding: 5px;
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

        .box input[type="text"], .box input[type="password"], .box-1 input[type="text"], .box-1 input[type="password"] {
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

        .box input[type="text"]:focus, .box-1 input[type="text"]:focus {
            outline: 2px solid #67105C;
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
            width: 90%; /* Szerokość, aby uwzględnić odstępy między boxami */
            max-width: calc(1620px); /* Maksymalna szerokość dla szerokości dwóch formularzy razem */
            flex: 1 1 100%;
            margin: 0 auto; /* Wyśrodkowanie */
            margin-bottom: 30px;
        }

        .box-fline {
            background-color: whitesmoke;
            color: #67105C;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.4);
            margin-bottom: 20px;
            margin-top: 60px;
            padding-top: 0;
            min-height: 120px;
            max-width: calc(1620px);
            width: 90%;
            flex: 1;
            position: relative; /* Add this line */
            height: 100%;
            max-height: 100px;
            display: flex;
            align-items: center; /* Wyśrodkowanie pionowe */
            justify-content: center;
        }

        .box-fline h1 {
            padding-top: 15px;
            color: #67105C;
            text-align: center; /* Center the text */
            margin: 0 auto;
        }


        .form-container {
            display: flex;
        }

        .box {
            margin-right: 5px; /* Odstęp między sekcjami */
        }

        .box:last-child {
            margin-right: 0; /* Usuń margines z ostatniego boxa */
        }


        form div {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        form label {
            margin-left: 10px;
            margin-top: 2px;
            margin-bottom: 2px;
            font-weight: 500;
            color: #67105C;
        }

        input[type="checkbox"] {
            width: 20px;
            height: 20px;
            margin: 0;
            padding: 0;
            accent-color: #67105C; /* nowoczesny kolor checkboxa */
        }

        button {
            width: 100%;
            background: linear-gradient(135deg, #67105C, #220039);
            color: white;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.3s ease;
            padding: 15px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
        }

        button:hover {
            background: linear-gradient(135deg, #5b79e4, #9561d2);
            transform: scale(1.05);
        }

        h3 {
            padding: 0;
            margin-top: 15px;
            margin-bottom: 5px;
            font-size: 20px;
        }

        #userTable {
            width: 100%;
            border-collapse: collapse;
            border-radius: 10px;
            overflow: hidden;
            table-layout: fixed;
        }

        #userTable thead {
            position: sticky;
            top: 0;
            z-index: 1;
            background-color: #67105C; /* Kolor tła nagłówka */
            color: white;
        }

        #userTable tbody {
            display: block;
            max-height: 398px;
            overflow-y: auto;
        }

        #userTable thead, #userTable tbody tr {
            display: table;
            width: 100%;
            table-layout: fixed;
        }

        #userTable td, #userTable th {
            text-align: center;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        #userTable th:nth-child(1), #userTable td:nth-child(1) { width: 12%; }
        #userTable th:nth-child(2), #userTable td:nth-child(2) { width: 18%; }
        #userTable th:nth-child(3), #userTable td:nth-child(3) { width: 16%; }
        #userTable th:nth-child(4), #userTable td:nth-child(4) { width: 30%; }
        #userTable th:nth-child(5), #userTable td:nth-child(5) { width: 22%; }

        #userTable th:nth-child(6) { width: 2%; }

        #rolesTable {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            font-size: 14px;
            background: rgba(255, 255, 255, 0.9); /* Jasne tło dla tabeli */
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.4); /* Lżejszy cień */
            border-radius: 10px; /* Dodaj border-radius bezpośrednio do tabeli */
            overflow: hidden;
        }

        #rolesTable thead {
            position: sticky;
            top: 0;
            z-index: 1;
            background-color: #67105C; /* Kolor tła nagłówka */
            color: white;
        }

        #rolesTable tbody {
            display: block;
            max-height: 200px; /* Ustal maksymalną wysokość dla tbody */
            overflow-y: auto;
        }

        #rolesTable thead, #rolesTable tbody tr {
            display: table;
            width: 100%;
            table-layout: fixed;
        }

        #rolesTable th, #rolesTable td {
            padding-left: 15px; /* Zwiększenie paddingu dla lepszej czytelności */
            padding-right: 15px;
            padding-top: 5px;
            padding-bottom: 5px;
            text-align: center;
        }

        #rolesTable th {
            background-color: #67105C; /* Użycie ciemniejszego koloru tła dla nagłówków */
            color: white;
            font-weight: 500;
            cursor: pointer;
            user-select: none;
            padding: 15px;
            text-align: center;
        }

        #rolesTable td {
            background: #ffffff; /* Jasne tło dla komórek */
            color: #333; /* Ciemniejszy tekst dla lepszej czytelności */
        }

        #rolesTable tr:nth-child(even) td {
            background: #f0f0f0; /* Kontrastujące, ale jasne tło dla co drugiego wiersza */
        }

        #rolesTable tr:hover td {
            background: #e0e0e0; /* Kolor tła wiersza po najechaniu */
        }

        #rolesTable th:nth-child(1), #rolesTable td:nth-child(1) { width: 13%; }
        #rolesTable th:nth-child(2), #rolesTable td:nth-child(2) { width: 85%; }
        #rolesTable th:nth-child(3) { width: 2%; }

        .filter-input {
            width: 100%;
            max-width: 300px;
            padding: 10px;
            margin: 0 auto 20px auto; /* Wyśrodkowanie pola i margines dolny */
            display: block;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            font-size: 16px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .filter-input:focus {
            border-color: #67105C;
            box-shadow: 0 0 10px rgba(103, 16, 92, 0.5);
            outline: none;
        }


    </style>
    <script src="<c:url value='/resources/js/goBack.js' />"></script>
    <script src="<c:url value='/resources/js/ScrollToTop.js' />"></script>
    <script>
        function back(){
            window.location.href = "/home"
        }

        function loadUserRoles(element) {
            const userId = element.getAttribute('data-user-id');
            const userName = element.getAttribute('data-user-name');
            const roles = element.getAttribute('data-roles').split(',').map(Number);

            document.getElementById("userId").value = userId;
            document.getElementById("userName").value = userName;
            const checkboxes = document.querySelectorAll('input[type="checkbox"][name="roles"]');
            checkboxes.forEach(checkbox => {
                checkbox.checked = roles.includes(parseInt(checkbox.value));
            });

            document.getElementById("submitButton").disabled = false;
        }

        function formSubmit() {
            document.getElementById("logoutForm").submit();
        }

        // Filtrowanie użytkowników
        document.addEventListener('DOMContentLoaded', function() {
            const filterInput = document.querySelector('.filter-input');

            filterInput.addEventListener('keyup', function() {
                const filterValue = filterInput.value.toLowerCase();
                const rows = document.querySelectorAll('#userTable tbody tr');
                rows.forEach(row => {
                    const cells = row.querySelectorAll('td');
                    const match = Array.from(cells).some(cell => cell.textContent.toLowerCase().includes(filterValue));
                    row.style.display = match ? '' : 'none';
                });
            });

            // Sortowanie po nagłówkach
            const headers = document.querySelectorAll('#userTable th');
            headers.forEach((header, index) => {
                header.addEventListener('click', function() {
                    const tableBody = document.querySelector('#userTable tbody');
                    const rows = Array.from(tableBody.querySelectorAll('tr'));
                    const isAscending = header.classList.contains('asc');
                    const direction = isAscending ? -1 : 1;

                    headers.forEach(th => th.classList.remove('asc', 'desc'));
                    header.classList.toggle('asc', !isAscending);
                    header.classList.toggle('desc', isAscending);

                    rows.sort((a, b) => {
                        const cellA = a.children[index].textContent.trim().toLowerCase();
                        const cellB = b.children[index].textContent.trim().toLowerCase();

                        if (cellA < cellB) return -1 * direction;
                        if (cellA > cellB) return 1 * direction;
                        return 0;
                    });

                    rows.forEach(row => tableBody.appendChild(row));
                });
            });
        });


    </script>

</head>
<body>
<div class="header">
    <div class="logo">
        <img src="resources/wod2.png" alt="Logo">
    </div>
    <div class="links">
        <a href="">Zaloguj się</a>
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
        <h1>Przydziel uprawnienia</h1>
    </div>

    <div class="form-container">
        <!-- Sekcja 1: Tabela z użytkownikami -->
        <div class="box">
            <h2>Lista użytkowników</h2>
            <input type="text" class="filter-input" placeholder="Filtruj użytkowników">
            <table id="userTable">
                <thead>
                <tr>
                    <th>Imię</th>
                    <th>Nazwisko</th>
                    <th>Login</th>
                    <th>Role</th>
                    <th>Akcje</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td><c:out value="${user.firstName}" /></td>
                        <td><c:out value="${user.lastName}" /></td>
                        <td><c:out value="${user.login}" /></td>
                        <td>
                            <c:forEach var="role" items="${user.appUserRole}" varStatus="status">
                                <c:out value="${role.role}" />
                                <c:if test="${!status.last}"> | </c:if>
                            </c:forEach>
                        </td>
                        <td class="actions">
                            <a href="#"
                               data-user-id="${user.id}"
                               data-user-name="${user.firstName} ${user.lastName}"
                               data-roles="<c:forEach var='role' items='${user.appUserRole}' varStatus='status'>${role.id}<c:if test='${!status.last}'>,</c:if></c:forEach>"
                               onclick="loadUserRoles(this)">Edytuj</a>
                            <a href="/ComingSoon">Więcej</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Sekcja 2: Formularz do edycji roli użytkownika -->
        <div class="box-1">
            <h2>Edytuj uprawnienia użytkownika</h2>
            <form action="<c:url value='/updateUserRoles' />" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" id="userId" name="userId" />
                <h3><label for="userName">Nazwa użytkownika:</label></h3>
                <input type="text" id="userName" name="userName" readonly />
                <h3><label>Dostępne uprawnienia:</label></h3>
                <div class="roles-container">
                    <table id="rolesTable">
                        <thead>
                        <tr>
                            <th>Wybierz</th>
                            <th>Uprawnienie</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="role" items="${allRoles}">
                            <tr>
                                <td>
                                    <input type="checkbox" id="role_${role.id}" name="roles" value="${role.id}" />
                                </td>
                                <td>
                                    <label for="role_${role.id}"><c:out value="${role.role}" /></label>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <button type="submit" id="submitButton" disabled>Zatwierdź</button>
            </form>
        </div>

    </div>
</div>
<div class="top-class">
    <button type="button" onclick="ScrollToTop()">
        <img src="resources/up.png" alt="Top" class="top-image">
    </button>
</div>
<div class="back-div">
    <button type="button" onclick="goBack()">Cofnij</button>
</div>
<div class="footer">
    <p>&copy; <%= new SimpleDateFormat("EEEE, d MMMM yyyy", new Locale("pl", "PL")).format(new Date()) %> - Wszystkie prawa zastrzeżone</p>
</div>
</body>
</html>
