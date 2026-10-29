<%@ page isErrorPage="true" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%
    request.setAttribute("titulo", "Error");
    request.setAttribute("mainClass", "narrow");
    Object codigo = request.getAttribute("jakarta.servlet.error.status_code");
%>
<%@ include file="/WEB-INF/layout/header.jspf" %>

        <div class="card centro">
            <div class="alert alert-error">
                <h2>Error <%= codigo %></h2>
                <p>La petición no pudo procesarse. Revisa el método o la dirección e inténtalo de nuevo.</p>
            </div>
            <a class="btn btn-ghost btn-block" href="index.jsp">← Volver al inicio</a>
        </div>

<%@ include file="/WEB-INF/layout/footer.jspf" %>