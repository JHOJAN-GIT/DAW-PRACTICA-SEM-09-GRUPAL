<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%
    request.setAttribute("titulo", "Formulario");
    request.setAttribute("mainClass", "narrow");
%>
<%@ include file="/WEB-INF/layout/header.jspf" %>

        <div class="card centro">
            <h2>Registro de contacto</h2>
            <p class="sub">Completa el formulario para guardar el contacto.</p>

            <form class="contact-form" action="procesar.jsp" method="POST">
                <div class="field">
                    <label for="nombre">Nombre completo</label>
                    <input id="nombre" type="text" name="nombre" maxlength="100" placeholder="Ej: Juan Pérez" required>
                </div>
                <div class="field">
                    <label for="correo">Correo electrónico</label>
                    <input id="correo" type="email" name="correo" maxlength="150" placeholder="ejemplo@correo.com" required>
                </div>
                <button class="btn btn-block" type="submit">Enviar registro →</button>
            </form>
        </div>

<%@ include file="/WEB-INF/layout/footer.jspf" %>