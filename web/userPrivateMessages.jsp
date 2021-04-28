<%@page import="beans.PrivateMessage"%>
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
        User user = (User) session.getAttribute("user");
        if (user == null) throw new Exception("Usuario no logueado intentando acceder a mensajes");
        Integer pag = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 0;
        Integer lastPage = DaoTienda.getLastUserPrivateMessagesPage(user.getId());
        Collection<PrivateMessage> messages = DaoTienda.getPrivateMessagesByUser(user.getId(), pag);
        for (PrivateMessage message : messages) {
%>
<li>
    <ul>
        <li>USUARIO: <%=message.getUser().getUsername()%></li>
        <li>PRODUCTO: <%=message.getProduct().getTitle()%></li>
        <li>OFERTA: <%=message.getContent()%></li>
    </ul>
</li>
    <%
        }
        out.print("</ul>");
%>
  
    <nav aria-label="Page navigation example">
        <ul class="pagination">
            <li class="page-item">
                <a class="page-link" href="userPrivateMessages.jsp?page=0" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
            <%
                if (pag != 0) {
            %>
            <li class="page-item"><a class="page-link" href="userPrivateMessages.jsp?page=<%=pag - 1%>"><%=pag%></a></li>
                <%
                    }
                %>
            <li class="page-item"><a class="page-link" aria-disabled="true" href="userPrivateMessages.jsp?page=<%=pag%>"><%=pag + 1%></a></li>
                <%
                    if (pag != lastPage) {
                %>
            <li class="page-item"><a class="page-link" href="userPrivateMessages.jsp?page=<%=pag + 1%>"><%=pag + 2%></a></li>
                <%
                    }
                %>
            <li class="page-item">
                <a class="page-link" href="userPrivateMessages.jsp?page=<%=lastPage%>" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
        </ul>
    </nav>

<%

    } catch (Exception e) {
e.printStackTrace();
    %>
<h1 style="color:red">PÁGINA NO ENCONTRADA</h1>
<%
    }
%>



<!--IMPORTACIÓN DEL FOOTER-->
<jsp:include page="footer.jsp" />
