<%-- 
    Document   : index
    Created on : 20 feb. 2021, 18:06:02
    Author     : ACER
--%>

<%@page import="beans.User"%>
<%@page import="beans.Category"%>
<%@page import="java.util.List"%>
<%@page import="dao.DaoRetro"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
                    <h2 class="m-5 titulo bordeneon">Categorias</h2>
                </div>
                
                <%
                    User user = (User) session.getAttribute("user");
                    if (utils.Utilities.checkAdmin(user)) {
                %>
                <div class="col-12 ">
                    <a href ="createCategory.jsp" class="btn btn-primary me-5 ms-5 mb-2">CREAR CATEGORÍA</a>
                </div>
                <%
                    }
                %>
                
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-8">
                            <hr>
                        </div>
                    </div>
                    
                    <%
                        List<Category> list = dao.DaoRetro.getCategories();
                        for (Category c : list) {
                    %>
                   
                    <div class="row justify-content-center">

                        <div class="col-12 col-lg-11">
                            <a href='threads.jsp?cat=<%=c.getId()%>'>
                                <div class="d-flex m-2 col categoria">
                                    <div class="bd-placeholder-img flex-shrink-0 me-4 ms-4 rounded">
                                        <div class="rounded-circle icono">
                                            <i class="fas fa-globe"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <h3><%=c.getName()%></h3>
                                        <p class="descripcion"><%=c.getDescription()%></p>
                                    </div>
                                </div>
                            </a>
                        </div>

                    </div> 
                    
                    <div class="row justify-content-center">
                        <div class="col-8">
                            <hr>
                        </div>
                    </div>
                    <%
                        }
                    %>
                    
                </div>                
            </div>
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
