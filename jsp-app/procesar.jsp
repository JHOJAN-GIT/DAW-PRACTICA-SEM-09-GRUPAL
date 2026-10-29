<%@ page import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%!
    // Prevención XSS: escapa caracteres peligrosos antes de mostrarlos
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
    // 1. Solo se acepta POST (405 mediante error-page de web.xml)
    if (!"POST".equalsIgnoreCase(request.getMethod())) {
        response.setHeader("Allow", "POST");
        response.sendError(405, "Método no permitido");
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

    // 4. Guardar en sesión (solo si es válido)
    List<Map<String, String>> registros = null;
    if (errores.isEmpty()) {
        HttpSession sesion = request.getSession();
        @SuppressWarnings("unchecked")
        List<Map<String, String>> existentes = (List<Map<String, String>>) sesion.getAttribute("registros");
        registros = (existentes != null) ? existentes : new ArrayList<>();

        Map<String, String> nuevo = new HashMap<>();
        nuevo.put("nombre", nombre);
        nuevo.put("correo", correo);
        registros.add(nuevo);
        sesion.setAttribute("registros", registros);
    } else {
        response.setStatus(400);
    }

    request.setAttribute("titulo", errores.isEmpty() ? "Registros" : "Datos inválidos");
    request.setAttribute("mainClass", errores.isEmpty() ? "wide" : "narrow");
%>
<%@ include file="/WEB-INF/layout/header.jspf" %>

<% if (!errores.isEmpty()) { %>
        <div class="card centro">
            <div class="alert alert-error">
                <h2>Datos inválidos</h2>
                <ul>
                <% for (String e : errores) { %>
                    <li><%= esc(e) %></li>
                <% } %>
                </ul>
            </div>
            <a class="btn btn-ghost btn-block" href="index.jsp">← Volver al formulario</a>
        </div>
<% } else { %>
        <div class="card">
            <h2>Registros almacenados</h2>
            <p class="sub">Los datos permanecen en la sesión mientras el navegador esté abierto.</p>

            <div class="alert alert-ok">Registro guardado correctamente.</div>

            <div class="stats">
                <div class="stat">
                    <b data-count="<%= registros.size() %>"><%= registros.size() %></b>
                    <span>Registros</span>
                </div>
            </div>

            <table>
                <thead>
                    <tr><th>#</th><th>Nombre</th><th>Correo</th></tr>
                </thead>
                <tbody>
                <% int i = 1; for (Map<String, String> r : registros) { %>
                    <tr>
                        <td><%= i++ %></td>
                        <td><%= esc(r.get("nombre")) %></td>
                        <td><%= esc(r.get("correo")) %></td>
                    </tr>
                <% } %>
                </tbody>
            </table>

            <br>
            <a class="btn" href="index.jsp">+ Agregar otro registro</a>
        </div>
<% } %>

<%@ include file="/WEB-INF/layout/footer.jspf" %>