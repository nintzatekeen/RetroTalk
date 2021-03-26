<%-- 
    Document   : profile
    Created on : 26-mar-2021, 7:25:37
    Author     : dw2
--%>

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
                        console.log(e.target);
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
        %>
        <h1>Perfil de <%=viewUser.getUsername()%></h1>
        <%
            User myUser = (User) session.getAttribute("user");
            boolean editable = (myUser != null && myUser.getId() == viewUser.getId());
        %>
        <ul>
            <li><%=viewUser.getBio()%>
                <%
                  if (editable) {
                %>
                <button class="editBtn" id="editBio">Editar</button>
                <%
                  }
                %>
            </li>
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
