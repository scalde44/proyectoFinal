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
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="UsuarioBEANS.Usuario" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" href="Iconos/logo.png">
        <link href="estilos.css" rel="stylesheet" type="text/css">
        <title>Meeting Office</title>
    </head>
    <body background="Iconos/fondo1.png">
        <h3>USUARIOS</h3>
        <br><br><br><br><br><br>
        <table border="1" width="600" height="100" align="center">
            <tr bgcolor="gray">
                <th><font   color="black">ID</font></th>
                <th><font   color="black">Nombre</font></th>
                <th><font color="black">Correo</font></th>
                <th><font color="black">Contraseña</font></th>
                <th><font color="black">Estado</font></th>
                <th><font color="black">Accion</font></th>
            </tr>
            <%
                ArrayList<Usuario> lista
                        = (ArrayList<Usuario>) request.getAttribute("lista");
                for (int i = 0; i < lista.size(); i++) {
                    Usuario u = lista.get(i);
            %>
            <tr>
                <th><%=u.getID_Usuario()%></th>
                <th><%=u.getNombre()%></th>
                <th><%=u.getCorreo()%></th>
                <th><%=u.getContrasena()%></th>
                <th><%=u.getEstado()%></th>
                <th>


                    <a href="ServletMantenimiento?accion=desactivar&id=<%=u.getID_Usuario()%>">
                        <image src="Iconos/desactivar.png" width="30" heigth="30">
                    </a>
                    <a href="ServletMantenimiento?accion=activar&id=<%=u.getID_Usuario()%>">
                        <image src="Iconos/activar.png" width="30" heigth="30">
                    </a>
                </th>


            </tr>
            <%
                }
            %>
        </table>
    <center>
        <a href="principal.jsp">
            <regresar>Regresar</regresar>
        </a>
    </center>
</body>
</html>
