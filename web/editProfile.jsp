<%-- 
    Document   : editProfile
    Created on : 27-mar-2021, 12:47:50
    Author     : ACER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="user" scope="session" value="${sessionScope.user}"/>
<!--IMPORTACIÓN DEL HEADER-->
<jsp:include page="header.jsp" />
<h1>Hola, ${user.getUsername()}</h1>

<form action="ProfileServlet" method="post" enctype="multipart/form-data">
    Avatar :
    <br/>
    <img style="width: 50px; height: 50px" alt="avatar" src="${user.getAvatar()}"/>
    <input type="file" name="avatar" value="Subir avatar" accept="image/*"/>
    Bio: <input type="text" name="bio" value="${user.getBio()}"/>
    <br/>
    Emilio: <input type="email" name="email" value="${user.getEmail()}"/>
    <br/>
    <label>Cambiar contraseña:</label>
    <br/>
    Contraseña antigua: <input type="password" name="oldPass"/>
    <br/>
    Nueva contraseña: <input type="password" name="newPass"/>
    <br/>
    Confirme nueva contraseña: <input type="password" name="newPassConfirm"/>
    <br/>
    <input type="submit" name="editProfile" value="ACTUALIZAR PERFIL"/>
</form>

<c:if test="${requestScope.error != null}">
    <p style="color:red">${requestScope.error}</p>
</c:if>

<!--IMPORTACIÓN DEL FOOTER-->
<jsp:include page="footer.jsp" />