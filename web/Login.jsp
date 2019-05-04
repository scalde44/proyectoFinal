
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
        <form class="login" action="ServletLogin" method="post">
            <h2>Login</h2>
            <input type="email" name="txtCorreo" placeholder="Correo" required>
            <input type="password" name="txtContra" placeholder="Contraseña" required> 
            <input type="submit" name="btn" value="Ingresar">
            
                   <%
                if (request.getAttribute("msg") != null) {
                    %><h4><%out.println(request.getAttribute("msg"));%></h4><%
                }
            %>
            <font color="white">Olvide mi contraseña, haz click <a href="recuperarContrasena.jsp"><font color="white">aquí</font></a></font>
        </form>
        
    </body>
</html>
