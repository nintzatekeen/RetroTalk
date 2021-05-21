<%-- 
    Document   : threadSearch
    Created on : 18-abr-2021, 14:22:01
    Author     : ACER
--%>

<%@page import="beans.ForumThread"%>
<%@page import="java.util.Collection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--IMPORTACIÓN DEL HEADER-->
<jsp:include page="header.jsp" />

<c:if test="${param.text != null && not empty param.text}">
    <div class="wrapper container ">
        <%
            String text = request.getParameter("text");
            Integer pag;
            int lastPage = dao.DaoRetro.getLastSearchThread(text);
            try {
                pag = Integer.parseInt(request.getParameter("page"));
            } catch (NullPointerException ex) {
                pag = 0;
            } catch (NumberFormatException ex) {
                pag = 0;
            }

            Collection<ForumThread> threads = dao.DaoRetro.searchThreads(text, pag);
        %>

        <div class="row colorfondo justify-content-end p-3  mt-5">
            <div class="col-lg-5 col-12 align-self-end">
                <form action="threadSearch.jsp" method="get" class="d-flex me-lg-5 me-5 ms-5 ms-lg-5">
                    <input class="form-control me-2" name="text" type="search" placeholder="Buscar" aria-label="Search">
                    <button class="btn btn-primary" type="submit"><i class="fas fa-search"></i></button>
                </form>
            </div>
        </div>

        <div class="mt-3 row p-3 colorfondo ">
            <div class="col-12 ">
                <h2 class="m-5 titulo bordeneon">Resultados de la busqueda</h2> 
            </div>

            <div class="col-12">

                <div class=" me-5 ms-5 justify-content-center headerHilo">
                    <div class="row my-auto">
                        <div class="col-lg-2 ps-4 col-4">
                            <p>Autor</p>
                        </div>
                        <div class="col-lg-7 col-8">
                            <p>Tema</p>
                        </div>
                        <div class="col-lg-1 col-0 d-none d-lg-block">
                            <p>Resp.</p>
                        </div>
                        <div class="col-lg-2 col-0 d-none d-lg-block">
                            <p>Ult. Mensaje</p>
                        </div>
                    </div>
                </div>
                <!--CARGA DE LOS HILOS SOLICITADOS-->
                <%
                    for (ForumThread thread : threads) {
                %>
                <div class=" me-5 ms-5 justify-content-center hilo">
                    <div class="row pt-2 pb-2">

                        <div class="col-lg-2 col-4">
                            <div class="d-flex">
                                <img src="images/fotoperfil.jpg" class="img-fluid me-3 d-block  fotoPerfil" alt="Responsive image">
                                <a class="text-center my-auto "><%=thread.getUser().getUsername()%></a>
                            </div>
                        </div>
                        <div class="col-lg-7 col-8 my-auto">
                            <h4><a href='thread.jsp?thread=<%=thread.getId()%>'><%=thread.getTitle()%></a></h4>
                        </div>
                        <div class="col-lg-1 col-0 my-auto d-none d-lg-block">
                            <p><%=thread.getMessageCount()%></p>
                        </div>
                        <div class="col-lg-2 col-0 my-auto d-none d-lg-block">
                            <p><%=utils.Utilities.removeTags(thread.getLastMessage().getContent())%></p>
                        </div>

                    </div>
                </div>    
                <%
                    }
                %>
            </div>
            <!--PAGINACIÓN-->
            <div class="col-12 mt-5">
                <nav class="me-5 ms-5 ">
                    <ul class="pagination justify-content-center navegador">
                         <%
                            if (pag == 0) {
                        %>
                        <li class="page-item flechas deshabilitado">
                            <a class="page-link" href="threadSearch.jsp?text=<%=text%>&page=0" tabindex="-1">&laquo; Atras</a>
                        </li>
                        <%
                            }else{
                        %>
                        <li class="page-item flechas">
                            <a class="page-link" href="threadSearch.jsp?text=<%=text%>&page=<%=pag - 1%>" tabindex="-1">&laquo; Atras</a>
                        </li>  

                        <%  
                            }
                            if (pag != 0) {
                        %>
                        <li class="page-item active"><a class="page-link" href="threadSearch.jsp?text=<%=text%>&page=<%=pag - 1%>"><%=pag%></a></li>
                            <%
                                }
                            %>
                        <li class="page-item active"><a class="page-link" href="threadSearch.jsp?text=<%=text%>&page=<%=pag%>"><%=pag + 1%></a></li>
                            <%
                                if (pag != lastPage) {
                            %>
                        <li class="page-item active"><a class="page-link" href="threadSearch.jsp?text=<%=text%>&page=<%=pag + 1%>"><%=pag + 2%></a></li>
                            <%
                                }
                            %>

                        <li class="page-item flechas">
                            <a class="page-link" href="threadSearch.jsp?text=<%=text%>&page=<%=lastPage%>">Siguiente &raquo;</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>    



</c:if>





<!--IMPORTACIÓN DEL FOOTER-->
<jsp:include page="footer.jsp" />
