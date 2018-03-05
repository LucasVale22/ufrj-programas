<%@page import="java.net.URL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% URL contexto = new URL(
            "https",
            request.getServerName(),
            request.getServerPort(),
            request.getContextPath());%>

<!DOCTYPE html>
<html>
    <head>
        <script>var contexto = "<%= contexto%>";</script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Verificação</title>
        <link rel="stylesheet" type="text/css" href="<%= contexto%>/css/login.css"/>
        <script type="text/javascript" src="<%= contexto %>/js/login.js"></script>
    </head>

    <body>
        <div class="bg"></div>
        <div id="divLogin">
            <br>
            <br>
            <br>
            <br>
            Apartamento ou senha inválidos,
            <br>
            tente de novo <a href="<%= contexto%>/logout.jsp">aqui</a>.
            <br>
            <br>
            (Erro 401 unauthorized)
        </div>
    </body>
</html>
