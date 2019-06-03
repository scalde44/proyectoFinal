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
    <inse>NUEVO COMPROMISO</inse>
        <%
            int idReunion = Integer.parseInt(request.getParameter("idR"));
        %>
    <form class="bax">
        <img src="Iconos/anadir.png" width="100" height="100">
    </form>
    <a href="compromisos.jsp?idReunion=<%=idReunion%>&agregar=si">
        <regresarse>Regresar</regresarse>
    </a>
    <br><br><br><br><br><br><br>
    <form action="ServletReunion" class="reunion">
        <input type="text" name="txtCompromiso" placeholder="Compromiso" required="">
        <h2><font color="white">Responsable</font></h2>
        <select name="responsable">
            <%
                Connection cnxr = ConexionBDReunion.getConexion();
                PreparedStatement sta = cnxr.prepareStatement("select b.ID_Usuario,b.nombre from participantes a,usuarios b where "
                        + "a.ID_Usuario = b.ID_Usuario and a.ID_Reunion =?");
                sta.setInt(1, idReunion);
                ResultSet rs = sta.executeQuery();
                while (rs.next()) {
            %>
            <option value=<%=rs.getInt(1)%>><%=rs.getString(2)%></option>
            <%
                }
                cnxr.close();
            %>
        </select>
        <input type="submit" name="btnl" value="Agregar">
        <input type="hidden" name="accion" value="compromiso">
        <input type="hidden" name="idR" value=<%=idReunion%>>
    </form>
</body>
</html>
