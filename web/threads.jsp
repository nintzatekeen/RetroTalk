<%-- 
    Document   : threads
    Created on : 05-mar-2021, 8:00:50
    Author     : dw2
--%>

<%@page import="utils.Utilities"%>
<%@page import="beans.User"%>
<%@page import="dao.DaoRetro"%>
<%@page import="beans.ForumThread"%>
<%@page import="java.util.Collection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--IMPORTACIÓN DEL HEADER-->
<jsp:include page="header.jsp" />

        <div class="wrapper container ">
            <div class="row colorfondo justify-content-end p-3  mt-5">
                <div class="col-lg-4 col-8 align-self-end">
                    <form class="d-flex me-5 ms-5" action="threadSearch.jsp" method="get">
                        <input class="form-control me-2" name="text" type="search" placeholder="Buscar" aria-label="Search">
                        <button class="btn btn-primary" type="submit"><i class="fas fa-search"></i></button>
                    </form>
                </div>
            </div>

            <div class="mt-3 row p-3 colorfondo ">
                <div class="col-12 ">
                    <h2 class="m-5 titulo bordeneon">Hilos: Categoria</h2> <!--Necesito el nombre de la categoria-->
                </div>
                
               
                <div class="col-12 ">
                    <a href ="createCategory.jsp" class="btn btn-primary me-5 ms-5 mb-2">CREAR CATEGORÍA</a>
                </div>
                
                <div class="col-12 mt-3">
                    <div class=" me-5 ms-5 justify-content-center headerHilo">
                        
                        <div class="row my-auto">
                            <div class="col-2 ps-4">
                                <p>Autor</p>
                            </div>
                            <div class="col-7 ">
                                <p>Tema</p>
                            </div>
                            <div class="col-1 ">
                                <p>Resp.</p>
                            </div>
                            <div class="col-2 ">
                                <p>Ult. Mensaje</p>
                            </div>
                        </div>
                        
                    </div> 
                </div>
                
                <div class="col-12">
                    <div class=" me-5 ms-5 justify-content-center hilo">
                        
                        <div class="row pt-2 pb-2">
                            <div class="col-2">
                                <div class="d-flex">
                                    <img src="images/fotoperfil.jpg" class="img-fluid me-3 d-block  fotoPerfil" alt="Responsive image">
                                    <a class="text-center my-auto ">Autor</a>
                                </div>
                            </div>
                            <div class="col-7 my-auto">
                                <h4>Las consolas mas vendidas</h4>
                            </div>
                            <div class="col-1 my-auto">
                                <p>55</p>
                            </div>
                            <div class="col-2 my-auto">
                                <p>Ult Mens</p>
                            </div>
                        </div>
                        
                    </div> 
                    
                    <div class=" me-5 ms-5 justify-content-center hilo">
                        
                        <div class="row pt-2 pb-2">
                            <div class="col-2">
                                <div class="d-flex">
                                    <img src="images/fotoperfil.jpg" class="img-fluid me-3 d-block  fotoPerfil" alt="Responsive image">
                                    <a class="text-center my-auto ">Autor</a>
                                </div>
                            </div>
                            <div class="col-7 my-auto">
                                <h4>Las consolas mas vendidas</h4>
                            </div>
                            <div class="col-1 my-auto">
                                <p>55</p>
                            </div>
                            <div class="col-2 my-auto">
                                <p>Ult Mens</p>
                            </div>
                        </div>
                        
                    </div> 
                </div>
                
                <div class="col-12 mt-5">
                    <nav class="me-5 ms-5 ">
                        <ul class="pagination justify-content-center navegador">
                            <li class="page-item flechas deshabilitado">
                                <a class="page-link" href="#" tabindex="-1">&laquo; Atras</a>
                            </li>
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item flechas">
                                <a class="page-link" href="#">Siguiente &raquo;</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>    

            
            
                   
                
            
            
            
            <c:if test="${requestScope.error != null}">
                <p style="color:red">${requestScope.error}</p>
            </c:if>
            <c:choose>
                <c:when test="${param.cat != null}">
                    <a href="createThread.jsp?cat=${param.cat}">CREAR HILO</a>
                    <%
                        try {
                            Integer cat = Integer.parseInt(request.getParameter("cat"));
                            Integer pag = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 0;
                            User user = (User) session.getAttribute("user");
                            if (Utilities.checkAdmin(user)) {
                    %>


                    <form method="post" action="CategoryRemoveServlet">
                        <input type="hidden" name="category" value="<%=cat%>"/>
                        <input type="submit" name="submit" value="BORRAR CATEGORÍA"/>
                    </form>
                    <%
                        }
                        Collection<ForumThread> threads = dao.DaoRetro.getThreads(cat, pag);
                        out.print("<ul>");
                        for (ForumThread thread : threads) {
                    %>
                    <li><a href='thread.jsp?thread=<%=thread.getId()%>'><%=thread.getTitle()%></a></li>
                        <%
                            }
                            out.print("</ul>");

                            int lastPage = DaoRetro.getLastCategoryPage(cat);
                        %>
                    <nav aria-label="Page navigation example">
                        <ul class="pagination">
                            <li class="page-item">
                                <a class="page-link" href="threads.jsp?cat=<%=cat%>&page=0" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <%
                                if (pag != 0) {
                            %>
                            <li class="page-item"><a class="page-link" href="threads.jsp?cat=<%=cat%>&page=<%=pag - 1%>"><%=pag%></a></li>
                                <%
                                    }
                                %>
                            <li class="page-item"><a class="page-link" aria-disabled="true" href="threads.jsp?cat=<%=cat%>&page=<%=pag%>"><%=pag + 1%></a></li>
                                <%
                                    if (pag != lastPage) {
                                %>
                            <li class="page-item"><a class="page-link" href="threads.jsp?cat=<%=cat%>&page=<%=pag + 1%>"><%=pag + 2%></a></li>
                                <%
                                    }
                                %>
                            <li class="page-item">
                                <a class="page-link" href="threads.jsp?cat=<%=cat%>&page=<%=lastPage%>" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>

                    <%
                    } catch (Exception ex) {
                    %>
                    <p style="color:red">
                        PÁGINA NO ENCONTRADA
                    </p>
                    <%
                        }

                    %>
                </c:when>
                <c:otherwise>
                    <p style="color:red">
                        PÁGINA NO ENCONTRADA
                    </p>
                </c:otherwise>
            </c:choose>
        </div>



        <ul>

        </ul>

<!--IMPORTACIÓN DEL FOOTER-->
<jsp:include page="footer.jsp" />