package br.com.consumoagua.Controller;

import br.com.consumoagua.bens.Medidas;
import br.com.consumoagua.jdbc.MedidasDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/MedidasController")
public class MedidasController extends HttpServlet {

    public MedidasController(){
        super();
    }
    
   
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Medidas med = new Medidas();
        MedidasDAO medDAO = new MedidasDAO();
        
        List<Medidas> lista = medDAO.buscarTodos(med);
        
        request.setAttribute("lista",lista);
        RequestDispatcher saida = request.getRequestDispatcher("lista_medidas.jsp");
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
