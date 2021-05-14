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
        <div class="col-lg-5 col-12 align-self-end">
            <form action="threadSearch.jsp" method="get" class="d-flex me-lg-5 me-5 ms-5 ms-lg-5">
                <input class="form-control me-2" name="text" type="search" placeholder="Buscar" aria-label="Search">
                <button class="btn btn-primary" type="submit"><i class="fas fa-search"></i></button>
            </form>
        </div>
    </div>

    <div class="mt-3 row p-3 colorfondo ">
        <c:if test="${requestScope.error != null}">
            <p style="color:red">${requestScope.error}</p>
        </c:if>
        <c:choose>
            <c:when test="${param.cat != null}">

                <%
                    try {
                        Integer cat = Integer.parseInt(request.getParameter("cat"));
                        Integer pag = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 0;
                        User user = (User) session.getAttribute("user");

                %>
                <div class="col-12 ">
                    <h2 class="m-5 titulo bordeneon">Hilos: <%=DaoRetro.getCategoryById(cat).getName() %></h2> 
                </div>

                <%
                    if (request.getSession().getAttribute("user") != null) {
                %>
                <div class="col-12 d-flex mb-2">
                    <a href="createThread.jsp?cat=${param.cat}" class="btn btn-primary me-3 ms-5 mb-2">CREAR HILO</a>


                    <%
                        if (Utilities.checkAdmin(user)) {
                    %>        
                    <form method="post" action="CategoryRemoveServlet">
                        <input type="hidden" name="category" value="<%=cat%>"/>
                        <input type="submit" name="submit" class="btn btn-primary" value="BORRAR CATEGORÍA"/>
                    </form>

                    <%
                        }
                        
                        
                    %>
                </div>
                <%
                    }
                    Collection<ForumThread> threads = dao.DaoRetro.getThreads(cat, pag);
                %>
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

                    <%
                        for (ForumThread thread : threads) {
                    %>

                    <div class=" me-5 ms-5 justify-content-center hilo">
                        <div class="row pt-2 pb-2">

                            <div class="col-lg-2 col-4">
                                <div class="d-flex">
                                    <c:choose >
                                        <c:when test="${thread.getUser().getAvatar()!=null}">
                                            <img src="${thread.getUser().getAvatar()}"  class="img-fluid me-3 d-block  fotoPerfil" alt="Responsive image">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="avatars/fotoperfil.jpg"  class="img-fluid me-3 d-block  fotoPerfil" alt="Responsive image">
                                        </c:otherwise>
                                    </c:choose>
                                    <a class="text-center my-auto " href="profile.jsp?user=<%=thread.getUser().getId()%>"><%=thread.getUser().getUsername()%></a>
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
                        int lastPage = DaoRetro.getLastCategoryPage(cat);
                    %>
                </div>

                <div class="col-12 mt-5">
                    <nav class="me-5 ms-5 ">
                        <ul class="pagination justify-content-center navegador">

                            <li class="page-item flechas deshabilitado">
                                <a class="page-link" href="#" href="threads.jsp?cat=<%=cat%>&page=0" tabindex="-1">&laquo; Atras</a>
                            </li>

                            <%
                                if (pag != 0) {
                            %>
                            <li class="page-item active"><a class="page-link" href="threads.jsp?cat=<%=cat%>&page=<%=pag - 1%>"><%=pag%></a></li>
                                <%
                                    }
                                %>
                            <li class="page-item active"><a class="page-link" href="threads.jsp?cat=<%=cat%>&page=<%=pag%>"><%=pag + 1%></a></li>
                                <%
                                    if (pag != lastPage) {
                                %>
                            <li class="page-item active"><a class="page-link" href="threads.jsp?cat=<%=cat%>&page=<%=pag + 1%>"><%=pag + 2%></a></li>
                                <%
                                    }
                                %>

                            <li class="page-item flechas">
                                <a class="page-link" href="threads.jsp?cat=<%=cat%>&page=<%=lastPage%>">Siguiente &raquo;</a>
                            </li>
                        </ul>
                    </nav>
                </div>

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









</div>





<!--IMPORTACIÓN DEL FOOTER-->
<jsp:include page="footer.jsp" />
