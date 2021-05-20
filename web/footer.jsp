<%@page import="java.util.List"%>
<%@page import="beans.Category"%>
<!--EL FOOTER QUE SE IMPORTARÁ A LOS JSP-->
<footer class="container">
            <div class="row my-5 justify-content-center py-5">
                <div class="col-11">
                    <div class="row ">
                        <div class="col-xl-8 col-md-4 col-sm-5 col-12 my-auto mx-auto a">
                            <h3 class="text-muted mb-md-0 mb-5 bold-text">RetroTalk</h3>
                        </div>
                        <div class="col-xl-2 col-md-4 col-sm-4 col-12">
                            <h6 class="mb-3 mb-lg-4 text-muted bold-text mt-sm-0 mt-5"><b>MENU</b></h6>
                            <ul class="list-unstyled">
                                <li><a href="index.jsp">Todas las categorias</a></li>
                                <%
                                    List<Category> list = dao.DaoRetro.getCategories();
                                    for (Category c : list) {
                                %>
                                <li><a href='threads.jsp?cat=<%=c.getId()%>'><%=c.getName()%></a></li>
                                <%
                                    }
                                    if (request.getSession().getAttribute("user") != null) {
                                       
                                %>
                                <li><a href="ShopServlet">Tienda</a></li>
                                 <%
                                    }  
                                %>
                            </ul>
                        </div>
                        <div class="col-xl-2 col-md-4 col-sm-3 col-12">
                            <h6 class="mb-3 mb-lg-4 text-muted bold-text mt-sm-0 mt-5"><b>Direccion</b></h6>
                            <p class="mb-1">Calle falsa, 56</p>
                            <p>Vitoria-Gasteiz</p>
                        </div>
                    </div>
                    <div class="row ">
                        <div class="col-xl-8 col-md-4 col-sm-5 col-auto my-md-0 mt-5 order-sm-1 order-3 align-self-end">
                            <p class="social text-muted mb-0 pb-0 bold-text"> <small class="rights"><span>&#174;</span> RetroTalk todos los derechos resevados</small>
                        </div>
                        <div class="col-xl-2 col-md-4 col-sm-4 col-auto order-1 align-self-end ">
                            <h6 class="mt-55 mt-2 text-muted bold-text"><b>Correo de contacto</b></h6><small> <span><i class="fa fa-envelope" aria-hidden="true"></i></span> contact@retrotalk.com</small>
                        </div>
                        <div class="col-xl-2 col-md-4 col-sm-3 col-auto order-2 align-self-end mt-3 ">
                            <h6 class="text-muted bold-text"><b>Telf.</b></h6><small><span><i class="fas fa-phone"></i></span> 978 78 77 99 99</small>
                        </div>
                    </div>
                </div>
            </div>
        </footer>   
    </body>
</html>
