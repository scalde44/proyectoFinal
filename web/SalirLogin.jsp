<%-- 
    Document   : SalirLogin
    Created on : 28/02/2019, 05:42:43 PM
    Author     : steve
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            HttpSession sesionOk=request.getSession();
            request.getSession().removeAttribute("usuario");
            sesionOk.invalidate();
            request.getRequestDispatcher("Login.jsp").forward(request, response);
             HttpSession sesionOkk=request.getSession();
            request.getSession().removeAttribute("administrador");
            sesionOk.invalidate();
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            %>
    </body>
</html>
