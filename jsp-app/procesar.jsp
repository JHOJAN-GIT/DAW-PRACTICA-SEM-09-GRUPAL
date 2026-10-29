<%@ page import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%!
    // Prevención XSS: escapa los caracteres peligrosos antes de mostrarlos
    public String esc(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#x27;");
    }

    public boolean correoValido(String c) {
        return c != null && c.matches("^[\\w.+-]+@[\\w-]+(\\.[\\w-]+)+$");
    }
%>
<%
    // 1. Solo se acepta POST
    if (!"POST".equalsIgnoreCase(request.getMethod())) {
        response.setStatus(405);
        response.setHeader("Allow", "POST");
        out.println("Método no permitido");
        return;
    }

    // 2. Leer y limpiar parámetros
    request.setCharacterEncoding("UTF-8");
    String nombre = request.getParameter("nombre");
    String correo = request.getParameter("correo");
    nombre = (nombre == null) ? "" : nombre.trim();
    correo = (correo == null) ? "" : correo.trim();

    // 3. Validar
    List<String> errores = new ArrayList<>();
    if (nombre.isEmpty() || nombre.length() > 100) {
        errores.add("El nombre es obligatorio y no debe superar 100 caracteres.");
    }
    if (!correoValido(correo)) {
        errores.add("El correo no tiene un formato válido.");
    }

    if (!errores.isEmpty()) {
        response.setStatus(400);
        out.println("<h3>Datos inválidos</h3><ul>");
        for (String e : errores) {
            out.println("<li>" + esc(e) + "</li>");
        }
        out.println("</ul><a href='index.jsp'>Volver al formulario</a>");
        return;
    }

    // 4. Guardar en sesión
    HttpSession sesion = request.getSession();
    @SuppressWarnings("unchecked")
    List<Map<String, String>> registros = (List<Map<String, String>>) sesion.getAttribute("registros");
    if (registros == null) {
        registros = new ArrayList<>();
    }
    Map<String, String> nuevo = new HashMap<>();
    nuevo.put("nombre", nombre);
    nuevo.put("correo", correo);
    registros.add(nuevo);
    sesion.setAttribute("registros", registros);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Resultado | Registro JSP</title>
</head>
<body>
    <h3>Registros almacenados</h3>
    <table border="1">
        <tr>
            <th>Nombre</th>
            <th>Correo</th>
        </tr>
<%
    // 5. Respuesta estructurada: iterar con scriptlet
    for (Map<String, String> r : registros) {
%>
        <tr>
            <td><%= esc(r.get("nombre")) %></td>
            <td><%= esc(r.get("correo")) %></td>
        </tr>
<%
    }
%>
    </table>
    <br>
    <a href="index.jsp">Agregar otro registro</a>
</body>
</html>