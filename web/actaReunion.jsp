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
        <link href="estilos3.css" rel="stylesheet" type="text/css">
        <title>Meeting Office</title>
    </head>
    <body background="Iconos/fondo1.png">
    <inse>ACTA</inse>
    <form class="bax">
        <img src="Iconos/crearReunion.png" width="100" height="100">
    </form>

    <form action="ServletActas" method="get" target="_blank" class="reunion">
        <%
            int idReunion = Integer.parseInt(request.getParameter("idR"));
            Connection cnxr = ConexionBD.getConexion();
            PreparedStatement sta = cnxr.prepareStatement("select * from reunion where ID_Reunion=?");
            sta.setInt(1, idReunion);
            ResultSet rs = sta.executeQuery();
            while (rs.next()) {
        %>

        <font color="white">Comentarios</font><input type="text" name="txtComentariosReunion" required="">

        <input type="submit" name="btnl" value="Generar Acta">
        <a class="boton" href="principalReuniones.jsp">Finalizar</a>
        <input type="hidden" name="idR" value="<%=idReunion%>">
        <input type="hidden" name="accion" value="generarActa">
    </form>
    <a href="compromisos.jsp?idReunion=<%=idReunion%>&agregar=si">
        <regresarse>Regresar</regresarse>
    </a>
    <%}

        rs.close();
cnxr.close();

    %>


</body>
</html>
