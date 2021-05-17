<%-- 
    Document   : createThread
    Created on : 25-mar-2021, 17:43:00
    Author     : ACER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--IMPORTACIÓN DEL HEADER-->
<jsp:include page="header.jsp" />

<div class="wrapper container ">
    <div class=" bordeneon colorfondo p-1 p-lg-5 mt-5">
        <h2 class="m-5 titulo border-bottom">Crear nuevo hilo</h2>
        <!--FORMULARIO CON TÍTULO DEL HILO Y MENSAJE-->
        <form method="post" class="text-center row justify-content-center m-5" action="NewThreadServlet">
            <div class="col-lg-8 col-12">
                <div class="form-group">
                    <label for="nombre" class="d-none">Nombre del hilo</label>
                    <input type="text" class="form-control" id="nombre" placeholder="Nombre del hilo" name="title">
                </div>

                <div class="form-group mt-4">
                    <label for="nombre" class="d-none">Nombre del hilo</label>
                    <textarea class="form-control"  name="content" rows="4" placeholder="Tema a tratar..."></textarea>
                </div>

                <input type="hidden" name="category" value="<%= request.getParameter("cat")%>"/>

                <input type="submit" name="create" class="btn btn-primary mt-3" value="CREAR HILO"/>

                <c:if test="${requestScope.error != null}">
                    <p style="color:red">${requestScope.error} </p>
                </c:if>
            </div>
        </form>

    </div>
</div>    

<!--IMPORTACIÓN DEL FOOTER-->
<jsp:include page="footer.jsp" />