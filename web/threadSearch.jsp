<%-- 
    Document   : threadSearch
    Created on : 18-abr-2021, 14:22:01
    Author     : ACER
--%>

<%@page import="beans.ForumThread"%>
<%@page import="java.util.Collection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--IMPORTACIÓN DEL HEADER-->
<jsp:include page="header.jsp" />

<c:if test="${param.text != null && not empty param.text}">

    <%
        String text = request.getParameter("text");
        Integer pag;
        int lastPage = dao.DaoRetro.getLastSearchThread(text);
        try {
            pag = Integer.parseInt(request.getParameter("page"));
        } catch (NullPointerException ex) {
            pag = 0;
        } catch (NumberFormatException ex) {
            pag = 0;
        }

        Collection<ForumThread> threads = dao.DaoRetro.searchThreads(text, pag);
    %>
    <ul>
        <%
            for (ForumThread thread : threads) {
        %>
        <li><a href='thread.jsp?thread=<%=thread.getId()%>'><%=thread.getTitle()%></a></li>
            <%
                }
            %>
    </ul>

    <nav aria-label="Page navigation example">
        <ul class="pagination">
            <li class="page-item">
                <a class="page-link" href="threadSearch.jsp?text=<%=text%>&page=0" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
            <%
                if (pag != 0) {
            %>
            <li class="page-item"><a class="page-link" href="threadSearch.jsp?text=<%=text%>&page=<%=pag - 1%>"><%=pag%></a></li>
                <%
                    }
                %>
            <li class="page-item"><a class="page-link" aria-disabled="true" href="threadSearch.jsp?text=<%=text%>&page=<%=pag%>"><%=pag + 1%></a></li>
                <%
                    if (pag != lastPage) {
                %>
            <li class="page-item"><a class="page-link" href="threadSearch.jsp?text=<%=text%>&page=<%=pag + 1%>"><%=pag + 2%></a></li>
                <%
                    }
                %>
            <li class="page-item">
                <a class="page-link" href="threadSearch.jsp?text=<%=text%>&page=<%=lastPage%>" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
        </ul>
    </nav>



</c:if>





<!--IMPORTACIÓN DEL FOOTER-->
<jsp:include page="footer.jsp" />
