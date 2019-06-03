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
        <h3>MIS COMPROMISOS</h3>

        <br><br><br><br><br><br>
        <table border="1"  align="center">
            <tr bgcolor="gray">
                <th><font   color="black">ID Compromiso</font></th>
                <th><font   color="black">Compromiso</font></th>
                <th><font   color="black">Responsable</font></th>
                <th><font color="black">ID Reunion</font></th>
                <th><font color="black">Estado</font></th>
                <th><font color="black">Acción</font></th>
            </tr>
            <%
                Connection cnxr = ConexionBD.getConexion();

                PreparedStatement sta = cnxr.prepareStatement("select * from usuarios where correo=?");
                sta.setString(1, usu);
                ResultSet rs1 = sta.executeQuery();
                PreparedStatement sta1 = null;
                if (rs1.next()) {
                    sta1 = cnxr.prepareStatement("select * from compromisosReunion where ID_Usuario=?");
                    sta1.setInt(1, rs1.getInt("ID_Usuario"));
                }
                ResultSet rs4 = sta1.executeQuery();
                while (rs4.next()) {
            %>
            <tr>
                <th><%=rs4.getInt(1)%></th>
                <th><%=rs4.getString(2)%></th>
                <th><%=usuu%></th>
                <th><%=rs4.getInt(4)%></th>
                <th><%=rs4.getString(5)%></th>
                <th>
                    <a href="ServletReunion?accion=pendiente&idCompromiso=<%=rs4.getInt(1)%>">
                        <img src="Iconos/pendiente.png" width="30" heigth="30">
                    </a>
                    <a href="ServletReunion?accion=realizado&idCompromiso=<%=rs4.getInt(1)%>">
                        <img src="Iconos/activar.png" width="30" heigth="30">
                    </a>
                </th>
            </tr>
            <%
                }
                rs1.close();
                rs4.close();
                cnxr.close();
            %>
        </table>
    <center>
        <a href="principalReuniones.jsp">
            <regresar>Regresar</regresar>
        </a>
    </center>
</body>
</html>
