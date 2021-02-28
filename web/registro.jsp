<%-- 
    Document   : registro
    Created on : 28-feb-2021, 14:20:54
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>REGISTRO</h1>
        <form method="POST" action="RegistryServlet">
            <input type="text" name="username" placeholder="USAURIO"/>
            <br/>
            <input type="password" name="password" placeholder="CONTRASEÑA"/>
            <br/>
            <input type="password" name="confirm" placeholder="REPITE CONTRASEÑA"/>
            <br/>
            <input type="email" name="email" placeholder="CORREO ELECTRÓNICO"/>
            <br/>
            <input type="submit" name="submit" value="REGISTRARSE"/>
        </form>

    </body>
</html>
