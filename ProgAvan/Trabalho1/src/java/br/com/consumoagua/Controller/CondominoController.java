package br.com.consumoagua.Controller;

import br.com.consumoagua.bens.Condomino;
import br.com.consumoagua.jdbc.CondominoDAO;
import java.io.IOException;
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
        CondominoDAO condDAO = new CondominoDAO();
        
        List<Condomino> lista = condDAO.buscarTodos(cond);
        
        request.setAttribute("lista",lista);
        RequestDispatcher saida = request.getRequestDispatcher("lista_condominos.jsp");
        saida.forward(request,response); 
    }

    
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

  
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
