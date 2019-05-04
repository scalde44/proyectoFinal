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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" href="Iconos/logo.png">
        <link href="estilos.css" rel="stylesheet" type="text/css">
        <title>Meeting Office</title>
    </head>
    <body background="Iconos/fondo1.png">
        <inse>INSERTAR USUARIOS</inse>
        <form class="bax">
            <img src="Iconos/insertarUsuario2.png" width="100" height="100">
        </form>
        <script>
                var numeros = "0123456789";
                var letras = "abcdefghyjklmnñopqrstuvwxyz";
                var letras_mayusculas = "ABCDEFGHYJKLMNÑOPQRSTUVWXYZ";

                function tiene_numeros(texto) {
                    for (i = 0; i < texto.length; i++) {
                        if (numeros.indexOf(texto.charAt(i), 0) != -1) {
                            return 1;
                        }
                    }
                    return 0;
                }

                function tiene_letras(texto) {
                    texto = texto.toLowerCase();
                    for (i = 0; i < texto.length; i++) {
                        if (letras.indexOf(texto.charAt(i), 0) != -1) {
                            return 1;
                        }
                    }
                    return 0;
                }

                function tiene_minusculas(texto) {
                    for (i = 0; i < texto.length; i++) {
                        if (letras.indexOf(texto.charAt(i), 0) != -1) {
                            return 1;
                        }
                    }
                    return 0;
                }

                function tiene_mayusculas(texto) {
                    for (i = 0; i < texto.length; i++) {
                        if (letras_mayusculas.indexOf(texto.charAt(i), 0) != -1) {
                            return 1;
                        }
                    }
                    return 0;
                }

                function seguridad_clave(clave) {
                    var seguridad = 0;
                    if (clave.length != 0) {
                        if (tiene_numeros(clave) && tiene_letras(clave)) {
                            seguridad += 30;
                        }
                        if (tiene_minusculas(clave) && tiene_mayusculas(clave)) {
                            seguridad += 30;
                        }
                        if (clave.length >= 4 && clave.length <= 5) {
                            seguridad += 10;
                        } else {
                            if (clave.length >= 6 && clave.length <= 8) {
                                seguridad += 30;
                            } else {
                                if (clave.length > 8) {
                                    seguridad += 40;
                                }
                            }
                        }
                    }
                    return seguridad
                }

                function muestra_seguridad_clave(clave, formulario) {
                    seguridad = seguridad_clave(clave);
                    if(seguridad<50){
                        nivel="MALA";
                    }else if(seguridad>50&&seguridad<80){
                       nivel="BUENA";
                    }else if(seguridad>80){
                        nivel="EXCELENTE";
                    }
                    
                    formulario.seguridad.value = nivel ;
                }
            </script>
        <form action="ServletMantenimiento" class="insertar">
                <input type="text" name="txtNombre" placeholder="Nombre"required>
                <input type="email" name="txtCorreo" placeholder="Correo"required>
                <input type="password" name="txtContrasena" placeholder="Contraseña" size="15" onkeyup="muestra_seguridad_clave(this.value, this.form)"
                       required>  
                <h4>Nivel de seguridad:</h4> <input name="seguridad" style="color: white; text-align:center ;border: 0px; background-color:#34495e; text-decoration:italic;" onfocus="blur()">
                <input type="password" name="txtContrasena1" placeholder="Repita la contraseña" size="15" onkeyup="muestra_seguridad_clave(this.value, this.form)"
                       required>
                <input type="submit" name="btnl"value="Grabar Usuario">
                <input type="hidden" name="accion" value="insertar">
                <%
                if (request.getAttribute("msg") != null) {
                    %><h4><%out.println(request.getAttribute("msg"));%></h4><%
                }
            %>
        </form>
        <br>
    <center>
        <a href="principal.jsp">
            <regresarse>Regresar</regresarse>
        </a>
    </center>
</body>
</html>
