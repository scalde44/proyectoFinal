<%@page import="java.sql.PreparedStatement"%>
<%@page import="Utils.ConexionBD"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%
    String usu = "";
    String usuu="";
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
        if(rs.next()){
        usuu=rs.getString("nombre");
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
    <inse>CREAR REUNION</inse>
    <form class="bax">
        <img src="Iconos/crearReunion.png" width="100" height="100">
    </form>
    <a href="principalReuniones.jsp">
        <regresarse>Regresar</regresarse>
    </a>
    <br><br><br><br><br><br><br>
    <form action="ServletReunion" class="reunion">
        <input type="text" name="txtNombreReunion" placeholder="Nombre Reunion" required="">

        <input type="text" name="txtAsunto" placeholder="Objetivos" required="required">
        <input type="date" name="txtFecha" min="2019-03-20"
               max="2019-12-31" step="1" required>
        <input type="time" name="txtHora" min="07:00"
               max="21:00" step="60" required>
        <h4>Lugar:</h4>
        <jsp:useBean id="cn" class="Servlets.ServletReunion" scope="page"></jsp:useBean>
        <%
            ResultSet rs = cn.mostrar();
            
        %>

        <select name="txtLugar" required>
            <%
                while (rs.next()) {

            %>

            <option value="<%=rs.getInt("ID_Lugar")%>"><%=rs.getString("nombreLugar")%> </option>
            <%
                }
            %>
        </select>
        <input type="submit" name="btnl" value="Crear Reunion">
        <input type="hidden" name="accion" value="crear">
        <input type="hidden" name="usuario" value="<%=usuu%>">
        <%
            if (request.getAttribute("msg") != null) {
        %><h4><%out.println(request.getAttribute("msg"));%></h4><%
                        }
        %>
    </form>


</body>
</html>
