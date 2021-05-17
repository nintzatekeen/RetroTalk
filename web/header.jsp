<%@page import="beans.User"%>
<%@page import="java.util.List"%>
<%@page import="beans.Category"%>
<%@page import="beans.Category"%>
<!DOCTYPE html>
<html>
    <html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="fontawesome/css/all.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="script/scripts.js"></script>
        <script src="bootstrap/js/bootstrap.js"></script>
        <meta name="viewport" content="width=device-width height=device-height">
    </head>
    <body class="bg-dark text-light">
        <header class="header vertical-center  justify-content-center d-flex align-items-center">
            <div class="text-white text-center align-middle">
                <h1 class="d-none">RetroTalk</h1>
                <a class="" href="index.jsp"><img src="images/logo_RetroTalk.png" class="img-fluid logo" alt="logo"></a>
            </div>
        </header>

        <nav class="menu navbar navbar-expand-lg navbar-dark menu ">
            <div class="container-fluid">
                <a class="navbar-brand" href="index.jsp">RetroTalk</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Categorias
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="index.jsp">Todas las categorias</a></li>
                                <%
                                    List<Category> list = dao.DaoRetro.getCategories();
                                    for (Category c : list) {
                                %>
                                <li><a class="dropdown-item" href='threads.jsp?cat=<%=c.getId()%>'><%=c.getName()%></a></li>
                                <%
                                    }
                                %>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="ShopServlet" tabindex="-1">Tienda</a>
                        </li>
                    </ul>
                    <ul class="navbar-nav mb-2 mr-2 mb-lg-0">
                        <li class="nav-item dropdown mr-3">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-user"></i>
                            </a>
                            <ul class="dropdown-menu menu-right" aria-labelledby="navbarDropdown">
                                <%
                                    if (request.getSession().getAttribute("user") != null) {
                                        User user = (User) request.getSession().getAttribute("user");
                                %>
                                <li><a class="dropdown-item" href="profile.jsp?user=<%=user.getId()%>">Mi cuenta</a></li>
                                <li><a class="dropdown-item" href="editProfile.jsp?user=<%=user.getId()%>">Editar perfil</a></li>
                                <li><a class="dropdown-item" href="userThreads.jsp?user=<%=user.getId()%>">Mis hilos creados</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="LogoutServlet">Cerrar sesion</a></li>
                                <%
                                    }else{
                                %>
                                <li><a class="dropdown-item" href="login.jsp">Iniciar sesion</a></li>
                                <li><a class="dropdown-item" href="registro.jsp">Registrarse</a></li>
                                
                                <%
                                    }
                                %>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>