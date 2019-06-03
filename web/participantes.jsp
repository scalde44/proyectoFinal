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
        <h3>PARTICIPANTES</h3>
        <%
            int idReunion = Integer.parseInt(request.getParameter("idReunion"));
            String nomReunion = request.getParameter("nombre");
            String lugar = request.getParameter("lugar");
            String fecha = request.getParameter("fecha");
            String hora = request.getParameter("hora");
            String objetivos = request.getParameter("objetivos");
        %>
        <br><br><br><br><br><br>
        <table border="1"  align="center">
            <tr bgcolor="gray">
                <th><font   color="black">ID usuario</font></th>
                <th><font   color="black">Nombre</font></th>
                <th><font   color="black">ID reunion</font></th>
                <th><font color="black">Accion</font></th>
                <th><font color="black">Estado</font></th>
            </tr>
            <jsp:useBean id="cn" class="Servlets.ServletReunion" scope="page"></jsp:useBean>

            <%
                ResultSet rs = cn.mostrarIDname();
                while (rs.next()) {
                    ResultSet rs1 = cn.participantesEstaReunion(idReunion, rs.getInt("ID_Usuario"));
            %>
            <tr>
                <th><font   color="black"><%=rs.getInt("ID_Usuario")%></font></th>
                <th><font   color="black"><%=rs.getString("nombre")%></font></th>
                <th><font   color="black"><%=idReunion%></font></th>
                <th>
                    <a href="ServletReunion?accion=vincularParticipante&idReunion=<%=idReunion%>&idUsuario=<%=rs.getInt("ID_Usuario")%>&correo=<%=rs.getString("correo")%>&coordinador=<%=usuu%>&usuario=<%=rs.getString("nombre")%>&nombreR=<%=nomReunion%>&lugarR=<%=lugar%>&fecha=<%=fecha%>&hora=<%=hora%>&objetivos=<%=objetivos%>">
                        <img src="Iconos/nuevoParticipante.png" width="30" heigth="30">
                    </a>
                    <a href="ServletReunion?accion=desvincularParticipante&idReunion=<%=idReunion%>&idUsuario=<%=rs.getInt("ID_Usuario")%>&correo=<%=rs.getString("correo")%>&coordinador=<%=usuu%>&usuario=<%=rs.getString("nombre")%>&nombreR=<%=nomReunion%>&lugarR=<%=lugar%>&fecha=<%=fecha%>&hora=<%=hora%>&objetivos=<%=objetivos%>">
                        <img src="Iconos/desvincularParticipante.png" width="30" heigth="30">
                    </a>
                </th>
                <th><font   color="black"><%if (rs1.next()) {
                        out.println("VINCULADO");
                    } else {
                        out.println("NO VINCULADO");
                    }%></font></th>
            </tr>
            <%
                }
                rs.close();

            %>

        </table>

    <center>
        <%              if (request.getAttribute("msg") != null) {
        %><h4><%out.println(request.getAttribute("msg"));%></h4><%
            }
        %>
        <a href="ServletReunion?accion=listar&usuario=<%=usuu%>">
            <regresar>Regresar</regresar>
        </a>
    </center>
</body>
</html>