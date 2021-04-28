<%-- 
    Document   : userThreads
    Created on : 26-mar-2021, 17:51:53
    Author     : ACER
--%>

<%@page import="beans.Product"%>
<%@page import="dao.DaoTienda"%>
<%@page import="beans.ForumThread"%>
<%@page import="java.util.Collection"%>
<%@page import="dao.DaoRetro"%>
<%@page import="beans.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!--IMPORTACIÓN DEL HEADER-->
<jsp:include page="header.jsp" />


<%
    try {
        User user = DaoRetro.getUserById(Integer.parseInt(request.getParameter("user")));
        Integer pag = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 0;
        Collection<Product> products = DaoTienda.getUserProducts(user.getId(), pag);
        for (Product producto : products) {
%>
<li><a href='product.jsp?id=<%=producto.getId()%>'><%=producto.getTitle()%></a></li>
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


<!--IMPORTACIÓN DEL FOOTER-->
<jsp:include page="footer.jsp" />