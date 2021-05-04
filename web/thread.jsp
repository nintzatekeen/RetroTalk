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
        
        <div class="container col-12 p-5">
            <div class="row mb-4">
                <div class="col-12 colorfondo2">
                    <p class="p-1 ps-3 my-auto text-muted"><i class="fas fa-calendar-week pe-2"></i>12/12/1111</p>
                </div>
                <div class="col-2 colorfondo2">
                    <div class="row d-flex  p-3">
                        <h4 class="">Admin</h4>
                        <div><img src="images/fotoperfil.jpg" class="img-fluid d-block  fotoPerfil2 mt-3 mb-3 bordeneon" alt="Responsive image"></div>
                        <p>Usuario desde: 12/01/2001</p>
                        
                        <div class="btn-toolbar" role="toolbar">
                            <div class="btn-group dropdown">
                                <button class="btn btn-primary btn-sm  dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Opciones
                                </button>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item" href="#">Citar</a>
                                    <a class="dropdown-item" href="#">Borrar mensaje</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                 
                <div class="col-10 p-3">
                    <p>ajldfhljasd asdljkgfh dsljfgh sdlfghj sdfljgh dsfg hsdljkgh sdgj hsdlg hjsdflg sdig hsdfloigh sdfklg hsdlk skgh lksfhsdiig hsdoigh sdflikgh lskhg sdlihg </p>
                </div>
            </div>
            
            <div class="row mb-4">
                <div class="col-12 colorfondo2">
                    <p class="p-1 ps-3 my-auto text-muted"><i class="fas fa-calendar-week pe-2"></i>12/12/1111</p>
                </div>
                <div class="col-2 colorfondo2">
                    <div class="row d-flex p-3">
                        <h4 class="">Admin</h4>
                        <div><img src="images/fotoperfil.jpg" class="img-fluid d-block  fotoPerfil2 mt-3 mb-3 bordeneon" alt="Responsive image"></div>
                        <p class="">Usuario desde: 12/01/2001</p>
                    </div>
                </div>
                <div class="col-10 p-3">
                    <p>ajldfhljasd asdljkgfh dsljfgh sdlfghj sdfljgh dsfg hsdljkgh sdgj hsdlg hjsdflg sdig hsdfloigh sdfklg hsdlk skgh lksfhsdiig hsdoigh sdflikgh lskhg sdlihg </p>
                    <img src="https://e00-marca.uecdn.es/assets/multimedia/imagenes/2020/09/08/15995636175475.jpg" alt="img" class="img-fluid" style="max-height: 300px">
                </div>
            </div>
            
            <div class="row mb-4">
                <div class="col-12 colorfondo2">
                    <p class="p-1 ps-3 my-auto text-muted"><i class="fas fa-calendar-week pe-2"></i>12/12/1111</p>
                </div>
                <div class="col-2 colorfondo2">
                    <div class="row d-flex p-3">
                        <h4 class="">Admin</h4>
                        <div><img src="images/fotoperfil.jpg" class="img-fluid d-block  fotoPerfil2 mt-3 mb-3 borde" alt="Responsive image"></div>
                        <p class="">Usuario desde: 12/01/2001</p>
                    </div>
                </div>
                <div class="col-10 p-3">
                    <div class="">
                        <div class="col-12 colorfondo2">
                            <p class="p-1 ps-3 my-auto">Cita de admin</p>
                        </div>
                        <div class="align-self-end quote">
                            <p>asdrfdasdf asdf asdf sadfg sdf sde fsdf sefdsfs saefsdaf</p>  
                            <img src="https://e00-marca.uecdn.es/assets/multimedia/imagenes/2020/09/08/15995636175475.jpg" alt="img" class="img-fluid" style="max-height: 200px">
                        </div>
                    </div>
                    <p>ajldfhljasd asdljkgfh dsljfgh sdlfghj sdfljgh dsfg hsdljkgh sdgj hsdlg hjsdflg sdig hsdfloigh sdfklg hsdlk skgh lksfhsdiig hsdoigh sdflikgh lskhg sdlihg </p>
                    <img src="https://e00-marca.uecdn.es/assets/multimedia/imagenes/2020/09/08/15995636175475.jpg" alt="img" class="img-fluid" style="max-height: 300px">
                </div>
            </div>
        </div>
        
        <div class="container col-12 p-5 pt-0">
            <div class="row">
                <div class="col-12 form-group">
                    
                    <label for="exampleFormControlTextarea1">Responder hilo</label>
                    <textarea class="form-control borde" id="exampleFormControlTextarea1" rows="7" placeholder="respuesta...."></textarea>
                </div>
                <div class="col-12 mt-4 d-flex align-content-end" >
                    <input type="submit" class="btn btn-primary align-self-end" name="submit" value="ENVIAR RESPUESTA"></a>
                </div>
            </div>
        </div>
    </div>    
</div>
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
