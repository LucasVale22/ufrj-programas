<%@page import="java.util.List"%>
<%@page import="br.com.consumoagua.bens.Condomino"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de Condominos</title>
        <link rel="stylesheet" type="text/css" href="css/login.css"/>
        <link rel="stylesheet" type="text/css" href="css/tabela.css"/>
    </head>
    <body>
        
        <br>
        <br>
        <br>
        <br>
        <div id="backTitulo">
            <span id="labelTitulo">Sistema de Medição do Consumo de Água</span>
        </div>
        <br>
        <br>
        <span id="labelApto">Condôminos:</span>
        <br>
        <br>    
        
    <%
    List<Condomino> listaResultado = (List<Condomino>)request.getAttribute("lista");
    %>
    
    <table class="tabela">
        <div class="linTab">
            <tr>
                   <th >Apartamento</th>
                   <th>Responsavel</th>
                   <th>Telefone</th>
                   <th>Email</th>
                   <th>Consumo</th>
                   <th>Excluir</th>
                   <th>Editar</th>
            </tr>
        </div>
        <%
        for(Condomino u:listaResultado){
        %>
        <tr  class="tg">
                <th><%=u.getApto() %></th>
                <th><%=u.getResponsavel() %></th>
                <th><%=u.getTelefone() %></th>
                <th><%=u.getEmail() %></th>
                <th><a href="MedidasController"><img src ="icone1.png"></img></a></th>
                <th><a href="CondominoController?acao=ex&apto=<%=u.getApto() %>"><img src ="icone2.png"></img></a></th>
                <th><a href="CondominoController?acao=alt&apto=<%=u.getApto() %>"><img src ="icone3.png"></img></a></th>
         </tr>
        <%
        }
        %>
    </table>
    
    <br>
    <a href="cadastro.jsp">Cadastrar novo condomino</a>
    <br>
    <a href="CondominoController?acao=lis">Condominos cadastrados</a>
    </body>
    <br>
    <a href="login.jsp">Sair</a>
    
</html>
