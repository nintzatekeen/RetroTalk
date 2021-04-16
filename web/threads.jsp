<%-- 
    Document   : threads
    Created on : 05-mar-2021, 8:00:50
    Author     : dw2
--%>

<%@page import="utils.Utilities"%>
<%@page import="beans.User"%>
<%@page import="dao.DaoRetro"%>
<%@page import="beans.ForumThread"%>
<%@page import="java.util.Collection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="bootstrap/js/jquery.js"></script>
        <script src="bootstrap/js/bootstrap.js"></script>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="fontawesome/css/all.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="script/scripts.js"></script>
        <meta name="viewport" content="width=device-width height=device-height">
    </head>
    <body class="bg-dark text-light">
        <header class="header vertical-center  justify-content-center d-flex align-items-center">
            <div class="text-white text-center align-middle">
                <h1 class="d-none">RetroTalk</h1>
                <a class=""><img src="images/logo_RetroTalk.png" class="img-fluid logo" alt="logo"></a>
            </div>
        </header>

        <nav class="menu navbar navbar-expand-lg navbar-dark menu ">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">RetroTalk</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="#">Opcion1</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Opcion2</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Categorias
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="#">Categoria 1</a></li>
                                <li><a class="dropdown-item" href="#">Categoria 2</a></li>
                                <li><a class="dropdown-item" href="#">Categoria 3</a></li>
                                <li><a class="dropdown-item" href="#">Categoria 4</a></li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" tabindex="-1">Opcion3</a>
                        </li>
                    </ul>
                    <ul class="navbar-nav mb-2 mr-2 mb-lg-0">
                        <li class="nav-item dropdown mr-3">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-user"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="#">Mi cuenta</a></li>
                                <li><a class="dropdown-item" href="#">Opcion1</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="#">Cerrar sesion</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="wrapper container ">
            <div class="row colorfondo justify-content-end p-3  mt-5">
                <div class="col-lg-4 col-8 align-self-end">
                    <form class="d-flex me-5 ms-5">
                        <input class="form-control me-2" type="search" placeholder="Buscar" aria-label="Search">
                        <button class="btn btn-primary" type="submit"><i class="fas fa-search"></i></button>
                    </form>
                </div>
            </div>

            <div class="mt-3 row p-3 colorfondo ">
                <div class="col-12 ">
                    <h2 class="m-5 titulo bordeneon">Hilos: Categoria</h2> <!--Necesito el nombre de la categoria-->
                </div>
                
               
                <div class="col-12 ">
                    <a href ="createCategory.jsp" class="btn btn-primary me-5 ms-5 mb-2">CREAR CATEGORÍA</a>
                </div>
                
                <div class="col-12 mt-3">
                    <div class=" me-5 ms-5 justify-content-center headerHilo">
                        
                        <div class="row my-auto">
                            <div class="col-2 ps-4">
                                <p>Autor</p>
                            </div>
                            <div class="col-7 ">
                                <p>Tema</p>
                            </div>
                            <div class="col-1 ">
                                <p>Resp.</p>
                            </div>
                            <div class="col-2 ">
                                <p>Ult. Mensaje</p>
                            </div>
                        </div>
                        
                    </div> 
                </div>
                
                <div class="col-12">
                    <div class=" me-5 ms-5 justify-content-center hilo">
                        
                        <div class="row pt-2 pb-2">
                            <div class="col-2">
                                <div class="d-flex">
                                    <img src="images/fotoperfil.jpg" class="img-fluid me-3 d-block  fotoPerfil" alt="Responsive image">
                                    <a class="text-center my-auto ">Autor</a>
                                </div>
                            </div>
                            <div class="col-7 my-auto">
                                <h4>Las consolas mas vendidas</h4>
                            </div>
                            <div class="col-1 my-auto">
                                <p>55</p>
                            </div>
                            <div class="col-2 my-auto">
                                <p>Ult Mens</p>
                            </div>
                        </div>
                        
                    </div> 
                    
                    <div class=" me-5 ms-5 justify-content-center hilo">
                        
                        <div class="row pt-2 pb-2">
                            <div class="col-2">
                                <div class="d-flex">
                                    <img src="images/fotoperfil.jpg" class="img-fluid me-3 d-block  fotoPerfil" alt="Responsive image">
                                    <a class="text-center my-auto ">Autor</a>
                                </div>
                            </div>
                            <div class="col-7 my-auto">
                                <h4>Las consolas mas vendidas</h4>
                            </div>
                            <div class="col-1 my-auto">
                                <p>55</p>
                            </div>
                            <div class="col-2 my-auto">
                                <p>Ult Mens</p>
                            </div>
                        </div>
                        
                    </div> 
                </div>
                
                <div class="col-12 mt-5">
                    <nav class="me-5 ms-5 ">
                        <ul class="pagination justify-content-center navegador">
                            <li class="page-item flechas deshabilitado">
                                <a class="page-link" href="#" tabindex="-1">&laquo; Atras</a>
                            </li>
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item flechas">
                                <a class="page-link" href="#">Siguiente &raquo;</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>    

            
            
                   
                
            
            
            
            <c:if test="${requestScope.error != null}">
                <p style="color:red">${requestScope.error}</p>
            </c:if>
            <c:choose>
                <c:when test="${param.cat != null}">
                    <a href="createThread.jsp?cat=${param.cat}">CREAR HILO</a>
                    <%
                        try {
                            Integer cat = Integer.parseInt(request.getParameter("cat"));
                            Integer pag = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 0;
                            User user = (User) session.getAttribute("user");
                            if (Utilities.checkAdmin(user)) {
                    %>


                    <form method="post" action="CategoryRemoveServlet">
                        <input type="hidden" name="category" value="<%=cat%>"/>
                        <input type="submit" name="submit" value="BORRAR CATEGORÍA"/>
                    </form>
                    <%
                        }
                        Collection<ForumThread> threads = dao.DaoRetro.getThreads(cat, pag);
                        out.print("<ul>");
                        for (ForumThread thread : threads) {
                    %>
                    <li><a href='thread.jsp?thread=<%=thread.getId()%>'><%=thread.getTitle()%></a></li>
                        <%
                            }
                            out.print("</ul>");

                            int lastPage = DaoRetro.getLastCategoryPage(cat);
                        %>
                    <nav aria-label="Page navigation example">
                        <ul class="pagination">
                            <li class="page-item">
                                <a class="page-link" href="threads.jsp?cat=<%=cat%>&page=0" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <%
                                if (pag != 0) {
                            %>
                            <li class="page-item"><a class="page-link" href="threads.jsp?cat=<%=cat%>&page=<%=pag - 1%>"><%=pag%></a></li>
                                <%
                                    }
                                %>
                            <li class="page-item"><a class="page-link" aria-disabled="true" href="threads.jsp?cat=<%=cat%>&page=<%=pag%>"><%=pag + 1%></a></li>
                                <%
                                    if (pag != lastPage) {
                                %>
                            <li class="page-item"><a class="page-link" href="threads.jsp?cat=<%=cat%>&page=<%=pag + 1%>"><%=pag + 2%></a></li>
                                <%
                                    }
                                %>
                            <li class="page-item">
                                <a class="page-link" href="threads.jsp?cat=<%=cat%>&page=<%=lastPage%>" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>

                    <%
                    } catch (Exception ex) {
                    %>
                    <p style="color:red">
                        PÁGINA NO ENCONTRADA
                    </p>
                    <%
                        }

                    %>
                </c:when>
                <c:otherwise>
                    <p style="color:red">
                        PÁGINA NO ENCONTRADA
                    </p>
                </c:otherwise>
            </c:choose>
        </div>



        <ul>

        </ul>

        <footer class="container">
            <div class="row my-5 justify-content-center py-5">
                <div class="col-11">
                    <div class="row ">
                        <div class="col-xl-8 col-md-4 col-sm-4 col-12 my-auto mx-auto a">
                            <h3 class="text-muted mb-md-0 mb-5 bold-text">RetroTalk</h3>
                        </div>
                        <div class="col-xl-2 col-md-4 col-sm-4 col-12">
                            <h6 class="mb-3 mb-lg-4 text-muted bold-text mt-sm-0 mt-5"><b>MENU</b></h6>
                            <ul class="list-unstyled">
                                <li>Home</li>
                                <li>About</li>
                                <li>Blog</li>
                                <li>Portfolio</li>
                            </ul>
                        </div>
                        <div class="col-xl-2 col-md-4 col-sm-4 col-12">
                            <h6 class="mb-3 mb-lg-4 text-muted bold-text mt-sm-0 mt-5"><b>ADDRESS</b></h6>
                            <p class="mb-1">605, RATAN ICON BUILDING</p>
                            <p>SEAWOODS SECTOR</p>
                        </div>
                    </div>
                    <div class="row ">
                        <div class="col-xl-8 col-md-4 col-sm-4 col-auto my-md-0 mt-5 order-sm-1 order-3 align-self-end">
                            <p class="social text-muted mb-0 pb-0 bold-text"> <span class="mx-2"><i class="fa fa-facebook" aria-hidden="true"></i></span> <span class="mx-2"><i class="fa fa-linkedin-square" aria-hidden="true"></i></span> <span class="mx-2"><i class="fa fa-twitter" aria-hidden="true"></i></span> <span class="mx-2"><i class="fa fa-instagram" aria-hidden="true"></i></span> </p><small class="rights"><span>&#174;</span> Pepper All Rights Reserved.</small>
                        </div>
                        <div class="col-xl-2 col-md-4 col-sm-4 col-auto order-1 align-self-end ">
                            <h6 class="mt-55 mt-2 text-muted bold-text"><b>ANIRUDH SINGLA</b></h6><small> <span><i class="fa fa-envelope" aria-hidden="true"></i></span> anirudh@gmail.com</small>
                        </div>
                        <div class="col-xl-2 col-md-4 col-sm-4 col-auto order-2 align-self-end mt-3 ">
                            <h6 class="text-muted bold-text"><b>RISHABH SHEKHAR</b></h6><small><span><i class="fa fa-envelope" aria-hidden="true"></i></span> rishab@gmail.com</small>
                        </div>
                    </div>
                </div>
            </div>
        </footer>   
    </body>
</html>