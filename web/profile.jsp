<%-- 
    Document   : profile
    Created on : 26-mar-2021, 7:25:37
    Author     : dw2
--%>

<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="dao.DaoRetro"%>
<%@page import="beans.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            window.onload = () => {
                let buttons = document.getElementsByClassName("editBtn");
                for (let i = 0; i < buttons.length; i++) {
                    buttons[i].addEventListener("click", e => {
                        //Todos los botones deben comenzar con la palabra "edit" seguido del id del elemento referenciado
                        let id = e.target.idtoLowerCase().substring(4);
                        let element = document.getElementById(id);
                        element.value
                    });
                }
            }

        </script>
    </head>
    <body>
        <%
            try {
                Integer usrId = Integer.parseInt(request.getParameter("user"));
                User viewUser = DaoRetro.getUserById(usrId);
                DateFormat df = new SimpleDateFormat("dd 'de' MMMMMMMMMMMM 'de' YYYY", new Locale("es", "ES"));
        %>
        <h1>Perfil de <%=viewUser.getUsername()%></h1>
        <%
            if (viewUser.getAvatar() != null && !viewUser.getAvatar().isEmpty()) {
        %>       
        <img style="width: 50px; height: 50px" alt="avatar" src="<%=viewUser.getAvatar()%>">
        <%
            }
        %>
        <ul>
            <li> Bio: <%=viewUser.getBio() != null ? viewUser.getBio() : ""%></li>
            <li> F.registro: <%=df.format(viewUser.getDate())%></li>
            <li><a href="userThreads.jsp?user=<%=viewUser.getId()%>">Hilos iniciados por <%=viewUser.getUsername()%></a></li>
        </ul>




        <%
        } catch (Exception e) {
        %>
        <p style="color:red">PÁGINA NO DISPONIBLE</p>
        <%
            }
        %>
    </body>
</html>
