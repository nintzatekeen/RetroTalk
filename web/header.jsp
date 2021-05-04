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