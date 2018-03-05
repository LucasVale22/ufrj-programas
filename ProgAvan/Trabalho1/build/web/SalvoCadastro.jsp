<%@page import="br.com.consumoagua.jdbc.CondominoDAO"%>
<%@page import="br.com.consumoagua.bens.Condomino"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Pagina - Salvar Cadastro</title>
<link rel="stylesheet" type="text/css" 
              href="css/login.css"/>
</head>

<body>
    
<%
   String sapto = request.getParameter("apto"); 
   String sresponsavel = request.getParameter("responsavel");
   String stelefone = request.getParameter("telefone");
   
   Condomino cond = new Condomino();
   cond.setApto(sapto);
   cond.setResponsavel(sresponsavel);
   cond.setTelefone(stelefone);
   
   CondominoDAO condDAO = new CondominoDAO();
   condDAO.cadastro(cond);
%>
<script language= "JavaScript">
alert("SALVO COM SUCESSO!");
location.href="CondominoController";
</script>
</body>
</html>
