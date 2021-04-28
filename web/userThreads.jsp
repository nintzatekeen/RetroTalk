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


<!--IMPORTACIÓN DEL HEADER-->
<jsp:include page="header.jsp" />


<%
    try {
        User user = DaoRetro.getUserById(Integer.parseInt(request.getParameter("user")));
        Integer pag = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 0;
        Integer lastPage = DaoRetro.getLastUserThreadsPage(user);
        Collection<ForumThread> threads = DaoRetro.getUserThreads(user.getId(), pag);
        for (ForumThread thread : threads) {
%>
<li><a href='thread.jsp?thread=<%=thread.getId()%>'><%=thread.getTitle()%></a></li>
    <%
        }
        out.print("</ul>");

%>
    
    <nav aria-label="Page navigation example">
        <ul class="pagination">
            <li class="page-item">
                <a class="page-link" href="userThreads.jsp?user=<%=user.getId()%>&page=0" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
            <%
                if (pag != 0) {
            %>
            <li class="page-item"><a class="page-link" href="userThreads.jsp?user=<%=user.getId()%>&page=<%=pag - 1%>"><%=pag%></a></li>
                <%
                    }
                %>
            <li class="page-item"><a class="page-link" aria-disabled="true" href="userThreads.jsp?user=<%=user.getId()%>&page=<%=pag%>"><%=pag + 1%></a></li>
                <%
                    if (pag != lastPage) {
                %>
            <li class="page-item"><a class="page-link" href="userProducts.jsp?user=<%=user.getId()%>&page=<%=pag + 1%>"><%=pag + 2%></a></li>
                <%
                    }
                %>
            <li class="page-item">
                <a class="page-link" href="userThreads.jsp?user=<%=user.getId()%>&page=<%=lastPage%>" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
        </ul>
    </nav>

<%

    } catch (Exception e) {
    %>
<h1 style="color:red">PÁGINA NO ENCONTRADA</h1>
<%
    }
%>


<!--IMPORTACIÓN DEL FOOTER-->
<jsp:include page="footer.jsp" />
