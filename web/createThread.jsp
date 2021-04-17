<%-- 
    Document   : createThread
    Created on : 25-mar-2021, 17:43:00
    Author     : ACER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--IMPORTACIÓN DEL HEADER-->
<jsp:include page="header.jsp" />
<h1>Crear nuevo hilo</h1>
<form method="post" action="NewThreadServlet">
    <input type="text" name="title">
    <textarea name="content"></textarea>
    <input type="submit" name="create" value="CREAR HILO"/>
    <input type="hidden" name="category" value="<%= request.getParameter("cat")%>"/>
</form>

<c:if test="${requestScope.error != null}">
    <p style="color:red">${requestScope.error} </p>
</c:if>

<!--IMPORTACIÓN DEL FOOTER-->
<jsp:include page="footer.jsp" />