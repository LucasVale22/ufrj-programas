package br.com.consumoagua.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;

import br.com.consumoagua.bens.Medidas;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class MedidasDAO {
    
    private Connection con = Conexao.getConnection();
    
    public List<Medidas> buscarTodos(Medidas condomino){
        String sql = "SELECT * from medidas";
        List<Medidas> lista = new ArrayList<Medidas>();
        try {
            PreparedStatement preparador = con.prepareStatement(sql);
            ResultSet resultados = preparador.executeQuery();
            while(resultados.next()){
                Medidas med = new Medidas();
                med.setApto(resultados.getString("apto"));
                med.setDatahora(resultados.getString("datahora"));
                med.setNropulsos(resultados.getInt("nropulsos"));
                med.setSerialmedidas(resultados.getInt("serialmedidas"));
                lista.add(med);
            }
        } catch (SQLException e) {
            System.out.println("Erro - "+e.getMessage());
        } return lista;
        
    }
    
}