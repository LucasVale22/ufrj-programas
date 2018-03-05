package br.com.consumoagua.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;

import br.com.consumoagua.bens.Condomino;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CondominoDAO {
    
    private Connection con = Conexao.getConnection();
    
    public Condomino buscarPorApto(String apto){
        Condomino condRetorno = null;
        
        String sql = "SELECT* from CONDOMINOS where APTO = ? ";
        
        try {
            PreparedStatement preparador = con.prepareStatement(sql);
            preparador.setString(1,condRetorno.getApto());
            ResultSet resultados = preparador.executeQuery();
            while(resultados.next()){
                condRetorno = new Condomino();
                condRetorno.setApto(resultados.getString("apto"));
                condRetorno.setResponsavel(resultados.getString("responsavel"));
                condRetorno.setTelefone(resultados.getString("telefone"));
                condRetorno.setEmail(resultados.getString("email"));
            }
            System.out.println("Encontrado com sucesso!");
        } catch (SQLException e) {
            System.out.println("Erro - "+e.getMessage());
        } return condRetorno;
        
    }
    
    public void cadastro(Condomino condomino){
        
        String sql = "INSERT INTO condominos (apto,responsavel,telefone,email) values (?,?,?,?)";
        
        try {
            PreparedStatement preparador = con.prepareStatement(sql);
            preparador.setString(1, condomino.getApto());
            preparador.setString(2, condomino.getResponsavel());
            preparador.setString(3, condomino.getTelefone());
            preparador.setString(4, condomino.getEmail());
            
            preparador.execute();
            preparador.close();
            
            System.out.println("Cadastrado com sucesso!");
        } catch (SQLException e) {
            System.out.println("Erro - "+e.getMessage());
        }
        
    }
    
    public void alterar(Condomino condomino){
        
        String sql = "UPDATE CONDOMINOS SET APTO = ?, RESPONSAVEL = ?, TELEFONE = ?, EMAIL = ?, where APTO = ? ";
        
        try {
            PreparedStatement preparador = con.prepareStatement(sql);
            preparador.setString(1, condomino.getApto());
            preparador.setString(2, condomino.getResponsavel());
            preparador.setString(3, condomino.getTelefone());
            preparador.setString(4, condomino.getEmail());
            
            preparador.execute();
            preparador.close();
            
            System.out.println("Alterado com sucesso!");
        } catch (SQLException e) {
            System.out.println("Erro - "+e.getMessage());
        }
        
    }
    
    public void deletar(Condomino condomino){
        
        String sql = "DELETE from CONDOMINOS where APTO = ? ";
        
        try {
            PreparedStatement preparador = con.prepareStatement(sql);
            preparador.setString(1, condomino.getApto());
            
            preparador.execute();
            preparador.close();
            
            System.out.println(" Deletado com sucesso!");
        } catch (SQLException e) {
            System.out.println("Erro - "+e.getMessage());
        }
        
    }
    
    public List<Condomino> buscarTodos(Condomino condomino){
        String sql = "SELECT* from CONDOMINOS order by APTO";
        List<Condomino> lista = new ArrayList<Condomino>();
        try {
            PreparedStatement preparador = con.prepareStatement(sql);
            ResultSet resultados = preparador.executeQuery();
            while(resultados.next()){
                Condomino cond = new Condomino();
                cond.setApto(resultados.getString("apto"));
                cond.setResponsavel(resultados.getString("responsavel"));
                cond.setTelefone(resultados.getString("telefone"));
                cond.setEmail(resultados.getString("email"));
                lista.add(cond);
            }
        } catch (SQLException e) {
            System.out.println("Erro - "+e.getMessage());
        } return lista;
        
    }
    
}
