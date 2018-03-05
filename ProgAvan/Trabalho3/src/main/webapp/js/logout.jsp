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
        <%="<meta http-equiv=\"refresh\" content=\"0; url=" + contexto + "/\" >"%> 
        <script>var contexto = "<%= contexto%>";</script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Retorno</title>
        <link rel="stylesheet" type="text/css" href="<%= contexto%>/css/login.css"/>
    </head>

    <body>
        <div class="bg"></div>
        <div id="divLogin">
            <form id="loginform" method="POST" action="j_security_check">
                <br>
                <br>
                <br>
                Username<br>
                <input type="text" class="textnome" name="j_username" size="30">
                <br>
                <br>
                Password<br>
                <input type="password" class="textnome" name="j_password" size="30">
                <br>
                <br>
                <br>
                <div id="idEntrar">Entrar</div>
        </div>
    </body>
</html>
