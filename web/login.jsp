<%-- 
    Document   : login
    Created on : 02-mar-2021, 19:09:47
    Author     : ACER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--IMPORTACIÓN DEL HEADER-->
<jsp:include page="header.jsp" />
        
        <div class="wrapper container ">
            <div class=" bordeneon colorfondo p-1 p-lg-5 mt-5">
                <h2 class="m-5 titulo">Login</h2>
                <form class="text-center row justify-content-center m-5" method="POST" action="LoginServlet">
                    <div class="col-lg-6 col-12 align-self-center">

                        <div class="input-group form-group mb-2">
                            <div class="input-group-prepend" >
                                <span class="input-group-text" style="height: 100%;"><i class="fas fa-user"></i></span>
                            </div>
                            <input type="text" class="form-control" id="inputUser" placeholder="Nombre de usuario" name="username" value="${param.username}"/>
                        </div>

                        <div class="input-group form-group mt-2">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="height: 100%;"><i class="fas fa-key"></i></span>
                            </div>
                            <input type="password" id="inputPassword" class="form-control" placeholder="Password" name="password"/>
                        </div>

                        <input type="submit" name="submit" class="btn btn-primary mt-3" value="INICIAR SESIÓN"/>
                    </div>
                </form>
                <div class="text-light">
                    <div class="d-flex justify-content-center links">
                        Don't have an account? <a href="#">Sign Up</a>
                    </div>
                    <div class="d-flex justify-content-center">
                        <a href="#">Forgot your password?</a>
                    </div>
                </div>
            </div>

            <c:if test="${requestScope.error != null}">
                <p style="color: red">${requestScope.error}</p>
            </c:if>
        </div>
                    
<!--IMPORTACIÓN DEL FOOTER-->
<jsp:include page="footer.jsp" />
