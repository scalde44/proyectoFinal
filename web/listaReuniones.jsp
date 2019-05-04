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

<%@page import="java.util.ArrayList"%>
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
        <h3>REUNIONES</h3>

        <br><br><br><br><br><br>
        <table border="1"  align="center">
            <tr bgcolor="gray">
                <th><font   color="black">ID reunion</font></th>
                <th><font   color="black">Coordinador</font></th>
                <th><font   color="black">Nombre reunion</font></th>
                <th><font   color="black">ID lugar</font></th>
                <th><font color="black">Objetivos</font></th>
                <th><font color="black">Fecha</font></th>
                <th><font color="black">Hora</font></th>
                <th><font color="black">Estado</font></th>
                <th><font color="black">Invitados</font></th>
                <th><font color="black">Accion</font></th>
                <th><font color="black">Iniciar</font></th>
            </tr>
            <jsp:useBean id="cn" class="Servlets.ServletReunion" scope="page"></jsp:useBean>
            <%
                ArrayList<Reuniones> lista
                        = (ArrayList<Reuniones>) request.getAttribute("lista");
                for (int i = 0; i < lista.size(); i++) {
                    Reuniones r = lista.get(i);
                    ResultSet rs = cn.mostrarLugar(r.getID_Lugar());
                    while (rs.next()) {
            %>
            <tr>
                <th><%=r.getID_Reunion()%></th>
                <th><%=r.getCoordinadorReunion()%></th>
                <th><%=r.getNombreReunion()%></th>
                <th><%=r.getID_Lugar()%></th>
                <th><%=r.getObjetivosReunion()%></th>
                <th><%=r.getFechaReunion()%></th>
                <th><%=r.getHoraReunion()%></th>
                <th><%=r.getEstado()%></th>
                <th>
                    <%if (r.getEstado().equalsIgnoreCase("Activa")) {%>
                    <a href="participantes.jsp?idReunion=<%=r.getID_Reunion()%>&nombre=<%=r.getNombreReunion()%>&lugar=<%=rs.getString("nombreLugar")%>&fecha=<%=r.getFechaReunion()%>&hora=<%=r.getHoraReunion()%>&objetivos=<%=r.getObjetivosReunion()%>">
                        <img src="Iconos/participantes.png" width="30" heigth="30">
                    </a>
                    <%} else {%>
                    <a href="ServletReunion?accion=listar&usuario=<%=usuu%>">
                        <img src="Iconos/participantes.png" width="30" heigth="30">
                    </a>
                        <%}%>
                </th>
                <th>
                    <a href="ServletReunion?accion=desactivarReunion&idReunion=<%=r.getID_Reunion()%>&usuario=<%=usuu%>">
                        <img src="Iconos/desactivar.png" width="30" heigth="30">
                    </a>
                    <a href="ServletReunion?accion=activarReunion&idReunion=<%=r.getID_Reunion()%>&usuario=<%=usuu%>">
                        <img src="Iconos/activar.png" width="30" heigth="30">
                    </a>
                </th>
                <th>
                    <%if (r.getEstado().equalsIgnoreCase("Activa")) {%>
                    <a href="actaReunion.jsp?idReunion=<%=r.getID_Reunion()%>">
                        <img src="Iconos/iniciar.png" width="30" heigth="30">
                    </a>
                    <%} else {%>
                    <a href="ServletReunion?accion=listar&usuario=<%=usuu%>">
                        <img src="Iconos/iniciar.png" width="30" heigth="30">
                    </a>
                        <%}%>
                </th>


            </tr>
            <%
                    }
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
