<%@page import="Utils.ConexionBDReunion"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Utils.ConexionBD"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
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
        <h3>COMPROMISOS</h3>
        <%
            int idReunion = Integer.parseInt(request.getParameter("idReunion"));
            String agregar = request.getParameter("agregar");
        %>
        <br><br><br><br><br><br>
        <table border="1" align="center">
            <tr bgcolor="gray">
                <th><font   color="black">ID Compromiso</font></th>
                <th><font   color="black">Compromiso</font></th>
                <th><font   color="black">ID Responsable</font></th>
                <th><font color="black">ID Reunion</font></th>
                <th><font color="black">Estado</font></th>
                    <%
                        Connection cnxr = ConexionBDReunion.getConexion();
                        PreparedStatement sta = cnxr.prepareStatement("select * from compromisosReunion where ID_Reunion=?");
                        sta.setInt(1, idReunion);
                        ResultSet rs = sta.executeQuery();
                        while (rs.next()) {
                    %>
            <tr>
                <th><font   color="black"><%=rs.getString(1)%></font></th>
                <th><font   color="black"><%=rs.getString(2)%></font></th>
                <th><font   color="black"><%=rs.getString(3)%></font></th>
                <th><font   color="black"><%=rs.getString(4)%></font></th>
                <th><font   color="black"><%=rs.getString(5)%></font></th>
            </tr>    
            <%
                }rs.close();cnxr.close();
            %>
        </tr>

    </table>
<center>
    <%              if (request.getAttribute("msg") != null) {
    %><h4><%out.println(request.getAttribute("msg"));%></h4><%
        }
    %>
    <%if (agregar.equalsIgnoreCase("si")) {%>
    <a href="nuevoCompromiso.jsp?idR=<%=idReunion%>">
        <img src="Iconos/anadir.png" width="40" height="40">

    </a>

    <p1>Nuevo</p1>
        <%} else {%>
    <img src="Iconos/anadir.png" width="40" height="40">
    <p1>Nuevo</p1>
        <%}%>
        <%if (agregar.equalsIgnoreCase("si")) {%>
    <a href="actaReunion.jsp?idR=<%=idReunion%>">
        <img src="Iconos/acta.png" width="40" height="40">

    </a>

    <p1>Acta</p1>
        <%} else {%>
    <img src="Iconos/acta.png" width="40" height="40">
    <p1>Acta</p1>
        <%}%>
        <%if (agregar.equalsIgnoreCase("noo")) {%>
    <a href="reunionesInvitado.jsp">
        <regresar>Regresar</regresar>
    </a>
    <%} else {%>
    <a href="ServletReunion?accion=listar&usuario=<%=usuu%>">
        <regresar>Regresar</regresar>
    </a>
    <%}%>
</center>
</body>
</html>
