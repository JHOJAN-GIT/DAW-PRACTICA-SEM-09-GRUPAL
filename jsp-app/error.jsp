<%@ page isErrorPage="true" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Error</title>
</head>
<body>
    <h2>Ocurrió un error</h2>
    <p>Código HTTP: <%= request.getAttribute("jakarta.servlet.error.status_code") %></p>
    <a href="index.jsp">Volver al inicio</a>
</body>
</html>