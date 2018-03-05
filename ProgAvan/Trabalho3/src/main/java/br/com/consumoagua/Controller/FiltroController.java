package br.com.consumoagua.Controller;

import br.com.consumoagua.bens.Medidas;
import br.com.consumoagua.jdbc.MedidasDAO;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.Integer.parseInt;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;

public class FiltroController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Medidas med = new Medidas();
        MedidasDAO medDAO = new MedidasDAO();
        
        String dataRef = request.getParameter("dataRef");
        med.setDataRecebida(dataRef);
        
        List<Medidas> lista = medDAO.buscarTodos(med);
        request.setAttribute("lista",lista);
        List<Medidas> listaRetorno = (List<Medidas>)request.getAttribute("lista");
        for(Medidas medida:listaRetorno){
            Integer nropulsos = medida.getNropulsos();
            PrintWriter out = response.getWriter();
            out.print(nropulsos);
        }    
        
        

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}