function fazerPedidoAJAX(argumento){
    // Preparacao do pedido
    var url = "http://localhost:8084/ajaxFiltro/FiltroController?dataRef=" + argumento;
    // Criar o novo objeto XMLHttpRequest (o objeto do AJAX)
    var ajaxRequest = new XMLHttpRequest();
    // Definir o metodo
    ajaxRequest.open("GET", url);
    // Definir o Content-type do pedido HTTP
    ajaxRequest.setRequestHeader(
            "Content-Type","application/x-www-form-urlencoded");
    // Prepara recebimento da resposta (definir funcao de callback)
    ajaxRequest.onreadystatechange =
            function() {
                if(ajaxRequest.readyState===4 && ajaxRequest.status===200){
                    document.getElementById("IDdadosResposta").value = ajaxRequest.responseText;
                    //alterar isso para escrever na tela e não num campo como no exemplo ajaxbemsimples
                }
            };
    // Enviar o pedido
    ajaxRequest.send(null);
}