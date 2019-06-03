<%@page import="java.io.File"%>
<%@page import="UsuarioBEANS.RutaFicheros"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Utils.ConexionBD"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="UsuarioBEANS.Reuniones"%>
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
        <h3>ARCHIVOS</h3>

        <br><br><br><br>
        <table border="1"  align="center">
            <tr bgcolor="gray">
                <th><font   color="black">Nombre archivo</font></th>
                <th><font   color="black">Direccion Archivo</font></th>
                <th><font color="black">Tamaño</font></th>
                <th><font color="black">Abrir</font></th>
            </tr>
            <%
                RutaFicheros rf = new RutaFicheros();
                for (int i = 0; i < rf.listar().length; i++) {
                    File fichero = rf.listar()[i];
                    long tamano = fichero.length() / 1024;
                    String tamanoarchivo = Long.toString(tamano) + " KB";
            %>
            <tr>
                <th><%=fichero.getName()%></th>
                <th><%=fichero.getAbsolutePath()%></th>
                <th><%=tamanoarchivo%></th>
                <th>
                    <a href="ServletArchivos?accion1=abrir&nombre=<%=fichero.getName()%>">
                        <img src="Iconos/listaReuniones.png" width="30" height="30">
                    </a>
                </th>
            </tr>
            <%
                }
            %>
        </table>
    <center>
        <a href="principalReuniones.jsp">
            <regresar>Regresar</regresar>
        </a>
    </center>
</body>
</html>
