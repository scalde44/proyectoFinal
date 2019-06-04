<%@page import="java.io.File"%>
<%@page import="UsuarioBEANS.RutaFicheros"%>
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
        <h3>ARCHIVOS</h3>

        <br><br><br><br><br><br><br><br>
    <center>
        <input type="text" id="myInput" onkeyup="myFunction()" placeholder="Busca por nombre">
    </center>
    <table border="1"  align="center" id="results">
        <tr bgcolor="gray">
            <th><font   color="black">Nombre archivo</font></th>
            <th><font   color="black">Direccion Archivo</font></th>
            <th><font color="black">Tamaño</font></th>
            <th><font color="black">Abrir</font></th>
        </tr>
        <%
            RutaFicheros rf = new RutaFicheros();
            for (int i = 0; i < rf.listar().length; i++) {
                File fichero = rf.listar()[i];
                long tamano = fichero.length() / 1024;
                String tamanoarchivo = Long.toString(tamano) + " KB";
        %>
        <tr>
            <td><%=fichero.getName()%></td>
            <th><%=fichero.getAbsolutePath()%></th>
            <th><%=tamanoarchivo%></th>
            <th>
                <a href="ServletArchivos?accion1=abrir&nombre=<%=fichero.getName()%>">
                    <img src="Iconos/listaReuniones.png" width="30" height="30">
                </a>
            </th>
        </tr>
        <%
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
