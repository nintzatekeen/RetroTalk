<%-- 
    Document   : thread
    Created on : 05-mar-2021, 9:12:07
    Author     : dw2
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<div class="wrapper container ">
    <div class="row colorfondo justify-content-end p-3  mt-5">
        <div class="col-lg-4 col-8 align-self-end">
            <form action="threadSearch.jsp" method="get" class="d-flex me-5 ms-5">
                <input class="form-control me-2" name="text" type="search" placeholder="Buscar" aria-label="Search">
                <button class="btn btn-primary" type="submit"><i class="fas fa-search"></i></button>
            </form>
        </div>
    </div>

    <div class="mt-3 row p-3 colorfondo ">
        <div class="col-12 ">
            <h2 class="m-5 titulo bordeneon">JAJA AL CHILE XD</h2>
        </div>
        
        <%
            try {
                Integer thread = Integer.parseInt(request.getParameter("thread"));
                Integer pag = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 0;
                Collection<Message> list = dao.DaoRetro.getMessages(thread, pag);
                User user = (User) session.getAttribute("user");
                boolean isAdmin = Utilities.checkAdmin(user);
                if (isAdmin) {
        %>
        
        <div class="col-12 d-flex mb-2 ps-5">
            <form method="post" action="ThreadRemoveServlet">
                <input type="hidden" name="threadId" value="<%=thread%>"/>
                <input type="submit" class="btn btn-primary" name="submit" value="Borrar hilo"/>
            </form>
        </div>
        
        <%
            }
        %>
        
        <div class="container col-12 p-5">
            
            <%
                for (Message msg : list) {
                    User msgUser = msg.getUser();
            %>
            <div class="row mb-4">
                <div class="col-12 colorfondo2">
                    <p class="p-1 ps-3 my-auto text-muted"><i class="fas fa-calendar-week pe-2"></i><%= msg.getDate() %></p>
                </div>
                <div class="col-2 colorfondo2">
                    <div class="row d-flex  p-3">
                        <h4 class=""><a href="profile.jsp?user=<%=msgUser.getId()%>"><%=msgUser.getUsername()%></a></h4>
                        <div><img src="images/fotoperfil.jpg" class="img-fluid d-block  fotoPerfil2 mt-3 mb-3 bordeneon" alt="Responsive image"></div>
                        <p>Usuario desde: <%=msgUser.getDate()%></p>
                        
                        <%
                            if (request.getSession().getAttribute("user") != null) {
                        %>
                        <div>
                            <input type="button" class="quoteBtn btn btn-primary  btn-sm" name="<%=msg.getId()%>" value="CITAR"/>
                            
                            <%
                                if (isAdmin) {
                            %>
                            <form method="post" action="MessageRemoveServlet">
                                <input type="hidden" name="messageId" value="<%=msg.getId()%>"/>
                                <input type="submit" name="submit" class="quoteBtn btn btn-primary  btn-sm mt-2" value="Borrar mensaje"/>
                            </form>

                            <%
                                }
                            %>

                        </div>
                        
                        
                        <%
                            }
                        %>
                    </div>
                </div>
                <div class="col-10 p-3 msg">
                    <%=Utilities.formatMsgOutput(msg.getContent())%>
                </div>    
            </div>
            <%
                }
            %>

        </div>
        
        <div class="container col-12 p-5 pt-0">
            <div class="row">
                <%
                    if (request.getSession().getAttribute("user") != null) {
                %>
                <form method="post" action="ServletMessage"> 
                    <div class="col-12 form-group">
                        <input type="hidden" name="thread" value="<%=thread%>"/>
                        <label for="exampleFormControlTextarea1">Responder hilo</label>
                        <textarea class="form-control borde" id="area" rows="7" name="message"  placeholder="respuesta...."></textarea>
                    </div>
                    <div class="col-12 mt-4 d-flex align-content-end" >
                        <input type="submit" class="btn btn-primary align-self-end" name="submit" value="ENVIAR RESPUESTA"></a>
                    </div>
                </form>
                <%
                    }else{
                %>
                
                <div class="alert alert-warning text-center" role="alert">
                    Debes iniciar sesion para poder responder!
                </div>
                
                <%
                    }
                %>
            </div>
        </div>  
        <%
        } catch (Exception ex) {
        %>
        <p style="color:red">PÁGINA NO ENCONTRADA</p>
        <%
            }
        %>    
            
    </div>    
</div>
        
        
        
        
<!--IMPORTACIÓN DEL FOOTER-->
<jsp:include page="footer.jsp" />
