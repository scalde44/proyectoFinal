
<%@page import="java.sql.ResultSet"%>
<%@page import="Utils.ConexionBD"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<%
    String usu = "";
    String usuu = "";
    HttpSession sesionOk = request.getSession();
    if (sesionOk.getAttribute("usuario") == null) {
%>
<jsp:forward page="Login.jsp">
    <jsp:param name="msg" value="Ingresa Primero"/>
</jsp:forward>
<%
    } else {
        usu = (String) sesionOk.getAttribute("usuario");
        Connection cnxr = ConexionBD.getConexion();
        PreparedStatement sta = cnxr.prepareStatement("select * from usuarios where correo=?");
        sta.setString(1, usu);
        ResultSet rs = sta.executeQuery();
        if (rs.next()) {
            usuu = rs.getString("nombre");
        }
        rs.close();
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" href="Iconos/logo.png">
        <link href="estilos.css" rel="stylesheet" type="text/css">
        <title>Meeting Office</title>
    </head>
    <body background="Iconos/fondo1.png">
        <h3> 
            INICIO
        </h3>
        <br><br><br><br>
        <h2 align="center">
            <font size="4" color="black">
            BIENVENIDO
            </font>
        </h2>
        <h2 align="center">
            <font size="4" color="black">

            <% out.println(usuu);%>
            </font>
        </h2>
        <br><br><br><br>
        <table border="0" width="700" align="center">
            <tr>
                <th><a href="ServletReunion?accion=listar&usuario=<%=usuu%>">
                        <img src="Iconos/listaReuniones.png" width="70" height="70">
                    </a>
                    <p>Lista de reuniones</p></th>
                <th><a href="nuevaReunion.jsp">
                        <img src="Iconos/crearReunion.png" width="70" height="70">
                    </a><p>Crear reunion</p></th>
                <th></th><th></th><th></th><th></th><th></th><th></th><th></th>
                <th>
                    <a href="subirArchivo.jsp">
                        <img src="Iconos/subirArchivo.png" width="70" height="70">
                    </a><p>Subir archivos</p>
                </th>
                <th>
                    <a href="listaArchivos.jsp">
                        <img src="Iconos/subirArchivo.png" width="70" height="70">
                    </a><p>Buscar archivos</p>
                </th>
                <th>
                    <a href="reunionesInvitado.jsp">
                        <img src="Iconos/listaReuniones.png" width="70" height="70">
                    </a><p>Lista invitaciones</p>
                </th>
                <th>
                    <a href="listaCompromisos.jsp">
                        <img src="Iconos/listac.png" width="70" height="70">
                    </a><p>Mis compromisos</p>
                </th>
            </tr>
        </table>
        <br><br><br>
    <center>
        <%              if (request.getAttribute("msg") != null) {
        %><h4><%out.println(request.getAttribute("msg"));%></h4><%
            }
        %>
    </center>
    <center>
        <a href="SalirLogin.jsp">
            <img src="Iconos/salirLogin.png" width="50" height="50">
        </a><p>Cerrar Sesión</p>
    </center>
</body>
</html>
