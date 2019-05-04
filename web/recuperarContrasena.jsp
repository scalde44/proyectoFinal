<%-- 
    Document   : recuperarContrasena
    Created on : 30/03/2019, 04:32:13 PM
    Author     : steve
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" href="Iconos/logo.png">
        <link href="estilos.css" rel="stylesheet" type="text/css">
        <title>Meeting Office</title>
    </head>
    <body background="Iconos/fondo1.png">
        
        <h1>MEETING OFFICE</h1>
        <form class="bax">
        <img src="Iconos/logo.png">
        </form>
        <form class="login" action="ServletLogin" method="get">
            <h2>RECUPERAR CONTRASEÑA</h2>
            <input type="email" name="txtCorreo" placeholder="Correo" required>
            <input type="submit" name="btn" value="Recuperar Contraseña">
            <a href="Login.jsp"><font color="white">Login</font></a>
                   <%
                if (request.getAttribute("msg") != null) {
                    %><h4><%out.println(request.getAttribute("msg"));%></h4><%
                }
            %>
        </form>
        
    </body>
</html>
