
<%@page import="java.util.ArrayList"%>
<%@page import="beans.Product"%>
<%@page import="beans.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--IMPORTACIÓN DEL HEADER-->
<jsp:include page="header.jsp" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <!--CARGAR LA TIENDA-->
        <%

            ArrayList<Product> productsList = (ArrayList<Product>) session.getAttribute("productsList");
            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("login.jsp");
            }
        %>
        <ul>
            <%                for (Product p : productsList) {
                    User userV = (User) p.getUser();
            %>
            <li>
                <a href="product.jsp?id=<%=p.getId()%>"><%=p.getTitle()%></a>

                <%=p.getPrice()%>
                <%=p.getDate()%>

                <img src="images/productos/<%=p.getImg()%>">

            </li>
            <%
                }
            %>       
        </ul>

        <!--IMPORTACIÓN DEL FOOTER-->
        <jsp:include page="footer.jsp" />
