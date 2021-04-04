<%-- 
    Document   : createCategory
    Created on : 04-abr-2021, 17:10:39
    Author     : ACER
--%>

<%@page import="beans.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    User user = (User) session.getAttribute("user");
            if (!utils.Utilities.checkAdmin(user)) {
                response.sendRedirect("index.jsp");
            }

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Crear nueva categoría</h1>
        <form method="post" action="NewCategoryServlet">
            ID: <input type="number" name="categoryId"/>
            <br/>
            NOMBRE: <input type="text" name="categoryName"/>
            <br/>
            DESC.: <input type="text" name="categoryDescription"/>
            <br/>
            <input type="submit" name="submit" value="CREAR"/>
        </form>
        <c:if test="${requestScope.error != null}">
            <p style="color:red">${requestScope.error}</p>
        </c:if>
        
        
    </body>
</html>
