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
        <title>HTTPS</title>
        <link rel="stylesheet" type="text/css" href="<%= contexto%>/css/login.css"/>
        <script type="text/javascript" src="<%= contexto%>/js/primeirapagina.js"></script>
    </head>

    <body>
        <div class="bg"></div>
        <div id="divLogin">
            <br>
            <br>
            <br>
            <h3>Primeira página</h3>
            <br>
            <a href="#" id="linkSair">SAIR</a>
            <br>
            <br>
        </div>
    </body>
</html>
