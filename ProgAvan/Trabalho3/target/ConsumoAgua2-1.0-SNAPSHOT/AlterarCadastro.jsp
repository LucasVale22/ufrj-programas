<%@page import="br.com.consumoagua.bens.Condomino"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro</title>
        <link rel="stylesheet" type="text/css" 
              href="css/login.css"/>
        <link rel="stylesheet" type="text/css" 
              href="css/cadastro.css"/>
    </head>
    <body>
        <%
          Condomino cond = (Condomino)request.getAttribute("condomino");
        %>
        <br>
        <br>
        <br>
        <br>
        <div id="backTitulo">
            <span id="labelTitulo">Sistema de Medição do Consumo de Água</span>
        </div>
        <br>
        <br>
        <div id="divPrincipal">
            <form action="CondominoController" method="post">
                
                <br>
                <span id="labelApto">Editar:</span>
                <br>
                <br>
                
                        <input type="hidden" name="acao" value="salvar">
                        <span>Apartamento</span>
                        <br>
                        <input type="text" name="apto" value="<%=cond.getApto()%>">
                        <br>
                        <span>Responsável</span>
                        <br>
                        <input type="text" name="responsavel" value="<%=cond.getResponsavel()%>">
                        <br>
                        <span>Telefone</span>
                        <br>
                        <input type="text" name="telefone" value="<%=cond.getTelefone()%>">
                        <br>
                        <span>Email</span>
                        <br>
                        <input type="text" name="email" value="<%=cond.getEmail()%>">
                        <br>
                        <br>
                        <input type="submit" value="ALTERAR">
                        <br>
                        <br>
 
            </form>
        </div>
        <br>
        <a href="cadastro.jsp">Cadastrar novo condomino</a>
        <br>
        <a href="CondominoController?acao=lis">Condominos cadastrados</a>
        <br>
        <a href="login.jsp">Sair</a>
        
    </body>
</html>
