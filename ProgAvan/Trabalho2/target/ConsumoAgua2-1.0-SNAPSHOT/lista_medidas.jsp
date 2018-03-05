<%@page import="java.util.List"%>
<%@page import="br.com.consumoagua.bens.Medidas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de Medidas</title>
        <script type="text/javascript" src="./js/ajaxFiltro.js"></script>
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
        %>
        <br>
            <div id="labelApto" class="wrap">
                Consumo mensal em 
                <form>
                <select id="mesRef">
                    <option value="01">jan</option>
                    <option value="02">fev</option>
                    <option value="03">mar</option>
                    <option value="04">abr</option>
                    <option value="05">mai</option>
                    <option value="06">jun</option>
                    <option value="07">jul</option>
                    <option value="08">ago</option>
                    <option value="09">set</option>
                    <option value="10">out</option>
                    <option value="11">nov</option>
                    <option value="12">dez</option>
                </select>
                <select id="anoRef">
                    <option value="2017">2017</option>
                    <option value="2018">2018</option>
                    <option value="2019">2019</option>
                    <option value="2020">2020</option>
                    <option value="2021">2021</option>
                    <option value="2022">2022</option>
                    <option value="2023">2023</option>
                    <option value="2024">2024</option>
                    <option value="2025">2025</option>
                    <option value="2026">2026</option>
                    <option value="2027">2027</option>
                </select>
                <!--<input type="button" value="Filtrar" onclick="fazerPedidoAJAX(anoRef.value+'-'+mesRef.value);"/>-->
                <input type="button" value="Filtrar" onclick="fazerPedidoAJAX(anoRef.value+'-'+mesRef.value);"/>
                <!--<span id="tituloApto">(
                    apto ${sessionScope.APTO})
                </span>-->
                </form>
            </div>
        <br>
        <a href="login.jsp">Sair</a>
        <br>
              
        <!--<div id="rolagem">-->
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
                        <%for(Medidas u:listaResultado){%>
                        <tr class="tg" id="buscaMes">
                            
                            <th><%=u.getDatahora() %></th>
                            <th><%=u.getNropulsos() %></th>
                            <th><%=u.getHidrometro() %></th>
                            <th><%=u.getVolnoperiodo() %></th>
                            <th><%=u.getNropulsosacumulados() %></th>
                            <th><%=u.getVolacumulado() %></th>
                            <th>R$ <%=u.getCustoacumulado() %></th>
                        </tr>
                        <%
                        }
                        %>
        </table>
        <!--</div>-->
        <br>
        <form action="MedidasController?acao=troca" method="post">
            <span>Página</span>    
        <input type="text" name="npagina" size="1px">
        <input type="submit" value="IR">
        </form>
        <br>
        <a href="login.jsp">Sair</a>
    </body>
    
</html>
