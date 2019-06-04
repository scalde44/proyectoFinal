<%
    String usu = "";
    HttpSession sesionOkk = request.getSession();
    if (sesionOkk.getAttribute("administrador") == null) {
%>
<jsp:forward page="Login.jsp">
    <jsp:param name="msg" value="Ingresa Primero"/>
</jsp:forward>
<%
    } else {
        usu = (String) sesionOkk.getAttribute("administrador");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="UsuarioBEANS.Usuario" %>
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
        <h3>USUARIOS</h3>
        <br><br><br><br><br>
    <center>
        <input type="text" id="myInput" onkeyup="myFunction()" placeholder="Busca por nombre">
    </center>
    <table border="1" width="600" height="100" align="center" id="results">
        <tr bgcolor="gray">
            <th><font   color="black">ID</font></th>
            <th><font   color="black">Nombre</font></th>
            <th><font color="black">Correo</font></th>
            <th><font color="black">Contraseña</font></th>
            <th><font color="black">Estado</font></th>
            <th><font color="black">Accion</font></th>
        </tr>
        <%
            ArrayList<Usuario> lista
                    = (ArrayList<Usuario>) request.getAttribute("lista");
            for (int i = 0; i < lista.size(); i++) {
                Usuario u = lista.get(i);
        %>
        <tr>
            <th><%=u.getID_Usuario()%></th>
            <td><%=u.getNombre()%></td>
            <th><%=u.getCorreo()%></th>
            <th><%=u.getContrasena()%></th>
            <th><%=u.getEstado()%></th>
            <th>


                <a href="ServletMantenimiento?accion=desactivar&id=<%=u.getID_Usuario()%>">
                    <image src="Iconos/desactivar.png" width="30" heigth="30">
                </a>
                <a href="ServletMantenimiento?accion=activar&id=<%=u.getID_Usuario()%>">
                    <image src="Iconos/activar.png" width="30" heigth="30">
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
        <a href="principal.jsp">
            <regresar>Regresar</regresar>
        </a>
    </center>
</body>
</html>
