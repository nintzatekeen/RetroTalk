<%-- 
    Document   : registro
    Created on : 28-feb-2021, 14:20:54
    Author     : ACER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!--IMPORTACIÓN DEL HEADER-->
<jsp:include page="header.jsp" />

<div class="wrapper container ">
    <div class=" bordeneon colorfondo p-1 p-lg-5 mt-5">
        <h2 class="m-5 titulo border-bottom">REGISTRO</h2>
        
        <form class="text-center row justify-content-center m-5" method="POST" action="RegistryServlet">
            <div class="col-lg-6 col-12 align-self-center">
                
                <c:if test="${requestScope.error != null}">
                    <p style="color:red">${requestScope.error}</p>
                </c:if>

                <div class="input-group form-group mb-2">
                    <div class="input-group-prepend" >
                        <span class="input-group-text" style="height: 100%;"><i class="fas fa-user"></i></span>
                    </div>
                    <input type="text" class="form-control" id="inputUser" placeholder="Nombre de usuario" name="username" value="${param.username}"/>
                </div>
                
                <div class="input-group form-group mb-2">
                    <div class="input-group-prepend" >
                        <span class="input-group-text" style="height: 100%;"><i class="fas fa-envelope"></i></span>
                    </div>
                    <input type="text" class="form-control" id="inputUser" ptype="email" name="email" placeholder="Correo Electrónico" value="${param.email}"/>
                </div>

                <div class="input-group form-group mt-2">
                    <div class="input-group-prepend">
                        <span class="input-group-text" style="height: 100%;"><i class="fas fa-key"></i></span>
                    </div>
                    <input type="password" name="password" placeholder="Contraseña" id="inputPassword" class="form-control"/>
                </div>
                
                <div class="input-group form-group mt-2">
                    <div class="input-group-prepend">
                        <span class="input-group-text" style="height: 100%;"><i class="fas fa-key"></i></span>
                    </div>
                    <input type="password" name="confirm" placeholder="Repite Contraseña" id="inputPassword" class="form-control"/>
                </div>

                <input type="submit" name="submit" value="REGISTRARSE" class="btn btn-primary mt-3"/>
            </div>
        </form>
                
        <div class="text-light">
            <div class="d-flex justify-content-center links">
                Ya tienes una cuenta? <a href="#" class="ps-2">Inicia sesion</a>
            </div>
        </div>   
    </div>
</div>
<!--IMPORTACIÓN DEL FOOTER-->
<jsp:include page="footer.jsp" />