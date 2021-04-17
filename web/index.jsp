<%-- 
    Document   : index
    Created on : 20 feb. 2021, 18:06:02
    Author     : ACER
--%>

<%@page import="beans.User"%>
<%@page import="beans.Category"%>
<%@page import="java.util.List"%>
<%@page import="dao.DaoRetro"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!--IMPORTACIÓN DEL HEADER-->
<jsp:include page="header.jsp" />

<div class="wrapper container ">
    <div class="row colorfondo justify-content-end p-3  mt-5">
        <div class="col-lg-4 col-8 align-self-end">
            <form class="d-flex me-5 ms-5">
                <input class="form-control me-2" type="search" placeholder="Buscar" aria-label="Search">
                <button class="btn btn-primary" type="submit"><i class="fas fa-search"></i></button>
            </form>
        </div>
    </div>

    <div class="mt-3 row p-3 colorfondo ">
        <div class="col-12 ">
            <h2 class="m-5 titulo bordeneon">Categorias</h2>
        </div>

        <%
            User user = (User) session.getAttribute("user");
            if (utils.Utilities.checkAdmin(user)) {
        %>
        <div class="col-12 ">
            <a href ="createCategory.jsp" class="btn btn-primary me-5 ms-5 mb-2">CREAR CATEGORÍA</a>
        </div>
        <%
            }
        %>

        <div class="container">
            <div class="row justify-content-center">
                <div class="col-8">
                    <hr>
                </div>
            </div>

            <%
                List<Category> list = dao.DaoRetro.getCategories();
                for (Category c : list) {
            %>

            <div class="row justify-content-center">

                <div class="col-12 col-lg-11">
                    <a href='threads.jsp?cat=<%=c.getId()%>'>
                        <div class="d-flex m-2 col categoria">
                            <div class="bd-placeholder-img flex-shrink-0 me-4 ms-4 rounded">
                                <div class="rounded-circle icono">
                                    <i class="fas fa-globe"></i>
                                </div>
                            </div>
                            <div>
                                <h3><%=c.getName()%></h3>
                                <p class="descripcion"><%=c.getDescription()%></p>
                            </div>
                        </div> 
                    </a>
                </div>

            </div> 

            <div class="row justify-content-center">
                <div class="col-8">
                    <hr>
                </div>
            </div>
            <%
                }
            %>

        </div>                
    </div>
</div>



<ul>

</ul>
<!--IMPORTACIÓN DEL FOOTER-->
<jsp:include page="footer.jsp" />