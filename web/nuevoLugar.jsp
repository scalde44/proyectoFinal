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
        <title>Meeting Office</title>
    </head>
    <body background="Iconos/fondo1.png">
    <inse>Nuevo Lugar</inse>
    <form class="bax">
        <img src="Iconos/abrir.png" width="100" height="100">
    </form>
    <form action="ServletMantenimiento" class="insertar">
        <input type="text" name="txtLugar" placeholder="Lugar"required>
        <input type="submit" name="btnl"value="Grabar Lugar">
        <input type="hidden" name="accion" value="lugar">
        <%
            if (request.getAttribute("msg") != null) {
        %><h4><%out.println(request.getAttribute("msg"));%></h4><%
            }
        %>
    </form>
    <br>
    <center>
        <a href="principal.jsp">
            <regresarse>Regresar</regresarse>
        </a>
    </center>
</body>
</html>
