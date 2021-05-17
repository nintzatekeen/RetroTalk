<%-- 
    Document   : createCategory
    Created on : 04-abr-2021, 17:10:39
    Author     : ACER
--%>

<%@page import="beans.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    User user = (User) session.getAttribute("user");
    if (!utils.Utilities.checkAdmin(user)) {
        response.sendRedirect("index.jsp");
    }

%>
<!--IMPORTACIÓN DEL HEADER-->
<jsp:include page="header.jsp" />

<div class="wrapper container ">
    <div class=" bordeneon colorfondo p-1 p-lg-5 mt-5">
        <h2 class="m-5 titulo border-bottom">Crear nueva categoría</h2>
        <!--FORMULARIO PARA LA NUEVA CATEGORÍA-->
        <form method="post" class="text-center row justify-content-center m-5" action="NewCategoryServlet">
            <div class="col-lg-8 col-12">
                <div class="form-group">
                    <label for="id" class="d-none">ID</label>
                    <input type="number" name="categoryId" class="form-control" id="id" placeholder="ID" >
                </div>

                <div class="form-group mt-4">
                    <label for="nombre" class="d-none">Nombre de la categoria</label>
                    <input type="text" class="form-control"  name="categoryName" rows="4" placeholder="Nombre de la categoria"/>
                </div>

                <div class="form-group mt-4">
                    <label for="Descripcion" class="d-none">Descripcion de la categoria</label>
                    <input type="text" class="form-control"  name="categoryDescription" id="Descripcion" rows="4" placeholder="Descripcion de la categoria"/>
                </div>

                <div class="form-group mt-4">
                    <label for="icono" class="d-none">Icono de la categoria</label>
                    <input type="text" class="form-control"  name="categoryIcon" rows="4" id="icono" placeholder="Icono de la categoria"/>
                </div>

                <input type="submit" name="submit" class="btn btn-primary mt-3" value="CREAR"/>

                <c:if test="${requestScope.error != null}">
                    <p style="color:red">${requestScope.error}</p>
                </c:if>
            </div>
        </form>

    </div>
</div>    


<!--IMPORTACIÓN DEL FOOTER-->
<jsp:include page="footer.jsp" />
