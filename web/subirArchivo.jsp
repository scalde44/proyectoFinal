

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<%
    String usu = "";
    HttpSession sesionOk = request.getSession();
    if (sesionOk.getAttribute("usuario") == null) {
%>
<jsp:forward page="Login.jsp">
    <jsp:param name="msg" value="Ingresa Primero"/>
</jsp:forward>
<%
    } else {
        usu = (String) sesionOk.getAttribute("usuario");
    }
%>
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
    <inse>SUBIR ARCHIVO</inse>
    <form class="bax">
        <img src="Iconos/crearReunion.png" width="100" height="100">
    </form>
    <a href="principalReuniones.jsp">
        <regresarse>Regresar</regresarse>
    </a>
    <form action="ServletArchivos" enctype="multipart/form-data" method="post" class="archivos">



        <font color="white">SELECCIONA UN ARCHIVO:</font>
        <input type="file" name="archivoSubido">
        <input type="submit" name="btnSubir" value="Subir">
        <input type="hidden" name="accion" value="subir">
        <%
            if (request.getAttribute("msg1") != null) {
        %><h4><font color="white"><%out.println(request.getAttribute("msg1"));%></font></h4><%
            }
        %>


    </form>
</body>
</html>
