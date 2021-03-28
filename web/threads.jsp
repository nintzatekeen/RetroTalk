<%-- 
    Document   : threads
    Created on : 05-mar-2021, 8:00:50
    Author     : dw2
--%>

<%@page import="dao.DaoRetro"%>
<%@page import="beans.ForumThread"%>
<%@page import="java.util.Collection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
    </head>
    <body>
        <c:choose>
            <c:when test="${param.cat != null}">
                <a href="createThread.jsp?cat=${param.cat}">CREAR HILO</a>
                <%
                    try {
                        Integer cat = Integer.parseInt(request.getParameter("cat"));
                        Integer pag = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 0;
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
</body>
</html>
