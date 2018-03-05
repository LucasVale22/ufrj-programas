<%@page import="java.util.List"%>
<%@page import="br.com.consumoagua.bens.Medidas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de Medidas</title>
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
        <br>
        
        <%
        List<Medidas> listaResultado = (List<Medidas>)request.getAttribute("lista");
        for(Medidas u:listaResultado){
        %>
        <br>
            <span id="labelApto">Consumo Mensal (Apto. <%=u.getApto() %>)</span>
        <br>
        <br>
              
        <table class="tabela">
                        <tr>
                            <th>Data-hora<br>da medida</th>
                            <th>Leitura no<br>hidrômetro</th>
                            <th>Pulsos<br>medidos</th>
                            <th>m<sup>3</sup> no<br>período</th>
                            <th>Pulsos acumulados<br>no mês</th>
                            <th>m<sup>3</sup><br>acumulados<br>no mês</th>
                            <th>Custo (R$)<br>acumulado<br>no mês</th>
                        </tr>
                        
                        <tr class="tg">
                            <th><%=u.getDatahora() %></th>
                            <th>654321</th>
                            <th><%=u.getNropulsos() %></th>
                            <th>0</th>
                            <th>0</th>
                            <th>0</th>
                            <th>R$ 0,00</th>
                        </tr>
        <%
        }
        %>
                        <tr class="tg">
                            <th>02/05/2016 01:00:03</th>
                            <th>654346</th>
                            <th>25</th>
                            <th>0,0127</th>
                            <th>25</th>
                            <th>0,012</th>
                            <th>R$ 221,45</th>
                        </tr>
                        <tr class="tg">
                            <th>03/05/2016 01:00:03</th>
                            <th>654367</th>
                            <th>21</th>
                            <th>0,0120</th>
                            <th>46</th>
                            <th></th>
                            <th></th>
                        </tr>
                        <tr class="tg">
                            <th>04/05/2016 01:00:03</th>
                            <th>654395</th>
                            <th>28</th>
                            <th>0,0131</th>
                            <th>54</th>
                            <th></th>
                            <th></th>
                        </tr>
                        <tr class="tg">
                            <th>05/05/2016 01:00:03</th>
                            <th>654418</th>
                            <th>23</th>
                            <th>0,0125</th>
                            <th>77</th>
                            <th></th>
                            <th></th>
                        </tr>
        </table>
        <br>
        <a href="login.jsp">Sair</a>
    </body>
    
</html>
