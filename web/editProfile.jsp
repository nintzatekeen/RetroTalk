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

<div class="wrapper container ">
    <div class=" bordeneon colorfondo p-1 p-lg-5 mt-5">
        <h2 class="m-5 titulo border-bottom">Editar perfil de ${user.getUsername()}</h2>
        
        <form action="ProfileServlet" method="post" enctype="multipart/form-data" class="text-center row justify-content-center m-5">
            <div class="col-lg-8 col-12">
                <div class="form-group text-start">
                    <div class="text-start d-flex mb-3">
                        <p>Avatar actual: </p>
                        <c:choose >
                            <c:when test="${user.getAvatar()!=null}">
                                <img src="${user.getAvatar()}" class="img-fluid ms-5 fotoPerfil2 bordeneon" alt="imagen perfil">
                            </c:when>
                            <c:otherwise>
                                <img src="avatars/fotoperfil.jpg" class="img-fluid ms-5 fotoPerfil2 bordeneon" alt="imagen perfil">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <label for="avatar" class="">Nuevo avatar:</label>
                    <input type="file" name="avatar" value="Subir avatar" id="avatar" accept="image/*"/>
                </div>

                <div class="form-group mt-2 text-start">
                    <label for="bio" class="">Bio:</label>
                    <textarea type="text" class="form-control"  name="categoryName" rows="4" id="bio" placeholder="Bio..." >${user.getBio()}</textarea>
                </div>
                
                <div class="form-group mt-2 text-start">
                    <label for="email" class="">Email:</label>
                    <input type="text" class="form-control" id="inputUser" ptype="email" name="email" placeholder="Correo Electrónico" value="${user.getEmail()}"/>
                </div>
                
                <h5 class="bold-text mt-5 border-bottom p-1 mb-4">Cambiar contraseña</h5>
                
                <div class="form-group mt-2 text-start">
                    <label for="oldPass" class="d-none">Contraseña actual:</label>
                    <input type="password" name="oldPass" id="oldPass" class="form-control" rows="4" id="bio" placeholder="Contraseña actual..." />
                </div>
                
                <div class="form-group mt-2 text-start">
                    <label for="newPass" class="d-none">Nueva contraseña:</label>
                    <input type="password" name="newPass" id="newPass" class="form-control" rows="4" id="bio" placeholder="Nueva contraseña..." />
                </div>
                
                <div class="form-group mt-2 text-start">
                    <label for="newPassConfirm" class="d-none">Repetir contraseña:</label>
                    <input type="password" name="newPassConfirm" id="newPassConfirm" class="form-control" rows="4" id="bio" placeholder="Repetir contraseña..." />
                </div>
                
                <input type="submit" name="editProfile" class="btn btn-primary mt-3" value="Actualizar perfil"/>
                
                <c:if test="${requestScope.error != null}">
                    <p style="color:red">${requestScope.error}</p>
                </c:if>
            </div>
        </form>
        <c:if test="${requestScope.error != null}">
            <p style="color:red">${requestScope.error}</p>
        </c:if>
    </div>
</div>   

<!--IMPORTACIÓN DEL FOOTER-->
<jsp:include page="footer.jsp" />