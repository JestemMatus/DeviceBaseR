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
    <title>Permission Management</title>
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
            margin-top: 60px;
            background-color: rgba(255,255,255, 0.2);
            border-radius: 20px;
        }

        .box {
            background-color: whitesmoke;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.4);
            text-align: center;
            width: 90%;
            max-width: 1400px;
            margin: 30px;
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

        #updateButton {
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

        #updateButton:hover {
            background: linear-gradient(135deg, #5b79e4, #9561d2);
            transform: scale(1.05);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
            background: rgba(255, 255, 255, 0.9); /* Lighter background for table */
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.5); /* Lighter shadow */
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 15px; /* Increase padding for better readability */
            text-align: left;
        }

        th {
            background-color: #67105C; /* Darker background for headers */
            color: white;
            font-weight: 500;
            user-select: none;
            text-align: center;
            text-decoration: none;
        }

        td {
            background: #ffffff; /* Light background for cells */
            color: #333; /* Darker text for better readability */
            max-width: 100px; /* Max width for cell */
            overflow: hidden; /* Hide overflow text */
            text-overflow: ellipsis; /* Ellipsis at the end */
            white-space: nowrap; /* No text wrapping */
            text-align: center;
        }

        .checked-td{
            width: 50px;
        }

        .endpoint-td {
            width: 250px;
        }

        tr:nth-child(even) td {
            background: #f0f0f0; /* Alternating background for rows */
        }

        tr:hover td {
            background: #e0e0e0; /* Background color for row on hover */
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

        a {
            text-decoration: none;
            color: #333;
            font-size: 12px;
        }

        .box-fline {
            background-color: whitesmoke;
            color: #67105C;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.4);
            margin-top: 60px;
            padding-top: 0;
            width: 90%;
            flex: 1;
            max-height: 120px;
            height: 100%;
            position: relative; /* Add this line */
        }

        .box-fline h1 {
            padding-top: 20px;
            color: #67105C;
            text-align: center; /* Center the text */
        }

        .table-wrapper {
            width: 100%;
            border-radius: 10px;
            overflow: hidden;
            table-layout: fixed;
            margin-top: 0;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);

        }

        .table-wrapper thead {
            position: sticky;
            top: 0;
            z-index: 1;
            background-color: #67105C; /* Kolor tła nagłówka */
            color: white;
        }

        .table-wrapper tbody {
            display: block;
            max-height: 300px;
            overflow-y: auto;
        }

        .table-wrapper thead, .table-wrapper tbody tr {
            display: table;
            width: 100%;
            table-layout: fixed;
        }

        .table-wrapper td, .table-wrapper th {
            text-align: center;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .table-wrapper th:nth-child(1), .table-wrapper td:nth-child(1) { width: 10%; }
        .table-wrapper th:nth-child(2), .table-wrapper td:nth-child(2) { width: 30%; }
        .table-wrapper th:nth-child(3), .table-wrapper td:nth-child(3) { width: 38%; }
        .table-wrapper th:nth-child(4), .table-wrapper td:nth-child(4) { width: 20%; }
        .table-wrapper th:nth-child(5), .table-wrapper td:nth-child(5) { width: 2%; }


    </style>
    <script src="<c:url value='/resources/js/goBack.js' />"></script>
    <script src="<c:url value='/resources/js/ScrollToTop.js' />"></script>
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
        <h1>Zarządzanie dostępem</h1>
    </div>
    <div class="box">
        <form action="${pageContext.request.contextPath}/permission-management" method="get">
            <div class="filter-box">
                <table>
                    <tr>
                        <th>Wybierz rolę</th>
                    </tr>
                    <tr>
                        <td>
                            <select name="roleId" onchange="this.form.submit()">
                                <c:forEach var="role" items="${roles}">
                                    <option value="${role.id}" <c:if test="${role.id == selectedRoleId}">selected</c:if>>${role.role}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
        <form action="${pageContext.request.contextPath}/permission-management/update" method="post">
            <input type="hidden" name="roleId" value="${selectedRoleId}" />
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <div id="endpointTable" class="${selectedRoleId == null ? 'hidden' : ''}">
                <h3>Przypisane uprawnienia</h3>
                <div class="table-wrapper">
                    <table>
                        <thead>
                        <tr>
                            <th class="checked-td">Aktywne</th>
                            <th class="endpoint-td">Uprawnienie</th>
                            <th class="description-td">Opis</th>
                            <th class="checked-td">Akcje</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="endpoint" items="${endpoints}">
                            <tr>
                                <td class="checked-td">
                                    <input type="checkbox" name="endpointIds" value="${endpoint.id}" <c:if test="${fn:contains(assignedEndpoints, endpoint.id)}">checked</c:if> />
                                </td>
                                <td class="endpoint-td">${endpoint.label}</td>
                                <td class="description-td">${endpoint.description}</td>
                                <td class="checked-td"><a href="/ComingSoon">Więcej</a> </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
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

            <input type="submit" value="Aktualizuj uprawnienia" class="${selectedRoleId == null ? 'hidden' : ''}" id="updateButton"/>
        </form>
    </div>
</div>

<div class="footer">
    <p>&copy; <%= new SimpleDateFormat("EEEE, d MMMM yyyy", new Locale("pl", "PL")).format(new Date()) %> - Wszystkie prawa zastrzeżone</p>
</div>
</body>
</html>
