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
        <h3>REUNIONES INVITADO</h3>

        <br><br><br><br><br><br>
        <table border="1"  align="center">
            <tr bgcolor="gray">
                <th><font   color="black">Coordinador</font></th>
                <th><font   color="black">Nombre reunion</font></th>
                <th><font   color="black">ID lugar</font></th>
                <th><font color="black">Objetivos</font></th>
                <th><font color="black">Fecha</font></th>
                <th><font color="black">Hora</font></th>

            </tr>
            <%
                Connection cnxr = ConexionBD.getConexion();

                PreparedStatement sta = cnxr.prepareStatement("select * from usuarios where correo=?");
                sta.setString(1, usu);
                ResultSet rs1 = sta.executeQuery();
                PreparedStatement sta1 = null;
                PreparedStatement sta2 = null;
                ResultSet rs2=null;
                if (rs1.next()) {
                    sta1 = cnxr.prepareStatement("select * from participantes where ID_Usuario=?");
                    sta1.setInt(1, rs1.getInt("ID_Usuario"));
                }
                ResultSet rs = sta1.executeQuery();
                while (rs.next()) {
                    sta2 = cnxr.prepareStatement("select * from reunion where ID_Reunion=?");
                    sta2.setInt(1, rs.getInt("ID_Reunion"));
                    rs2 = sta2.executeQuery();
                    
                if (rs2.next()) {
            %>
            <tr>
                <th><%=rs2.getString("coordinadorReunion")%></th>
                <th><%=rs2.getString("nombreReunion")%></th>
                <th><%=rs2.getInt("ID_Lugar")%></th>
                <th><%=rs2.getString("objetivosReunion")%></th>
                <th><%=rs2.getString("fechaReunion")%></th>
                <th><%=rs2.getString("horaReunion")%></th>
            </tr>
            <%}}%>
        </table>
        <center>
        <a href="principalReuniones.jsp">
            <regresar>Regresar</regresar>
        </a>
    </center>
    </body>
</html>
