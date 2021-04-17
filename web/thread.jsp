<%-- 
    Document   : thread
    Created on : 05-mar-2021, 9:12:07
    Author     : dw2
--%>

<%@page import="utils.Utilities"%>
<%@page import="beans.User"%>
<%@page import="beans.Message"%>
<%@page import="java.util.Collection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--IMPORTACIÓN DEL HEADER-->
<jsp:include page="header.jsp" />
        <script>
            window.onload = () => {
                var btns = document.getElementsByClassName("quoteBtn");

                for (let i = 0; i < btns.length; i++) {
                    btns[i].addEventListener("click", e => {
                        let id = e.target.name;
                        document.getElementById("area").value += "[quote]" + id + "[/quote]";
                    });
                }
            }

        </script>
        <%
            try {
                Integer thread = Integer.parseInt(request.getParameter("thread"));
                Integer pag = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 0;
                Collection<Message> list = dao.DaoRetro.getMessages(thread, pag);
                User user = (User) session.getAttribute("user");
                boolean isAdmin = Utilities.checkAdmin(user);
                if (isAdmin) {
        %>
        <form method="post" action="ThreadRemoveServlet">
            <input type="hidden" name="threadId" value="<%=thread%>"/>
            <input type="submit" name="submit" value="Borrar hilo"/>
        </form>
        <%
            }
        %>
        <ul>
            <%
                for (Message msg : list) {
                    User msgUser = msg.getUser();
            %>
            <li><a href="profile.jsp?user=<%=msgUser.getId()%>"><%=msgUser.getUsername()%></a></li>
            <li>

                <%=Utilities.formatMsgOutput(msg.getContent())%>
                <%
                    if (request.getSession().getAttribute("user") != null) {
                %>
                <input type="button" class="quoteBtn" name="<%=msg.getId()%>" value="CITAR"/>
                <%
                    }
                %>
            </li>
            <%
                if (isAdmin) {
            %>
            <form method="post" action="MessageRemoveServlet">
                <input type="hidden" name="messageId" value="<%=msg.getId()%>"/>
                <input type="submit" name="submit" value="Borrar mensaje"/>
            </form>
            <%
                    }
                }%>
        </ul>
        <%
            if (request.getSession().getAttribute("user") != null) {
        %>
        <form method="post" action="ServletMessage"> <!--enctype="multipart/form-data"-->
            <input type="hidden" name="thread" value="<%=thread%>"/>
            <textarea id="area" name="message" cols="80" rows="10"></textarea>
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
<!--IMPORTACIÓN DEL FOOTER-->
<jsp:include page="footer.jsp" />
