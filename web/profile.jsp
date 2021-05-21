<%-- 
    Document   : profile
    Created on : 26-mar-2021, 7:25:37
    Author     : dw2
--%>

<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="dao.DaoRetro"%>
<%@page import="beans.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<div class="wrapper container ">


    <div class="mt-5 row p-3 colorfondo ">
        <div class="container">
            <%
                try {
                    //OBTENCIÓN DEL USUARIO SOLICITADO DESDE LA BD
                    Integer usrId = Integer.parseInt(request.getParameter("user"));
                    User viewUser = DaoRetro.getUserById(usrId);
                    DateFormat df = new SimpleDateFormat("dd 'de' MMMMMMMMMMMM 'de' YYYY", new Locale("es", "ES"));
            %>

            <div class=" row m-3 colorfondo2">
                <div class="col-12 p-5 d-flex ">
                    <!--SELECCIÓN DE LA FOTO DE PERFIL, SI ESTÁ -> BD / SI NO -> IMAGEN POR DEFAULT-->
                    <c:choose >
                        <c:when test="${user.getAvatar()!=null}">
                            <img src="${user.getAvatar()}" class="img-fluid me-3 d-block fotoPerfil2 bordeneon" alt="imagen perfil">
                        </c:when>
                        <c:otherwise>
                            <img src="avatars/fotoperfil.jpg"  class="img-fluid me-3 d-block fotoPerfil2 bordeneon" alt="imagen perfil">
                        </c:otherwise>
                    </c:choose> 
                    <h2 class="text-center my-auto ms-5">Perfil de: <span class="titulo"><%=viewUser.getUsername()%></span></h2>
                </div>
            </div>

            <div class=" row m-3">
                <div class="col-lg-6 col-12 colorfondo2">
                    <div class="colorfondo2 p-5">
                        <h4 class="border-bottom">Bio:</h4>
                        <p><%=viewUser.getBio() != null ? viewUser.getBio() : ""%></p>
                    </div>
                </div>
                <div class="col-lg-5 col-12 offset-lg-1 p-5 colorfondo2">
                    <h4 class="border-bottom">Fecha ingreso:</h4>
                    <p><%=df.format(viewUser.getDate())%></p>
                    <%
                        if (request.getSession().getAttribute("user") != null) {
                            User user = (User) request.getSession().getAttribute("user");
                            if (viewUser.getId() == user.getId()) {

                    %>
                    <!--REDIRECCIÓN A LA PÁGINA DE EDICIÓN DEL PERFIL EN CASO DE SER EL MISMO USUARIO LOGUEADO-->
                    <a href="editProfile.jsp?user=<%=user.getId()%>" class="btn btn-primary  mt-4">Editar perfil</a>
                    <%      }
                        }
                    %>
                    <a href="userThreads.jsp?user=<%=viewUser.getId()%>" class="btn btn-primary  mt-4">Hilos iniciados por <%=viewUser.getUsername()%></a>
                </div>
            </div>

            <%
            } catch (Exception e) {
            %>
            <p style="color:red">PÁGINA NO DISPONIBLE</p>
            <%
                }
            %>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />
