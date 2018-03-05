<%@page import="br.com.consumoagua.jdbc.MedidasDAO"%>
<%@page import="br.com.consumoagua.bens.Medidas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tratador do Login</title>
    </head>
    <body>
        <%
        String sapto = request.getParameter("apto"); 
        
        if(sapto.equals("000")){
        %>
            <script language= "JavaScript">
            location.href="CondominoController?acao=lis"
            </script>
        <%}
        else{

        %>
            <script language= "JavaScript">
            location.href="MedidasController"
            </script>
            
        <%}
        %>
    </body>
</html>
