<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Odmowa dostępu</title>
    <!-- Import Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Roboto', sans-serif;
            background-color: #F1F0FF;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #4A4A4A;
        }

        .container {
            text-align: center;
            background-color: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            max-width: 500px;
            width: 100%;
        }

        h2 {
            font-size: 24px;
            color: #a94442; /* Slightly dark red to highlight the error */
            margin-bottom: 20px;
        }

        p {
            font-size: 16px;
            margin-bottom: 20px;
        }

        .check-permissions {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 16px;
            color: white;
            background-color: #6e8efb; /* Gradient starting color */
            background-image: linear-gradient(135deg, #6e8efb, #a777e3); /* Gradient */
            border: none;
            border-radius: 5px;
            text-decoration: none;
            transition: background 0.3s ease, transform 0.3s ease;
        }

        .check-permissions:hover {
            background-color: #5b79e4; /* Slightly darker gradient on hover */
            transform: scale(1.05);
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Odmowa dostępu</h2>
    <p>Nie masz uprawnień do tego zasobu. Aby uzyskać dostęp, sprawdź swoje uprawnienia lub skontaktuj się z administratorem.</p>
    <a href="#" class="check-permissions">Sprawdź swoje uprawnienia</a>
</div>
</body>
</html>
