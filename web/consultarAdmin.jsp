<%
    String usu = "";
    HttpSession sesionOkk = request.getSession();
    if (sesionOkk.getAttribute("administrador") == null) {
%>
<jsp:forward page="Login.jsp">
    <jsp:param name="msg" value="Ingresa Primero"/>
</jsp:forward>
<%
    } else {
        usu = (String) sesionOkk.getAttribute("administrador");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <link rel="shortcut icon" href="Iconos/logo.png">
        <link href="estilos.css" rel="stylesheet" type="text/css">
        
        <link href="estilos2.css" rel="stylesheet" type="text/css">
        <title>Meeting Office</title>
    </head>
   <body background="Iconos/fondo1.png">
        <inse>CONSULTAR ADMINISTRADORES</inse>
        <form class="bax">
            <img src="Iconos/consultarAdmin.png" width="100" height="100">
        </form>
        <br><br><br><br><br><br><br>
        <form action="ServletMantenimiento" class="consulta">
            
            <h2>Ingrese Correo:</h2> 
                <input type="text" name="txtCorreo">
                <input type="submit" name="bntl" value="Consultar">
                <input type="hidden" name="accion" value="consultarAdmin">
            
        </form>
        <br>
    <center>
        <a href="principal.jsp">
            <regresar>Regresar</regresar>
        </a>
    </center>
</body>
</html>
