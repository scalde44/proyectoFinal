<%@page import="Utils.ConexionBD"%>
<%@page import="java.sql.PreparedStatement"%>
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
        }rs.close();
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
        <h3>ASISTENCIA</h3>

        <br><br><br><br><br><br>
        <form action="actaReunion.jsp">
            <table border="1" align="center">
                <tr bgcolor="gray">
                    <th><font   color="black">ID Usuario</font></th>
                    <th><font   color="black">Nombre</font></th>
                    <th><font   color="black">Correo</font></th>
                    <th><font   color="black">Asistencia</font></th>
                </tr>
                <%
                    int Id = Integer.parseInt(request.getParameter("idReunion"));
                    Connection cnxr = ConexionBD.getConexion();
                    PreparedStatement sta = cnxr.prepareStatement("select * from participantes where ID_Reunion=?");
                    sta.setInt(1, Id);
                    ResultSet rs = sta.executeQuery();
                    ResultSet rs1 = null;

                    while (rs.next()) {
                        PreparedStatement sta1 = cnxr.prepareStatement("select * from usuarios where ID_Usuario=?");
                        sta1.setString(1, rs.getString("ID_Usuario"));
                        rs1 = sta1.executeQuery();
                        while (rs1.next()) {
                %>

                <tr>
                    <th><%=rs1.getString(1)%></th>
                    <th><%=rs1.getString(2)%></th>
                    <th><%=rs1.getString(3)%></th>
                    <th><input type="checkbox" name="asistentes" id="<%=rs1.getString(2)%>" value="<%=rs1.getString(2)%>"></th>
                </tr>
                <%}
                    }
                    rs.close();
cnxr.close();
                %>

            </table>
            <center>
                <input type="submit" name="btnl" value="Siguiente">

                <input  type = "hidden" name = "idR" value ="<%=Id%>">
            </center>
        </form>
    </body>
</html>
