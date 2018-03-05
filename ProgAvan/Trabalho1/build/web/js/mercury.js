
function submitForm(formID,valorDoBotaoEscolhido){
    document.getElementById(formID).botaoEscolhido.value=valorDoBotaoEscolhido;
    document.getElementById(formID).submit();
}

function limparCampos(formID){
    document.getElementById(formID).SERIALNO.value='';
    document.getElementById(formID).CAMPO.value='';
    document.getElementById(formID).dialogo.value='';
}
