<%-- 
    Document   : thread
    Created on : 05-mar-2021, 9:12:07
    Author     : dw2
--%>

<%@page import="beans.User"%>
<%@page import="beans.Message"%>
<%@page import="java.util.Collection"%>
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
                Integer thread = Integer.parseInt(request.getParameter("thread"));
                Integer pag = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 0;
                Collection<Message> list = dao.DaoRetro.getMessages(thread, pag);
        %>
        <ul>
            <%
                for (Message msg : list) {
                    User msgUser = msg.getUser();
            %>
            <li><a href="profile.jsp?user=<%=msgUser.getId()%>"><%=msgUser.getUsername()%></a></li>
            <li><%=msg.getContent()%></li>
                <%
                    }%>
        </ul>
        <%
            if (request.getSession().getAttribute("user") != null) {
        %>
        <form method="post" action="ServletMessage"> <!--enctype="multipart/form-data"-->
            <input type="hidden" name="thread" value="<%=thread%>"/>
            <textarea name="message" cols="80" rows="10"></textarea>
            <input type="submit" name="submit" value="ENVIAR"/>
        </form>
        <%
            }
        } catch (Exception ex) {
        %>
        <p style="color:red">PÁGINA NO ENCONTRADA</p>
        <%
            }
        %>
    </body>
</html>
