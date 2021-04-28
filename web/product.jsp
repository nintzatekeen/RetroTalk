<%-- 
    Document   : product
    Created on : 28-abr-2021, 8:02:14
    Author     : David
--%>

<%@page import="beans.User"%>
<%@page import="beans.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <!-- Integer.parseInt(request.getParameter("id")))--> 
    <body>
        <%
            Product product = null;
            ArrayList<Product> productsList = (ArrayList<Product>) session.getAttribute("productsList");
            for (Product p : productsList) {
                if (p.getId() == Integer.parseInt(request.getParameter("id"))) {
                    product = p;
                }
            }
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("login.jsp");
            }

        %>
        <jsp:include page="header.jsp" />
        <h1> <%= product.getTitle()%> </h1>
        <img src="images/productos/<%=product.getImg()%>">
        <ul>

            <li><%=product.getDescription()%></li> 
            <li><%=product.getPrice()%></li> 
            <li><%=product.getDate()%></li> 
            <li><%= product.getUser().getUsername()%></li> 

        </ul>

        <h3>Envía tu mensaje</h3>
        <hr>
        <form method="Post" action="NewPrivateMessageServlet">
            <input type="hidden" name="idProducto" value="<%=product.getId()%>"/>
            <label>Oferta: 
                <input type="number" name="oferta" placeholder="Oferta"/> €
            </label>
            <hr>
            <label>Mensaje: 
                <textarea type="textarea" name="msg" placeholder="Mensaje..." required></textarea>
            </label>
            <input type="submit" name="submit" value="Enviar"/>
        </form>


        <!--IMPORTACIÓN DEL FOOTER-->
        <jsp:include page="footer.jsp" />

    </body>
</html>
