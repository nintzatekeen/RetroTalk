<%-- 
    Document   : registro
    Created on : 28-feb-2021, 14:20:54
    Author     : ACER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!--IMPORTACIÓN DEL HEADER-->
<jsp:include page="header.jsp" />


<h1>REGISTRO</h1>
<form method="POST" action="RegistryServlet">
    <input type="text" name="username" placeholder="USAURIO" value="${param.username}"/>
    <br/>
    <input type="password" name="password" placeholder="CONTRASEÑA"/>
    <br/>
    <input type="password" name="confirm" placeholder="REPITE CONTRASEÑA"/>
    <br/>
    <input type="email" name="email" placeholder="CORREO ELECTRÓNICO" value="${param.email}"/>
    <br/>
    <input type="submit" name="submit" value="REGISTRARSE"/>
    <c:if test="${requestScope.error != null}">
        <p style="color:red">${requestScope.error}</p>
    </c:if>
</form>
<!--IMPORTACIÓN DEL FOOTER-->
<jsp:include page="footer.jsp" />