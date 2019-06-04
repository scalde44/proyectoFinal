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

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" href="Iconos/logo.png">
        <link href="estilos.css" rel="stylesheet" type="text/css">

        <script type="text/javascript" src="pager.js"></script>
        <title>Meeting Office</title>
        <style type="text/css">
            .pg-normal {
                color: black;
                font-weight: normal;
                text-decoration: none;
                cursor: pointer;
                font-family:    'Lucida Grande',Verdana,Arial,Sans-Serif;
                font-size:10px
            }
            .pg-selected {
                color: black;
                font-weight: bold;
                text-decoration: underline;
                cursor: pointer;
                font-family:    'Lucida Grande',Verdana,Arial,Sans-Serif;
                font-size:10px
            }
            #myInput {
                width: 400px; /* Full-width */
                font-size: 16px; /* Increase font-size */
                padding: 12px 20px 12px 40px; /* Add some padding */
                border: 1px solid #ddd; /* Add a grey border */
                margin-bottom: 12px; /* Add some space below the input */
                text-align: center;
            }
        </style>
        <script>
            function myFunction() {
                // Declare variables 
                var input, filter, table, tr, td, i, txtValue;
                input = document.getElementById("myInput");
                filter = input.value.toUpperCase();
                table = document.getElementById("results");
                tr = table.getElementsByTagName("tr");

                // Loop through all table rows, and hide those who don't match the search query
                for (i = 0; i < tr.length; i++) {
                    td = tr[i].getElementsByTagName("td")[0];
                    if (td) {
                        txtValue = td.textContent || td.innerText;
                        if (txtValue.toUpperCase().indexOf(filter) > -1) {
                            tr[i].style.display = "";
                        } else {
                            tr[i].style.display = "none";
                        }
                    }
                }
            }
        </script>
    </head>
    <body background="Iconos/fondo1.png">
        <h3>REUNIONES</h3>

        <br><br><br><br><br><br><br><br>
    <center>
        <input type="text" id="myInput" onkeyup="myFunction()" placeholder="Busca por nombre">
    </center>
        <table border="1"  align="center" id="results">
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
                <th><font color="black">Compromisos</font></th>
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
                <td><%=r.getNombreReunion()%></td>
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
                    <img src="Iconos/participantes.png" width="30" heigth="30">
                    <%}%>
                </th>
                <th>
                    <a href="compromisos.jsp?idReunion=<%=r.getID_Reunion()%>&agregar=no">
                        <img src="Iconos/compromisos.png" width="30" heigth="30">
                    </a>
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
                    <a href="compromisos.jsp?idReunion=<%=r.getID_Reunion()%>&agregar=si">
                        <img src="Iconos/iniciar.png" width="30" heigth="30">
                    </a>
                    <%} else {%>
                    <img src="Iconos/iniciar.png" width="30" heigth="30">
                    <%}%>
                </th>


            </tr>
            <%
                    }

                    rs.close();

                }

            %>
        </table>
        <div id="pageNavPosition"></div>
        <script type="text/javascript">
            var pager = new Pager('results', 5);
            pager.init();
            pager.showPageNav('pager', 'pageNavPosition');
            pager.showPage(1);

        </script>
    <center>
        <a href="principalReuniones.jsp">
            <regresar>Regresar</regresar>
        </a>
    </center>
</body>
</html>
