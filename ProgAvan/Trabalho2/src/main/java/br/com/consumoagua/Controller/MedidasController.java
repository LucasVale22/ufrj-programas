package br.com.consumoagua.Controller;

import br.com.consumoagua.bens.Medidas;
import br.com.consumoagua.jdbc.MedidasDAO;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.StringReader;
import java.util.List;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/MedidasController")
public class MedidasController extends HttpServlet {

    /*protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Não é um conjunto de pares nome-valor,
        // então tem que ler como se fosse um upload de arquivo...
        BufferedReader br = new BufferedReader(
                                  new  InputStreamReader(
                                           request.getInputStream(),"UTF8"));
        String textoDoJson = br.readLine();
        
        JsonObject jsonObjectDeJava = null;
        // Ler e fazer o parsing do String para o "objeto json" java
        try (   //Converte o string em "objeto json" java
                // Criar um JsonReader.
                JsonReader readerDoTextoDoJson = 
                        Json.createReader(new StringReader(textoDoJson))) {
                // Ler e fazer o parsing do String para o "objeto json" java
                jsonObjectDeJava = readerDoTextoDoJson.readObject();
                // Acabou, então fechar o reader.
        }catch(Exception e){
            e.printStackTrace();
        }
        
        // Agora é só responder...
        Medidas med = new Medidas();
        med.setMesRef(jsonObjectDeJava.getString("mesRef"));
        med.setAnoRef(jsonObjectDeJava.getString("anoRef"));
        //med.setSucesso(true);
        
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.print(med.toString());
        out.flush();
        
    }*/
   
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Medidas med = new Medidas();
        String acao = request.getParameter("acao");
        
        MedidasDAO medDAO = new MedidasDAO();
        
        String sapto = request.getParameter("apto"); 
        med.setApto(sapto);
        
        /*if(acao!=null && acao.equals("primeira")){
            List<Medidas> lista = medDAO.buscarTodos(med,"0");
            request.setAttribute("lista",lista);
        }else if(acao!=null && acao.equals("troca")){
            String npagina = request.getParameter("npagina");
            List<Medidas> lista = medDAO.buscarTodos(med,npagina);
            request.setAttribute("lista",lista); 
        }*/
        
        List<Medidas> lista = medDAO.buscarTodos(med/*,"0"*/);
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
