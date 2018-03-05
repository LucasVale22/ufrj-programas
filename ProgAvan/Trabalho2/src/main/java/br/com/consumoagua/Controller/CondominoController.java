package br.com.consumoagua.Controller;

import br.com.consumoagua.bens.Condomino;
import br.com.consumoagua.jdbc.CondominoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.Integer.parseInt;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CondominoController")
public class CondominoController extends HttpServlet {

    public CondominoController(){
        super();
    }
    
   
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Condomino cond = new Condomino();
        String acao = request.getParameter("acao");
        CondominoDAO condDAO = new CondominoDAO();
        
        if(acao != null && acao.equals("lis")){
        
        List<Condomino> lista = condDAO.buscarTodos(cond);
        
        request.setAttribute("lista",lista);
        RequestDispatcher saida = request.getRequestDispatcher("lista_condominos.jsp");
        saida.forward(request,response); 
        
        }else if(acao != null && acao.equals("ex")){
            
            String apto = request.getParameter("apto");
            cond.setApto(apto);
            condDAO.deletar(cond);
            response.sendRedirect("CondominoController?acao=lis");
        }
        else if(acao != null && acao.equals("alt")){
            
            String apto = request.getParameter("apto");
            Condomino condomino = condDAO.buscarPorApto(apto);
            request.setAttribute("condomino",condomino);
            RequestDispatcher saida = request.getRequestDispatcher("AlterarCadastro.jsp");
            saida.forward(request,response);
        }
        
    }

    
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String sapto = request.getParameter("apto");
        String sresponsavel = request.getParameter("responsavel");
        String stelefone = request.getParameter("telefone");
        String semail = request.getParameter("email");
        
        Condomino cond =  new Condomino();
        cond.setApto(sapto);
        cond.setResponsavel(sresponsavel);
        cond.setTelefone(stelefone);
        cond.setEmail(semail);
        
        CondominoDAO condDAO =  new CondominoDAO();
        condDAO.alterar(cond);
        
        response.sendRedirect("CondominoController?acao=lis");
        
    }

  
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
