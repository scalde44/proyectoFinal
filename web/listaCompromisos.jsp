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
        <h3>MIS COMPROMISOS</h3>

        <br><br><br><br><br><br><br><br>
    <center>
        <input type="text" id="myInput" onkeyup="myFunction()" placeholder="Busca por compromiso">
    </center>
    <table border="1"  align="center" id="results">
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
            <td><%=rs4.getString(2)%></td>
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
