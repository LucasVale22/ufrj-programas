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
   String semail = request.getParameter("email");
   
   Condomino cond = new Condomino();
   cond.setApto(sapto);
   cond.setResponsavel(sresponsavel);
   cond.setTelefone(stelefone);
   cond.setEmail(semail);
   
   CondominoDAO condDAO = new CondominoDAO();
   condDAO.cadastro(cond);
%>
<script language= "JavaScript">
location.href="CondominoController?acao=lis";
</script>
</body>
</html>
