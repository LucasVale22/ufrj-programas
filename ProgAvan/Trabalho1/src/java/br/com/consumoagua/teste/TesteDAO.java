package br.com.consumoagua.teste;

import br.com.consumoagua.bens.Condomino;
import br.com.consumoagua.jdbc.CondominoDAO;
import java.util.List;

public class TesteDAO {
    
    public static void main(String[] args){
        testeCadastro();
        //testeAlteracao();
        //testeDeletar();
        //testeBuscarTodos();
    }
    
    public static void testeCadastro(){
        Condomino cond = new Condomino();
        cond.setApto("101");
        cond.setResponsavel("Lucas");
        cond.setTelefone("33333333");
        
        CondominoDAO condDAO = new CondominoDAO();
        condDAO.cadastro(cond);
    }
    
    public static void testeAlteracao(){
        Condomino cond = new Condomino();
        cond.setApto("101");
        cond.setResponsavel("Lucas do Vale");
        cond.setTelefone("44444444");
        
        CondominoDAO condDAO = new CondominoDAO();
        condDAO.alterar(cond);
    }
    
    public static void testeDeletar(){
        Condomino cond = new Condomino();
        cond.setApto("101");
        
        CondominoDAO condDAO = new CondominoDAO();
        condDAO.deletar(cond);
    }
    
    public static void testeBuscarTodos(){
        Condomino cond = new Condomino();
        CondominoDAO condDAO = new CondominoDAO();
        List<Condomino> listaResultado = condDAO.buscarTodos(cond);
        
        for(Condomino u:listaResultado){
            System.out.println("Apto: "+u.getApto()+"Responsavel: "+u.getResponsavel()+"Telefone: "+u.getTelefone());
        }
    }
    
}
