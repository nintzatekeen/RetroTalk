<%-- 
    Document   : userThreads
    Created on : 26-mar-2021, 17:51:53
    Author     : ACER
--%>

<%@page import="beans.ForumThread"%>
<%@page import="java.util.Collection"%>
<%@page import="dao.DaoRetro"%>
<%@page import="beans.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            try {
                User user = DaoRetro.getUserById(Integer.parseInt(request.getParameter("user")));
                Integer pag = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 0;
                Collection<ForumThread> threads = DaoRetro.getUserThreads(user.getId(), pag);
                for (ForumThread thread : threads) {
        %>
    <li><a href='thread.jsp?thread=<%=thread.getId()%>'><%=thread.getTitle()%></a></li>
        <%
            }
            out.print("</ul>");

        } catch (Exception e) {
        %>
    <h1 style="color:red">PÁGINA NO ENCONTRADA</h1>
    <%
        }
    %>
</body>
</html>
